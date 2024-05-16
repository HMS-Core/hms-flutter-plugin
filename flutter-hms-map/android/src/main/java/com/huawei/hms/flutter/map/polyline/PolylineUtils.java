/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.huawei.hms.flutter.map.polyline;

import android.app.Application;

import com.huawei.hms.flutter.map.constants.Method;
import com.huawei.hms.flutter.map.constants.Param;
import com.huawei.hms.flutter.map.logger.HMSLogger;
import com.huawei.hms.flutter.map.utils.Convert;
import com.huawei.hms.flutter.map.utils.ToJson;
import com.huawei.hms.maps.HuaweiMap;
import com.huawei.hms.maps.model.Polyline;
import com.huawei.hms.maps.model.PolylineOptions;

import io.flutter.plugin.common.MethodChannel;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PolylineUtils {
    private HuaweiMap huaweiMap;

    private final MethodChannel mChannel;

    private final float compactness;

    private final Map<String, PolylineController> idsOnMap;

    private final Map<String, String> ids;

    private final HMSLogger logger;

    public PolylineUtils(final MethodChannel mChannel, final float compactness, final Application application) {
        idsOnMap = new HashMap<>();
        ids = new HashMap<>();
        this.mChannel = mChannel;
        this.compactness = compactness;
        logger = HMSLogger.getInstance(application);

    }

    public void setMap(final HuaweiMap huaweiMap) {
        this.huaweiMap = huaweiMap;
    }

    private void insert(final HashMap<String, Object> polyline) {
        if (huaweiMap == null) {
            return;
        }
        if (polyline == null) {
            return;
        }

        final PolylineBuilder polylineBuilder = new PolylineBuilder(compactness);
        final String polylineId = Convert.processPolylineOptions(polyline, polylineBuilder);
        final PolylineOptions options = polylineBuilder.build();

        logger.startMethodExecutionTimer("addPolyline");
        final Polyline newPolyline = huaweiMap.addPolyline(options);
        logger.sendSingleEvent("addPolyline");

        final PolylineController controller = new PolylineController(newPolyline, polylineBuilder.isClickable(),
            compactness);
        idsOnMap.put(polylineId, controller);
        ids.put(newPolyline.getId(), polylineId);
    }

    public void insertMulti(final List<HashMap<String, Object>> polylineList) {
        if (polylineList == null) {
            return;
        }

        for (final HashMap<String, Object> polyline : polylineList) {
            insert(polyline);
        }
    }

    private void update(final HashMap<String, Object> polyline) {
        if (polyline == null) {
            return;
        }

        final String polylineId = getId(polyline);
        final PolylineController polylineController = idsOnMap.get(polylineId);
        if (polylineController == null) {
            return;
        }
        Convert.processPolylineOptions(polyline, polylineController);

    }

    public void updateMulti(final List<HashMap<String, Object>> polylineList) {
        if (polylineList == null) {
            return;
        }
        for (final HashMap<String, Object> polyline : polylineList) {
            update(polyline);
        }
    }

    public void deleteMulti(final List<String> polylineList) {
        if (polylineList == null) {
            return;
        }

        for (final String id : polylineList) {
            if (id == null) {
                continue;
            }

            final PolylineController polylineController = idsOnMap.remove(id);
            if (polylineController == null) {
                continue;
            }

            logger.startMethodExecutionTimer("removePolyline");
            polylineController.delete();
            logger.sendSingleEvent("removePolyline");

            ids.remove(polylineController.getMapPolylineId());
        }
    }

    public boolean onPolylineClick(final String mapPolylineId) {
        final String polylineId = ids.get(mapPolylineId);
        if (polylineId == null) {
            return false;
        }

        mChannel.invokeMethod(Method.POLYLINE_CLICK, ToJson.polylineId(polylineId));
        final PolylineController polylineController = idsOnMap.get(polylineId);

        return polylineController != null && polylineController.isClickable();
    }

    private static String getId(final HashMap<String, Object> polyline) {
        return (String) polyline.get(Param.POLYLINE_ID);
    }
}

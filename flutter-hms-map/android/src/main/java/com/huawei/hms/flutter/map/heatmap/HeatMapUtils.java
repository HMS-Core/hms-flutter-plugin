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

package com.huawei.hms.flutter.map.heatmap;

import android.app.Application;

import com.huawei.hms.flutter.map.constants.Param;
import com.huawei.hms.flutter.map.logger.HMSLogger;
import com.huawei.hms.flutter.map.utils.Convert;
import com.huawei.hms.maps.HuaweiMap;
import com.huawei.hms.maps.model.HeatMap;
import com.huawei.hms.maps.model.HeatMapOptions;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class HeatMapUtils {
    private HuaweiMap huaweiMap;

    private final MethodChannel mChannel;

    private final Map<String, HeatMapController> idsOnMap;

    private final Map<String, String> ids;

    private final HMSLogger logger;

    private final Application application;

    public HeatMapUtils(final MethodChannel mChannel, final Application application) {
        idsOnMap = new HashMap<>();
        ids = new HashMap<>();
        this.mChannel = mChannel;
        logger = HMSLogger.getInstance(application);
        this.application = application;
    }

    public void setMap(final HuaweiMap huaweiMap) {
        this.huaweiMap = huaweiMap;
    }

    public void insertMulti(final List<HashMap<String, Object>> heatMapList) {
        if (heatMapList == null) {
            return;
        }
        for (final HashMap<String, Object> heatMapToAdd : heatMapList) {
            insert(heatMapToAdd);
        }
    }

    private void insert(final HashMap<String, Object> heatMap) {
        if (huaweiMap == null) {
            return;
        }
        if (heatMap == null) {
            return;
        }

        final HeatMapBuilder heatMapBuilder = new HeatMapBuilder();
        final String id = Convert.processHeatMapOptions(heatMap, heatMapBuilder);
        final HeatMapOptions options = heatMapBuilder.build();

        logger.startMethodExecutionTimer("addHeatMap");
        final HeatMap newHeatMap = huaweiMap.addHeatMap(id, options);
        logger.sendSingleEvent("addHeatMap");

        final HeatMapController controller = new HeatMapController(newHeatMap, application);

        idsOnMap.put(id, controller);
        ids.put(newHeatMap.getId(), id);
    }

    private void update(final HashMap<String, Object> heatMap) {
        if (heatMap == null) {
            return;
        }
        final String heatMapId = getId(heatMap);
        final HeatMapController heatMapController = idsOnMap.get(heatMapId);
        if (heatMapController != null) {
            Convert.processHeatMapOptions(heatMap, heatMapController);
        }
    }

    public void updateMulti(final List<HashMap<String, Object>> heatMap) {
        if (heatMap == null) {
            return;
        }
        for (final HashMap<String, Object> heatMapToChange : heatMap) {
            update(heatMapToChange);
        }
    }

    public void deleteMulti(final List<String> heatMapList) {
        if (heatMapList == null) {
            return;
        }
        for (final String id : heatMapList) {
            if (id == null) {
                continue;
            }
            final HeatMapController heatMapController = idsOnMap.remove(id);
            if (heatMapController != null) {

                logger.startMethodExecutionTimer("removeHeatMap");
                heatMapController.delete();
                logger.sendSingleEvent("removeHeatMap");

                ids.remove(heatMapController.getHeatMapId());
            }
        }
    }

    private static String getId(final HashMap<String, Object> heatMap) {
        return (String) heatMap.get(Param.HEAT_MAP_ID);
    }

    private static HashMap<String, Object> heatMapIdToJson(final String heatMapId) {
        if (heatMapId == null) {
            return null;
        }
        final HashMap<String, Object> data = new HashMap<>();
        data.put(Param.HEAT_MAP_ID, heatMapId);
        return data;
    }
}

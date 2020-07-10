/*
Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.map.polyline;

import com.huawei.hms.flutter.map.constants.Method;
import com.huawei.hms.flutter.map.constants.Param;
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

    public PolylineUtils(MethodChannel mChannel, float compactness) {
        this.idsOnMap = new HashMap<>();
        this.ids = new HashMap<>();
        this.mChannel = mChannel;
        this.compactness = compactness;
    }

    public void setMap(HuaweiMap huaweiMap) {
        this.huaweiMap = huaweiMap;
    }


    private void insert(HashMap<String, Object> polyline) {
        if (huaweiMap == null) return;
        if (polyline == null) return;

        PolylineBuilder polylineBuilder = new PolylineBuilder(compactness);
        String polylineId = Convert.processPolylineOptions(polyline, polylineBuilder);
        PolylineOptions options = polylineBuilder.build();

        final Polyline newPolyline = huaweiMap.addPolyline(options);
        PolylineController controller = new PolylineController(newPolyline, polylineBuilder.isClickable(), compactness);
        idsOnMap.put(polylineId, controller);
        ids.put(newPolyline.getId(), polylineId);
    }


    public void insertMulti(List<HashMap<String, Object>> polylineList) {
        if (polylineList == null) return;

        for (HashMap<String, Object> polyline : polylineList) {
            insert(polyline);
        }
    }


    private void update(HashMap<String, Object> polyline) {
        if (polyline == null) return;

        String polylineId = getId(polyline);
        PolylineController polylineController = idsOnMap.get(polylineId);
        if (polylineController == null) return;
        Convert.processPolylineOptions(polyline, polylineController);

    }

    public void updateMulti(List<HashMap<String, Object>> polylineList) {
        if (polylineList == null) return;
        for (HashMap<String, Object> polyline : polylineList) {
            update(polyline);
        }
    }

    public void deleteMulti(List<String> polylineList) {
        if (polylineList == null) return;

        for (String id : polylineList) {
            if (id == null) continue;

            final PolylineController polylineController = idsOnMap.remove(id);
            if (polylineController == null) continue;

            polylineController.delete();
            ids.remove(polylineController.getMapPolylineId());
        }
    }

    public boolean onPolylineClick(String mapPolylineId) {
        String polylineId = ids.get(mapPolylineId);
        if (polylineId == null) return false;

        mChannel.invokeMethod(Method.POLYLINE_CLICK, ToJson.polylineId(polylineId));
        PolylineController polylineController = idsOnMap.get(polylineId);

        return polylineController != null && polylineController.isClickable();
    }

    private static String getId(HashMap<String, Object> polyline) {
        return (String) polyline.get(Param.POLYLINE_ID);
    }
}

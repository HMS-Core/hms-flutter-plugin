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

package com.huawei.hms.flutter.map.polygon;

import com.huawei.hms.flutter.map.constants.Method;
import com.huawei.hms.flutter.map.utils.Convert;
import com.huawei.hms.flutter.map.utils.ToJson;
import com.huawei.hms.maps.HuaweiMap;
import com.huawei.hms.maps.model.Polygon;
import com.huawei.hms.maps.model.PolygonOptions;

import io.flutter.plugin.common.MethodChannel;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PolygonUtils {
    private HuaweiMap huaweiMap;
    private final MethodChannel mChannel;

    private final float compactness;
    private final Map<String, PolygonController> idsOnMap;
    private final Map<String, String> ids;

    public PolygonUtils(MethodChannel mChannel, float compactness) {
        this.idsOnMap = new HashMap<>();
        this.ids = new HashMap<>();
        this.mChannel = mChannel;
        this.compactness = compactness;
    }

    public void setMap(HuaweiMap huaweiMap) {
        this.huaweiMap = huaweiMap;
    }

    private void insert(HashMap<String, Object> polygon) {
        if (huaweiMap == null) return;
        if (polygon == null) return;

        PolygonBuilder polygonBuilder = new PolygonBuilder(compactness);
        String id = Convert.processPolygonOptions(polygon, polygonBuilder);
        PolygonOptions options = polygonBuilder.build();

        final Polygon newPolygon = huaweiMap.addPolygon(options);
        PolygonController controller = new PolygonController(newPolygon, polygonBuilder.isClickable(), compactness);
        idsOnMap.put(id, controller);
        ids.put(newPolygon.getId(), id);
    }

    private void update(HashMap<String, Object> polygon) {
        if (polygon == null) return;

        String id = getId(polygon);
        PolygonController polygonController = idsOnMap.get(id);
        if (polygonController == null) return;
        Convert.processPolygonOptions(polygon, polygonController);
    }

    public void insertMulti(List<HashMap<String, Object>> polygonList) {
        if (polygonList == null) return;

        for (HashMap<String, Object> polygon : polygonList) {
            insert(polygon);
        }
    }

    public void updateMulti(List<HashMap<String, Object>> polygonList) {
        if (polygonList == null) return;

        for (HashMap<String, Object> polygonToChange : polygonList) {
            update(polygonToChange);
        }
    }

    public void deleteMulti(List<String> polygonList) {
        if (polygonList == null) return;

        for (String id : polygonList) {
            if (id == null) continue;

            final PolygonController polygonController = idsOnMap.remove(id);
            if (polygonController == null) continue;
            polygonController.delete();
            ids.remove(polygonController.getMapPolygonId());

        }
    }

    public boolean onPolygonClick(String idOnMap) {
        String id = ids.get(idOnMap);
        if (id == null) return false;

        mChannel.invokeMethod(Method.POLYGON_CLICK, ToJson.polygonId(id));
        PolygonController polygonController = idsOnMap.get(id);

        return polygonController != null && polygonController.isClickable();
    }


    private static String getId(HashMap<String, Object> polygon) {
        return (String) polygon.get("polygonId");
    }
}

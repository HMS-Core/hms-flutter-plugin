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

package com.huawei.hms.flutter.map.circle;

import com.huawei.hms.flutter.map.constants.Method;
import com.huawei.hms.flutter.map.constants.Param;
import com.huawei.hms.flutter.map.utils.Convert;
import com.huawei.hms.flutter.map.utils.ToJson;
import com.huawei.hms.maps.HuaweiMap;
import com.huawei.hms.maps.model.Circle;
import com.huawei.hms.maps.model.CircleOptions;

import io.flutter.plugin.common.MethodChannel;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CircleUtils {
    private HuaweiMap huaweiMap;
    private final MethodChannel mChannel;

    private final float compactness;
    private final Map<String, CircleController> idsOnMap;
    private final Map<String, String> ids;

    public CircleUtils(MethodChannel mChannel, float compactness) {
        this.idsOnMap = new HashMap<>();
        this.ids = new HashMap<>();
        this.mChannel = mChannel;
        this.compactness = compactness;
    }

    public void setMap(HuaweiMap huaweiMap) {
        this.huaweiMap = huaweiMap;
    }

    private void insert(HashMap<String, Object> circle) {
        if (huaweiMap == null) return;
        if (circle == null) return;

        CircleBuilder circleBuilder = new CircleBuilder(compactness);
        String circleId = Convert.processCircleOptions(circle, circleBuilder);
        CircleOptions options = circleBuilder.build();

        final Circle newCircle = huaweiMap.addCircle(options);
        CircleController controller = new CircleController(newCircle, circleBuilder.isClickable(), compactness);
        idsOnMap.put(circleId, controller);
        ids.put(newCircle.getId(), circleId);
    }

    public void insertMulti(List<HashMap<String, Object>> circlesToAdd) {
        if (circlesToAdd == null) return;

        for (HashMap<String, Object> circleToAdd : circlesToAdd) {
            insert(circleToAdd);
        }

    }

    private void update(HashMap<String, Object> circle) {
        if (circle == null) return;

        String circleId = getId(circle);
        CircleController circleController = idsOnMap.get(circleId);
        if (circleController != null) {
            Convert.processCircleOptions(circle, circleController);
        }
    }

    public void updateMulti(List<HashMap<String, Object>> circleList) {
        if (circleList == null) return;
        for (HashMap<String, Object> circleToChange : circleList) {
            update(circleToChange);
        }
    }

    public void deleteMulti(List<String> circleList) {
        if (circleList == null) return;

        for (String id : circleList) {
            if (id == null) continue;

            final CircleController circleController = idsOnMap.remove(id);
            if (circleController == null) continue;
            circleController.delete();
            ids.remove(circleController.getIdOnMap());
        }
    }

    public boolean onCircleClick(String mapCircleId) {
        String circleId = ids.get(mapCircleId);
        if (circleId == null) return false;

        mChannel.invokeMethod(Method.CIRCLE_CLICK, ToJson.circleId(circleId));
        CircleController circleController = idsOnMap.get(circleId);

        return circleController != null && circleController.isClickable();
    }

    private static String getId(HashMap<String, Object> circle) {
        return (String) circle.get(Param.CIRCLE_ID);
    }
}

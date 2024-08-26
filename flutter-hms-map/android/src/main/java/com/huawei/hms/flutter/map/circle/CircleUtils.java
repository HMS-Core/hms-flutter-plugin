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

package com.huawei.hms.flutter.map.circle;

import android.app.Application;

import com.huawei.hms.flutter.map.constants.Method;
import com.huawei.hms.flutter.map.constants.Param;
import com.huawei.hms.flutter.map.logger.HMSLogger;
import com.huawei.hms.flutter.map.utils.Convert;
import com.huawei.hms.flutter.map.utils.ToJson;
import com.huawei.hms.maps.HuaweiMap;
import com.huawei.hms.maps.model.Circle;
import com.huawei.hms.maps.model.CircleOptions;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.BinaryMessenger;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CircleUtils {
    private HuaweiMap huaweiMap;

    private final MethodChannel mChannel;

    private BinaryMessenger messenger;

    private final float compactness;

    private final Map<String, CircleController> idsOnMap;

    private final Map<String, String> ids;

    private final HMSLogger logger;

    public CircleUtils(final MethodChannel mChannel, final float compactness, final Application application) {
        idsOnMap = new HashMap<>();
        ids = new HashMap<>();
        this.mChannel = mChannel;
        this.compactness = compactness;
        logger = HMSLogger.getInstance(application);
    }

    public void setMap(final HuaweiMap huaweiMap) {
        this.huaweiMap = huaweiMap;
    }

    private void insert(final HashMap<String, Object> circle, final BinaryMessenger messenger) {
        if (huaweiMap == null) {
            return;
        }
        if (circle == null) {
            return;
        }

        final CircleBuilder circleBuilder = new CircleBuilder(compactness);
        final String circleId = Convert.processCircleOptions(circle, circleBuilder, messenger);
        final CircleOptions options = circleBuilder.build();

        logger.startMethodExecutionTimer("addCircle");
        final Circle newCircle = huaweiMap.addCircle(options);
        logger.sendSingleEvent("addCircle");

        final CircleController controller = new CircleController(newCircle, circleBuilder.isClickable(), compactness);
        if (circleBuilder.getAnimation() != null) {
            controller.setAnimation(circleBuilder.getAnimation());
        }

        idsOnMap.put(circleId, controller);
        ids.put(newCircle.getId(), circleId);
    }

    public void insertMulti(final List<HashMap<String, Object>> circlesToAdd, final BinaryMessenger messenger) {
        this.messenger = messenger;
        if (circlesToAdd == null) {
            return;
        }

        for (final HashMap<String, Object> circleToAdd : circlesToAdd) {
            insert(circleToAdd, messenger);
        }

    }

    private void update(final HashMap<String, Object> circle) {
        if (circle == null) {
            return;
        }

        final String circleId = getId(circle);
        final CircleController circleController = idsOnMap.get(circleId);
        if (circleController != null) {
            Convert.processCircleOptions(circle, circleController, messenger);
        }
    }

    public void updateMulti(final List<HashMap<String, Object>> circleList) {
        if (circleList == null) {
            return;
        }
        for (final HashMap<String, Object> circleToChange : circleList) {
            update(circleToChange);
        }
    }

    public void deleteMulti(final List<String> circleList) {
        if (circleList == null) {
            return;
        }

        for (final String id : circleList) {
            if (id == null) {
                continue;
            }

            final CircleController circleController = idsOnMap.remove(id);
            if (circleController == null) {
                continue;
            }

            logger.startMethodExecutionTimer("removeCircle");
            circleController.delete();
            logger.sendSingleEvent("removeCircle");

            ids.remove(circleController.getIdOnMap());
        }
    }

    public boolean onCircleClick(final String mapCircleId) {
        final String circleId = ids.get(mapCircleId);
        if (circleId == null) {
            return false;
        }

        mChannel.invokeMethod(Method.CIRCLE_CLICK, ToJson.circleId(circleId));
        final CircleController circleController = idsOnMap.get(circleId);

        return circleController != null && circleController.isClickable();
    }

    public void startAnimation(final String id) {
        final CircleController circleController = idsOnMap.get(id);
        if (circleController != null) {
            circleController.startAnimation();
        }
    }

    private static String getId(final HashMap<String, Object> circle) {
        return (String) circle.get(Param.CIRCLE_ID);
    }
}

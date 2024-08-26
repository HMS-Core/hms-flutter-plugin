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

package com.huawei.hms.flutter.map.groundoverlay;

import android.app.Application;

import com.huawei.hms.flutter.map.constants.Method;
import com.huawei.hms.flutter.map.constants.Param;
import com.huawei.hms.flutter.map.logger.HMSLogger;
import com.huawei.hms.flutter.map.utils.Convert;
import com.huawei.hms.flutter.map.utils.ToJson;
import com.huawei.hms.maps.HuaweiMap;
import com.huawei.hms.maps.model.GroundOverlay;
import com.huawei.hms.maps.model.GroundOverlayOptions;

import io.flutter.plugin.common.MethodChannel;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GroundOverlayUtils {
    private HuaweiMap huaweiMap;

    private final MethodChannel mChannel;

    private final Map<String, GroundOverlayController> idsOnMap;

    private final Map<String, String> ids;

    private final HMSLogger logger;

    public GroundOverlayUtils(final MethodChannel mChannel, final Application application) {
        idsOnMap = new HashMap<>();
        ids = new HashMap<>();
        this.mChannel = mChannel;
        logger = HMSLogger.getInstance(application);
    }

    public void setMap(final HuaweiMap huaweiMap) {
        this.huaweiMap = huaweiMap;
    }

    public void insertMulti(final List<HashMap<String, Object>> groundOverlayList) {
        if (groundOverlayList == null) {
            return;
        }

        for (final HashMap<String, Object> groundOverlayToAdd : groundOverlayList) {
            insert(groundOverlayToAdd);
        }
    }

    private void insert(final HashMap<String, Object> groundOverlay) {
        if (huaweiMap == null) {
            return;
        }
        if (groundOverlay == null) {
            return;
        }

        final GroundOverlayBuilder groundOverlayBuilder = new GroundOverlayBuilder();
        final String id = Convert.processGroundOverlayOptions(groundOverlay, groundOverlayBuilder);
        final GroundOverlayOptions options = groundOverlayBuilder.build();

        logger.startMethodExecutionTimer("addGroundOverlay");
        final GroundOverlay newGroundOverlay = huaweiMap.addGroundOverlay(options);
        logger.sendSingleEvent("addGroundOverlay");

        final GroundOverlayController controller = new GroundOverlayController(newGroundOverlay,
            groundOverlayBuilder.isClickable());

        idsOnMap.put(id, controller);
        ids.put(newGroundOverlay.getId(), id);
    }

    private void update(final HashMap<String, Object> groundOverlay) {
        if (groundOverlay == null) {
            return;
        }
        final String groundOverlayId = getId(groundOverlay);
        final GroundOverlayController groundOverlayController = idsOnMap.get(groundOverlayId);
        if (groundOverlayController != null) {
            Convert.processGroundOverlayOptions(groundOverlay, groundOverlayController);
        }
    }

    public void updateMulti(final List<HashMap<String, Object>> groundOverlay) {
        if (groundOverlay == null) {
            return;
        }

        for (final HashMap<String, Object> groundOverlayToChange : groundOverlay) {
            update(groundOverlayToChange);
        }
    }

    public void deleteMulti(final List<String> groundOverlayList) {
        if (groundOverlayList == null) {
            return;
        }

        for (final String id : groundOverlayList) {
            if (id == null) {
                continue;
            }

            final GroundOverlayController groundOverlayController = idsOnMap.remove(id);
            if (groundOverlayController != null) {
                logger.startMethodExecutionTimer("removeGroundOverlay");
                groundOverlayController.delete();
                logger.sendSingleEvent("removeGroundOverlay");

                ids.remove(groundOverlayController.getMapGroundOverlayId());
            }
        }
    }

    public boolean onGroundOverlayClick(final String idOnMap) {
        final String id = ids.get(idOnMap);
        if (id == null) {
            return false;
        }
        mChannel.invokeMethod(Method.GROUND_OVERLAY_CLICK, ToJson.groundOverlayId(id));
        final GroundOverlayController groundOverlayController = idsOnMap.get(id);

        if (groundOverlayController != null) {
            return groundOverlayController.isClickable();
        }
        return false;
    }

    private static String getId(final HashMap<String, Object> groundOverlay) {
        return (String) groundOverlay.get(Param.GROUND_OVERLAY_ID);
    }

}

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

package com.huawei.hms.flutter.map.tileoverlay;

import android.app.Application;

import com.huawei.hms.flutter.map.constants.Param;
import com.huawei.hms.flutter.map.logger.HMSLogger;
import com.huawei.hms.flutter.map.utils.Convert;
import com.huawei.hms.maps.HuaweiMap;
import com.huawei.hms.maps.model.TileOverlay;
import com.huawei.hms.maps.model.TileOverlayOptions;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TileOverlayUtils {
    private HuaweiMap huaweiMap;

    private final Map<String, TileOverlayController> idsOnMap;

    private final Map<String, String> ids;

    private final HMSLogger logger;

    public TileOverlayUtils(final Application application) {
        idsOnMap = new HashMap<>();
        ids = new HashMap<>();
        logger = HMSLogger.getInstance(application);
    }

    public void setMap(final HuaweiMap huaweiMap) {
        this.huaweiMap = huaweiMap;
    }

    public void insertMulti(final List<HashMap<String, Object>> tileOverlayList) {
        if (tileOverlayList == null) {
            return;
        }

        for (final HashMap<String, Object> tileOverlayToAdd : tileOverlayList) {
            insert(tileOverlayToAdd);
        }
    }

    public void insert(final HashMap<String, Object> tileOverlay) {
        if (huaweiMap == null) {
            return;
        }
        if (tileOverlay == null) {
            return;
        }

        final TileOverlayBuilder tileOverlayBuilder = new TileOverlayBuilder();
        final String id = Convert.processTileOverlayOptions(tileOverlay, tileOverlayBuilder);
        final TileOverlayOptions options = tileOverlayBuilder.build();

        logger.startMethodExecutionTimer("addTileOverlay");
        final TileOverlay newTileOverlay = huaweiMap.addTileOverlay(options);
        logger.sendSingleEvent("addTileOverlay");

        final TileOverlayController controller = new TileOverlayController(newTileOverlay);

        idsOnMap.put(id, controller);
        ids.put(newTileOverlay.getId(), id);
    }

    private void update(final HashMap<String, Object> tileOverlay) {
        if (tileOverlay == null) {
            return;
        }
        final String tileOverlayId = getId(tileOverlay);
        final TileOverlayController tileOverlayController = idsOnMap.get(tileOverlayId);
        if (tileOverlayController != null) {
            Convert.processTileOverlayOptions(tileOverlay, tileOverlayController);
        }
    }

    public void updateMulti(final List<HashMap<String, Object>> tileOverlay) {
        if (tileOverlay == null) {
            return;
        }
        for (final HashMap<String, Object> tileOverlayToChange : tileOverlay) {
            update(tileOverlayToChange);
        }
    }

    public void deleteMulti(final List<String> tileOverlayList) {
        if (tileOverlayList == null) {
            return;
        }
        for (final String id : tileOverlayList) {
            if (id == null) {
                continue;
            }

            final TileOverlayController tileOverlayController = idsOnMap.remove(id);
            if (tileOverlayController != null) {

                logger.startMethodExecutionTimer("removeTileOverlay");
                tileOverlayController.delete();
                logger.sendSingleEvent("removeTileOverlay");

                ids.remove(tileOverlayController.getMapTileOverlayId());
            }
        }
    }

    public void clearTileCache(final String id) {
        final TileOverlayController tileOverlayController = idsOnMap.get(id);
        if (tileOverlayController == null) {
            return;
        }

        logger.startMethodExecutionTimer("clearTileCache");
        tileOverlayController.clearTileCache();
        logger.sendSingleEvent("clearTileCache");
    }

    private static String getId(final HashMap<String, Object> tileOverlay) {
        return (String) tileOverlay.get(Param.TILE_OVERLAY_ID);
    }
}

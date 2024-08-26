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

import com.huawei.hms.maps.model.TileOverlay;
import com.huawei.hms.maps.model.TileProvider;

public class TileOverlayController implements TileOverlayMethods {

    private final TileOverlay tileOverlay;

    private final String mapTileOverlayId;

    TileOverlayController(final TileOverlay tileOverlay) {
        this.tileOverlay = tileOverlay;
        mapTileOverlayId = tileOverlay.getId();
    }

    @Override
    public void clearTileCache() {
        tileOverlay.clearTileCache();
    }

    @Override
    public boolean isVisible() {
        return tileOverlay.isVisible();
    }

    @Override
    public void delete() {
        tileOverlay.remove();
    }

    @Override
    public void setFadeIn(final boolean fadeIn) {
        tileOverlay.setFadeIn(fadeIn);
    }

    @Override
    public void setTransparency(final float transparency) {
        tileOverlay.setTransparency(transparency);
    }

    @Override
    public void setVisible(final boolean visible) {
        tileOverlay.setVisible(visible);
    }

    @Override
    public void setZIndex(final float zIndex) {
        tileOverlay.setZIndex(zIndex);
    }

    @Override
    public void setTileProvider(final TileProvider tileProvider) {
    }

    String getMapTileOverlayId() {
        return mapTileOverlayId;
    }
}

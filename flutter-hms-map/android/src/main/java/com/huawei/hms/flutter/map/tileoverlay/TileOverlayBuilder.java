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

import com.huawei.hms.maps.model.TileOverlayOptions;
import com.huawei.hms.maps.model.TileProvider;

public class TileOverlayBuilder implements TileOverlayMethods {
    private final TileOverlayOptions tileOverlayOptions;

    TileOverlayBuilder() {
        tileOverlayOptions = new TileOverlayOptions();
    }

    TileOverlayOptions build() {
        return tileOverlayOptions;
    }

    @Override
    public void setTileProvider(final TileProvider tileProvider) {
        tileOverlayOptions.tileProvider(tileProvider);
    }

    @Override
    public void clearTileCache() {
    }

    @Override
    public boolean isVisible() {
        return tileOverlayOptions.isVisible();
    }

    @Override
    public void delete() {
    }

    @Override
    public void setFadeIn(final boolean fadeIn) {
        tileOverlayOptions.fadeIn(fadeIn);
    }

    @Override
    public void setTransparency(final float transparency) {
        tileOverlayOptions.transparency(transparency);
    }

    @Override
    public void setVisible(final boolean visible) {
        tileOverlayOptions.visible(visible);
    }

    @Override
    public void setZIndex(final float zIndex) {
        tileOverlayOptions.zIndex(zIndex);
    }
}

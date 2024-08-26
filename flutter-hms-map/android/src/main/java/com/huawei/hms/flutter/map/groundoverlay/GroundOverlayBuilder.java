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

import com.huawei.hms.maps.model.BitmapDescriptor;
import com.huawei.hms.maps.model.GroundOverlayOptions;
import com.huawei.hms.maps.model.LatLng;
import com.huawei.hms.maps.model.LatLngBounds;

public class GroundOverlayBuilder implements GroundOverlayMethods {
    private final GroundOverlayOptions groundOverlayOptions;

    private boolean clickable;

    GroundOverlayBuilder() {
        groundOverlayOptions = new GroundOverlayOptions();
    }

    GroundOverlayOptions build() {
        return groundOverlayOptions;
    }

    @Override
    public boolean isClickable() {
        return clickable;
    }

    @Override
    public void setBearing(final float bearing) {
        groundOverlayOptions.bearing(bearing);
    }

    @Override
    public void setAnchor(final float u, final float v) {
        groundOverlayOptions.anchor(u, v);
    }

    @Override
    public void setClickable(final boolean clickable) {
        this.clickable = clickable;
        groundOverlayOptions.clickable(clickable);
    }

    @Override
    public void setImage(final BitmapDescriptor imageDescriptor) {
        groundOverlayOptions.image(imageDescriptor);
    }

    @Override
    public void setPosition(final LatLng position, final float width, final float height) {
        groundOverlayOptions.position(position, width, height);
    }

    @Override
    public void setPositionFromBounds(final LatLngBounds bounds) {
        groundOverlayOptions.positionFromBounds(bounds);
    }

    @Override
    public void setTransparency(final float transparency) {
        groundOverlayOptions.transparency(transparency);
    }

    @Override
    public void setVisible(final boolean visible) {
        groundOverlayOptions.visible(visible);
    }

    @Override
    public void setZIndex(final float zIndex) {
        groundOverlayOptions.zIndex(zIndex);
    }

    @Override
    public void delete() {
    }
}

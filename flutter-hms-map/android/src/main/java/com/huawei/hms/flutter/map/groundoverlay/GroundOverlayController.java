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
import com.huawei.hms.maps.model.GroundOverlay;
import com.huawei.hms.maps.model.LatLng;
import com.huawei.hms.maps.model.LatLngBounds;

public class GroundOverlayController implements GroundOverlayMethods {

    private final GroundOverlay groundOverlay;

    private final String mapGroundOverlayId;

    private final boolean clickable;

    GroundOverlayController(final GroundOverlay groundOverlay, final boolean clickable) {
        this.groundOverlay = groundOverlay;
        this.clickable = clickable;
        mapGroundOverlayId = groundOverlay.getId();
    }

    @Override
    public void delete() {
        groundOverlay.remove();
    }

    @Override
    public void setBearing(final float bearing) {
        groundOverlay.setBearing(bearing);
    }

    @Override
    public void setAnchor(final float u, final float v) {
    }

    @Override
    public void setClickable(final boolean clickable) {
        groundOverlay.setClickable(clickable);
    }

    @Override
    public void setImage(final BitmapDescriptor imageDescriptor) {
        groundOverlay.setImage(imageDescriptor);
    }

    @Override
    public void setPosition(final LatLng position, final float width, final float height) {
        groundOverlay.setPosition(position);
        groundOverlay.setDimensions(width, height);
    }

    @Override
    public void setPositionFromBounds(final LatLngBounds bounds) {
        groundOverlay.setPositionFromBounds(bounds);
    }

    @Override
    public void setTransparency(final float transparency) {
        groundOverlay.setTransparency(transparency);
    }

    @Override
    public void setVisible(final boolean visible) {
        groundOverlay.setVisible(visible);
    }

    @Override
    public void setZIndex(final float zIndex) {
        groundOverlay.setZIndex(zIndex);
    }

    String getMapGroundOverlayId() {
        return mapGroundOverlayId;
    }

    @Override
    public boolean isClickable() {
        return clickable;
    }
}

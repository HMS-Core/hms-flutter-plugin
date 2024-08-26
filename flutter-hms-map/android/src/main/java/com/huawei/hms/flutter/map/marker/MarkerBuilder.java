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

package com.huawei.hms.flutter.map.marker;

import com.huawei.hms.maps.model.BitmapDescriptor;
import com.huawei.hms.maps.model.LatLng;
import com.huawei.hms.maps.model.MarkerOptions;
import com.huawei.hms.maps.model.animation.AnimationSet;

class MarkerBuilder implements MarkerMethods {
    private final MarkerOptions markerOptions;

    private AnimationSet animationSet;

    MarkerBuilder() {
        markerOptions = new MarkerOptions();
    }

    MarkerOptions build() {
        return markerOptions;
    }

    boolean isClickable() {
        return markerOptions.isClickable();
    }

    public AnimationSet getAnimationSet() {
        return animationSet;
    }

    boolean isClusterable() {
        return markerOptions.ismClusterable();
    }

    @Override
    public void setClusterable(final boolean clusterable) {
        markerOptions.clusterable(clusterable);
    }

    @Override
    public void setAlpha(final float alpha) {
        markerOptions.alpha(alpha);
    }

    @Override
    public void setAnchor(final float u, final float v) {
        markerOptions.anchorMarker(u, v);
    }

    @Override
    public void setClickable(final boolean clickable) {
        markerOptions.clickable(clickable);
    }

    @Override
    public void setDraggable(final boolean draggable) {
        markerOptions.draggable(draggable);
    }

    @Override
    public void setFlat(final boolean flat) {
        markerOptions.flat(flat);
    }

    @Override
    public void setIcon(final BitmapDescriptor bitmapDescriptor) {
        markerOptions.icon(bitmapDescriptor);
    }

    @Override
    public void setInfoWindowAnchor(final float u, final float v) {
        markerOptions.infoWindowAnchor(u, v);
    }

    @Override
    public void setInfoWindowText(final String title, final String snippet) {
        markerOptions.title(title);
        markerOptions.snippet(snippet);
    }

    @Override
    public void setPosition(final LatLng position) {
        markerOptions.position(position);
    }

    @Override
    public void setRotation(final float rotation) {
        markerOptions.rotation(rotation);
    }

    @Override
    public void setVisible(final boolean visible) {
        markerOptions.visible(visible);
    }

    @Override
    public void setZIndex(final float zIndex) {
        markerOptions.zIndex(zIndex);
    }

    @Override
    public void setAnimationSet(final AnimationSet animationSet) {
        this.animationSet = animationSet;
    }

    @Override
    public void startAnimation() {
    }

    @Override
    public void delete() {

    }
}

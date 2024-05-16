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
import com.huawei.hms.maps.model.Marker;
import com.huawei.hms.maps.model.animation.AnimationSet;

class MarkerController implements MarkerMethods {

    private final Marker marker;

    private final String mapMarkerId;

    private final boolean clusterable;

    MarkerController(final Marker marker, final boolean clusterable) {
        this.marker = marker;
        mapMarkerId = marker.getId();
        this.clusterable = clusterable;
    }

    @Override
    public void delete() {
        marker.remove();
    }

    @Override
    public void setAlpha(final float alpha) {
        marker.setAlpha(alpha);
    }

    @Override
    public void setClusterable(final boolean isClusterable) {
    }

    @Override
    public void setAnchor(final float u, final float v) {
        marker.setMarkerAnchor(u, v);
    }

    @Override
    public void setClickable(final boolean clickable) {
        marker.setClickable(clickable);
    }

    @Override
    public void setDraggable(final boolean draggable) {
        marker.setDraggable(draggable);
    }

    @Override
    public void setFlat(final boolean flat) {
        marker.setFlat(flat);
    }

    @Override
    public void setIcon(final BitmapDescriptor bitmapDescriptor) {
        marker.setIcon(bitmapDescriptor);
    }

    @Override
    public void setInfoWindowAnchor(final float u, final float v) {
        marker.setInfoWindowAnchor(u, v);
    }

    @Override
    public void setInfoWindowText(final String title, final String snippet) {
        marker.setTitle(title);
        marker.setSnippet(snippet);
    }

    @Override
    public void setPosition(final LatLng position) {
        marker.setPosition(position);
    }

    @Override
    public void setRotation(final float rotation) {
        marker.setRotation(rotation);
    }

    @Override
    public void setVisible(final boolean visible) {
        marker.setVisible(visible);
    }

    @Override
    public void setZIndex(final float zIndex) {
        marker.setZIndex(zIndex);
    }

    @Override
    public void setAnimationSet(final AnimationSet animationSet) {
        marker.setAnimation(animationSet);
    }

    @Override
    public void startAnimation() {
        marker.startAnimation();
    }

    String getMapMarkerId() {
        return mapMarkerId;
    }

    boolean isClickable() {
        return marker.isClickable();
    }

    boolean isClusterable() {
        return clusterable;
    }

    void showInfoWindow() {
        marker.showInfoWindow();
    }

    void hideInfoWindow() {
        marker.hideInfoWindow();
    }

    boolean isInfoWindowShown() {
        return marker.isInfoWindowShown();
    }
}

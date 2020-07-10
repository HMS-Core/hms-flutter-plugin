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

package com.huawei.hms.flutter.map.marker;

import com.huawei.hms.maps.model.BitmapDescriptor;
import com.huawei.hms.maps.model.LatLng;
import com.huawei.hms.maps.model.MarkerOptions;

class MarkerBuilder implements MarkerMethods {
    private final MarkerOptions markerOptions;
    private boolean clickable;

    MarkerBuilder() {
        this.markerOptions = new MarkerOptions();
    }

    MarkerOptions build() {
        return markerOptions;
    }

    boolean isClickable() {
        return clickable;
    }

    @Override
    public void setAlpha(float alpha) {
        markerOptions.alpha(alpha);
    }

    @Override
    public void setAnchor(float u, float v) {
        markerOptions.anchor(u, v);
    }

    @Override
    public void setClickable(boolean clickable) {
        this.clickable = clickable;
    }

    @Override
    public void setDraggable(boolean draggable) {
        markerOptions.draggable(draggable);
    }

    @Override
    public void setFlat(boolean flat) {
        markerOptions.flat(flat);
    }

    @Override
    public void setIcon(BitmapDescriptor bitmapDescriptor) {
        markerOptions.icon(bitmapDescriptor);
    }

    @Override
    public void setInfoWindowAnchor(float u, float v) {
        markerOptions.infoWindowAnchor(u, v);
    }

    @Override
    public void setInfoWindowText(String title, String snippet) {
        markerOptions.title(title);
        markerOptions.snippet(snippet);
    }

    @Override
    public void setPosition(LatLng position) {
        markerOptions.position(position);
    }

    @Override
    public void setRotation(float rotation) {
        markerOptions.rotation(rotation);
    }

    @Override
    public void setVisible(boolean visible) {
        markerOptions.visible(visible);
    }

    @Override
    public void setZIndex(float zIndex) {
        markerOptions.zIndex(zIndex);
    }

    @Override
    public void delete() {

    }
}

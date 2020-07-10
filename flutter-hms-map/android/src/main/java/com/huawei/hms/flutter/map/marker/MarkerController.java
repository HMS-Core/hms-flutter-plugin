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
import com.huawei.hms.maps.model.Marker;

class MarkerController implements MarkerMethods {

    private final Marker marker;
    private final String mapMarkerId;
    private boolean clickable;

    MarkerController(Marker marker, boolean clickable) {
        this.marker = marker;
        this.clickable = clickable;
        this.mapMarkerId = marker.getId();
    }

    @Override
    public void delete() {
        marker.remove();
    }

    @Override
    public void setAlpha(float alpha) {
        marker.setAlpha(alpha);
    }

    @Override
    public void setAnchor(float u, float v) {
        marker.setAnchor(u, v);
    }

    @Override
    public void setClickable(boolean clickable) {
        this.clickable = clickable;
    }

    @Override
    public void setDraggable(boolean draggable) {
        marker.setDraggable(draggable);
    }

    @Override
    public void setFlat(boolean flat) {
        marker.setFlat(flat);
    }

    @Override
    public void setIcon(BitmapDescriptor bitmapDescriptor) {
        marker.setIcon(bitmapDescriptor);
    }

    @Override
    public void setInfoWindowAnchor(float u, float v) {
        marker.setInfoWindowAnchor(u, v);
    }

    @Override
    public void setInfoWindowText(String title, String snippet) {
        marker.setTitle(title);
        marker.setSnippet(snippet);
    }

    @Override
    public void setPosition(LatLng position) {
        marker.setPosition(position);
    }

    @Override
    public void setRotation(float rotation) {
        marker.setRotation(rotation);
    }

    @Override
    public void setVisible(boolean visible) {
        marker.setVisible(visible);
    }

    @Override
    public void setZIndex(float zIndex) {
        marker.setZIndex(zIndex);
    }

    String getMapMarkerId() {
        return mapMarkerId;
    }

    boolean isClickable() {
        return clickable;
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

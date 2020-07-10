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

package com.huawei.hms.flutter.map.polyline;

import com.huawei.hms.maps.model.Cap;
import com.huawei.hms.maps.model.LatLng;
import com.huawei.hms.maps.model.PatternItem;
import com.huawei.hms.maps.model.Polyline;

import java.util.List;

class PolylineController implements PolylineMethods {
    private final Polyline polyline;
    private final String mapPolylineId;
    private boolean clickable;
    private final float compactness;

    PolylineController(Polyline polyline, boolean clickable, float compactness) {
        this.polyline = polyline;
        this.clickable = clickable;
        this.compactness = compactness;
        this.mapPolylineId = polyline.getId();
    }

    @Override
    public void delete() {
        polyline.remove();
    }

    @Override
    public void setClickable(boolean clickable) {
        this.clickable = clickable;
        polyline.setClickable(clickable);
    }

    @Override
    public void setColor(int color) {
        polyline.setColor(color);
    }

    @Override
    public void setEndCap(Cap endCap) {
        polyline.setEndCap(endCap);
    }

    @Override
    public void setGeodesic(boolean geodesic) {
        polyline.setGeodesic(geodesic);
    }

    @Override
    public void setJointType(int jointType) {
        polyline.setJointType(jointType);
    }

    @Override
    public void setPattern(List<PatternItem> pattern) {
        polyline.setPattern(pattern);
    }

    @Override
    public void setPoints(List<LatLng> points) {
        polyline.setPoints(points);
    }

    @Override
    public void setStartCap(Cap startCap) {
        polyline.setStartCap(startCap);
    }

    @Override
    public void setVisible(boolean visible) {
        polyline.setVisible(visible);
    }

    @Override
    public void setWidth(float width) {
        polyline.setWidth(width * compactness);
    }

    @Override
    public void setZIndex(float zIndex) {
        polyline.setZIndex(zIndex);
    }

    String getMapPolylineId() {
        return mapPolylineId;
    }

    boolean isClickable() {
        return clickable;
    }
}

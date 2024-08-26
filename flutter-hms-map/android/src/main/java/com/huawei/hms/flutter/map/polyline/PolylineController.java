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

    PolylineController(final Polyline polyline, final boolean clickable, final float compactness) {
        this.polyline = polyline;
        this.clickable = clickable;
        this.compactness = compactness;
        mapPolylineId = polyline.getId();
    }

    @Override
    public void delete() {
        polyline.remove();
    }

    @Override
    public void setClickable(final boolean clickable) {
        this.clickable = clickable;
        polyline.setClickable(clickable);
    }

    @Override
    public void setColor(final int color) {
        polyline.setColor(color);
    }

    @Override
    public void setEndCap(final Cap endCap) {
        polyline.setEndCap(endCap);
    }

    @Override
    public void setGeodesic(final boolean geodesic) {
        polyline.setGeodesic(geodesic);
    }

    @Override
    public void setJointType(final int jointType) {
        polyline.setJointType(jointType);
    }

    @Override
    public void setPattern(final List<PatternItem> pattern) {
        polyline.setPattern(pattern);
    }

    @Override
    public void setPoints(final List<LatLng> points) {
        polyline.setPoints(points);
    }

    @Override
    public void setStartCap(final Cap startCap) {
        polyline.setStartCap(startCap);
    }

    @Override
    public void setVisible(final boolean visible) {
        polyline.setVisible(visible);
    }

    @Override
    public void setWidth(final float width) {
        polyline.setWidth(width * compactness);
    }

    @Override
    public void setZIndex(final float zIndex) {
        polyline.setZIndex(zIndex);
    }

    @Override
    public void setGradient(final boolean on) {
        polyline.setGradient(on);
    }

    @Override
    public void setColorValues(List<Integer> colorValues) {
        polyline.setColorValues(colorValues);
    }

    String getMapPolylineId() {
        return mapPolylineId;
    }

    boolean isClickable() {
        return clickable;
    }
}

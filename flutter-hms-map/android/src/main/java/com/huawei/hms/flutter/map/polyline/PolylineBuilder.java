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
import com.huawei.hms.maps.model.PolylineOptions;

import java.util.List;

class PolylineBuilder implements PolylineMethods {
    private final PolylineOptions polylineOptions;

    private boolean clickable;

    private final float compactness;

    PolylineBuilder(final float compactness) {
        polylineOptions = new PolylineOptions();
        this.compactness = compactness;
    }

    PolylineOptions build() {
        return polylineOptions;
    }

    boolean isClickable() {
        return clickable;
    }

    @Override
    public void setColor(final int color) {
        polylineOptions.color(color);
    }

    @Override
    public void setEndCap(final Cap endCap) {
        polylineOptions.endCap(endCap);
    }

    @Override
    public void setJointType(final int jointType) {
        polylineOptions.jointType(jointType);
    }

    @Override
    public void setPattern(final List<PatternItem> pattern) {
        polylineOptions.pattern(pattern);
    }

    @Override
    public void setPoints(final List<LatLng> points) {
        polylineOptions.addAll(points);
    }

    @Override
    public void delete() {
    }

    @Override
    public void setClickable(final boolean clickable) {
        this.clickable = clickable;
        polylineOptions.clickable(clickable);
    }

    @Override
    public void setGeodesic(final boolean geodisc) {
        polylineOptions.geodesic(geodisc);
    }

    @Override
    public void setStartCap(final Cap startCap) {
        polylineOptions.startCap(startCap);
    }

    @Override
    public void setVisible(final boolean visible) {
        polylineOptions.visible(visible);
    }

    @Override
    public void setWidth(final float width) {
        polylineOptions.width(width * compactness);
    }

    @Override
    public void setZIndex(final float zIndex) {
        polylineOptions.zIndex(zIndex);
    }

    @Override
    public void setGradient(boolean on) {
        polylineOptions.gradient(on);
    }

    @Override
    public void setColorValues(List<Integer> colorValues) {
        polylineOptions.colorValues(colorValues);
    }
}

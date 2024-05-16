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

package com.huawei.hms.flutter.map.polygon;

import com.huawei.hms.maps.model.LatLng;
import com.huawei.hms.maps.model.PatternItem;
import com.huawei.hms.maps.model.PolygonOptions;

import java.util.List;

class PolygonBuilder implements PolygonMethods {
    private final PolygonOptions polygonOptions;

    private final float compactness;

    private boolean clickable;

    PolygonBuilder(final float compactness) {
        polygonOptions = new PolygonOptions();
        this.compactness = compactness;
    }

    PolygonOptions build() {
        return polygonOptions;
    }

    boolean isClickable() {
        return clickable;
    }

    @Override
    public void setFillColor(final int color) {
        polygonOptions.fillColor(color);
    }

    @Override
    public void setStrokeColor(final int color) {
        polygonOptions.strokeColor(color);
    }

    @Override
    public void setPoints(final List<LatLng> points) {
        polygonOptions.addAll(points);
    }

    @Override
    public void delete() {
    }

    @Override
    public void setClickable(final boolean clickable) {
        this.clickable = clickable;
        polygonOptions.clickable(clickable);
    }

    @Override
    public void setGeodesic(final boolean geodisc) {
        polygonOptions.geodesic(geodisc);
    }

    @Override
    public void setVisible(final boolean visible) {
        polygonOptions.visible(visible);
    }

    @Override
    public void setStrokeWidth(final float width) {
        polygonOptions.strokeWidth(width * compactness);
    }

    @Override
    public void setZIndex(final float zIndex) {
        polygonOptions.zIndex(zIndex);
    }

    @Override
    public void setHoles(List<List<LatLng>> holes) {
        for (List<LatLng> hole : holes) {
            polygonOptions.addHole(hole);
        }
    }

    @Override
    public void setStrokeJointType(int strokeJointType) {
        polygonOptions.strokeJointType(strokeJointType);
    }

    @Override
    public void setStrokePattern(List<PatternItem> strokePattern) {
        polygonOptions.strokePattern(strokePattern);
    }
}

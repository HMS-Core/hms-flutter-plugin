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
import com.huawei.hms.maps.model.Polygon;

import java.util.List;

class PolygonController implements PolygonMethods {
    private final Polygon polygon;

    private final String mapPolygonId;

    private final float compactness;

    private boolean clickable;

    PolygonController(Polygon polygon, boolean clickable, float compactness) {
        this.polygon = polygon;
        this.compactness = compactness;
        this.clickable = clickable;
        this.mapPolygonId = polygon.getId();
    }

    @Override
    public void delete() {
        polygon.remove();
    }

    @Override
    public void setClickable(boolean clickable) {
        this.clickable = clickable;
        polygon.setClickable(clickable);
    }

    @Override
    public void setFillColor(int color) {
        polygon.setFillColor(color);
    }

    @Override
    public void setStrokeColor(int color) {
        polygon.setStrokeColor(color);
    }

    @Override
    public void setGeodesic(boolean geodesic) {
        polygon.setGeodesic(geodesic);
    }

    @Override
    public void setPoints(List<LatLng> points) {
        polygon.setPoints(points);
    }

    @Override
    public void setVisible(boolean visible) {
        polygon.setVisible(visible);
    }

    @Override
    public void setStrokeWidth(float width) {
        polygon.setStrokeWidth(width * compactness);
    }

    @Override
    public void setZIndex(float zIndex) {
        polygon.setZIndex(zIndex);
    }

    @Override
    public void setHoles(List<List<LatLng>> holes) {
        polygon.setHoles(holes);
    }

    @Override
    public void setStrokeJointType(int strokeJointType) {
        polygon.setStrokeJointType(strokeJointType);
    }

    @Override
    public void setStrokePattern(List<PatternItem> strokePattern) {
        polygon.setStrokePattern(strokePattern);
    }

    String getMapPolygonId() {
        return mapPolygonId;
    }

    boolean isClickable() {
        return clickable;
    }
}

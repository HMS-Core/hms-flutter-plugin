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

package com.huawei.hms.flutter.map.circle;

import com.huawei.hms.maps.model.Circle;
import com.huawei.hms.maps.model.LatLng;
import com.huawei.hms.maps.model.PatternItem;
import com.huawei.hms.maps.model.animation.Animation;

import java.util.List;

class CircleController implements CircleMethods {
    private final Circle circle;

    private final String idOnMap;

    private final float compactness;

    private boolean isClickable;

    CircleController(final Circle circle, final boolean clickable, final float compactness) {
        this.circle = circle;
        isClickable = clickable;
        this.compactness = compactness;
        idOnMap = circle.getId();
    }

    @Override
    public void delete() {
        circle.remove();
    }

    @Override
    public boolean isClickable() {
        return isClickable;
    }

    @Override
    public void setClickable(final boolean isClickable) {
        this.isClickable = isClickable;
        circle.setClickable(isClickable);
    }

    @Override
    public void setStrokeColor(final int strokeColor) {
        circle.setStrokeColor(strokeColor);
    }

    @Override
    public void setFillColor(final int fillColor) {
        circle.setFillColor(fillColor);
    }

    @Override
    public void setCenter(final LatLng center) {
        circle.setCenter(center);
    }

    @Override
    public void setRadius(final double radius) {
        circle.setRadius(radius);
    }

    @Override
    public void setVisible(final boolean visible) {
        circle.setVisible(visible);
    }

    @Override
    public void setStrokeWidth(final float strokeWidth) {
        circle.setStrokeWidth(strokeWidth * compactness);
    }

    @Override
    public void setZIndex(final float zIndex) {
        circle.setZIndex(zIndex);
    }

    @Override
    public void setStrokePattern(List<PatternItem> strokePattern) {
        circle.setStrokePattern(strokePattern);
    }

    @Override
    public void setAnimation(final Animation animation) {
        circle.setAnimation(animation);
    }

    @Override
    public void startAnimation() {
        circle.startAnimation();
    }

    String getIdOnMap() {
        return idOnMap;
    }
}

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

import com.huawei.hms.maps.model.CircleOptions;
import com.huawei.hms.maps.model.LatLng;
import com.huawei.hms.maps.model.PatternItem;
import com.huawei.hms.maps.model.animation.Animation;

import java.util.List;

class CircleBuilder implements CircleMethods {
    private final CircleOptions circleOptions;

    private final float compactness;

    private boolean clickable;

    private Animation animation;

    public Animation getAnimation() {
        return animation;
    }

    CircleBuilder(float compactness) {
        this.circleOptions = new CircleOptions();
        this.compactness = compactness;
    }

    CircleOptions build() {
        return circleOptions;
    }

    @Override
    public void delete() {
    }

    @Override
    public boolean isClickable() {
        return clickable;
    }

    @Override
    public void setCenter(LatLng center) {
        circleOptions.center(center);
    }

    @Override
    public void setRadius(double radius) {
        circleOptions.radius(radius);
    }

    @Override
    public void setStrokeColor(int color) {
        circleOptions.strokeColor(color);
    }

    @Override
    public void setFillColor(int color) {
        circleOptions.fillColor(color);
    }

    @Override
    public void setClickable(boolean clickable) {
        this.clickable = clickable;
        circleOptions.clickable(clickable);
    }

    @Override
    public void setVisible(boolean visible) {
        circleOptions.visible(visible);
    }

    @Override
    public void setStrokeWidth(float strokeWidth) {
        circleOptions.strokeWidth(strokeWidth * compactness);
    }

    @Override
    public void setZIndex(float zIndex) {
        circleOptions.zIndex(zIndex);
    }

    @Override
    public void setStrokePattern(List<PatternItem> strokePattern) {
        circleOptions.strokePattern(strokePattern);
    }

    @Override
    public void setAnimation(final Animation animation) {
        this.animation = animation;
    }

    @Override
    public void startAnimation() {
    }
}

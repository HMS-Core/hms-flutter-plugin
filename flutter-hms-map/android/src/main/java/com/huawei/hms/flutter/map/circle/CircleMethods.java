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

import com.huawei.hms.maps.model.LatLng;
import com.huawei.hms.maps.model.PatternItem;
import com.huawei.hms.maps.model.animation.Animation;

import java.util.List;

/**
 * The interface Circle methods.
 *
 * @since v.6.11.0
 */
public interface CircleMethods {

    /**
     * Delete.
     */
    void delete();

    /**
     * Is clickable boolean.
     *
     * @return the boolean
     */
    boolean isClickable();

    /**
     * Sets clickable.
     *
     * @param isClickable the is clickable
     */
    void setClickable(boolean isClickable);

    /**
     * Sets stroke color.
     *
     * @param strokeColor the stroke color
     */
    void setStrokeColor(int strokeColor);

    /**
     * Sets fill color.
     *
     * @param fillColor the fill color
     */
    void setFillColor(int fillColor);

    /**
     * Sets center.
     *
     * @param center the center
     */
    void setCenter(LatLng center);

    /**
     * Sets radius.
     *
     * @param radius the radius
     */
    void setRadius(double radius);

    /**
     * Sets visible.
     *
     * @param visible the visible
     */
    void setVisible(boolean visible);

    /**
     * Sets stroke width.
     *
     * @param strokeWidth the stroke width
     */
    void setStrokeWidth(float strokeWidth);

    /**
     * Sets z index.
     *
     * @param zIndex the z index
     */
    void setZIndex(float zIndex);

    /**
     * Sets stroke pattern.
     *
     * @param strokePattern the stroke pattern
     */
    void setStrokePattern(List<PatternItem> strokePattern);

    /**
     * Sets Animation Set.
     *
     * @param animation the animation set
     */
    void setAnimation(Animation animation);

    /**
     * Starts animation.
     */
    void startAnimation();
}

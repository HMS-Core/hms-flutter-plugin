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

import java.util.List;

/**
 * The interface Polyline methods.
 *
 * @since v.6.11.0
 */
public interface PolylineMethods {

    /**
     * Delete.
     */
    void delete();

    /**
     * Sets clickable.
     *
     * @param isClickable the is clickable
     */
    void setClickable(boolean isClickable);

    /**
     * Sets color.
     *
     * @param color the color
     */
    void setColor(int color);

    /**
     * Sets end cap.
     *
     * @param endCap the end cap
     */
    void setEndCap(Cap endCap);

    /**
     * Sets geodesic.
     *
     * @param geodesic the geodesic
     */
    void setGeodesic(boolean geodesic);

    /**
     * Sets joint type.
     *
     * @param jointType the joint type
     */
    void setJointType(int jointType);

    /**
     * Sets pattern.
     *
     * @param pattern the pattern
     */
    void setPattern(List<PatternItem> pattern);

    /**
     * Sets points.
     *
     * @param points the points
     */
    void setPoints(List<LatLng> points);

    /**
     * Sets start cap.
     *
     * @param startCap the start cap
     */
    void setStartCap(Cap startCap);

    /**
     * Sets visible.
     *
     * @param visible the visible
     */
    void setVisible(boolean visible);

    /**
     * Sets width.
     *
     * @param width the width
     */
    void setWidth(float width);

    /**
     * Sets z index.
     *
     * @param zIndex the z index
     */
    void setZIndex(float zIndex);

    /**
     * Sets gradient.
     *
     * @param on the gradient
     */
    void setGradient(boolean on);

    /**
     * Sets color values.
     *
     * @param colorValues the gradient
     */
    void setColorValues(List<Integer> colorValues);
}

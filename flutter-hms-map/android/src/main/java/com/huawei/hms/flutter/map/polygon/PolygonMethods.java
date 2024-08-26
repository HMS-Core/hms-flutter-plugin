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

import java.util.List;

/**
 * The interface Polygon methods.
 *
 * @since v.5.3.0
 */
public interface PolygonMethods {

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
     * Sets fill color.
     *
     * @param color the color
     */
    void setFillColor(int color);

    /**
     * Sets stroke color.
     *
     * @param color the color
     */
    void setStrokeColor(int color);

    /**
     * Sets geodesic.
     *
     * @param geodesic the geodesic
     */
    void setGeodesic(boolean geodesic);

    /**
     * Sets points.
     *
     * @param points the points
     */
    void setPoints(List<LatLng> points);

    /**
     * Sets visible.
     *
     * @param visible the visible
     */
    void setVisible(boolean visible);

    /**
     * Sets stroke width.
     *
     * @param width the width
     */
    void setStrokeWidth(float width);

    /**
     * Sets z index.
     *
     * @param zIndex the z index
     */
    void setZIndex(float zIndex);

    /**
     * Sets holes.
     *
     * @param holes the holes
     */
    void setHoles(List<List<LatLng>> holes);

    /**
     * Sets stroke joint type.
     *
     * @param strokeJointType the stroke joint type
     */
    void setStrokeJointType(int strokeJointType);

    /**
     * Sets stroke pattern.
     *
     * @param strokePattern the stroke pattern
     */
    void setStrokePattern(List<PatternItem> strokePattern);
}

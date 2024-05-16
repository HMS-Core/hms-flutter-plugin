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

package com.huawei.hms.flutter.map.heatmap;

import com.huawei.hms.maps.model.HeatMapOptions;

import java.util.Map;

public interface HeatMapMethods {

    /**
     * Set the color.
     *
     * @param color the colors.
     */
    void setColor(Map<Float, Integer> color);

    /**
     * Set the dataSet with resourceId.
     *
     * @param resourceId the resourceId
     */
    void setDataSet(int resourceId);

    /**
     * Set the dataSet with jsonData.
     *
     * @param jsonData the jsonData
     */
    void setDataSet(String jsonData);

    /**
     * Set the intensity.
     *
     * @param intensity the intensity.
     */
    void setIntensity(float intensity);

    /**
     * Set the intensity map.
     *
     * @param intensity the intensity map.
     */
    void setIntensity(Map<Float, Float> intensity);

    /**
     * Set the opacity.
     *
     * @param opacity the opacity.
     */
    void setOpacity(float opacity);

    /**
     * Set the opacity map.
     *
     * @param opacity the opacity map.
     */
    void setOpacity(Map<Float, Float> opacities);

    /**
     * Set the radius.
     *
     * @param radius the radius.
     */
    void setRadius(float radius);

    /**
     * Set the radius map.
     *
     * @param radius the radius map.
     */
    void setRadius(Map<Float, Float> radius);

    /**
     * Set the radiusUnit.
     *
     * @param unit the unit.
     */
    void setRadiusUnit(HeatMapOptions.RadiusUnit unit);

    /**
     * Set the resourceId.
     *
     * @param resourceId the resourceId.
     */
    void setResourceId(int resourceId);

    /**
     * Set the visible.
     *
     * @param visible the visible.
     */
    void setVisible(boolean visible);

    /**
     * Delete.
     */
    void delete();
}

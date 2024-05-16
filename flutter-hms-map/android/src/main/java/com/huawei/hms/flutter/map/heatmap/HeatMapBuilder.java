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

class HeatMapBuilder implements HeatMapMethods {
    private final HeatMapOptions heatMapOptions;

    HeatMapBuilder() {
        heatMapOptions = new HeatMapOptions();
    }

    HeatMapOptions build() {
        return heatMapOptions;
    }

    @Override
    public void setColor(Map<Float, Integer> color) {
        heatMapOptions.color(color);
    }

    @Override
    public void setDataSet(int resourceId) {
        heatMapOptions.dataSet(resourceId);
    }

    @Override
    public void setDataSet(String jsonData) {
        heatMapOptions.dataSet(jsonData);
    }

    @Override
    public void setIntensity(float intensity) {
        heatMapOptions.intensity(intensity);
    }

    @Override
    public void setIntensity(Map<Float, Float> intensity) {
        heatMapOptions.intensity(intensity);
    }

    @Override
    public void setOpacity(float opacity) {
        heatMapOptions.opacity(opacity);
    }

    @Override
    public void setOpacity(Map<Float, Float> opacities) {
        heatMapOptions.opacity(opacities);
    }

    @Override
    public void setRadius(float radius) {
        heatMapOptions.radius(radius);
    }

    @Override
    public void setRadius(Map<Float, Float> radius) {
        heatMapOptions.radius(radius);
    }

    @Override
    public void setRadiusUnit(HeatMapOptions.RadiusUnit unit) {
        heatMapOptions.radiusUnit(unit);
    }

    @Override
    public void setResourceId(int resourceId) {
        heatMapOptions.setResourceId(resourceId);
    }

    @Override
    public void setVisible(boolean visible) {
        heatMapOptions.visible(visible);
    }

    @Override
    public void delete() {
    }
}

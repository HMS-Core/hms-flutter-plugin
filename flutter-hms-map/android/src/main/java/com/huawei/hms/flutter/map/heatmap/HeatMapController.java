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

import android.content.Context;

import com.huawei.hms.maps.model.HeatMap;
import com.huawei.hms.maps.model.HeatMapOptions;

import java.util.Map;

class HeatMapController implements HeatMapMethods {
    private final HeatMap heatMap;

    private final String heatMapId;

    private final Context context;

    HeatMapController(final HeatMap heatMap, Context context) {
        this.context = context;
        this.heatMap = heatMap;
        heatMapId = heatMap.getId();
    }

    @Override
    public void delete() {
        heatMap.remove();
    }

    @Override
    public void setColor(Map<Float, Integer> color) {
        heatMap.setColor(color);
    }

    @Override
    public void setDataSet(int resourceId) {
        heatMap.changeDataSet(context, resourceId);
    }

    @Override
    public void setDataSet(String jsonData) {
        heatMap.changeDataSet(jsonData);
    }

    @Override
    public void setIntensity(float intensity) {
        heatMap.setIntensity(intensity);
    }

    @Override
    public void setIntensity(Map<Float, Float> intensity) {
        heatMap.setIntensity(intensity);
    }

    @Override
    public void setOpacity(float opacity) {
        heatMap.setOpacity(opacity);
    }

    @Override
    public void setOpacity(Map<Float, Float> opacities) {
        heatMap.setOpacity(opacities);
    }

    @Override
    public void setRadius(float radius) {
        heatMap.setRadius(radius);
    }

    @Override
    public void setRadius(Map<Float, Float> radius) {
        heatMap.setRadius(radius);
    }

    @Override
    public void setRadiusUnit(HeatMapOptions.RadiusUnit unit) {
        heatMap.setRadiusUnit(unit);
    }

    @Override
    public void setResourceId(int resourceId) {
        // uses the setDataSet method
    }

    @Override
    public void setVisible(boolean visible) {
        heatMap.setVisible(visible);
    }

    String getHeatMapId() {
        return heatMapId;
    }
}

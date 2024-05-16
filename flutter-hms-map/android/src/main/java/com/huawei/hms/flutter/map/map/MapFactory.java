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

package com.huawei.hms.flutter.map.map;

import android.app.Activity;
import android.app.Application;
import android.content.Context;

import androidx.lifecycle.Lifecycle;

import com.huawei.hms.flutter.map.constants.Param;
import com.huawei.hms.flutter.map.utils.Convert;
import com.huawei.hms.maps.model.CameraPosition;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

public class MapFactory extends PlatformViewFactory {

    private final AtomicInteger mActivityState;

    private final BinaryMessenger binaryMessenger;

    private final Application application;

    private final Activity mActivity;

    private final int activityHashCode;

    private final Lifecycle lifecycle;

    private final PluginRegistry.Registrar registrar;

    public MapFactory(final AtomicInteger state, final BinaryMessenger binaryMessenger, final Activity mActivity,
        final Lifecycle lifecycle, final PluginRegistry.Registrar registrar, final int activityHashCode) {
        super(StandardMessageCodec.INSTANCE);
        mActivityState = state;
        this.binaryMessenger = binaryMessenger;
        this.application = mActivity.getApplication();
        this.activityHashCode = activityHashCode;
        this.lifecycle = lifecycle;
        this.registrar = registrar;
        this.mActivity = mActivity;
    }

    @Override
    public PlatformView create(final Context context, final int id, final Object args) {
        final Map<String, Object> params = args != null ? (Map<String, Object>) args : new HashMap<>();
        final MapBuilder builder = new MapBuilder(application);

        Convert.processHuaweiMapOptions(params.get(Param.OPTIONS), builder);
        if (params.containsKey(Param.INITIAL_CAMERA_POSITION)) {
            final CameraPosition position = Convert.toCameraPosition(params.get(Param.INITIAL_CAMERA_POSITION));
            builder.setInitialCameraPosition(position);
        }
        if (params.containsKey(Param.MARKERS_TO_INSERT)) {
            builder.setMarkers((List<HashMap<String, Object>>) params.get(Param.MARKERS_TO_INSERT));
        }
        if (params.containsKey(Param.POLYGONS_TO_INSERT)) {
            builder.setPolygons((List<HashMap<String, Object>>) params.get(Param.POLYGONS_TO_INSERT));
        }
        if (params.containsKey(Param.POLYLINES_TO_INSERT)) {
            builder.setPolylines((List<HashMap<String, Object>>) params.get(Param.POLYLINES_TO_INSERT));
        }
        if (params.containsKey(Param.CIRCLES_TO_INSERT)) {
            builder.setCircles((List<HashMap<String, Object>>) params.get(Param.CIRCLES_TO_INSERT));
        }
        if (params.containsKey(Param.GROUND_OVERLAYS_TO_INSERT)) {
            builder.setGroundOverlays((List<HashMap<String, Object>>) params.get(Param.GROUND_OVERLAYS_TO_INSERT));
        }
        if (params.containsKey(Param.TILE_OVERLAYS_TO_INSERT)) {
            builder.setTileOverlays((List<HashMap<String, Object>>) params.get(Param.TILE_OVERLAYS_TO_INSERT));
        }
        if (params.containsKey(Param.HEAT_MAPS_TO_INSERT)) {
            builder.setHeatMaps((List<HashMap<String, Object>>) params.get(Param.HEAT_MAPS_TO_INSERT));
        }
        return builder.build(id, context, mActivity, mActivityState, binaryMessenger, application, lifecycle, registrar,
            activityHashCode);
    }
}

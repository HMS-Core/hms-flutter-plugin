/*
Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.map.map;

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

import java.util.concurrent.atomic.AtomicInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MapFactory extends PlatformViewFactory {

    private final AtomicInteger mActivityState;
    private final BinaryMessenger binaryMessenger;
    private final Application application;
    private final int activityHashCode;
    private final Lifecycle lifecycle;
    private final PluginRegistry.Registrar registrar;

    public MapFactory(
            AtomicInteger state,
            BinaryMessenger binaryMessenger,
            Application application,
            Lifecycle lifecycle,
            PluginRegistry.Registrar registrar,
            int activityHashCode) {
        super(StandardMessageCodec.INSTANCE);
        mActivityState = state;
        this.binaryMessenger = binaryMessenger;
        this.application = application;
        this.activityHashCode = activityHashCode;
        this.lifecycle = lifecycle;
        this.registrar = registrar;
    }

    @SuppressWarnings("unchecked")
    @Override
    public PlatformView create(Context context, int id, Object args) {
        Map<String, Object> params = (Map<String, Object>) args;
        final MapBuilder builder = new MapBuilder();

        Convert.processHuaweiMapOptions(params.get(Param.OPTIONS), builder);
        if (params.containsKey(Param.INITIAL_CAMERA_POSITION)) {
            CameraPosition position = Convert.toCameraPosition(params.get(Param.INITIAL_CAMERA_POSITION));
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
        return builder.build(
                id,
                context,
                mActivityState,
                binaryMessenger,
                application,
                lifecycle,
                registrar,
                activityHashCode);
    }
}

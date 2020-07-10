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

import androidx.annotation.Nullable;

import com.huawei.hms.flutter.map.constants.Method;
import com.huawei.hms.flutter.map.constants.Param;
import com.huawei.hms.flutter.map.utils.ToJson;
import com.huawei.hms.maps.HuaweiMap;
import com.huawei.hms.maps.model.Circle;
import com.huawei.hms.maps.model.LatLng;
import com.huawei.hms.maps.model.Marker;
import com.huawei.hms.maps.model.Polygon;
import com.huawei.hms.maps.model.Polyline;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class MapListenerHandler implements MapListener {
    private int id;
    private HuaweiMap huaweiMap;
    private final MethodChannel mChannel;
    private final MapUtils mapUtils;
    private boolean trackCameraPosition = false;

    MapListenerHandler(int id, MapUtils mapUtils, MethodChannel mChannel) {
        this.id = id;
        this.mChannel = mChannel;
        this.mapUtils = mapUtils;
    }

    void init(HuaweiMap huaweiMap) {
        this.huaweiMap = huaweiMap;
        setMapListener(this);
    }

    void setTrackCameraPosition(boolean trackCameraPosition) {
        this.trackCameraPosition = trackCameraPosition;
    }

    void setMapListener(@Nullable MapListener listener) {
        huaweiMap.setOnInfoWindowClickListener(this);
        huaweiMap.setOnCameraMoveListener(listener);
        huaweiMap.setOnCameraMoveStartedListener(listener);
        huaweiMap.setOnCameraIdleListener(listener);
        huaweiMap.setOnMarkerClickListener(listener);
        huaweiMap.setOnMarkerDragListener(listener);
        huaweiMap.setOnPolygonClickListener(listener);
        huaweiMap.setOnPolylineClickListener(listener);
        huaweiMap.setOnCircleClickListener(listener);
        huaweiMap.setOnMapClickListener(listener);
        huaweiMap.setOnMapLongClickListener(listener);
    }


    @Override
    public void onMapClick(LatLng latLng) {
        final Map<String, Object> arguments = new HashMap<>();
        arguments.put(Param.POSITION, ToJson.latLng(latLng));
        mChannel.invokeMethod(Method.MAP_CLICK, arguments);
    }

    @Override
    public void onMapLongClick(LatLng latLng) {
        final Map<String, Object> arguments = new HashMap<>();
        arguments.put(Param.POSITION, ToJson.latLng(latLng));
        mChannel.invokeMethod(Method.MAP_ON_LONG_PRESS, arguments);
    }

    @Override
    public void onCameraMoveStarted(int reason) {
        final Map<String, Object> arguments = new HashMap<>();
        boolean isGesture = reason == HuaweiMap.OnCameraMoveStartedListener.REASON_GESTURE;
        arguments.put(Param.IS_GESTURE, isGesture);
        mChannel.invokeMethod(Method.CAMERA_ON_MOVE_STARTED, arguments);
    }

    @Override
    public void onInfoWindowClick(Marker marker) {
        mapUtils.onInfoWindowClick(marker.getId());
    }

    @Override
    public void onCameraMove() {
        if (!trackCameraPosition) return;

        final Map<String, Object> arguments = new HashMap<>();
        arguments.put(Param.POSITION, ToJson.cameraPosition(huaweiMap.getCameraPosition()));
        mChannel.invokeMethod(Method.CAMERA_ON_MOVE, arguments);
    }

    @Override
    public void onCameraIdle() {
        mChannel.invokeMethod(Method.CAMERA_ON_IDLE, Collections.singletonMap(Param.MAP, id));
    }

    @Override
    public boolean onMarkerClick(Marker marker) {
        return mapUtils.onMarkerClick(marker.getId());
    }

    @Override
    public void onMarkerDragStart(Marker marker) {
    }

    @Override
    public void onMarkerDrag(Marker marker) {
    }

    @Override
    public void onMarkerDragEnd(Marker marker) {
        mapUtils.onMarkerDragEnd(marker.getId(), marker.getPosition());
    }

    @Override
    public void onPolygonClick(Polygon polygon) {
        mapUtils.onPolygonClick(polygon.getId());
    }

    @Override
    public void onPolylineClick(Polyline polyline) {
        mapUtils.onPolylineClick(polyline.getId());
    }

    @Override
    public void onCircleClick(Circle circle) {
        mapUtils.onCircleClick(circle.getId());
    }


}

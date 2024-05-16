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

import android.app.Application;
import android.location.Location;

import androidx.annotation.Nullable;

import com.huawei.hms.flutter.map.constants.Method;
import com.huawei.hms.flutter.map.constants.Param;
import com.huawei.hms.flutter.map.logger.HMSLogger;
import com.huawei.hms.flutter.map.utils.ToJson;
import com.huawei.hms.maps.HuaweiMap;
import com.huawei.hms.maps.model.Circle;
import com.huawei.hms.maps.model.GroundOverlay;
import com.huawei.hms.maps.model.LatLng;
import com.huawei.hms.maps.model.Marker;
import com.huawei.hms.maps.model.PointOfInterest;
import com.huawei.hms.maps.model.Polygon;
import com.huawei.hms.maps.model.Polyline;

import io.flutter.plugin.common.MethodChannel;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public class MapListenerHandler implements MapListener {
    private final int id;

    private HuaweiMap huaweiMap;

    private final MethodChannel mChannel;

    private final MapUtils mapUtils;

    private boolean trackCameraPosition = false;

    private final HMSLogger logger;

    MapListenerHandler(final int id, final MapUtils mapUtils, final MethodChannel mChannel,
        final Application application) {
        this.id = id;
        this.mChannel = mChannel;
        this.mapUtils = mapUtils;
        logger = HMSLogger.getInstance(application);
    }

    void init(final HuaweiMap huaweiMap) {
        this.huaweiMap = huaweiMap;
        setMapListener(this);
    }

    void setTrackCameraPosition(final boolean trackCameraPosition) {
        this.trackCameraPosition = trackCameraPosition;
    }

    void setMapListener(@Nullable final MapListener listener) {
        logger.startMethodExecutionTimer("setOnInfoWindowClickListener");
        huaweiMap.setOnInfoWindowClickListener(this);
        logger.sendSingleEvent("setOnInfoWindowClickListener");

        logger.startMethodExecutionTimer("setOnCameraMoveListener");
        huaweiMap.setOnCameraMoveListener(listener);
        logger.sendSingleEvent("setOnCameraMoveListener");

        logger.startMethodExecutionTimer("setOnCameraMoveStartedListener");
        huaweiMap.setOnCameraMoveStartedListener(listener);
        logger.sendSingleEvent("setOnCameraMoveStartedListener");

        logger.startMethodExecutionTimer("setOnCameraIdleListener");
        huaweiMap.setOnCameraIdleListener(listener);
        logger.sendSingleEvent("setOnCameraIdleListener");

        logger.startMethodExecutionTimer("setOnCameraMoveCanceledListener");
        huaweiMap.setOnCameraMoveCanceledListener(listener);
        logger.sendSingleEvent("setOnCameraMoveCanceledListener");

        logger.startMethodExecutionTimer("setOnMarkerClickListener");
        huaweiMap.setOnMarkerClickListener(listener);
        logger.sendSingleEvent("setOnMarkerClickListener");

        logger.startMethodExecutionTimer("setOnMarkerDragListener");
        huaweiMap.setOnMarkerDragListener(listener);
        logger.sendSingleEvent("setOnMarkerDragListener");

        logger.startMethodExecutionTimer("setOnPolygonClickListener");
        huaweiMap.setOnPolygonClickListener(listener);
        logger.sendSingleEvent("setOnPolygonClickListener");

        logger.startMethodExecutionTimer("setOnPolylineClickListener");
        huaweiMap.setOnPolylineClickListener(listener);
        logger.sendSingleEvent("setOnPolylineClickListener");

        logger.startMethodExecutionTimer("setOnCircleClickListener");
        huaweiMap.setOnCircleClickListener(listener);
        logger.sendSingleEvent("setOnCircleClickListener");

        logger.startMethodExecutionTimer("setOnMapClickListener");
        huaweiMap.setOnMapClickListener(listener);
        logger.sendSingleEvent("setOnMapClickListener");

        logger.startMethodExecutionTimer("setOnMapLongClickListener");
        huaweiMap.setOnMapLongClickListener(listener);
        logger.sendSingleEvent("setOnMapLongClickListener");

        logger.startMethodExecutionTimer("setOnGroundOverlayClickListener");
        huaweiMap.setOnGroundOverlayClickListener(listener);
        logger.sendSingleEvent("setOnGroundOverlayClickListener");

        logger.startMethodExecutionTimer("setOnPoiClickListener");
        huaweiMap.setOnPoiClickListener(listener);
        logger.sendSingleEvent("setOnPoiClickListener");

        logger.startMethodExecutionTimer("setOnMyLocationClickListener");
        huaweiMap.setOnMyLocationClickListener(listener);
        logger.sendSingleEvent("setOnMyLocationClickListener");

        logger.startMethodExecutionTimer("setOnMyLocationButtonClickListener");
        huaweiMap.setOnMyLocationButtonClickListener(listener);
        logger.sendSingleEvent("setOnMyLocationButtonClickListener");

        logger.startMethodExecutionTimer("setOnInfoWindowLongClickListener");
        huaweiMap.setOnInfoWindowLongClickListener(listener);
        logger.sendSingleEvent("setOnInfoWindowLongClickListener");

        logger.startMethodExecutionTimer("setOnInfoWindowCloseListener");
        huaweiMap.setOnInfoWindowCloseListener(listener);
        logger.sendSingleEvent("setOnInfoWindowCloseListener");
    }

    @Override
    public void onMapClick(final LatLng latLng) {
        logger.startMethodExecutionTimer(Method.MAP_CLICK);
        final Map<String, Object> arguments = new HashMap<>();
        arguments.put(Param.POSITION, ToJson.latLng(latLng));
        mChannel.invokeMethod(Method.MAP_CLICK, arguments);
        logger.sendSingleEvent(Method.MAP_CLICK);
    }

    @Override
    public void onMapLongClick(final LatLng latLng) {
        logger.startMethodExecutionTimer(Method.MAP_ON_LONG_PRESS);
        final Map<String, Object> arguments = new HashMap<>();
        arguments.put(Param.POSITION, ToJson.latLng(latLng));
        mChannel.invokeMethod(Method.MAP_ON_LONG_PRESS, arguments);
        logger.sendSingleEvent(Method.MAP_ON_LONG_PRESS);
    }

    @Override
    public void onPoiClick(PointOfInterest pointOfInterest) {
        logger.startMethodExecutionTimer(Method.MAP_ON_POI_CLICK);
        final Map<String, Object> arguments = new HashMap<>();
        arguments.put(Param.POINT_OF_INTEREST, ToJson.pointOfInterest(pointOfInterest));
        mChannel.invokeMethod(Method.MAP_ON_POI_CLICK, arguments);
        logger.sendSingleEvent(Method.MAP_ON_POI_CLICK);
    }

    @Override
    public void onMyLocationClick(Location location) {
        logger.startMethodExecutionTimer(Method.MAP_ON_MY_LOCATION_CLICK);
        final Map<String, Object> arguments = new HashMap<>();
        arguments.put(Param.LOCATION, ToJson.location(location));
        mChannel.invokeMethod(Method.MAP_ON_MY_LOCATION_CLICK, arguments);
        logger.sendSingleEvent(Method.MAP_ON_MY_LOCATION_CLICK);
    }

    @Override
    public boolean onMyLocationButtonClick() {
        logger.startMethodExecutionTimer(Method.MAP_ON_MY_LOCATION_BUTTON_CLICK);
        mChannel.invokeMethod(Method.MAP_ON_MY_LOCATION_BUTTON_CLICK, false);
        logger.sendSingleEvent(Method.MAP_ON_MY_LOCATION_BUTTON_CLICK);
        return false;
    }

    @Override
    public void onInfoWindowClick(final Marker marker) {
        mapUtils.onInfoWindowClick(marker.getId());
    }

    @Override
    public void onInfoWindowLongClick(Marker marker) {
        mapUtils.onInfoWindowLongClick(marker.getId());
    }

    @Override
    public void onInfoWindowClose(Marker marker) {
        mapUtils.onInfoWindowClose(marker.getId());
    }

    @Override
    public void onCameraMove() {
        if (!trackCameraPosition) {
            return;
        }
        logger.startMethodExecutionTimer(Method.CAMERA_ON_MOVE);
        final Map<String, Object> arguments = new HashMap<>();
        arguments.put(Param.POSITION, ToJson.cameraPosition(huaweiMap.getCameraPosition()));
        mChannel.invokeMethod(Method.CAMERA_ON_MOVE, arguments);
        logger.sendPeriodicEvent(Method.CAMERA_ON_MOVE);
    }

    @Override
    public void onCameraIdle() {
        logger.startMethodExecutionTimer(Method.CAMERA_ON_IDLE);
        mChannel.invokeMethod(Method.CAMERA_ON_IDLE, Collections.singletonMap(Param.MAP, id));
        logger.sendPeriodicEvent(Method.CAMERA_ON_IDLE);
    }

    @Override
    public void onCameraMoveStarted(final int reason) {
        logger.startMethodExecutionTimer(Method.CAMERA_ON_MOVE_STARTED);
        final Map<String, Object> arguments = new HashMap<>();
        arguments.put(Param.REASON, reason);
        mChannel.invokeMethod(Method.CAMERA_ON_MOVE_STARTED, arguments);
        logger.sendSingleEvent(Method.CAMERA_ON_MOVE_STARTED);
    }

    @Override
    public void onCameraMoveCanceled() {
        logger.startMethodExecutionTimer(Method.CAMERA_ON_MOVE_CANCELED);
        mChannel.invokeMethod(Method.CAMERA_ON_MOVE_CANCELED, Collections.singletonMap(Param.MAP, id));
        logger.sendPeriodicEvent(Method.CAMERA_ON_MOVE_CANCELED);
    }

    @Override
    public boolean onMarkerClick(final Marker marker) {
        return mapUtils.onMarkerClick(marker.getId());
    }

    @Override
    public void onMarkerDragStart(final Marker marker) {
        mapUtils.onMarkerDragStart(marker.getId(), marker.getPosition());
    }

    @Override
    public void onMarkerDrag(final Marker marker) {
        mapUtils.onMarkerDrag(marker.getId(), marker.getPosition());
    }

    @Override
    public void onMarkerDragEnd(final Marker marker) {
        mapUtils.onMarkerDragEnd(marker.getId(), marker.getPosition());
    }

    @Override
    public void onPolygonClick(final Polygon polygon) {
        mapUtils.onPolygonClick(polygon.getId());
    }

    @Override
    public void onPolylineClick(final Polyline polyline) {
        mapUtils.onPolylineClick(polyline.getId());
    }

    @Override
    public void onCircleClick(final Circle circle) {
        mapUtils.onCircleClick(circle.getId());
    }

    @Override
    public void onGroundOverlayClick(final GroundOverlay groundOverlay) {
        mapUtils.onGroundOverlayClick(groundOverlay.getId());
    }
}

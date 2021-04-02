/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.map.map;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.graphics.Rect;

import androidx.lifecycle.Lifecycle;

import com.huawei.hms.flutter.map.logger.HMSLogger;
import com.huawei.hms.maps.HuaweiMapOptions;
import com.huawei.hms.maps.model.CameraPosition;
import com.huawei.hms.maps.model.LatLngBounds;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry;

import java.util.HashMap;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

class MapBuilder implements MapMethods {
    private final HuaweiMapOptions options = new HuaweiMapOptions();

    private List<HashMap<String, Object>> markers;

    private List<HashMap<String, Object>> polygons;

    private List<HashMap<String, Object>> polylines;

    private List<HashMap<String, Object>> circles;

    private List<HashMap<String, Object>> groundOverlays;

    private List<HashMap<String, Object>> tileOverlays;

    private boolean trackCameraPosition = false;

    private boolean myLocationEnabled = false;

    private boolean myLocationButtonEnabled = false;

    private boolean trafficEnabled = false;

    private boolean buildingsEnabled = true;

    private boolean markersClustering = false;

    private Rect padding = new Rect(0, 0, 0, 0);

    private final HMSLogger logger;

    MapBuilder(final Application application) {
        logger = HMSLogger.getInstance(application);
    }

    MapController build(final int id, final Context context, final Activity mActivity, final AtomicInteger state,
        final BinaryMessenger binaryMessenger, final Application application, final Lifecycle lifecycle,
        final PluginRegistry.Registrar registrar, final int activityHashCode) {
        final MapController controller = new MapController(id, context, mActivity, state, binaryMessenger, application,
            lifecycle, registrar, activityHashCode, options);
        controller.init();
        controller.setMyLocationEnabled(myLocationEnabled);
        controller.setMyLocationButtonEnabled(myLocationButtonEnabled);
        controller.setTrafficEnabled(trafficEnabled);
        controller.setBuildingsEnabled(buildingsEnabled);
        controller.setTrackCameraPosition(trackCameraPosition);
        controller.setMarkers(markers);
        controller.setPolygons(polygons);
        controller.setPolylines(polylines);
        controller.setCircles(circles);
        controller.setPadding(padding.top, padding.left, padding.bottom, padding.right);
        controller.setGroundOverlays(groundOverlays);
        controller.setMarkersClustering(markersClustering);
        controller.setTileOverlays(tileOverlays);
        return controller;
    }

    void setInitialCameraPosition(final CameraPosition position) {
        logger.startMethodExecutionTimer("setInitialCameraPosition");
        options.camera(position);
        logger.sendSingleEvent("setInitialCameraPosition");
    }

    @Override
    public void setMarkersClustering(final boolean markersClustering) {
        this.markersClustering = markersClustering;
    }

    @Override
    public void setCompassEnabled(final boolean compassEnabled) {
        logger.startMethodExecutionTimer("setCompassEnabled");
        options.compassEnabled(compassEnabled);
        logger.sendSingleEvent("setCompassEnabled");
    }

    @Override
    public void setMapToolbarEnabled(final boolean setMapToolbarEnabled) {
        logger.startMethodExecutionTimer("setMapToolbarEnabled");
        options.mapToolbarEnabled(setMapToolbarEnabled);
        logger.sendSingleEvent("setMapToolbarEnabled");
    }

    @Override
    public void setCameraTargetBounds(final LatLngBounds bounds) {
        logger.startMethodExecutionTimer("setCameraTargetBounds");
        options.latLngBoundsForCameraTarget(bounds);
        logger.sendSingleEvent("setCameraTargetBounds");
    }

    @Override
    public void setMapType(final int mapType) {
        logger.startMethodExecutionTimer("setMapType");
        options.mapType(mapType);
        logger.sendSingleEvent("setMapType");
    }

    @Override
    public void setMinMaxZoomPreference(final Float min, final Float max) {
        if (min != null) {
            logger.startMethodExecutionTimer("setMinZoomPreference");
            options.minZoomPreference(min);
            logger.sendSingleEvent("setMinZoomPreference");
        }
        if (max != null) {
            logger.startMethodExecutionTimer("setMaxZoomPreference");
            options.maxZoomPreference(max);
            logger.sendSingleEvent("setMaxZoomPreference");
        }
    }

    @Override
    public void setPadding(final float top, final float left, final float bottom, final float right) {
        padding = new Rect((int) left, (int) top, (int) right, (int) bottom);
    }

    @Override
    public void setTrackCameraPosition(final boolean trackCameraPosition) {
        this.trackCameraPosition = trackCameraPosition;
    }

    @Override
    public void setRotateGesturesEnabled(final boolean rotateGesturesEnabled) {
        logger.startMethodExecutionTimer("setRotateGesturesEnabled");
        options.rotateGesturesEnabled(rotateGesturesEnabled);
        logger.startMethodExecutionTimer("setRotateGesturesEnabled");
    }

    @Override
    public void setScrollGesturesEnabled(final boolean scrollGesturesEnabled) {
        logger.startMethodExecutionTimer("setScrollGesturesEnabled");
        options.scrollGesturesEnabled(scrollGesturesEnabled);
        logger.sendSingleEvent("setScrollGesturesEnabled");
    }

    @Override
    public void setTiltGesturesEnabled(final boolean tiltGesturesEnabled) {
        logger.startMethodExecutionTimer("setTiltGesturesEnabled");
        options.tiltGesturesEnabled(tiltGesturesEnabled);
        logger.sendSingleEvent("setTiltGesturesEnabled");
    }

    @Override
    public void setZoomGesturesEnabled(final boolean zoomGesturesEnabled) {
        logger.startMethodExecutionTimer("setZoomGesturesEnabled");
        options.zoomGesturesEnabled(zoomGesturesEnabled);
        logger.sendSingleEvent("setZoomGesturesEnabled");
    }

    @Override
    public void setTrafficEnabled(final boolean trafficEnabled) {
        this.trafficEnabled = trafficEnabled;
    }

    @Override
    public void setBuildingsEnabled(final boolean buildingsEnabled) {
        this.buildingsEnabled = buildingsEnabled;
    }

    @Override
    public void setMyLocationEnabled(final boolean myLocationEnabled) {
        this.myLocationEnabled = myLocationEnabled;
    }

    @Override
    public void setZoomControlsEnabled(final boolean zoomControlsEnabled) {
        logger.startMethodExecutionTimer("setZoomControlsEnabled");
        options.zoomControlsEnabled(zoomControlsEnabled);
        logger.sendSingleEvent("setZoomControlsEnabled");
    }

    @Override
    public void setMyLocationButtonEnabled(final boolean myLocationButtonEnabled) {
        this.myLocationButtonEnabled = myLocationButtonEnabled;
    }

    @Override
    public void setMarkers(final List<HashMap<String, Object>> markers) {
        this.markers = markers;
    }

    @Override
    public void setPolygons(final List<HashMap<String, Object>> polygons) {
        this.polygons = polygons;
    }

    @Override
    public void setPolylines(final List<HashMap<String, Object>> polylines) {
        this.polylines = polylines;
    }

    @Override
    public void setCircles(final List<HashMap<String, Object>> initCircles) {
        circles = initCircles;
    }

    @Override
    public void setGroundOverlays(final List<HashMap<String, Object>> groundOverlays) {
        this.groundOverlays = groundOverlays;
    }

    @Override
    public void setTileOverlays(final List<HashMap<String, Object>> tileOverlays) {
        this.tileOverlays = tileOverlays;
    }
}

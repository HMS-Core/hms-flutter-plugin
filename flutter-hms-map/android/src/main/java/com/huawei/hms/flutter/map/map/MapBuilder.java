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
import android.graphics.Rect;

import androidx.lifecycle.Lifecycle;

import com.huawei.hms.maps.HuaweiMapOptions;
import com.huawei.hms.maps.model.CameraPosition;
import com.huawei.hms.maps.model.LatLngBounds;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry;

import java.util.concurrent.atomic.AtomicInteger;
import java.util.HashMap;
import java.util.List;

class MapBuilder implements MapMethods {
    private final HuaweiMapOptions options = new HuaweiMapOptions();

    private List<HashMap<String,Object>> markers;
    private List<HashMap<String,Object>> polygons;
    private List<HashMap<String,Object>> polylines;
    private List<HashMap<String,Object>> circles;

    private boolean trackCameraPosition = false;
    private boolean myLocationEnabled = false;
    private boolean myLocationButtonEnabled = false;
    private boolean trafficEnabled = false;
    private boolean buildingsEnabled = true;

    private Rect padding = new Rect(0, 0, 0, 0);

    MapController build(
            int id,
            Context context,
            AtomicInteger state,
            BinaryMessenger binaryMessenger,
            Application application,
            Lifecycle lifecycle,
            PluginRegistry.Registrar registrar,
            int activityHashCode) {
        final MapController controller =
                new MapController(
                        id,
                        context,
                        state,
                        binaryMessenger,
                        application,
                        lifecycle,
                        registrar,
                        activityHashCode,
                        options);
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
        return controller;
    }

    void setInitialCameraPosition(CameraPosition position) {
        options.camera(position);
    }

    @Override
    public void setCompassEnabled(boolean compassEnabled) {
        options.compassEnabled(compassEnabled);
    }

    @Override
    public void setMapToolbarEnabled(boolean setMapToolbarEnabled) {
        options.mapToolbarEnabled(setMapToolbarEnabled);
    }

    @Override
    public void setCameraTargetBounds(LatLngBounds bounds) {
        options.latLngBoundsForCameraTarget(bounds);
    }

    @Override
    public void setMapType(int mapType) {
        options.mapType(mapType);
    }

    @Override
    public void setMinMaxZoomPreference(Float min, Float max) {
        if (min != null) {
            options.minZoomPreference(min);
        }
        if (max != null) {
            options.maxZoomPreference(max);
        }
    }

    @Override
    public void setPadding(float top, float left, float bottom, float right) {
        this.padding = new Rect((int) left, (int) top, (int) right, (int) bottom);
    }

    @Override
    public void setTrackCameraPosition(boolean trackCameraPosition) {
        this.trackCameraPosition = trackCameraPosition;
    }

    @Override
    public void setRotateGesturesEnabled(boolean rotateGesturesEnabled) {
        options.rotateGesturesEnabled(rotateGesturesEnabled);
    }

    @Override
    public void setScrollGesturesEnabled(boolean scrollGesturesEnabled) {
        options.scrollGesturesEnabled(scrollGesturesEnabled);
    }

    @Override
    public void setTiltGesturesEnabled(boolean tiltGesturesEnabled) {
        options.tiltGesturesEnabled(tiltGesturesEnabled);
    }

    @Override
    public void setZoomGesturesEnabled(boolean zoomGesturesEnabled) {
        options.zoomGesturesEnabled(zoomGesturesEnabled);
    }

    @Override
    public void setTrafficEnabled(boolean trafficEnabled) {
        this.trafficEnabled = trafficEnabled;
    }

    @Override
    public void setBuildingsEnabled(boolean buildingsEnabled) {
        this.buildingsEnabled = buildingsEnabled;
    }

    @Override
    public void setMyLocationEnabled(boolean myLocationEnabled) {
        this.myLocationEnabled = myLocationEnabled;
    }

    @Override
    public void setZoomControlsEnabled(boolean zoomControlsEnabled) {
        options.zoomControlsEnabled(zoomControlsEnabled);
    }

    @Override
    public void setMyLocationButtonEnabled(boolean myLocationButtonEnabled) {
        this.myLocationButtonEnabled = myLocationButtonEnabled;
    }

    @Override
    public void setMarkers(List<HashMap<String,Object>> markers) {
        this.markers = markers;
    }

    @Override
    public void setPolygons(List<HashMap<String,Object>> polygons) {
        this.polygons = polygons;
    }

    @Override
    public void setPolylines(List<HashMap<String,Object>> polylines) {
        this.polylines = polylines;
    }

    @Override
    public void setCircles(List<HashMap<String,Object>> initCircles) {
        this.circles = initCircles;
    }
}

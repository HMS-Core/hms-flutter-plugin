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
import android.graphics.Point;
import android.graphics.Rect;

import androidx.annotation.NonNull;
import androidx.lifecycle.Lifecycle;

import com.huawei.hms.flutter.map.logger.HMSLogger;
import com.huawei.hms.maps.HuaweiMapOptions;
import com.huawei.hms.maps.model.BitmapDescriptor;
import com.huawei.hms.maps.model.CameraPosition;
import com.huawei.hms.maps.model.LatLngBounds;
import com.huawei.hms.maps.model.MyLocationStyle;

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

    private List<HashMap<String, Object>> heatMaps;

    private boolean trackCameraPosition = false;

    private boolean myLocationEnabled = false;

    private boolean myLocationButtonEnabled = false;

    private boolean trafficEnabled = false;

    private boolean buildingsEnabled = true;

    private boolean markersClustering = false;

    private Boolean allGesturesEnabled;

    private boolean scrollGesturesEnabledDuringRotateOrZoom = true;

    private boolean gestureScaleByMapCenter = false;

    private Rect padding = new Rect(0, 0, 0, 0);

    private Point pointToCenter;

    private Integer clusterMarkerColor;

    private Integer clusterMarkerTextColor;

    private BitmapDescriptor iconDescriptor;

    private MyLocationStyle myLocationStyle;

    private int logoPosition;

    private Rect logoPadding = new Rect(0, 0, 0, 0);

    private final HMSLogger logger;

    MapBuilder(final Application application) {
        logger = HMSLogger.getInstance(application);
    }

    MapController build(final int id, @NonNull final Context context, final Activity mActivity,
        final AtomicInteger state, final BinaryMessenger binaryMessenger, final Application application,
        final Lifecycle lifecycle, final PluginRegistry.Registrar registrar, final int activityHashCode) {
        final MapController controller = new MapController(id, context, mActivity, state, binaryMessenger, application,
            lifecycle, registrar, activityHashCode, options);
        controller.init();
        controller.setAllGesturesEnabled(allGesturesEnabled);
        controller.setScrollGesturesEnabledDuringRotateOrZoom(scrollGesturesEnabledDuringRotateOrZoom);
        controller.setGestureScaleByMapCenter(gestureScaleByMapCenter);
        controller.setMyLocationEnabled(myLocationEnabled);
        controller.setMyLocationButtonEnabled(myLocationButtonEnabled);
        controller.setTrafficEnabled(trafficEnabled);
        controller.setBuildingsEnabled(buildingsEnabled);
        controller.setTrackCameraPosition(trackCameraPosition);
        controller.setMarkers(markers);
        controller.setPolygons(polygons);
        controller.setPolylines(polylines);
        controller.setCircles(circles);
        controller.setHeatMaps(heatMaps);
        controller.setPadding(padding.top, padding.left, padding.bottom, padding.right);
        controller.setPointToCenter(pointToCenter);
        controller.setGroundOverlays(groundOverlays);
        controller.setMarkersClustering(markersClustering);
        controller.setTileOverlays(tileOverlays);
        controller.setClusterMarkerColor(clusterMarkerColor);
        controller.setClusterMarkerTextColor(clusterMarkerTextColor);
        controller.setClusterMarkerIcon(iconDescriptor);
        controller.setMyLocationStyle(myLocationStyle);
        controller.setLogoPosition(logoPosition);
        controller.setLogoPadding(logoPadding.left, logoPadding.top, logoPadding.right, logoPadding.bottom);
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
    public void setDark(final boolean isDark) {
        logger.startMethodExecutionTimer("setDark");
        options.dark(isDark);
        logger.sendSingleEvent("setDark");
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
    public void setAllGesturesEnabled(Boolean allGesturesEnabled) {
        this.allGesturesEnabled = allGesturesEnabled;
    }

    @Override
    public void setScrollGesturesEnabledDuringRotateOrZoom(boolean scrollGesturesEnabledDuringRotateOrZoom) {
        this.scrollGesturesEnabledDuringRotateOrZoom = scrollGesturesEnabledDuringRotateOrZoom;
    }

    @Override
    public void setGestureScaleByMapCenter(boolean gestureScaleByMapCenter) {
        this.gestureScaleByMapCenter = gestureScaleByMapCenter;
    }

    @Override
    public void setPointToCenter(Point pointToCenter) {
        this.pointToCenter = pointToCenter;
    }

    @Override
    public void setClusterMarkerColor(Integer color) {
        this.clusterMarkerColor = color;
    }

    @Override
    public void setClusterMarkerTextColor(Integer color) {
        this.clusterMarkerTextColor = color;
    }

    @Override
    public void setClusterMarkerIcon(BitmapDescriptor iconDescriptor) {
        this.iconDescriptor = iconDescriptor;
    }

    @Override
    public void setLogoPosition(int logoPosition) {
        this.logoPosition = logoPosition;
    }

    @Override
    public void setLogoPadding(int paddingStart, int paddingTop, int paddingEnd, int paddingBottom) {
        this.logoPadding = new Rect(paddingStart, paddingTop, paddingEnd, paddingBottom);
    }

    @Override
    public void setPreviewId(String previewId) {
        logger.startMethodExecutionTimer("setPreviewId");
        options.previewId(previewId);
        logger.sendSingleEvent("setPreviewId");
    }

    @Override
    public void setLiteMode(Boolean liteMode) {
        logger.startMethodExecutionTimer("setLiteMode");
        options.liteMode(liteMode);
        logger.sendSingleEvent("setLiteMode");
    }

    @Override
    public void setStyleId(String styleId) {
        logger.startMethodExecutionTimer("setStyleId");
        options.styleId(styleId);
        logger.sendSingleEvent("setStyleId");
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
    public void setMyLocationStyle(final MyLocationStyle myLocationStyle) {
        this.myLocationStyle = myLocationStyle;
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

    @Override
    public void setHeatMaps(final List<HashMap<String, Object>> heatMaps) {
        this.heatMaps = heatMaps;
    }
}

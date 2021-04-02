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

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Point;
import android.os.Bundle;
import android.util.Log;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.lifecycle.DefaultLifecycleObserver;
import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleOwner;

import com.huawei.hms.flutter.map.HmsMap;
import com.huawei.hms.flutter.map.constants.Channel;
import com.huawei.hms.flutter.map.constants.Method;
import com.huawei.hms.flutter.map.constants.Param;
import com.huawei.hms.flutter.map.logger.HMSLogger;
import com.huawei.hms.flutter.map.utils.Convert;
import com.huawei.hms.flutter.map.utils.ToJson;
import com.huawei.hms.maps.CameraUpdate;
import com.huawei.hms.maps.HuaweiMap;
import com.huawei.hms.maps.HuaweiMapOptions;
import com.huawei.hms.maps.MapView;
import com.huawei.hms.maps.OnMapReadyCallback;
import com.huawei.hms.maps.model.LatLng;
import com.huawei.hms.maps.model.LatLngBounds;

import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.platform.PlatformView;

import java.io.ByteArrayOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

final class MapController
    implements MapMethods, MethodChannel.MethodCallHandler, OnMapReadyCallback, DefaultLifecycleObserver,
    Application.ActivityLifecycleCallbacks, PlatformView, ActivityPluginBinding.OnSaveInstanceStateListener {

    private final AtomicInteger activityState;

    private final MethodChannel methodChannel;

    private MethodChannel.Result mapReadyResult;

    private final int activityHashCode;

    private final Lifecycle lifecycle;

    private final Context context;

    private final Application mApplication;

    private final PluginRegistry.Registrar registrar;

    private final MapView mapView;

    private HuaweiMap huaweiMap;

    private boolean trackCameraPosition = false;

    private boolean myLocationEnabled = false;

    private boolean myLocationButtonEnabled = false;

    private boolean zoomControlsEnabled = true;

    private boolean trafficEnabled = false;

    private boolean buildingsEnabled = true;

    private boolean disposed = false;

    private final float compactness;

    private boolean markersClustering = false;

    private List<HashMap<String, Object>> initMarkers;

    private List<HashMap<String, Object>> initPolylines;

    private List<HashMap<String, Object>> initPolygons;

    private List<HashMap<String, Object>> initCircles;

    private List<HashMap<String, Object>> initGroundOverlays;

    private List<HashMap<String, Object>> initTileOverlays;

    private final MapUtils mapUtils;

    private final MapListenerHandler mapListenerHandler;

    private final BinaryMessenger messenger;

    private final HMSLogger logger;

    MapController(final int id, final Context context, final Activity mActivity, final AtomicInteger activityState,
        final BinaryMessenger binaryMessenger, final Application application, final Lifecycle lifecycle,
        final PluginRegistry.Registrar registrar, final int registrarActivityHashCode, final HuaweiMapOptions options) {
        this.context = context;
        this.activityState = activityState;
        mapView = new MapView(mActivity, options);
        compactness = context.getResources().getDisplayMetrics().density;
        messenger = binaryMessenger;
        methodChannel = new MethodChannel(binaryMessenger, Channel.CHANNEL + "_" + id);
        methodChannel.setMethodCallHandler(this);
        mApplication = application;
        this.lifecycle = lifecycle;
        this.registrar = registrar;
        activityHashCode = registrarActivityHashCode;
        mapUtils = new MapUtils(methodChannel, compactness, application);
        mapListenerHandler = new MapListenerHandler(id, mapUtils, methodChannel, application);
        logger = HMSLogger.getInstance(application);
    }

    @Override
    public View getView() {
        return mapView;
    }

    void init() {
        final String caseTag = "MapController init";
        switch (activityState.get()) {
            case HmsMap.STOPPED:
                Log.i(caseTag, "HmsMap.Stopped");
                mapView.onCreate(null);
                mapView.onStart();
                mapView.onResume();
                mapView.onPause();
                mapView.onStop();
                break;
            case HmsMap.PAUSED:
                Log.i(caseTag, "HmsMap.Paused");
                mapView.onCreate(null);
                mapView.onStart();
                mapView.onResume();
                mapView.onPause();
                break;
            case HmsMap.RESUMED:
                Log.i(caseTag, "HmsMap.Resumed");
                mapView.onCreate(null);
                mapView.onStart();
                mapView.onResume();
                break;
            case HmsMap.STARTED:
                Log.i(caseTag, "HmsMap.Started");
                mapView.onCreate(null);
                mapView.onStart();
                break;
            case HmsMap.CREATED:
                Log.i(caseTag, "HmsMap.Created");
                mapView.onCreate(null);
                break;
            case HmsMap.DESTROYED:
                Log.i(caseTag, "HmsMap.Destroyed");
                break;
            default:
                throw new IllegalArgumentException("Cannot interpret " + activityState.get() + " as an activity state");
        }
        if (lifecycle != null) {
            lifecycle.addObserver(this);
        } else {
            getApplication().registerActivityLifecycleCallbacks(this);
        }
        mapView.getMapAsync(this);
    }

    @Override
    public void onMethodCall(final MethodCall call, final MethodChannel.Result result) {
        switch (call.method) {
            case Method.MAP_WAIT_FOR_MAP:
                if (huaweiMap != null) {
                    result.success(null);
                    return;
                }
                mapReadyResult = result;
                break;
            case Method.MAP_UPDATE: {
                Convert.processHuaweiMapOptions(call.argument(Param.OPTIONS), this);
                logger.startMethodExecutionTimer("getCameraPosition");
                result.success(ToJson.cameraPosition(mapUtils.getCameraPosition(trackCameraPosition)));
                logger.sendSingleEvent("getCameraPosition");
                break;
            }
            case Method.MAP_GET_VISIBLE_REGION: {
                logger.startMethodExecutionTimer(Method.MAP_GET_VISIBLE_REGION);
                if (huaweiMap != null) {
                    final LatLngBounds latLngBounds = huaweiMap.getProjection().getVisibleRegion().latLngBounds;
                    result.success(ToJson.latlngBounds(latLngBounds));
                    logger.sendSingleEvent(Method.MAP_GET_VISIBLE_REGION);
                } else {
                    result.error(Param.ERROR, Method.MAP_GET_VISIBLE_REGION, null);
                    logger.sendSingleEvent(Method.MAP_GET_VISIBLE_REGION, "getProjection.getVisibleRegion error");
                }
                break;
            }
            case Method.MAP_GET_SCREEN_COORDINATE: {
                logger.startMethodExecutionTimer(Method.MAP_GET_SCREEN_COORDINATE);
                if (huaweiMap != null) {
                    final LatLng latLng = Convert.toLatLng(call.arguments);
                    final Point screenLocation = huaweiMap.getProjection().toScreenLocation(latLng);
                    result.success(ToJson.point(screenLocation));
                    logger.sendSingleEvent(Method.MAP_GET_SCREEN_COORDINATE);
                } else {
                    result.error(Param.ERROR, Method.MAP_GET_SCREEN_COORDINATE, null);
                    logger.sendSingleEvent(Method.MAP_GET_SCREEN_COORDINATE, "getProjection.toScreenLocation error");
                }
                break;
            }
            case Method.MAP_GET_LAT_LNG: {
                logger.startMethodExecutionTimer(Method.MAP_GET_LAT_LNG);
                if (huaweiMap != null) {
                    final Point point = Convert.toPoint(call.arguments);
                    final LatLng latLng = huaweiMap.getProjection().fromScreenLocation(point);
                    result.success(ToJson.latLng(latLng));
                    logger.sendSingleEvent(Method.MAP_GET_LAT_LNG);
                } else {
                    result.error(Param.ERROR, Method.MAP_GET_LAT_LNG, null);
                    logger.sendSingleEvent(Method.MAP_GET_LAT_LNG, "getProjection.fromScreenLocation error");
                }
                break;
            }
            case Method.CAMERA_MOVE: {
                final CameraUpdate cameraUpdate = Convert.toCameraUpdate(call.argument(Param.CAMERA_UPDATE),
                    compactness);
                mapUtils.moveCamera(cameraUpdate);
                result.success(null);
                break;
            }
            case Method.MAP_TAKE_SNAPSHOT: {
                logger.startMethodExecutionTimer(Method.MAP_TAKE_SNAPSHOT);
                if (huaweiMap != null) {
                    huaweiMap.snapshot(bitmap -> {
                        final ByteArrayOutputStream stream = new ByteArrayOutputStream();
                        bitmap.compress(Bitmap.CompressFormat.PNG, 85, stream);
                        final byte[] byteArray = stream.toByteArray();
                        bitmap.recycle();
                        result.success(byteArray);
                    });
                    logger.sendSingleEvent(Method.MAP_TAKE_SNAPSHOT);
                } else {
                    result.error(Param.ERROR, Method.MAP_TAKE_SNAPSHOT, null);
                    logger.sendSingleEvent(Method.MAP_TAKE_SNAPSHOT, "snapshotError");
                }
                break;
            }
            default:
                mapUtils.onMethodCallCamera(call, result);
        }
    }

    @Override
    public void onMapReady(final HuaweiMap huaweiMap) {
        this.huaweiMap = huaweiMap;

        logger.startMethodExecutionTimer("MapController-setTrafficEnabled");
        this.huaweiMap.setTrafficEnabled(trafficEnabled);
        logger.sendSingleEvent("MapController-setTrafficEnabled");

        logger.startMethodExecutionTimer("MapController-setBuildingsEnabled");
        this.huaweiMap.setBuildingsEnabled(buildingsEnabled);
        logger.sendSingleEvent("MapController-setBuildingsEnabled");

        logger.startMethodExecutionTimer("MapController-setMarkersClustering");
        this.huaweiMap.setMarkersClustering(markersClustering);
        logger.sendSingleEvent("MapController-setMarkersClustering");

        if (mapReadyResult != null) {
            mapReadyResult.success(null);
            mapReadyResult = null;
        }
        mapListenerHandler.init(huaweiMap);
        mapUtils.init(huaweiMap, initMarkers, initPolylines, initPolygons, initCircles, initGroundOverlays,
            initTileOverlays, markersClustering, messenger);
        updateMyLocationSettings();
    }

    @Override
    public void dispose() {
        if (disposed) {
            return;
        }

        disposed = true;
        methodChannel.setMethodCallHandler(null);
        mapListenerHandler.setMapListener(null);
        getApplication().unregisterActivityLifecycleCallbacks(this);
    }

    @Override
    public void setCameraTargetBounds(final LatLngBounds bounds) {
        logger.startMethodExecutionTimer("MapController-setLatLngBoundsForCameraTarget");
        huaweiMap.setLatLngBoundsForCameraTarget(bounds);
        logger.sendSingleEvent("MapController-setLatLngBoundsForCameraTarget");
    }

    @Override
    public void setCompassEnabled(final boolean compassEnabled) {
        logger.startMethodExecutionTimer("MapController-setCompassEnabled");
        huaweiMap.getUiSettings().setCompassEnabled(compassEnabled);
        logger.sendSingleEvent("MapController-setCompassEnabled");
    }

    @Override
    public void setMapToolbarEnabled(final boolean mapToolbarEnabled) {
        logger.startMethodExecutionTimer("MapController-setMapToolbarEnabled");
        huaweiMap.getUiSettings().setMapToolbarEnabled(mapToolbarEnabled);
        logger.sendSingleEvent("MapController-setMapToolbarEnabled");
    }

    @Override
    public void setMapType(final int mapType) {
        logger.startMethodExecutionTimer("MapController-setMapType");
        huaweiMap.setMapType(mapType);
        logger.sendSingleEvent("MapController-setMapType");
    }

    @Override
    public void setTrackCameraPosition(final boolean trackCameraPosition) {
        this.trackCameraPosition = trackCameraPosition;
        mapListenerHandler.setTrackCameraPosition(trackCameraPosition);
    }

    @Override
    public void setRotateGesturesEnabled(final boolean rotateGesturesEnabled) {
        logger.startMethodExecutionTimer("MapController-setRotateGesturesEnabled");
        huaweiMap.getUiSettings().setRotateGesturesEnabled(rotateGesturesEnabled);
        logger.sendSingleEvent("MapController-setRotateGesturesEnabled");
    }

    @Override
    public void setScrollGesturesEnabled(final boolean scrollGesturesEnabled) {
        logger.startMethodExecutionTimer("MapController-setScrollGesturesEnabled");
        huaweiMap.getUiSettings().setScrollGesturesEnabled(scrollGesturesEnabled);
        logger.sendSingleEvent("MapController-setScrollGesturesEnabled");
    }

    @Override
    public void setTiltGesturesEnabled(final boolean tiltGesturesEnabled) {
        logger.startMethodExecutionTimer("MapController-setTiltGesturesEnabled");
        huaweiMap.getUiSettings().setTiltGesturesEnabled(tiltGesturesEnabled);
        logger.sendSingleEvent("MapController-setTiltGesturesEnabled");
    }

    @Override
    public void setMinMaxZoomPreference(final Float min, final Float max) {
        logger.startMethodExecutionTimer("resetMinMaxZoomPreference");
        huaweiMap.resetMinMaxZoomPreference();
        logger.sendSingleEvent("resetMinMaxZoomPreference");

        if (min != null) {
            logger.startMethodExecutionTimer("MapController-setMinZoomPreference");
            huaweiMap.setMinZoomPreference(min);
            logger.sendSingleEvent("MapController-setMinZoomPreference");
        }
        if (max != null) {
            logger.startMethodExecutionTimer("MapController-setMaxZoomPreference");
            huaweiMap.setMaxZoomPreference(max);
            logger.sendSingleEvent("MapController-setMaxZoomPreference");
        }
    }

    @Override
    public void setPadding(final float top, final float left, final float bottom, final float right) {
        if (huaweiMap == null) {
            return;
        }

        logger.startMethodExecutionTimer("MapController-setPadding");
        huaweiMap.setPadding((int) (left * compactness), (int) (top * compactness), (int) (right * compactness),
            (int) (bottom * compactness));
        logger.sendSingleEvent("MapController-setPadding");
    }

    @Override
    public void setZoomGesturesEnabled(final boolean zoomGesturesEnabled) {
        logger.startMethodExecutionTimer("MapController-setZoomGesturesEnabled");
        huaweiMap.getUiSettings().setZoomGesturesEnabled(zoomGesturesEnabled);
        logger.sendSingleEvent("MapController-setZoomGesturesEnabled");
    }

    @Override
    public void setMyLocationEnabled(final boolean myLocationEnabled) {
        if (this.myLocationEnabled == myLocationEnabled) {
            return;
        }

        this.myLocationEnabled = myLocationEnabled;
        if (huaweiMap != null) {
            updateMyLocationSettings();
        }
    }

    @Override
    public void setMyLocationButtonEnabled(final boolean myLocationButtonEnabled) {
        if (this.myLocationButtonEnabled == myLocationButtonEnabled) {
            return;
        }

        this.myLocationButtonEnabled = myLocationButtonEnabled;
        if (huaweiMap != null) {
            updateMyLocationSettings();
        }

    }

    @Override
    public void setZoomControlsEnabled(final boolean zoomControlsEnabled) {
        if (this.zoomControlsEnabled == zoomControlsEnabled) {
            return;
        }

        this.zoomControlsEnabled = zoomControlsEnabled;
        if (huaweiMap != null) {
            logger.startMethodExecutionTimer("MapController-setZoomControlsEnabled");
            huaweiMap.getUiSettings().setZoomControlsEnabled(zoomControlsEnabled);
            logger.sendSingleEvent("MapController-setZoomControlsEnabled");
        }
    }

    @Override
    public void setMarkers(final List<HashMap<String, Object>> initMarkers) {
        this.initMarkers = initMarkers;
        if (huaweiMap != null) {
            mapUtils.initMarkers(initMarkers);
        }
    }

    @Override
    public void setPolygons(final List<HashMap<String, Object>> initPolygons) {
        this.initPolygons = initPolygons;
        if (huaweiMap != null) {
            mapUtils.initPolygons(initPolygons);
        }
    }

    @Override
    public void setPolylines(final List<HashMap<String, Object>> initPolylines) {
        this.initPolylines = initPolylines;
        if (huaweiMap != null) {
            mapUtils.initPolylines(initPolylines);
        }
    }

    @Override
    public void setCircles(final List<HashMap<String, Object>> initialCircles) {
        initCircles = initialCircles;
        if (huaweiMap != null) {
            mapUtils.initCircles(initCircles);
        }
    }

    @Override
    public void setGroundOverlays(final List<HashMap<String, Object>> initGroundOverlays) {
        this.initGroundOverlays = initGroundOverlays;
        if (huaweiMap != null) {
            mapUtils.initGroundOverlays(initGroundOverlays);
        }
    }

    @Override
    public void setTileOverlays(final List<HashMap<String, Object>> initTileOverlays) {
        this.initTileOverlays = initTileOverlays;
        if (huaweiMap != null) {
            mapUtils.initTileOverlays(initTileOverlays);
        }
    }

    @Override
    public void setTrafficEnabled(final boolean trafficEnabled) {
        this.trafficEnabled = trafficEnabled;
        if (huaweiMap == null) {
            return;
        }
        logger.startMethodExecutionTimer("MapController-setTrafficEnabled");
        huaweiMap.setTrafficEnabled(trafficEnabled);
        logger.sendSingleEvent("MapController-setTrafficEnabled");
    }

    @Override
    public void setMarkersClustering(final boolean markersClustering) {
        this.markersClustering = markersClustering;
        if (huaweiMap == null) {
            return;
        }
        logger.startMethodExecutionTimer("MapController-setMarkersClustering");
        huaweiMap.setMarkersClustering(markersClustering);
        logger.sendSingleEvent("MapController-setMarkersClustering");
    }

    @Override
    public void setBuildingsEnabled(final boolean buildingsEnabled) {
        this.buildingsEnabled = buildingsEnabled;
    }

    @Override
    public void onInputConnectionLocked() {
    }

    @Override
    public void onInputConnectionUnlocked() {
    }

    @Override
    public void onActivityCreated(final Activity activity, final Bundle savedInstanceState) {
        if (disposed || activity.hashCode() != getActivityHashCode()) {
            return;
        }

        mapView.onCreate(savedInstanceState);
    }

    @Override
    public void onActivityStarted(final Activity activity) {
        if (disposed || activity.hashCode() != getActivityHashCode()) {
            return;
        }

        mapView.onStart();
    }

    @Override
    public void onActivityResumed(final Activity activity) {
        if (disposed || activity.hashCode() != getActivityHashCode()) {
            return;
        }

        mapView.onResume();
    }

    @Override
    public void onActivityPaused(final Activity activity) {
        if (disposed || activity.hashCode() != getActivityHashCode()) {
            return;
        }

        mapView.onPause();
    }

    @Override
    public void onActivityStopped(final Activity activity) {
        if (disposed || activity.hashCode() != getActivityHashCode()) {
            return;
        }

        mapView.onStop();
    }

    @Override
    public void onActivitySaveInstanceState(final Activity activity, final Bundle outState) {
        if (disposed || activity.hashCode() != getActivityHashCode()) {
            return;
        }

        mapView.onSaveInstanceState(outState);
    }

    @Override
    public void onActivityDestroyed(final Activity activity) {
        if (disposed || activity.hashCode() != getActivityHashCode()) {
            return;
        }

        mapView.onDestroy();
    }

    @Override
    public void onCreate(@NonNull final LifecycleOwner owner) {
        if (disposed) {
            return;
        }

        mapView.onCreate(null);
    }

    @Override
    public void onStart(@NonNull final LifecycleOwner owner) {
        if (disposed) {
            return;
        }

        mapView.onStart();
    }

    @Override
    public void onResume(@NonNull final LifecycleOwner owner) {
        if (disposed) {
            return;
        }

        mapView.onResume();
    }

    @Override
    public void onPause(@NonNull final LifecycleOwner owner) {
        if (disposed) {
            return;
        }

        mapView.onResume();
    }

    @Override
    public void onStop(@NonNull final LifecycleOwner owner) {
        if (disposed) {
            return;
        }

        mapView.onStop();
    }

    @Override
    public void onDestroy(@NonNull final LifecycleOwner owner) {
        if (disposed) {
            return;
        }

        mapView.onDestroy();
    }

    @Override
    public void onRestoreInstanceState(final Bundle bundle) {
        if (disposed) {
            return;
        }

        mapView.onCreate(bundle);
    }

    @Override
    public void onSaveInstanceState(final Bundle bundle) {
        if (disposed) {
            return;
        }

        mapView.onSaveInstanceState(bundle);
    }

    @SuppressLint("MissingPermission")
    private void updateMyLocationSettings() {
        if (MapLocation.hasLocationPermission(context)) {
            logger.startMethodExecutionTimer("MapController-setMyLocationEnabled");
            huaweiMap.setMyLocationEnabled(myLocationEnabled);
            logger.sendSingleEvent("MapController-setMyLocationEnabled");

            logger.startMethodExecutionTimer("MapController-setMyLocationButtonEnabled");
            huaweiMap.getUiSettings().setMyLocationButtonEnabled(myLocationButtonEnabled);
            logger.sendSingleEvent("MapController-setMyLocationButtonEnabled");
        }
    }

    private int getActivityHashCode() {
        return registrar != null && registrar.activity() != null ? registrar.activity().hashCode() : activityHashCode;
    }

    private Application getApplication() {
        return registrar != null && registrar.activity() != null ? registrar.activity().getApplication() : mApplication;
    }

}


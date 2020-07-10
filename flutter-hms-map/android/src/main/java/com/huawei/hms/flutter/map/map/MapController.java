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

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Point;
import android.os.Bundle;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.lifecycle.DefaultLifecycleObserver;
import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleOwner;

import com.huawei.hms.flutter.map.HmsMap;
import com.huawei.hms.flutter.map.constants.Channel;
import com.huawei.hms.flutter.map.constants.Method;
import com.huawei.hms.flutter.map.constants.Param;
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

import java.util.concurrent.atomic.AtomicInteger;
import java.io.ByteArrayOutputStream;
import java.util.HashMap;
import java.util.List;

final class MapController
        implements MapMethods,
        MethodChannel.MethodCallHandler,
        OnMapReadyCallback,
        DefaultLifecycleObserver,
        Application.ActivityLifecycleCallbacks,
        PlatformView, ActivityPluginBinding.OnSaveInstanceStateListener {

    private final AtomicInteger activityState;
    private final MethodChannel methodChannel;
    private MethodChannel.Result mapReadyResult;
    private final int
            activityHashCode;
    private final Lifecycle lifecycle;
    private final Context context;
    private final Application
            mApplication;
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
    private List<HashMap<String, Object>> initMarkers;
    private List<HashMap<String, Object>> initPolylines;
    private List<HashMap<String, Object>> initPolygons;
    private List<HashMap<String, Object>> initCircles;
    private final MapUtils mapUtils;
    private final MapListenerHandler mapListenerHandler;

    MapController(
            int id,
            Context context,
            AtomicInteger activityState,
            BinaryMessenger binaryMessenger,
            Application application,
            Lifecycle lifecycle,
            PluginRegistry.Registrar registrar,
            int registrarActivityHashCode,
            HuaweiMapOptions options) {
        this.context = context;
        this.activityState = activityState;
        this.mapView = new MapView(context, options);
        this.compactness = context.getResources().getDisplayMetrics().density;
        methodChannel = new MethodChannel(binaryMessenger, Channel.CHANNEL + "_" + id);
        methodChannel.setMethodCallHandler(this);
        mApplication = application;
        this.lifecycle = lifecycle;
        this.registrar = registrar;
        this.activityHashCode = registrarActivityHashCode;
        this.mapUtils = new MapUtils(methodChannel, compactness);
        this.mapListenerHandler = new MapListenerHandler(id, mapUtils, methodChannel);
    }

    @Override
    public View getView() {
        return mapView;
    }

    void init() {
        switch (activityState.get()) {
            case HmsMap.STOPPED:
                mapView.onCreate(null);
                mapView.onStart();
                mapView.onResume();
                mapView.onPause();
                mapView.onStop();
                break;
            case HmsMap.PAUSED:
                mapView.onCreate(null);
                mapView.onStart();
                mapView.onResume();
                mapView.onPause();
                break;
            case HmsMap.RESUMED:
                mapView.onCreate(null);
                mapView.onStart();
                mapView.onResume();
                break;
            case HmsMap.STARTED:
                mapView.onCreate(null);
                mapView.onStart();
                break;
            case HmsMap.CREATED:
                mapView.onCreate(null);
                break;
            case HmsMap.DESTROYED:
                break;
        }
        if (lifecycle != null) {
            lifecycle.addObserver(this);
        } else {
            getApplication().registerActivityLifecycleCallbacks(this);
        }
        mapView.getMapAsync(this);
    }


    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
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
                result.success(ToJson.cameraPosition(mapUtils.getCameraPosition(trackCameraPosition)));
                break;
            }
            case Method.MAP_GET_VISIBLE_REGION: {
                if (huaweiMap != null) {
                    LatLngBounds latLngBounds = huaweiMap.getProjection().getVisibleRegion().latLngBounds;
                    result.success(ToJson.latlngBounds(latLngBounds));
                } else {
                    result.error(Param.ERROR, Method.MAP_GET_VISIBLE_REGION, null);
                }
                break;
            }
            case Method.MAP_GET_SCREEN_COORDINATE: {
                if (huaweiMap != null) {
                    LatLng latLng = Convert.toLatLng(call.arguments);
                    Point screenLocation = huaweiMap.getProjection().toScreenLocation(latLng);
                    result.success(ToJson.point(screenLocation));
                } else {
                    result.error(Param.ERROR, Method.MAP_GET_SCREEN_COORDINATE, null);
                }
                break;
            }
            case Method.MAP_GET_LAT_LNG: {
                if (huaweiMap != null) {
                    Point point = Convert.toPoint(call.arguments);
                    LatLng latLng = huaweiMap.getProjection().fromScreenLocation(point);
                    result.success(ToJson.latLng(latLng));
                } else {
                    result.error(
                            Param.ERROR, Method.MAP_GET_LAT_LNG, null);
                }
                break;
            }
            case Method.CAMERA_MOVE: {
                final CameraUpdate cameraUpdate =
                        Convert.toCameraUpdate(call.argument(Param.CAMERA_UPDATE), compactness);
                mapUtils.moveCamera(cameraUpdate);
                result.success(null);
                break;
            }

            case Method.MAP_TAKE_SNAPSHOT: {
                if (huaweiMap != null) {
                    final MethodChannel.Result resultHandler = result;
                    huaweiMap.snapshot(
                            bitmap -> {
                                ByteArrayOutputStream stream = new ByteArrayOutputStream();
                                bitmap.compress(Bitmap.CompressFormat.PNG, 85, stream);
                                byte[] byteArray = stream.toByteArray();
                                bitmap.recycle();
                                resultHandler.success(byteArray);
                            });
                } else {
                    result.error(Param.ERROR, Method.MAP_TAKE_SNAPSHOT, null);
                }
                break;
            }
            default:
                mapUtils.onMethodCallCamera(call, result);
        }
    }


    @Override
    public void onMapReady(HuaweiMap huaweiMap) {
        this.huaweiMap = huaweiMap;
        this.huaweiMap.setTrafficEnabled(this.trafficEnabled);
        this.huaweiMap.setBuildingsEnabled(this.buildingsEnabled);
        if (mapReadyResult != null) {
            mapReadyResult.success(null);
            mapReadyResult = null;
        }
        mapListenerHandler.init(huaweiMap);
        mapUtils.init(huaweiMap, initMarkers, initPolylines, initPolygons, initCircles);
        updateMyLocationSettings();
    }

    @Override
    public void dispose() {
        if (disposed) return;

        disposed = true;
        methodChannel.setMethodCallHandler(null);
        mapListenerHandler.setMapListener(null);
        getApplication().unregisterActivityLifecycleCallbacks(this);
    }


    @Override
    public void setCameraTargetBounds(LatLngBounds bounds) {
        huaweiMap.setLatLngBoundsForCameraTarget(bounds);
    }

    @Override
    public void setCompassEnabled(boolean compassEnabled) {
        huaweiMap.getUiSettings().setCompassEnabled(compassEnabled);
    }

    @Override
    public void setMapToolbarEnabled(boolean mapToolbarEnabled) {
        huaweiMap.getUiSettings().setMapToolbarEnabled(mapToolbarEnabled);
    }

    @Override
    public void setMapType(int mapType) {
        huaweiMap.setMapType(mapType);
    }

    @Override
    public void setTrackCameraPosition(boolean trackCameraPosition) {
        this.trackCameraPosition = trackCameraPosition;
        mapListenerHandler.setTrackCameraPosition(trackCameraPosition);
    }

    @Override
    public void setRotateGesturesEnabled(boolean rotateGesturesEnabled) {
        huaweiMap.getUiSettings().setRotateGesturesEnabled(rotateGesturesEnabled);
    }

    @Override
    public void setScrollGesturesEnabled(boolean scrollGesturesEnabled) {
        huaweiMap.getUiSettings().setScrollGesturesEnabled(scrollGesturesEnabled);
    }

    @Override
    public void setTiltGesturesEnabled(boolean tiltGesturesEnabled) {
        huaweiMap.getUiSettings().setTiltGesturesEnabled(tiltGesturesEnabled);
    }

    @Override
    public void setMinMaxZoomPreference(Float min, Float max) {
        huaweiMap.resetMinMaxZoomPreference();
        if (min != null) huaweiMap.setMinZoomPreference(min);
        if (max != null) huaweiMap.setMaxZoomPreference(max);
    }

    @Override
    public void setPadding(float top, float left, float bottom, float right) {
        if (huaweiMap == null) return;
        huaweiMap.setPadding(
                (int) (left * compactness),
                (int) (top * compactness),
                (int) (right * compactness),
                (int) (bottom * compactness));

    }

    @Override
    public void setZoomGesturesEnabled(boolean zoomGesturesEnabled) {
        huaweiMap.getUiSettings().setZoomGesturesEnabled(zoomGesturesEnabled);
    }

    @Override
    public void setMyLocationEnabled(boolean myLocationEnabled) {
        if (this.myLocationEnabled == myLocationEnabled) return;

        this.myLocationEnabled = myLocationEnabled;
        if (huaweiMap != null) updateMyLocationSettings();
    }

    @Override
    public void setMyLocationButtonEnabled(boolean myLocationButtonEnabled) {
        if (this.myLocationButtonEnabled == myLocationButtonEnabled) return;

        this.myLocationButtonEnabled = myLocationButtonEnabled;
        if (huaweiMap != null) updateMyLocationSettings();

    }

    @Override
    public void setZoomControlsEnabled(boolean zoomControlsEnabled) {
        if (this.zoomControlsEnabled == zoomControlsEnabled) return;

        this.zoomControlsEnabled = zoomControlsEnabled;
        if (huaweiMap != null)
            huaweiMap.getUiSettings().setZoomControlsEnabled(zoomControlsEnabled);
    }

    @Override
    public void setMarkers(List<HashMap<String, Object>> initMarkers) {
        this.initMarkers = initMarkers;
        if (huaweiMap != null) mapUtils.initMarkers(initMarkers);
    }

    @Override
    public void setPolygons(List<HashMap<String, Object>> initPolygons) {
        this.initPolygons = initPolygons;
        if (huaweiMap != null) mapUtils.initPolygons(initPolygons);
    }

    @Override
    public void setPolylines(List<HashMap<String, Object>> initPolylines) {
        this.initPolylines = initPolylines;
        if (huaweiMap != null) mapUtils.initPolylines(initPolylines);
    }

    @Override
    public void setCircles(List<HashMap<String, Object>> initialCircles) {
        this.initCircles = initialCircles;
        if (huaweiMap != null) mapUtils.initCircles(initCircles);

    }

    @Override
    public void setTrafficEnabled(boolean trafficEnabled) {
        this.trafficEnabled = trafficEnabled;
        if (huaweiMap == null) return;
        huaweiMap.setTrafficEnabled(trafficEnabled);
    }

    @Override
    public void setBuildingsEnabled(boolean buildingsEnabled) {
        this.buildingsEnabled = buildingsEnabled;
    }

    public void onInputConnectionLocked() {
    }

    public void onInputConnectionUnlocked() {
    }


    @Override
    public void onActivityCreated(Activity activity, Bundle savedInstanceState) {
        if (disposed || activity.hashCode() != getActivityHashCode()) return;

        mapView.onCreate(savedInstanceState);
    }

    @Override
    public void onActivityStarted(Activity activity) {
        if (disposed || activity.hashCode() != getActivityHashCode()) return;

        mapView.onStart();
    }

    @Override
    public void onActivityResumed(Activity activity) {
        if (disposed || activity.hashCode() != getActivityHashCode()) return;

        mapView.onResume();
    }

    @Override
    public void onActivityPaused(Activity activity) {
        if (disposed || activity.hashCode() != getActivityHashCode()) return;

        mapView.onPause();
    }

    @Override
    public void onActivityStopped(Activity activity) {
        if (disposed || activity.hashCode() != getActivityHashCode()) return;

        mapView.onStop();
    }

    @Override
    public void onActivitySaveInstanceState(Activity activity, Bundle outState) {
        if (disposed || activity.hashCode() != getActivityHashCode()) return;

        mapView.onSaveInstanceState(outState);
    }

    @Override
    public void onActivityDestroyed(Activity activity) {
        if (disposed || activity.hashCode() != getActivityHashCode()) return;

        mapView.onDestroy();
    }


    @Override
    public void onCreate(@NonNull LifecycleOwner owner) {
        if (disposed) return;

        mapView.onCreate(null);
    }

    @Override
    public void onStart(@NonNull LifecycleOwner owner) {
        if (disposed) return;

        mapView.onStart();
    }

    @Override
    public void onResume(@NonNull LifecycleOwner owner) {
        if (disposed) return;

        mapView.onResume();
    }

    @Override
    public void onPause(@NonNull LifecycleOwner owner) {
        if (disposed) return;

        mapView.onResume();
    }

    @Override
    public void onStop(@NonNull LifecycleOwner owner) {
        if (disposed) return;

        mapView.onStop();
    }

    @Override
    public void onDestroy(@NonNull LifecycleOwner owner) {
        if (disposed) return;

        mapView.onDestroy();
    }

    @Override
    public void onRestoreInstanceState(Bundle bundle) {
        if (disposed) return;

        mapView.onCreate(bundle);
    }

    @Override
    public void onSaveInstanceState(Bundle bundle) {
        if (disposed) return;

        mapView.onSaveInstanceState(bundle);
    }


    @SuppressLint("MissingPermission")
    private void updateMyLocationSettings() {
        if (MapLocation.hasLocationPermission(context)) {
            huaweiMap.setMyLocationEnabled(myLocationEnabled);
            huaweiMap.getUiSettings().setMyLocationButtonEnabled(myLocationButtonEnabled);
        }
    }

    private int getActivityHashCode() {
        return registrar != null && registrar.activity() != null ? registrar.activity().hashCode() : activityHashCode;
    }

    private Application getApplication() {
        return registrar != null && registrar.activity() != null ? registrar.activity().getApplication() : mApplication;
    }


}


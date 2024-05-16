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

package com.huawei.hms.flutter.map;

import android.app.Activity;
import android.app.Application;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.lifecycle.DefaultLifecycleObserver;
import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleOwner;

import com.huawei.hms.flutter.map.constants.Channel;
import com.huawei.hms.flutter.map.constants.Method;
import com.huawei.hms.flutter.map.logger.HMSLogger;
import com.huawei.hms.flutter.map.map.MapFactory;
import com.huawei.hms.flutter.map.utils.Convert;
import com.huawei.hms.flutter.map.utils.ToJson;
import com.huawei.hms.maps.MapsInitializer;
import com.huawei.hms.maps.common.util.CoordinateConverter;
import com.huawei.hms.maps.common.util.DistanceCalculator;
import com.huawei.hms.maps.model.LatLng;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.embedding.engine.plugins.lifecycle.HiddenLifecycleReference;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

public class HmsMap
    implements Application.ActivityLifecycleCallbacks, FlutterPlugin, ActivityAware, DefaultLifecycleObserver,
    MethodCallHandler {
    public static final int CREATED = 1;

    public static final int STARTED = 2;

    public static final int RESUMED = 3;

    public static final int PAUSED = 4;

    public static final int STOPPED = 5;

    public static final int DESTROYED = 6;

    private final AtomicInteger state = new AtomicInteger(0);

    private int registrarActivityHashCode;

    private FlutterPluginBinding flutterPluginBinding;

    private Lifecycle lifecycle;

    private MethodChannel mapUtils;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        flutterPluginBinding = binding;
        mapUtils = new MethodChannel(binding.getBinaryMessenger(), Channel.MAP_UTILS);
        mapUtils.setMethodCallHandler(this);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding activityPluginBinding) {
        if (flutterPluginBinding == null) {
            return;
        }
        activityPluginBinding.getActivity().getIntent().putExtra("background_mode", "transparent");
        registrarActivityHashCode = activityPluginBinding.getActivity().hashCode();
        lifecycle = ((HiddenLifecycleReference) activityPluginBinding.getLifecycle()).getLifecycle();
        lifecycle.addObserver(this);
        flutterPluginBinding.getPlatformViewRegistry()
            .registerViewFactory(Channel.CHANNEL,
                new MapFactory(state, flutterPluginBinding.getBinaryMessenger(), activityPluginBinding.getActivity(),
                    lifecycle, null, activityPluginBinding.getActivity().hashCode()));
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding activityPluginBinding) {
        lifecycle = ((HiddenLifecycleReference) activityPluginBinding.getLifecycle()).getLifecycle();
        lifecycle.addObserver(this);
    }

    @Override
    public void onDetachedFromActivity() {
        if (lifecycle != null) {
            lifecycle.removeObserver(this);
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        flutterPluginBinding = null;
        mapUtils = null;
    }

    // DefaultLifecycleObserver methods

    @Override
    public void onCreate(@NonNull final LifecycleOwner owner) {
        state.set(CREATED);
    }

    @Override
    public void onStart(@NonNull final LifecycleOwner owner) {
        state.set(STARTED);
    }

    @Override
    public void onResume(@NonNull final LifecycleOwner owner) {
        state.set(RESUMED);
    }

    @Override
    public void onPause(@NonNull final LifecycleOwner owner) {
        state.set(PAUSED);
    }

    @Override
    public void onStop(@NonNull final LifecycleOwner owner) {
        state.set(STOPPED);
    }

    @Override
    public void onDestroy(@NonNull final LifecycleOwner owner) {
        state.set(DESTROYED);
    }

    // Application.ActivityLifecycleCallbacks methods

    @Override
    public void onActivityCreated(final Activity activity, final Bundle savedInstanceState) {
        if (activity.hashCode() == registrarActivityHashCode) {
            state.set(CREATED);
        }
    }

    @Override
    public void onActivityStarted(final Activity activity) {
        if (activity.hashCode() == registrarActivityHashCode) {
            state.set(STARTED);
        }
    }

    @Override
    public void onActivityResumed(final Activity activity) {
        if (activity.hashCode() == registrarActivityHashCode) {
            state.set(RESUMED);
        }
    }

    @Override
    public void onActivityPaused(final Activity activity) {
        if (activity.hashCode() == registrarActivityHashCode) {
            state.set(PAUSED);
        }
    }

    @Override
    public void onActivityStopped(final Activity activity) {
        if (activity.hashCode() == registrarActivityHashCode) {
            state.set(STOPPED);
        }
    }

    @Override
    public void onActivitySaveInstanceState(final Activity activity, final Bundle outState) {
    }

    @Override
    public void onActivityDestroyed(final Activity activity) {
        if (activity.hashCode() == registrarActivityHashCode) {
            activity.getApplication().unregisterActivityLifecycleCallbacks(this);
            state.set(DESTROYED);
        }
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        switch (call.method) {
            case Method.ENABLE_LOGGER: {
                if (flutterPluginBinding != null) {
                    HMSLogger.getInstance(flutterPluginBinding.getApplicationContext()).enableLogger();
                }
                break;
            }
            case Method.DISABLE_LOGGER: {
                if (flutterPluginBinding != null) {
                    HMSLogger.getInstance(flutterPluginBinding.getApplicationContext()).disableLogger();
                }
                break;
            }
            case Method.DISTANCE_CALCULATOR: {
                if (flutterPluginBinding != null) {
                    final List<LatLng> request = Convert.toLatLngStartEnd(call.arguments);
                    HMSLogger.getInstance(flutterPluginBinding.getApplicationContext())
                        .startMethodExecutionTimer(Method.DISTANCE_CALCULATOR);
                    result.success(DistanceCalculator.computeDistanceBetween(request.get(0), request.get(1)));
                    HMSLogger.getInstance(flutterPluginBinding.getApplicationContext())
                        .sendSingleEvent(Method.DISTANCE_CALCULATOR);
                }
                break;
            }
            case Method.INITIALIZE_MAP: {
                if (flutterPluginBinding != null) {
                    final String routePolicy = Convert.toString(call.arguments);
                    HMSLogger.getInstance(flutterPluginBinding.getApplicationContext())
                        .startMethodExecutionTimer(Method.INITIALIZE_MAP);
                    if (routePolicy != null) {
                        MapsInitializer.initialize(flutterPluginBinding.getApplicationContext(), routePolicy);
                    } else {
                        MapsInitializer.initialize(flutterPluginBinding.getApplicationContext());
                    }
                    result.success(true);
                    HMSLogger.getInstance(flutterPluginBinding.getApplicationContext())
                        .sendSingleEvent(Method.INITIALIZE_MAP);
                }
                break;
            }
            case Method.SET_API_KEY: {
                final String apiKey = Convert.toString(call.arguments);
                HMSLogger.getInstance(flutterPluginBinding.getApplicationContext())
                    .startMethodExecutionTimer(Method.SET_API_KEY);
                MapsInitializer.setApiKey(apiKey);
                result.success(true);
                HMSLogger.getInstance(flutterPluginBinding.getApplicationContext()).sendSingleEvent(Method.SET_API_KEY);
                break;
            }
            case Method.SET_ACCESS_TOKEN: {
                final String accessToken = Convert.toString(call.arguments);
                HMSLogger.getInstance(flutterPluginBinding.getApplicationContext())
                    .startMethodExecutionTimer(Method.SET_ACCESS_TOKEN);
                MapsInitializer.setAccessToken(accessToken);
                result.success(true);
                HMSLogger.getInstance(flutterPluginBinding.getApplicationContext())
                    .sendSingleEvent(Method.SET_ACCESS_TOKEN);
                break;
            }
            case Method.CONVERT_COORDINATE: {
                final LatLng latLng = Convert.toLatLng(call.arguments);
                HMSLogger.getInstance(flutterPluginBinding.getApplicationContext())
                    .startMethodExecutionTimer(Method.CONVERT_COORDINATE);
                result.success(ToJson.latLng(new CoordinateConverter().convert(latLng)));
                HMSLogger.getInstance(flutterPluginBinding.getApplicationContext())
                    .sendSingleEvent(Method.CONVERT_COORDINATE);
                break;
            }
            case Method.CONVERT_COORDINATES: {
                final LatLng[] latLngArr = Convert.toLatLngList(call.arguments);
                HMSLogger.getInstance(flutterPluginBinding.getApplicationContext())
                    .startMethodExecutionTimer(Method.CONVERT_COORDINATES);
                result.success(ToJson.latLngList(new CoordinateConverter().convert(latLngArr)));
                HMSLogger.getInstance(flutterPluginBinding.getApplicationContext())
                    .sendSingleEvent(Method.CONVERT_COORDINATES);
                break;
            }
            default:
                result.notImplemented();
        }
    }
}

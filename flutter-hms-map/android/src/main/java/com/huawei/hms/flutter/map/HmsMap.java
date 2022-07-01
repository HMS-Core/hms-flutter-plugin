/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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
import io.flutter.plugin.common.BinaryMessenger;
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

    private FlutterPluginBinding pluginBinding;

    private Lifecycle lifecycle;

    private MethodChannel mapUtils;

    private static final String VIEW_TYPE = Channel.CHANNEL;

    public HmsMap() {
    }

    private void initChannels(final BinaryMessenger messenger) {
        mapUtils = new MethodChannel(messenger, Channel.MAP_UTILS);
        mapUtils.setMethodCallHandler(this);
    }

    // FlutterPlugin

    @Override
    public void onAttachedToEngine(final FlutterPluginBinding binding) {
        pluginBinding = binding;
        initChannels(binding.getBinaryMessenger());
    }

    @Override
    public void onDetachedFromEngine(final FlutterPluginBinding binding) {
        pluginBinding = null;
        mapUtils = null;
    }

    // ActivityAware

    @Override
    public void onAttachedToActivity(final ActivityPluginBinding binding) {
        if (pluginBinding == null) {
            return;
        }
        registrarActivityHashCode = binding.getActivity().hashCode();
        lifecycle = ((HiddenLifecycleReference) binding.getLifecycle()).getLifecycle();
        lifecycle.addObserver(this);
        pluginBinding.getPlatformViewRegistry()
            .registerViewFactory(VIEW_TYPE,
                new MapFactory(state, pluginBinding.getBinaryMessenger(), binding.
                        getActivity(), lifecycle, null,
                        binding.getActivity().hashCode()));
    }

    @Override
    public void onDetachedFromActivity() {
        if (lifecycle == null) {
            return;
        }

        lifecycle.removeObserver(this);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(final ActivityPluginBinding binding) {
        lifecycle = ((HiddenLifecycleReference) binding.getLifecycle()).getLifecycle();
        lifecycle.addObserver(this);
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
        if (activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        state.set(CREATED);
    }

    @Override
    public void onActivityStarted(final Activity activity) {
        if (activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        state.set(STARTED);
    }

    @Override
    public void onActivityResumed(final Activity activity) {
        if (activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        state.set(RESUMED);
    }

    @Override
    public void onActivityPaused(final Activity activity) {
        if (activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        state.set(PAUSED);
    }

    @Override
    public void onActivityStopped(final Activity activity) {
        if (activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        state.set(STOPPED);
    }

    @Override
    public void onActivitySaveInstanceState(final Activity activity, final Bundle outState) {
    }

    @Override
    public void onActivityDestroyed(final Activity activity) {
        if (activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        activity.getApplication().unregisterActivityLifecycleCallbacks(this);
        state.set(DESTROYED);
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        switch (call.method) {
            case Method.ENABLE_LOGGER:
                if (pluginBinding != null) {
                    HMSLogger.getInstance(pluginBinding.getApplicationContext()).enableLogger();
                }
                break;
            case Method.DISABLE_LOGGER:
                if (pluginBinding != null) {
                    HMSLogger.getInstance(pluginBinding.getApplicationContext()).disableLogger();
                }
                break;
            case Method.DISTANCE_CALCULATOR: {
                final List<LatLng> request = Convert.toLatLngStartEnd(call.arguments);
                if (pluginBinding != null) {
                    HMSLogger.getInstance(pluginBinding.getApplicationContext())
                        .startMethodExecutionTimer(Method.DISTANCE_CALCULATOR);
                    result.success(DistanceCalculator.computeDistanceBetween(request.get(0), request.get(1)));
                    HMSLogger.getInstance(pluginBinding.getApplicationContext())
                        .sendSingleEvent(Method.DISTANCE_CALCULATOR);
                }
                break;
            }
            case Method.INITIALIZE_MAP: {
                if (pluginBinding != null) {
                    HMSLogger.getInstance(pluginBinding.getApplicationContext())
                            .startMethodExecutionTimer(Method.INITIALIZE_MAP);
                    MapsInitializer.initialize(pluginBinding.getApplicationContext());
                    HMSLogger.getInstance(pluginBinding.getApplicationContext())
                            .sendSingleEvent(Method.INITIALIZE_MAP);
                }
                break;
            }
            case Method.SET_API_KEY: {
                final String apiKey = Convert.toString(call.arguments);
                HMSLogger.getInstance(pluginBinding.getApplicationContext())
                        .startMethodExecutionTimer(Method.SET_API_KEY);
                MapsInitializer.setApiKey(apiKey);
                HMSLogger.getInstance(pluginBinding.getApplicationContext())
                        .sendSingleEvent(Method.SET_API_KEY);
                break;
            }
            case Method.CONVERT_COORDINATE: {
                final LatLng latLng = Convert.toLatLng(call.arguments);
                HMSLogger.getInstance(pluginBinding.getApplicationContext())
                        .startMethodExecutionTimer(Method.CONVERT_COORDINATE);
                CoordinateConverter converter = new CoordinateConverter();
                result.success(ToJson.latLng(converter.convert(latLng)));
                HMSLogger.getInstance(pluginBinding.getApplicationContext())
                        .sendSingleEvent(Method.CONVERT_COORDINATE);
                break;
            }
            case Method.CONVERT_COORDINATES: {
                LatLng[] latLngs = Convert.toLatLngList(call.arguments);
                HMSLogger.getInstance(pluginBinding.getApplicationContext())
                        .startMethodExecutionTimer(Method.CONVERT_COORDINATES);
                CoordinateConverter converter = new CoordinateConverter();
                result.success(ToJson.latLngList(converter.convert(latLngs)));
                HMSLogger.getInstance(pluginBinding.getApplicationContext())
                        .sendSingleEvent(Method.CONVERT_COORDINATES);
                break;
            }
            default:
                result.notImplemented();
        }
    }
}

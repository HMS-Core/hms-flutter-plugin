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

package com.huawei.hms.flutter.map;

import android.app.Activity;
import android.app.Application;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.lifecycle.DefaultLifecycleObserver;
import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleOwner;

import com.huawei.hms.flutter.map.constants.Channel;
import com.huawei.hms.flutter.map.map.MapFactory;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.embedding.engine.plugins.lifecycle.FlutterLifecycleAdapter;
import io.flutter.plugin.common.PluginRegistry;

import java.util.concurrent.atomic.AtomicInteger;


public class HmsMap
        implements Application.ActivityLifecycleCallbacks,
        FlutterPlugin,
        ActivityAware,
        DefaultLifecycleObserver {
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

    private static final String VIEW_TYPE = Channel.CHANNEL;

    public static void registerWith(PluginRegistry.Registrar registrar) {
        if (registrar.activity() == null) {
            return;
        }
        final HmsMap plugin = new HmsMap(registrar.activity());
        registrar.activity().getApplication().registerActivityLifecycleCallbacks(plugin);
        registrar
                .platformViewRegistry()
                .registerViewFactory(
                        VIEW_TYPE,
                        new MapFactory(plugin.state, registrar.messenger(), null, null, registrar, -1));
    }

    public HmsMap() {
    }

    // FlutterPlugin

    @Override
    public void onAttachedToEngine(FlutterPluginBinding binding) {
        pluginBinding = binding;
    }

    @Override
    public void onDetachedFromEngine(FlutterPluginBinding binding) {
        pluginBinding = null;
    }

    // ActivityAware

    @Override
    public void onAttachedToActivity(ActivityPluginBinding binding) {
        if (pluginBinding == null) return;

        lifecycle = FlutterLifecycleAdapter.getActivityLifecycle(binding);
        lifecycle.addObserver(this);
        pluginBinding
                .getPlatformViewRegistry()
                .registerViewFactory(
                        VIEW_TYPE,
                        new MapFactory(
                                state,
                                pluginBinding.getBinaryMessenger(),
                                binding.getActivity().getApplication(),
                                lifecycle,
                                null,
                                binding.getActivity().hashCode()));
    }

    @Override
    public void onDetachedFromActivity() {
        if (lifecycle == null) return;

        lifecycle.removeObserver(this);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        this.onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
        lifecycle = FlutterLifecycleAdapter.getActivityLifecycle(binding);
        lifecycle.addObserver(this);
    }

    // DefaultLifecycleObserver methods

    @Override
    public void onCreate(@NonNull LifecycleOwner owner) {
        state.set(CREATED);
    }

    @Override
    public void onStart(@NonNull LifecycleOwner owner) {
        state.set(STARTED);
    }

    @Override
    public void onResume(@NonNull LifecycleOwner owner) {
        state.set(RESUMED);
    }

    @Override
    public void onPause(@NonNull LifecycleOwner owner) {
        state.set(PAUSED);
    }

    @Override
    public void onStop(@NonNull LifecycleOwner owner) {
        state.set(STOPPED);
    }

    @Override
    public void onDestroy(@NonNull LifecycleOwner owner) {
        state.set(DESTROYED);
    }

    // Application.ActivityLifecycleCallbacks methods

    @Override
    public void onActivityCreated(Activity activity, Bundle savedInstanceState) {
        if (activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        state.set(CREATED);
    }

    @Override
    public void onActivityStarted(Activity activity) {
        if (activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        state.set(STARTED);
    }

    @Override
    public void onActivityResumed(Activity activity) {
        if (activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        state.set(RESUMED);
    }

    @Override
    public void onActivityPaused(Activity activity) {
        if (activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        state.set(PAUSED);
    }

    @Override
    public void onActivityStopped(Activity activity) {
        if (activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        state.set(STOPPED);
    }

    @Override
    public void onActivitySaveInstanceState(Activity activity, Bundle outState) {
    }

    @Override
    public void onActivityDestroyed(Activity activity) {
        if (activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        activity.getApplication().unregisterActivityLifecycleCallbacks(this);
        state.set(DESTROYED);
    }

    private HmsMap(Activity activity) {
        this.registrarActivityHashCode = activity.hashCode();
    }
}

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

package com.huawei.hms.flutter.push.backgroundmessaging;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.AssetManager;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.huawei.hms.flutter.push.constants.Channel;
import com.huawei.hms.flutter.push.constants.Core;
import com.huawei.hms.flutter.push.constants.Param;
import com.huawei.hms.flutter.push.hms.PluginContext;
import com.huawei.hms.flutter.push.utils.RemoteMessageUtils;
import com.huawei.hms.push.RemoteMessage;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.embedding.engine.dart.DartExecutor.DartCallback;
import io.flutter.embedding.engine.loader.FlutterLoader;
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
import io.flutter.view.FlutterCallbackInformation;

import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.atomic.AtomicBoolean;

public class FlutterBackgroundRunner implements MethodCallHandler {
    private static final String TAG = FlutterBackgroundRunner.class.getSimpleName();

    public static final String CALLBACK_DISPATCHER_KEY = "push_background_message_handler";

    public static final String USER_CALLBACK_KEY = "push_background_message_callback";

    // Deprecated, Support for backwards compatibility with V1 embedding.
    private static PluginRegistrantCallback pluginRegistrantCallback;

    private final AtomicBoolean isCallbackDispatcherReady = new AtomicBoolean(false);

    private MethodChannel bgMethodChannel;

    private FlutterEngine flutterEngine;

    private long bgMessagingCallback;

    // For Backwards Compatibility with V1 Plugin registration.
    public static void setPluginRegistrantCallback(final PluginRegistrantCallback callback) {
        pluginRegistrantCallback = callback;
    }

    public static void setCallBackDispatcher(final Context context, final long callbackHandle) {
        final SharedPreferences prefs = context.getSharedPreferences(Core.PREFERENCE_NAME, Context.MODE_PRIVATE);
        prefs.edit().putLong(CALLBACK_DISPATCHER_KEY, callbackHandle).apply();
    }

    public static void setUserCallback(final Context context, final long userCallback) {
        final SharedPreferences prefs = context.getSharedPreferences(Core.PREFERENCE_NAME, Context.MODE_PRIVATE);
        prefs.edit().putLong(USER_CALLBACK_KEY, userCallback).apply();
    }

    public boolean isNotReady() {
        return !isCallbackDispatcherReady.get();
    }

    private void loadCallbacks(final Context context) {
        final SharedPreferences prefs = context.getSharedPreferences(Core.PREFERENCE_NAME, Context.MODE_PRIVATE);
        bgMessagingCallback = prefs.getLong(USER_CALLBACK_KEY, -1);
    }

    public void startBgIsolate(final Context context) {
        Log.i(TAG, "#startBgIsolate");
        if (isNotReady()) {
            final SharedPreferences prefs = context.getSharedPreferences(Core.PREFERENCE_NAME, Context.MODE_PRIVATE);
            final long callbackHandle = prefs.getLong(CALLBACK_DISPATCHER_KEY, -1);
            loadCallbacks(context);
            startBgIsolate(context, callbackHandle);
        }
    }

    public void startBgIsolate(final Context context, final long callbackHandle) {
        loadCallbacks(context);
        if (flutterEngine != null) {
            Log.e(TAG, "Background isolate has already started.");
            return;
        }
        Handler mainHandler = new Handler(Looper.getMainLooper());
        Runnable runnable = () -> {
            FlutterLoader flutterLoader = new FlutterLoader();
            flutterLoader.startInitialization(Objects.requireNonNull(PluginContext.getContext()));
            flutterLoader.ensureInitializationCompleteAsync(PluginContext.getContext(), null, mainHandler, () -> {
                Log.i(TAG, "Starting Background Runner");
                final String appBundlePath = flutterLoader.findAppBundlePath();
                final AssetManager assets = context.getAssets();
                if (isNotReady()) {
                    flutterEngine = new FlutterEngine(context);

                    final FlutterCallbackInformation flutterCallbackInfo
                        = FlutterCallbackInformation.lookupCallbackInformation(callbackHandle);
                    final DartExecutor executor = flutterEngine.getDartExecutor();
                    initializeMethodChannel(executor);
                    final DartCallback dartCallback = new DartCallback(assets, appBundlePath, flutterCallbackInfo);
                    executor.executeDartCallback(dartCallback);

                    // For V1 Embedding
                    if (pluginRegistrantCallback != null) {
                        pluginRegistrantCallback.registerWith(new ShimPluginRegistry(flutterEngine));
                    }

                }
            });
        };
        mainHandler.post(runnable);
    }

    private void initializeMethodChannel(final BinaryMessenger messenger) {
        bgMethodChannel = new MethodChannel(messenger, Channel.BACKGROUND_MESSAGE_CHANNEL.id());
        bgMethodChannel.setMethodCallHandler(this);
    }

    private void onInitialized() {
        isCallbackDispatcherReady.set(true);
        BackgroundMessagingService.onInitialized();
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        try {
            if (call.method.equals("BackgroundRunner.initialize")) {
                onInitialized();
                result.success(1);
            } else {
                result.notImplemented();
            }
        } catch (final Exception e) {
            Log.e(TAG, e.getMessage() != null ? e.getMessage() : "");
            result.error("-1", "FlutterBackgroundRunner.onMethodCall error: " + e.getMessage(), null);
        }
    }

    public void executeDartCallbackInBgIsolate(final Intent intent, final CountDownLatch latch) {
        if (flutterEngine == null) {
            Log.i(TAG,
                "A background message could not be handled in Dart as no onBackgroundLocation handler has been registered");
            return;
        }
        Result result = null;
        if (latch != null) {
            result = new LatchResult(latch);
        }
        if (intent != null) {
            RemoteMessage remoteMessage = (RemoteMessage) intent.getExtras().get(Param.MESSAGE.code());

            if (bgMethodChannel != null) {
                List<Object> resp = Arrays.asList(bgMessagingCallback, RemoteMessageUtils.toMap(remoteMessage));
                bgMethodChannel.invokeMethod("", resp, result);
            } else {
                Log.e(TAG, "Can not find the background method channel.");
            }
        } else {
            Log.e(TAG, "Intent is null");
        }
    }

    private static class LatchResult implements Result {
        private final CountDownLatch latch;

        public LatchResult(CountDownLatch latch) {
            this.latch = latch;
        }

        @Override
        public void success(@Nullable Object result) {
            latch.countDown();
        }

        @Override
        public void error(String errorCode, String errorMessage, @Nullable Object errorDetails) {
            latch.countDown();
        }

        @Override
        public void notImplemented() {
            latch.countDown();
        }
    }
}

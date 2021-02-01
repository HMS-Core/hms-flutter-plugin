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

package com.huawei.hms.flutter.push;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.push.constants.Channel;
import com.huawei.hms.flutter.push.constants.Core;
import com.huawei.hms.flutter.push.utils.RemoteMessageUtils;
import com.huawei.hms.push.RemoteMessage;

import java.util.Arrays;
import java.util.List;
import java.util.concurrent.atomic.AtomicBoolean;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.view.FlutterCallbackInformation;
import io.flutter.view.FlutterMain;
import io.flutter.view.FlutterNativeView;
import io.flutter.view.FlutterRunArguments;

public class HeadlessPushPlugin implements MethodChannel.MethodCallHandler {
    private static final String TAG = HeadlessPushPlugin.class.getSimpleName();

    public final static String KEY_HANDLER = "push_background_message_handler";
    public final static String KEY_CALLBACK = "push_background_message_callback";

    private static MethodChannel methodBackgroundChannel;
    private static PluginRegistry.PluginRegistrantCallback pluginRegistrantCallback;

    private Context context;

    private static FlutterNativeView flutterNativeView;

    private static final AtomicBoolean SYNCHRONIZER = new AtomicBoolean(false);

    public HeadlessPushPlugin(Context context) {
        this.context = context;
        if (flutterNativeView == null)
            initFlutterNativeView();

        // Queue events while background isolate is starting
        waitFlutterNativeView();
    }

    private static synchronized void waitFlutterNativeView() {
        if (!SYNCHRONIZER.get()) {
            Log.d(TAG, "Waiting for Flutter Native View");
        }
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(PluginRegistry.Registrar registrar) {
        // Placeholder for registerWith
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        result.notImplemented();
    }

    static void setPluginRegistrant(PluginRegistry.PluginRegistrantCallback callback) {
        Log.i(TAG, "PluginRegistrantCallback - setPluginRegistrant");
        pluginRegistrantCallback = callback;
    }


    public void handleBackgroundMessage(Context context, RemoteMessage remoteMessage) {

        SharedPreferences prefs = context.getSharedPreferences(Core.PREFERENCE_NAME, Context.MODE_PRIVATE);
        Long mCallbackHandle = prefs.getLong(KEY_CALLBACK, -1);

        List<Object> result = Arrays.asList(mCallbackHandle, RemoteMessageUtils.toMap(remoteMessage));
        if (methodBackgroundChannel != null) {
            methodBackgroundChannel.invokeMethod("", result);
            Log.i(TAG, RemoteMessageUtils.toMap(remoteMessage).toString());
        } else {
            Log.i(TAG, "No channel");
            this.initFlutterNativeView();
        }
    }

    private void initFlutterNativeView() {
        FlutterMain.ensureInitializationComplete(context, null);

        SharedPreferences prefs = context.getSharedPreferences(Core.PREFERENCE_NAME, Context.MODE_PRIVATE);
        Long mCallbackHandle = prefs.getLong(KEY_HANDLER, -1);

        FlutterCallbackInformation callbackInfo = FlutterCallbackInformation
                .lookupCallbackInformation(mCallbackHandle);

        if (callbackInfo == null) {
            Log.e(TAG, "ERROR : failed to find callback");
            return;
        }

        flutterNativeView = new FlutterNativeView(context.getApplicationContext(), true);

        // Create the Transmitter Channel
        methodBackgroundChannel = new MethodChannel(flutterNativeView, Channel.BACKGROUND_MESSAGE_CHANNEL.id());
        methodBackgroundChannel.setMethodCallHandler(this);

        if (pluginRegistrantCallback == null)
            return;

        pluginRegistrantCallback.registerWith(flutterNativeView.getPluginRegistry());

        // Dispatch back to client for initialization
        FlutterRunArguments args = new FlutterRunArguments();
        args.bundlePath = FlutterMain.findAppBundlePath(context);
        args.entrypoint = callbackInfo.callbackName;
        args.libraryPath = callbackInfo.callbackLibraryPath;
        flutterNativeView.runFromBundle(args);
        SYNCHRONIZER.set(true);
    }
}

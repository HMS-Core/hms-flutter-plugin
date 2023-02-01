/*
 * Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.wallet;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.wallet.logger.HMSLogger;
import com.huawei.hms.flutter.wallet.passsdk.WalletPassApiMethodHandler;
import com.huawei.hms.flutter.wallet.utils.FromMap;
import com.huawei.hms.flutter.wallet.utils.WalletUtils;
import com.huawei.hms.flutter.wallet.utils.constants.Channels;
import com.huawei.hms.flutter.wallet.utils.constants.Constants;
import com.huawei.hms.flutter.wallet.utils.jwe.JweUtil;
import com.huawei.hms.wallet.AutoResolvableForegroundIntentResult;
import com.huawei.hms.wallet.CreateWalletPassRequest;
import com.huawei.hms.wallet.ResolveTaskHelper;
import com.huawei.hms.wallet.Wallet;
import com.huawei.hms.wallet.WalletPassClient;
import com.huawei.hms.wallet.constant.WalletPassConstant;
import com.huawei.hms.wallet.pass.PassObject;

import org.json.JSONException;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;

public class HuaweiWalletPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
    public static final int SAVE_TO_ANDROID = 888;
    public static final int NO_OWNER = 20;
    public static final int HMS_VERSION_CODE = 907135001;

    private static final String TAG = "HuaweiWalletPlugin";

    private FlutterPluginBinding flutterPluginBinding;
    private Context context;
    private Activity activity;

    private MethodChannel methodChannel;
    private MethodChannel walletPassApiMethodChannel;

    private WalletPassApiMethodHandler walletPassApiMethodHandler;

    private final HashMap<Integer, String> activityRequestMethods = new HashMap<>();
    private final HashMap<Integer, Result> activityRequestResults = new HashMap<>();

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        this.flutterPluginBinding = flutterPluginBinding;
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        this.activity = binding.getActivity();
        this.context = binding.getActivity().getApplicationContext();
        if (flutterPluginBinding != null) {
            methodChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), Channels.WALLET_METHOD_CHANNEL);
            methodChannel.setMethodCallHandler(this);

            walletPassApiMethodChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), Channels.WALLET_API_METHOD_CHANNEL);
            walletPassApiMethodHandler = new WalletPassApiMethodHandler(context);
            walletPassApiMethodChannel.setMethodCallHandler(walletPassApiMethodHandler);
        }
        binding.addActivityResultListener(this);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        this.activity = null;
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        this.activity = null;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        methodChannel.setMethodCallHandler(null);
        walletPassApiMethodChannel.setMethodCallHandler(null);
        methodChannel = null;
        walletPassApiMethodChannel = null;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer(call.method);
        switch (call.method) {
            case "createWalletPassWithSdk":
                createWalletPassWithSdk(call, result);
                break;
            case "createWalletPassWithIntent":
                startActivityWithUriIntent(call, result, SAVE_TO_ANDROID);
                break;
            case "generateJwe":
                final String appId = FromMap.toString("appId", call.argument("appId"), false);
                final Map<String, Object> passObjectMap = call.argument("passObject");
                final String jwePrivateKey = FromMap.toString("jwePrivateKey", call.argument("jwePrivateKey"), false);
                final String sessionKeyPublicKey = FromMap.toString("sessionKeyPublicKey", call.argument("sessionKeyPublicKey"), false);
                if (appId == null || passObjectMap == null || jwePrivateKey == null || sessionKeyPublicKey == null) {
                    result.error(String.valueOf(Constants.MISSING_PARAM), Constants.MISSING_PARAM_DESC, "");
                    return;
                }
                try {
                    final PassObject passObject = WalletUtils.passObjectFromMap(passObjectMap);
                    final String jwe = JweUtil.generateJwe(appId, passObject.toJson(), jwePrivateKey, sessionKeyPublicKey);
                    result.success(jwe);
                } catch (JSONException e) {
                    result.error("", e.getMessage(), null);
                }
                HMSLogger.getInstance(context).sendSingleEvent("generateJwe");
                break;
            case "enableLogger":
                HMSLogger.getInstance(context).enableLogger();
                result.success(true);
                break;
            case "disableLogger":
                HMSLogger.getInstance(context).disableLogger();
                result.success(true);
                break;
            case "startActivityWithUriIntent":
                startActivityWithUriIntent(call, result, null);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void startActivityWithUriIntent(final @NonNull MethodCall call, final @NonNull Result result, Integer requestCode) {
        final String uri = FromMap.toString("uri", call.argument("uri"), false);
        if (uri == null) {
            result.error(String.valueOf(Constants.MISSING_PARAM), Constants.MISSING_PARAM_DESC, "");
            HMSLogger.getInstance(context).sendSingleEvent(call.method, String.valueOf(Constants.MISSING_PARAM));
            return;
        }
        final Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.setData(Uri.parse(uri));
        try {
            if (requestCode == null) {
                activity.startActivity(intent);
                result.success(true);
            } else {
                activity.startActivityForResult(intent, requestCode);
                activityRequestMethods.put(requestCode, call.method);
                activityRequestResults.put(requestCode, result);
            }
            HMSLogger.getInstance(context).sendSingleEvent(call.method);
        } catch (ActivityNotFoundException e) {
            result.error(String.valueOf(Constants.ACTIVITY_NOT_FOUND), Constants.ACTIVITY_NOT_FOUND_DESC, "");
            HMSLogger.getInstance(context).sendSingleEvent(call.method, String.valueOf(Constants.ACTIVITY_NOT_FOUND));
        }
    }

    private void createWalletPassWithSdk(final @NonNull MethodCall call, final @NonNull Result result) {
        final String content = FromMap.toString("content", call.argument("content"), false);
        if (content == null) {
            result.error(String.valueOf(Constants.MISSING_PARAM), Constants.MISSING_PARAM_DESC, "");
            HMSLogger.getInstance(context).sendSingleEvent(call.method, String.valueOf(Constants.MISSING_PARAM));
            return;
        }
        final CreateWalletPassRequest request = CreateWalletPassRequest.getBuilder()
                .setContent(content)
                .build();
        Log.i(TAG, "createWalletPassWithSdk");
        final WalletPassClient walletObjectsClient = Wallet.getWalletPassClient(activity);
        final Task<AutoResolvableForegroundIntentResult> task = walletObjectsClient.createWalletPass(request);
        ResolveTaskHelper.excuteTask(task, activity, SAVE_TO_ANDROID);
        activityRequestMethods.put(SAVE_TO_ANDROID, call.method);
        activityRequestResults.put(SAVE_TO_ANDROID, result);
        HMSLogger.getInstance(context).sendSingleEvent(call.method);
    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("onActivityResult");
        if (activityRequestMethods.containsKey(requestCode) && activityRequestResults.containsKey(requestCode)) {
            Log.i(TAG, "requestCode：" + requestCode + "resultCode" + resultCode);

            final Result result = activityRequestResults.get(requestCode);
            if (result != null) {
                if (resultCode == Activity.RESULT_OK) {
                    result.success(Constants.RESULT_OK);
                    HMSLogger.getInstance(context).sendSingleEvent("onActivityResult");
                } else if (resultCode == Activity.RESULT_CANCELED) {
                    result.success(Constants.RESULT_CANCELED);
                    HMSLogger.getInstance(context).sendSingleEvent("onActivityResult");
                } else if (resultCode == NO_OWNER) {
                    result.success(Constants.NO_OWNER);
                    HMSLogger.getInstance(context).sendSingleEvent("onActivityResult");
                } else if (resultCode == HMS_VERSION_CODE) {
                    result.success(Constants.HMS_VERSION_CODE);
                    HMSLogger.getInstance(context).sendSingleEvent("onActivityResult");
                } else if (data != null) {
                    final int errorCode = data.getIntExtra(WalletPassConstant.EXTRA_ERROR_CODE, -1);
                    result.error(String.valueOf(errorCode), analyzeErrorCode(errorCode), "");
                    HMSLogger.getInstance(context).sendSingleEvent("onActivityResult", String.valueOf(errorCode));
                } else {
                    final int errorCode = WalletPassConstant.ERROR_CODE_OTHERS;
                    result.error(String.valueOf(errorCode), analyzeErrorCode(errorCode), "");
                    HMSLogger.getInstance(context).sendSingleEvent("onActivityResult", String.valueOf(errorCode));
                }
            }
            activityRequestMethods.remove(requestCode);
            activityRequestResults.remove(requestCode);
        } else {
            Log.e(TAG, "onActivityResult is returned data to a null MethodCall - Result object pair");
            HMSLogger.getInstance(context).sendSingleEvent("onActivityResult", String.valueOf(Constants.MISSING_METHOD_RESULT));
        }
        return true;
    }

    private String analyzeErrorCode(int errorCode) {
        switch (errorCode) {
            case WalletPassConstant.ERROR_CODE_SERVICE_UNAVAILABLE:
                return "server unavailable（net error）";
            case WalletPassConstant.ERROR_CODE_INTERNAL_ERROR:
                return "internal error";
            case WalletPassConstant.ERROR_CODE_INVALID_PARAMETERS:
                return "invalid parameters or card is added";
            case WalletPassConstant.ERROR_CODE_MERCHANT_ACCOUNT_ERROR:
                return "JWE verify fail";
            case WalletPassConstant.ERROR_CODE_USER_ACCOUNT_ERROR:
                return "hms account error（invalidity or Authentication failed）";
            case WalletPassConstant.ERROR_CODE_UNSUPPORTED_API_REQUEST:
                return "unSupport API";
            case WalletPassConstant.ERROR_CODE_OTHERS:
            default:
                return "unknown Error";
        }
    }
}

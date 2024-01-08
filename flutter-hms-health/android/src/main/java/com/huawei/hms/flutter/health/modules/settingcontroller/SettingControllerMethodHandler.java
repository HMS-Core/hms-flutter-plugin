/*
 * Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.health.modules.settingcontroller;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.huawei.agconnect.config.AGConnectServicesConfig;
import com.huawei.hms.flutter.health.foundation.constants.Constants;
import com.huawei.hms.flutter.health.foundation.helper.ResultHelper;
import com.huawei.hms.flutter.health.foundation.helper.VoidResultHelper;
import com.huawei.hms.flutter.health.foundation.listener.VoidResultListener;
import com.huawei.hms.flutter.health.foundation.logger.HMSLogger;
import com.huawei.hms.flutter.health.foundation.utils.Utils;
import com.huawei.hms.flutter.health.modules.settingcontroller.service.DefaultSettingController;
import com.huawei.hms.flutter.health.modules.settingcontroller.utils.SettingControllerConstants.SettingControllerMethods;
import com.huawei.hms.hihealth.ConsentsController;
import com.huawei.hms.hihealth.HuaweiHiHealth;
import com.huawei.hms.hihealth.SettingController;
import com.huawei.hms.hihealth.data.DataType;
import com.huawei.hms.hihealth.data.ScopeLangItem;
import com.huawei.hms.hihealth.options.DataTypeAddOptions;
import com.huawei.hms.hihealth.options.DataTypeAddOptions.Builder;
import com.huawei.hms.hihealth.result.HealthKitAuthResult;

import org.json.JSONException;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SettingControllerMethodHandler implements MethodCallHandler, PluginRegistry.ActivityResultListener {
    private Activity activity;

    private Context context;

    private SettingController settingController;

    private ConsentsController consentsController;

    private DefaultSettingController settingControllerImpl;

    private MethodChannel.Result mResult;

    public SettingControllerMethodHandler(@Nullable Activity activity) {
        this.activity = activity;
        this.settingControllerImpl = new DefaultSettingController();
    }

    public void setActivity(@Nullable Activity activity) {
        this.activity = activity;
        if (activity != null) {
            initControllers();
            this.context = activity.getApplicationContext();
        }
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer(call.method);
        switch (SettingControllerMethods.get(call.method)) {
            case ADD_DATA_TYPE:
                addDataType(call, result);
                break;
            case READ_DATA_TYPE:
                readDataType(call, result);
                break;
            case DISABLE_HI_HEALTH:
                disableHiHealth(call, result);
                break;
            case CHECK_HEALTH_APP_AUTHORIZATION:
                checkHealthAppAuth(call, result);
                break;
            case GET_HEALTH_APP_AUTHORIZATION:
                getHealthAppAuth(call, result);
                break;
            default:
                onConsentMethodCall(call, result);
                break;
        }
    }

    private void onConsentMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (SettingControllerMethods.get(call.method)) {
            case GET:
                get(call, result);
                break;
            case REVOKE:
                revoke(call, result);
                break;
            case REVOKE_WITH_SCOPES:
                revokeWithScopes(call, result);
                break;
            case CANCEL_AUTHORIZATION:
                cancelAuthorization(call, result);
                break;
            case CANCEL_AUTHORIZATION_WITH_SCOPES:
                cancelAuthorizationWithScopes(call, result);
                break;
            case GET_APP_ID:
                getAppId(result);
                break;
            default:
                onLoggerMethodCall(call, result);
                break;
        }
    }

    private void onLoggerMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (SettingControllerMethods.get(call.method)) {
            case ENABLE_LOGGER:
                HMSLogger.getInstance(activity).enableLogger();
                break;
            case DISABLE_LOGGER:
                HMSLogger.getInstance(activity).disableLogger();
                break;
            case REQUEST_AUTHORIZATION_INTENT:
                reqAuthIntent(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private String[] toStringArray(List<String> strings) {
        String[] res = new String[strings.size()];
        for (int i = 0; i < res.length; i++) {
            res[i] = strings.get(i);
        }
        return res;
    }

    private void reqAuthIntent(MethodCall call, Result result) {
        checkControllers();
        mResult = result;
        List<String> list = call.argument("scopes");
        Log.i("test", list.toString());

        String[] array = toStringArray(list);

        checkControllers();

        Intent intent = settingController.requestAuthorizationIntent(array, true);
        activity.startActivityForResult(intent, 8888);
    }

    private void addDataType(final MethodCall call, final Result result) {
        checkControllers();
        // Create a DataTypeAddOptions. The options to be added must be specified.
        DataTypeAddOptions dataTypeAddOptions = toDataTypeAddOptions((HashMap<String, Object>) call.arguments);
        // Add a new data type.
        settingControllerImpl.addDataType(settingController, dataTypeAddOptions,
            new ResultHelper<>(DataType.class, result, context, call.method));
    }

    private void readDataType(final MethodCall call, final Result result) {
        checkControllers();
        String dataTypeName = (String) call.arguments;
        settingControllerImpl.readDataType(settingController, dataTypeName,
            new ResultHelper<>(DataType.class, result, context, call.method));
    }

    private void disableHiHealth(final MethodCall call, final Result result) {
        checkControllers();
        settingControllerImpl.disableHiHealth(settingController, new VoidResultHelper(result, context, call.method));
    }

    private void checkHealthAppAuth(final MethodCall call, final Result result) {
        checkControllers();
        settingControllerImpl.checkHealthAppAuthorization(settingController,
            new VoidResultHelper(result, context, call.method));
    }

    private void getHealthAppAuth(final MethodCall call, final Result result) {
        checkControllers();
        settingControllerImpl.getHealthAppAuthorization(settingController,
            new ResultHelper<>(Boolean.class, result, context, call.method));
    }

    private void getAppId(final Result result) {
        String appId = AGConnectServicesConfig.fromContext(context).getString("client/app_id");
        if (appId == null) {
            appId = "";
        }
        result.success(appId);
    }

    private void get(final MethodCall call, final Result result) {
        checkControllers();
        String lang = call.argument("lang");
        String appId = call.argument("appId");
        ResultHelper<ScopeLangItem> resultHelper = new ResultHelper<>(ScopeLangItem.class, result, context,
            call.method);
        consentsController.get(lang, appId)
            .addOnSuccessListener(resultHelper::onSuccess)
            .addOnFailureListener(resultHelper::onFail);
    }

    private void revoke(final MethodCall call, final Result result) {
        checkControllers();
        String appId = (String) call.arguments;

        VoidResultListener voidResultListener = new VoidResultHelper(result, context, call.method);
        consentsController.revoke(appId)
            .addOnSuccessListener(voidResultListener::onSuccess)
            .addOnFailureListener(voidResultListener::onFail);
    }

    private void revokeWithScopes(final MethodCall call, final Result result) {
        checkControllers();
        String appId = call.argument("appId");
        List<String> scopes = call.argument("scopes");
        VoidResultListener voidResultListener = new VoidResultHelper(result, context, call.method);
        consentsController.revoke(appId, scopes)
            .addOnSuccessListener(voidResultListener::onSuccess)
            .addOnFailureListener(voidResultListener::onFail);
    }

    private void cancelAuthorization(final MethodCall call, final Result result) {
        checkControllers();
        final Boolean deleteData = (Boolean) call.arguments;
        final VoidResultListener voidResultListener = new VoidResultHelper(result, context, call.method);
        consentsController.cancelAuthorization(deleteData)
            .addOnSuccessListener(voidResultListener::onSuccess)
            .addOnFailureListener(voidResultListener::onFail);
    }

    private void cancelAuthorizationWithScopes(final MethodCall call, final Result result) {
        checkControllers();
        final String appId = call.argument("appId");
        final List<String> scopes = call.argument("scopes");
        final VoidResultListener voidResultListener = new VoidResultHelper(result, context, call.method);
        consentsController.cancelAuthorization(appId, scopes)
            .addOnSuccessListener(voidResultListener::onSuccess)
            .addOnFailureListener(voidResultListener::onFail);
    }

    /**
     * Initialize variable of settingController with no dataType params, in case it is null.
     */
    private void initControllers() {
        this.settingController = HuaweiHiHealth.getSettingController(activity);
        this.consentsController = HuaweiHiHealth.getConsentsController(activity);
    }

    /**
     * Check whether dataController is initialized, or not.
     */
    private void checkControllers() {
        if (this.settingController == null && this.activity != null) {
            initControllers();
        }
    }

    private DataTypeAddOptions toDataTypeAddOptions(Map<String, Object> callMap) {
        DataTypeAddOptions.Builder builder = new Builder();
        if (Boolean.TRUE.equals(Utils.hasKey(callMap, Constants.NAME_KEY))) {
            builder.setName((String) callMap.get(Constants.NAME_KEY));
        }
        if (Boolean.TRUE.equals(Utils.hasKey(callMap, Constants.FIELDS_KEY))) {
            ArrayList<HashMap<String, Object>> fieldList = (ArrayList<HashMap<String, Object>>) callMap.get(
                Constants.FIELDS_KEY);
            if (fieldList != null) {
                for (HashMap<String, Object> fieldMap : fieldList) {
                    builder.addField(Utils.toField(fieldMap));
                }
            }
        }
        return builder.build();
    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == 8888) {
            HealthKitAuthResult result = settingController.parseHealthKitAuthResultFromIntent(data);
            try {
                mResult.success(result.toJson());
            } catch (JSONException e) {
                Log.i("SettingCntlerHandler", e.toString());
            }
        }
        return true;
    }
}

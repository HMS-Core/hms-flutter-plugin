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

package com.huawei.hms.flutter.health.modules.blecontroller;

import static com.huawei.hms.flutter.health.modules.blecontroller.utils.BleControllerConstants.DATA_TYPES_KEY;
import static com.huawei.hms.flutter.health.modules.blecontroller.utils.BleControllerConstants.TIMEOUT_SECS_KEY;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.huawei.hms.flutter.health.foundation.helper.ResultHelper;
import com.huawei.hms.flutter.health.foundation.helper.VoidResultHelper;
import com.huawei.hms.flutter.health.foundation.listener.ResultListener;
import com.huawei.hms.flutter.health.foundation.logger.HMSLogger;
import com.huawei.hms.flutter.health.foundation.utils.ExceptionHandler;
import com.huawei.hms.flutter.health.foundation.utils.Utils;
import com.huawei.hms.flutter.health.modules.blecontroller.service.BleControllerService;
import com.huawei.hms.flutter.health.modules.blecontroller.service.DefaultBleControllerService;
import com.huawei.hms.flutter.health.modules.blecontroller.utils.BleControllerConstants;
import com.huawei.hms.flutter.health.modules.blecontroller.utils.BleControllerConstants.BleControllerMethods;
import com.huawei.hms.flutter.health.modules.blecontroller.utils.BleControllerUtils;
import com.huawei.hms.hihealth.BleController;
import com.huawei.hms.hihealth.HiHealthOptions;
import com.huawei.hms.hihealth.HiHealthStatusCodes;
import com.huawei.hms.hihealth.HuaweiHiHealth;
import com.huawei.hms.hihealth.data.BleDeviceInfo;
import com.huawei.hms.hihealth.data.DataType;
import com.huawei.hms.support.hwid.HuaweiIdAuthManager;
import com.huawei.hms.support.hwid.result.AuthHuaweiId;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class BleControllerMethodHandler implements MethodCallHandler {
    private static final String TAG = BleControllerConstants.BLE_MODULE_NAME;
    private BleController bleController;

    private BleControllerService bleControllerService;

    private Activity activity;
    private Context context;

    public BleControllerMethodHandler(@Nullable Activity activity) {
        this.activity = activity;
    }

    public void setActivity(@Nullable Activity activity) {
        this.activity = activity;
        if (activity != null) {
            checkBleController();
            this.context = activity.getApplicationContext();
        }
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer(call.method);
        switch (BleControllerMethods.get(call.method)) {
            case BEGIN_SCAN:
                beginScan(call, result);
                break;
            case END_SCAN:
                endScan(call, result);
                break;
            case GET_SAVED_DEVICES:
                getSavedDevices(call, result);
                break;
            case SAVE_DEVICE_BY_INFO:
                saveDeviceByInfo(call, result);
                break;
            case SAVE_DEVICE_BY_ADDRESS:
                saveDeviceByAddress(call, result);
                break;
            case DELETE_DEVICE_BY_INFO:
                deleteDeviceByInfo(call, result);
                break;
            case DELETE_DEVICE_BY_ADDRESS:
                deleteDeviceByAddress(call, result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void beginScan(final MethodCall call, final Result result) {
        checkBleController();
        int timeoutSecs = Utils.getInt(call, TIMEOUT_SECS_KEY);
        ArrayList<HashMap<String, Object>> dataTypeMaps = call.argument(DATA_TYPES_KEY);
        List<DataType> dataTypes = new ArrayList<>();
        if (dataTypeMaps != null) {
            for (HashMap<String, Object> dataTypeMap : dataTypeMaps) {
                DataType dt = Utils.toDataType(dataTypeMap, activity.getPackageName());
                dataTypes.add(dt);
            }
            bleControllerService.beginScan(bleController, dataTypes, timeoutSecs,
                new VoidResultHelper(result, context, call.method));
        } else {
            HMSLogger.getInstance(context)
                .sendSingleEvent(call.method, String.valueOf(HiHealthStatusCodes.INPUT_PARAM_MISSING));
            result.error(TAG, "Please provide valid data types and timeout seconds in the method call", "");
        }
    }

    private void endScan(final MethodCall call, final Result flutterResult) {
        checkBleController();
        bleControllerService.endScan(bleController,
            new ResultHelper<>(Boolean.class, flutterResult, context, call.method));
    }

    private void getSavedDevices(final MethodCall call, final Result result) {
        checkBleController();
        bleControllerService.getSavedDevices(bleController, new BleReadListener(context, call, result));
    }

    private void saveDeviceByInfo(final MethodCall call, final Result result) {
        checkBleController();
        BleDeviceInfo bleDeviceInfo = BleControllerUtils.toBleDeviceInfo((Map<String, Object>) call.arguments,
            activity.getPackageName());
        bleControllerService.saveDevice(bleController, bleDeviceInfo,
            new VoidResultHelper(result, context, call.method));
    }

    private void saveDeviceByAddress(final MethodCall call, final Result result) {
        checkBleController();
        bleControllerService.saveDevice(bleController, (String) call.arguments,
            new VoidResultHelper(result, context, call.method));
    }

    private void deleteDeviceByAddress(final MethodCall call, final Result result) {
        checkBleController();
        bleControllerService.deleteDevice(bleController, (String) call.arguments,
            new VoidResultHelper(result, context, call.method));
    }

    private void deleteDeviceByInfo(final MethodCall call, final Result result) {
        checkBleController();
        BleDeviceInfo bleDeviceInfo = BleControllerUtils.toBleDeviceInfo((Map<String, Object>) call.arguments,
            activity.getPackageName());
        bleControllerService.deleteDevice(bleController, bleDeviceInfo,
            new VoidResultHelper(result, context, call.method));
    }

    /**
     * Initialize {@link BleController}.
     */
    private void initBleRecorderController() {
        // Obtain BleController first when accessing the UI.
        HiHealthOptions options = HiHealthOptions.builder().build();
        // Sign in to the HUAWEI ID.
        AuthHuaweiId signInHuaweiId = HuaweiIdAuthManager.getExtendedAuthResult(options);
        // Obtain BleController.
        bleController = HuaweiHiHealth.getBleController(activity, signInHuaweiId);
    }

    /**
     * Check whether bleRecorderController is initialized, or not.
     */
    private void checkBleController() {
        if (this.bleController == null) {
            initBleRecorderController();
        }
        if (bleControllerService == null) {
            this.bleControllerService = new DefaultBleControllerService(activity);
        }
    }

    /**
     * Listener for getSavedDevices method.
     */
    static class BleReadListener implements ResultListener<List<BleDeviceInfo>> {
        private Context context;
        private final Result result;
        private final MethodCall call;

        public BleReadListener(Context context, final MethodCall call, final Result result) {
            this.context = context;
            this.result = result;
            this.call = call;
        }

        @Override
        public void onSuccess(List<BleDeviceInfo> bleDeviceInfoList) {
            HMSLogger.getInstance(context).sendSingleEvent(call.method);
            result.success(BleControllerUtils.bleDeviceInfoListToMap(bleDeviceInfoList));
        }

        @Override
        public void onFail(Exception exception) {
            String errorCode = Utils.getErrorCode(exception);
            HMSLogger.getInstance(context).sendSingleEvent(call.method, errorCode);
            ExceptionHandler.fail(exception, result);
        }
    }

}

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

package com.huawei.hms.flutter.health.modules.settingcontroller.service;

import com.huawei.hms.flutter.health.foundation.listener.ResultListener;
import com.huawei.hms.flutter.health.foundation.listener.VoidResultListener;
import com.huawei.hms.flutter.health.modules.settingcontroller.utils.SettingControllerConstants;
import com.huawei.hms.hihealth.SettingController;
import com.huawei.hms.hihealth.data.DataType;
import com.huawei.hms.hihealth.options.DataTypeAddOptions;

import io.flutter.Log;

public class DefaultSettingController implements DefaultSettingControllerService {
    private static final String TAG = SettingControllerConstants.SETTING_CONTROLLER_MODULE;

    @Override
    public void addDataType(SettingController settingController, DataTypeAddOptions options,
        ResultListener<DataType> resultListener) {
        settingController.addDataType(options).addOnFailureListener(exception -> {
            Log.i(SettingControllerConstants.SETTING_CONTROLLER_MODULE, "Add dataType failed");
            resultListener.onFail(exception);
        }).addOnSuccessListener(dataType -> {
            Log.i(TAG, "Add dataType is successful");
            resultListener.onSuccess(dataType);
        });
    }

    @Override
    public void disableHiHealth(SettingController settingController, VoidResultListener voidResultListener) {
        settingController.disableHiHealth().addOnFailureListener(exception -> {
            Log.i("TAG", "Disable HiHealth failed");
            voidResultListener.onFail(exception);
        }).addOnSuccessListener(task -> {
            Log.i(TAG, "Disable HiHealth is successful");
            voidResultListener.onSuccess(task);
        });
    }

    @Override
    public void readDataType(SettingController settingController, String dataTypeName,
        ResultListener<DataType> resultListener) {
        settingController.readDataType(dataTypeName).addOnFailureListener(exception -> {
            Log.i(TAG, "Read dataType failed");
            resultListener.onFail(exception);
        }).addOnSuccessListener(dataType -> {
            Log.i(TAG, "Read dataType successful");
            resultListener.onSuccess(dataType);
        });
    }

    @Override
    public void checkHealthAppAuthorization(SettingController settingController,
        VoidResultListener voidResultListener) {
        settingController.checkHealthAppAuthorization().addOnFailureListener(exception -> {
            Log.i(TAG, "checkHealthAppAuthorization failed");
            voidResultListener.onFail(exception);
        }).addOnSuccessListener(aVoid -> {
            Log.i(TAG, "checkHealthAppAuthorization is successful");
            voidResultListener.onSuccess(aVoid);
        });
    }

    @Override
    public void getHealthAppAuthorization(SettingController settingController, ResultListener<Boolean> resultListener) {
        settingController.getHealthAppAuthorization().addOnFailureListener(exception -> {
            Log.i(TAG, "getHealthAppAuthorization failed");
            resultListener.onFail(exception);
        }).addOnSuccessListener(aBoolean -> {
            Log.i(TAG, "getHealthAppAuthorization is successful");
            resultListener.onSuccess(aBoolean);
        });
    }
}

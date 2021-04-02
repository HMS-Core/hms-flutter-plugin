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

package com.huawei.hms.flutter.health.modules.blecontroller.service;

import android.app.Activity;
import android.content.Intent;

import com.google.gson.Gson;
import com.huawei.hms.flutter.health.foundation.listener.ResultListener;
import com.huawei.hms.flutter.health.foundation.listener.VoidResultListener;
import com.huawei.hms.flutter.health.modules.blecontroller.utils.BleControllerConstants;
import com.huawei.hms.flutter.health.modules.blecontroller.utils.BleControllerUtils;
import com.huawei.hms.hihealth.BleController;
import com.huawei.hms.hihealth.data.BleDeviceInfo;
import com.huawei.hms.hihealth.data.DataType;
import com.huawei.hms.hihealth.options.BleScanCallback;

import java.util.List;

import io.flutter.Log;

public class DefaultBleControllerService implements BleControllerService {
    private static final String TAG = BleControllerConstants.BLE_MODULE_NAME;

    private Activity activity;

    public DefaultBleControllerService(Activity activity) {
        this.activity = activity;
    }

    /**
     * Bluetooth scanning callback object
     */
    private BleScanCallback bleCallback = new BleScanCallback() {
        @Override
        public void onDeviceDiscover(BleDeviceInfo bleDeviceInfo) {
            // Bluetooth devices detected during the scanning will be called back to the bleDeviceInfo object.
            Log.i(TAG, "onDeviceDiscover : " + bleDeviceInfo.getDeviceName());
            // Send the found device to Flutter Platform.
            Gson gson = new Gson();
            String bleDeviceJson = gson.toJson(BleControllerUtils.bleDeviceInfoToMap(bleDeviceInfo));
            Intent intent = new Intent();
            intent.setAction(BleControllerConstants.BLE_SCAN_INTENT_ACTION);
            intent.putExtra("bleDeviceInfo", bleDeviceJson);
            activity.sendBroadcast(intent);
        }

        @Override
        public void onScanEnd() {
            Log.i(TAG, "onScanEnd");
        }
    };

    @Override
    public void beginScan(BleController bleController, List<DataType> dataTypes, int time,
        VoidResultListener listener) {
        Log.i(TAG, "call beginScan");
        bleController.beginScan(dataTypes, time, bleCallback)
            .addOnSuccessListener(listener::onSuccess)
            .addOnFailureListener(listener::onFail);
    }

    @Override
    public void endScan(BleController bleController, ResultListener<Boolean> listener) {
        Log.i(TAG, "call endScan");
        bleController.endScan(bleCallback)
            .addOnSuccessListener(listener::onSuccess)
            .addOnFailureListener(listener::onFail);
    }

    @Override
    public void getSavedDevices(BleController bleController, ResultListener<List<BleDeviceInfo>> listener) {
        Log.i(TAG, "call getSavedDevices");
        bleController.getSavedDevices()
            .addOnSuccessListener(listener::onSuccess)
            .addOnFailureListener(listener::onFail);
    }

    @Override
    public void saveDevice(BleController bleController, BleDeviceInfo bleDeviceInfo, VoidResultListener listener) {
        Log.i(TAG, "call saveDeviceByInfo");
        bleController.saveDevice(bleDeviceInfo)
            .addOnSuccessListener(listener::onSuccess)
            .addOnFailureListener(listener::onFail);
    }

    @Override
    public void saveDevice(BleController bleController, String deviceAddress, VoidResultListener listener) {
        Log.i(TAG, "call saveDeviceByAddress");
        bleController.saveDevice(deviceAddress)
            .addOnSuccessListener(listener::onSuccess)
            .addOnFailureListener(listener::onFail);
    }

    @Override
    public void deleteDevice(BleController bleController, BleDeviceInfo bleDeviceInfo, VoidResultListener listener) {
        Log.i(TAG, "call deleteDeviceByInfo");
        bleController.deleteDevice(bleDeviceInfo)
            .addOnSuccessListener(listener::onSuccess)
            .addOnFailureListener(listener::onFail);
    }

    @Override
    public void deleteDevice(BleController bleController, String deviceAddress, VoidResultListener listener) {
        Log.i(TAG, "call deleteDeviceByAddress");
        bleController.deleteDevice(deviceAddress)
            .addOnSuccessListener(listener::onSuccess)
            .addOnFailureListener(listener::onFail);
    }
}

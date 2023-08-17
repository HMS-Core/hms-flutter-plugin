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

package com.huawei.hms.flutter.health.modules.healthcontroller;

import android.app.Activity;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.huawei.hms.flutter.health.foundation.logger.HMSLogger;
import com.huawei.hms.hihealth.HealthRecordController;
import com.huawei.hms.hihealth.HuaweiHiHealth;
import com.huawei.hms.hihealth.data.HealthRecord;
import com.huawei.hms.hihealth.options.HealthRecordDeleteOptions;
import com.huawei.hms.hihealth.options.HealthRecordInsertOptions;
import com.huawei.hms.hihealth.options.HealthRecordReadOptions;
import com.huawei.hms.hihealth.options.HealthRecordUpdateOptions;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import java.util.Map;

public class HealthControllerMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = "HealthControllerHandler";

    private Activity activity;

    private HealthRecordController healthRecordController;

    public HealthControllerMethodHandler(@Nullable Activity a) {
        this.activity = a;
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
        this.healthRecordController = HuaweiHiHealth.getHealthRecordController(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "addHealthRecord":
                addHR(call, result);
                break;
            case "updateHealthRecord":
                updateHR(call, result);
                break;
            case "getHealthRecord":
                getHR(call, result);
                break;
            case "deleteHealthRecord":
                deleteHR(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void addHR(MethodCall call, MethodChannel.Result result) {
        Map<String, Object> map = HealthRecordUtils.fromObject(call.argument("healthRecord"));

        if (map.isEmpty()) {
            result.error(TAG, "Invalid parameter", null);
            return;
        }
        HealthRecord hr = HealthRecordUtils.createHR(map, activity.getPackageName(), result);
        HealthRecordInsertOptions opt = new HealthRecordInsertOptions.Builder().setHealthRecord(hr).build();

        healthRecordController.addHealthRecord(opt).addOnSuccessListener(s -> {
            HMSLogger.getInstance(activity).sendSingleEvent(call.method);
            result.success(s);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity).sendSingleEvent(call.method, "-1");
            result.error(TAG, e.getMessage(), null);
        });
    }

    private void updateHR(MethodCall call, MethodChannel.Result result) {
        Map<String, Object> map = HealthRecordUtils.fromObject(call.argument("healthRecord"));
        String hrID = call.argument("healthRecordId");

        if (map.isEmpty() || hrID == null) {
            result.error(TAG, "Invalid parameter", null);
            return;
        }
        HealthRecord hr = HealthRecordUtils.createHR(map, activity.getPackageName(), result);
        HealthRecordUpdateOptions opt = new HealthRecordUpdateOptions.Builder().setHealthRecord(hr)
            .setHealthRecordId(hrID)
            .build();

        healthRecordController.updateHealthRecord(opt).addOnSuccessListener(aVoid -> {
            HMSLogger.getInstance(activity).sendSingleEvent(call.method);
            result.success(true);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity).sendSingleEvent(call.method, "-1");
            result.error(TAG, e.getMessage(), null);
        });
    }

    private void getHR(MethodCall call, MethodChannel.Result result) {
        Map<String, Object> reqMap = HealthRecordUtils.fromObject(call.arguments);

        if (reqMap.isEmpty()) {
            HMSLogger.getInstance(activity).sendSingleEvent(call.method, "-1");
            result.error(TAG, "Invalid parameters", null);
            return;
        }
        HealthRecordReadOptions opt = HealthRecordUtils.createHRReadOptions(reqMap);
        healthRecordController.getHealthRecord(opt).addOnSuccessListener(healthRecordReply -> {
            HMSLogger.getInstance(activity).sendSingleEvent(call.method);
            result.success(HealthRecordUtils.hrReplyToMap(healthRecordReply));
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity).sendSingleEvent(call.method, "-1");
            result.error(TAG, e.getMessage(), null);
        });
    }

    private void deleteHR(MethodCall call, MethodChannel.Result result) {
        Map<String, Object> reqMap = HealthRecordUtils.fromObject(call.arguments);

        if (reqMap.isEmpty()) {
            HMSLogger.getInstance(activity).sendSingleEvent(call.method, "-1");
            result.error(TAG, "Invalid parameters", null);
            return;
        }
        HealthRecordDeleteOptions opt = HealthRecordUtils.createHRDeleteOptions(reqMap, activity.getPackageName());
        healthRecordController.deleteHealthRecord(opt).addOnSuccessListener(aVoid -> {
            HMSLogger.getInstance(activity).sendSingleEvent(call.method);
            result.success(null);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity).sendSingleEvent(call.method, "-1");
            result.error(TAG, e.getMessage(), null);
        });
    }
}

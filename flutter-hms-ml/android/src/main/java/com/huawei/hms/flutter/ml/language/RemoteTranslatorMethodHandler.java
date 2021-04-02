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

package com.huawei.hms.flutter.ml.language;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hmf.tasks.Tasks;
import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.mlsdk.common.MLException;
import com.huawei.hms.mlsdk.translate.MLTranslateLanguage;
import com.huawei.hms.mlsdk.translate.MLTranslatorFactory;
import com.huawei.hms.mlsdk.translate.cloud.MLRemoteTranslator;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class RemoteTranslatorMethodHandler implements MethodChannel.MethodCallHandler {
    private final static String TAG = RemoteTranslatorMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;

    private MLRemoteTranslator mlRemoteTranslator;

    public RemoteTranslatorMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "getCloudAllLanguages":
                getCloudLanguages();
                break;
            case "syncGetCloudAllLanguages":
                getSyncCloudLanguages();
                break;
            case "asyncTranslate":
                asyncTranslate(call);
                break;
            case "syncTranslate":
                syncTranslate(call);
                break;
            case "stop":
                stopTranslate();
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    private void getCloudLanguages() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getCloudLanguages");
        MLTranslateLanguage.getCloudAllLanguages().addOnSuccessListener(strings -> {
            List<String> list = new ArrayList<>(strings);
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getCloudLanguages");
            mResult.success(list);
        }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "getCloudLanguages", mResult));
    }

    private void getSyncCloudLanguages() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getSyncCloudLanguages");
        try {
            Set<String> result = MLTranslateLanguage.syncGetCloudAllLanguages();
            List<String> syncResult = new ArrayList<>(result);
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getSyncCloudLanguages");
            mResult.success(syncResult);
        } catch (MLException e) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getSyncCloudLanguages", String.valueOf(e.getErrCode()));
            mResult.error(TAG, e.getMessage(), e.getErrCode());
        }
    }

    private void asyncTranslate(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("asyncTranslate");
        String text2 = call.argument("sourceText");

        if (text2 == null || text2.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncTranslate", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Illegal parameter", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        mlRemoteTranslator = MLTranslatorFactory.getInstance().getRemoteTranslator(SettingUtils.createRemoteTranslateSetting(call));

        mlRemoteTranslator.asyncTranslate(text2).addOnSuccessListener(s -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncTranslate");
            mResult.success(s);
        }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "asyncTranslate", mResult));
    }

    private void syncTranslate(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("syncTranslate");
        String text3 = call.argument("sourceText");

        if (text3 == null || text3.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncTranslate", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Illegal parameter", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        mlRemoteTranslator = MLTranslatorFactory.getInstance().getRemoteTranslator(SettingUtils.createRemoteTranslateSetting(call));

        Tasks.callInBackground(() -> mlRemoteTranslator.syncTranslate(text3)).addOnSuccessListener(s -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncTranslate");
            mResult.success(s);
        }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "syncTranslate", mResult));
    }

    private void stopTranslate() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopTranslate");
        if (mlRemoteTranslator == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopTranslate", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Translator is not prepared", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }
        mlRemoteTranslator.stop();
        mlRemoteTranslator = null;
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopTranslate");
        mResult.success(true);
    }
}

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

import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.mlsdk.common.MLException;
import com.huawei.hms.mlsdk.model.download.MLLocalModelManager;
import com.huawei.hms.mlsdk.translate.MLTranslateLanguage;
import com.huawei.hms.mlsdk.translate.MLTranslatorFactory;
import com.huawei.hms.mlsdk.translate.local.MLLocalTranslator;
import com.huawei.hms.mlsdk.translate.local.MLLocalTranslatorModel;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class LocalTranslatorMethodHandler implements MethodChannel.MethodCallHandler {
    private final static String TAG = LocalTranslatorMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;

    private MLLocalTranslator mlLocalTranslator;

    public LocalTranslatorMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "syncGetLocalAllLanguages":
                getSyncLocalLanguages();
                break;
            case "stop":
                stopTranslate();
                break;
            case "deleteModel":
                deleteModel(call);
                break;
            case "asyncTranslate":
                asyncTranslate(call);
                break;
            case "prepareModel":
                prepareModel(call);
                break;
            case "syncTranslate":
                syncTranslate(call);
                break;
            case "getLocalAllLanguages":
                getLocalLanguages();
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    private void getLocalLanguages() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getLocalLanguages");
        MLTranslateLanguage.getLocalAllLanguages().addOnSuccessListener(strings -> {
            List<String> list = new ArrayList<>(strings);
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getLocalLanguages");
            mResult.success(list);
        }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "getLocalLanguages", mResult));
    }

    private void getSyncLocalLanguages() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getSyncLocalLanguages");
        Set<String> result = MLTranslateLanguage.syncGetLocalAllLanguages();
        List<String> syncResult = new ArrayList<>(result);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getSyncLocalLanguages");
        mResult.success(syncResult);
    }

    private void prepareModel(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("prepareModel");
        mlLocalTranslator = MLTranslatorFactory.getInstance().getLocalTranslator(SettingUtils.createLocalTranslateSetting(call));

        mlLocalTranslator.preparedModel(SettingUtils.createModelDownloadStrategy(call), SettingUtils.MODEL_DOWNLOAD_LISTENER
        ).addOnSuccessListener(aVoid -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("prepareModel");
            mResult.success(true);
        }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "prepareModel", mResult));
    }

    private void deleteModel(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("deleteModel");
        String lang = call.argument("langCode");
        MLLocalModelManager localModelManager = MLLocalModelManager.getInstance();

        MLLocalTranslatorModel model = new MLLocalTranslatorModel.Factory(lang).create();
        localModelManager.deleteModel(model).addOnSuccessListener(aVoid -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("deleteModel");
            mResult.success(true);
        }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "deleteModel", mResult));
    }

    private void asyncTranslate(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("asyncTranslate");
        String text = call.argument("sourceText");

        if (text == null || text.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncTranslate", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Illegal parameter", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        mlLocalTranslator.asyncTranslate(text).addOnSuccessListener(s -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncTranslate");
            mResult.success(s);
        }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "asyncTranslate", mResult));
    }

    private void syncTranslate(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("syncTranslate");
        String text1 = call.argument("sourceText");

        if (text1 == null || text1.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncTranslate", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Illegal parameter", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        try {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncTranslate");
            mResult.success(mlLocalTranslator.syncTranslate(text1));
        } catch (MLException e) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncTranslate", String.valueOf(e.getErrCode()));
            mResult.error(TAG, e.getMessage(), String.valueOf(e.getErrCode()));
        }
    }

    private void stopTranslate() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopTranslate");
        if (mlLocalTranslator == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopTranslate", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Translator is not prepared", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }
        mlLocalTranslator.stop();
        mlLocalTranslator = null;
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopTranslate");
        mResult.success(true);
    }
}

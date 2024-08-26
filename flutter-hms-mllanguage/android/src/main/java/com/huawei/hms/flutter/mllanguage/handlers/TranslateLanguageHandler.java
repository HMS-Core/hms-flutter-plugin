/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.mllanguage.handlers;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.mlsdk.common.MLException;
import com.huawei.hms.mlsdk.translate.MLTranslateLanguage;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class TranslateLanguageHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = TranslateLanguageHandler.class.getSimpleName();

    private final ResponseHandler handler;

    public TranslateLanguageHandler(Activity activity) {
        this.handler = ResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        handler.setup(TAG, call.method, result);
        switch (call.method) {
            case "getCloudAllLanguages":
                getCloudLanguages();
                break;
            case "getLocalAllLanguages":
                getLocalLanguages();
                break;
            case "syncGetCloudAllLanguages":
                getSyncCloudLanguages();
                break;
            case "syncGetLocalAllLanguages":
                getSyncLocalLanguages();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void getLocalLanguages() {
        MLTranslateLanguage.getLocalAllLanguages().addOnSuccessListener(strings -> {
            List<String> list = new ArrayList<>(strings);
            handler.success(list);
        }).addOnFailureListener(handler::exception);
    }

    private void getSyncLocalLanguages() {
        Set<String> result = MLTranslateLanguage.syncGetLocalAllLanguages();
        List<String> syncResult = new ArrayList<>(result);
        handler.success(syncResult);
    }

    private void getCloudLanguages() {
        MLTranslateLanguage.getCloudAllLanguages().addOnSuccessListener(strings -> {
            List<String> list = new ArrayList<>(strings);
            handler.success(list);
        }).addOnFailureListener(handler::exception);
    }

    private void getSyncCloudLanguages() {
        Set<String> result;
        try {
            result = MLTranslateLanguage.syncGetCloudAllLanguages();
            List<String> syncResult = new ArrayList<>(result);
            handler.success(syncResult);
        } catch (MLException e) {
            handler.exception(e);
        }
    }
}

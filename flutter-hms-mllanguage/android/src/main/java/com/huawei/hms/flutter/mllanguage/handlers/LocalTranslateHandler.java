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
import android.os.Handler;
import android.os.Looper;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mllanguage.utils.FromMap;
import com.huawei.hms.flutter.mllanguage.utils.RequestBuilder;
import com.huawei.hms.mlsdk.common.MLException;
import com.huawei.hms.mlsdk.model.download.MLLocalModelManager;
import com.huawei.hms.mlsdk.model.download.MLModelDownloadListener;
import com.huawei.hms.mlsdk.translate.MLTranslatorFactory;
import com.huawei.hms.mlsdk.translate.local.MLLocalTranslator;
import com.huawei.hms.mlsdk.translate.local.MLLocalTranslatorModel;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class LocalTranslateHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = "LocalTranslator";

    private final Handler handler = new Handler(Looper.getMainLooper());
    private final ResponseHandler responseHandler;

    private MethodChannel mChannel;
    private MLLocalTranslator mlLocalTranslator;

    public LocalTranslateHandler(Activity activity, MethodChannel channel) {
        this.mChannel = channel;
        this.responseHandler = ResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        responseHandler.setup(TAG, call.method, result);
        switch (call.method) {
            case "prepareModel":
                prepareModel(call);
                break;
            case "asyncTranslate":
                asyncTranslate(call);
                break;
            case "syncTranslate":
                syncTranslate(call);
                break;
            case "deleteModel":
                deleteModel(call);
                break;
            case "stop":
                stop();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private final MLModelDownloadListener downloadListener = (l, l1) -> {
        final Map<String, Object> downloadMap = new HashMap<>();
        downloadMap.put("downloaded", l);
        downloadMap.put("all", l1);
        handler.post(() -> mChannel.invokeMethod("langDownload", downloadMap));
    };

    private void prepareModel(@NonNull MethodCall call) {
        Map<String, Object> translateMap = FromMap.fromObject(call.argument("setting"));
        Map<String, Object> strategyMap = FromMap.fromObject(call.argument("strategy"));

        mlLocalTranslator = MLTranslatorFactory.getInstance().getLocalTranslator(RequestBuilder.createLocalTranslateSetting(translateMap));

        mlLocalTranslator.preparedModel(RequestBuilder.createModelDownloadStrategy(strategyMap), downloadListener
        ).addOnSuccessListener(aVoid -> responseHandler.success(true))
                .addOnFailureListener(responseHandler::exception);
    }

    private void asyncTranslate(@NonNull MethodCall call) {
        String text = FromMap.toString("sourceText", call.argument("sourceText"), false);

        mlLocalTranslator.asyncTranslate(text)
                .addOnSuccessListener(responseHandler::success)
                .addOnFailureListener(responseHandler::exception);
    }

    private void syncTranslate(@NonNull MethodCall call) {
        String text1 = FromMap.toString("sourceText", call.argument("sourceText"), false);

        try {
            responseHandler.success(mlLocalTranslator.syncTranslate(text1));
        } catch (MLException e) {
            responseHandler.exception(e);
        }
    }

    private void deleteModel(@NonNull MethodCall call) {
        String lang = FromMap.toString("langCode", call.argument("langCode"), false);

        MLLocalModelManager localModelManager = MLLocalModelManager.getInstance();
        MLLocalTranslatorModel model = new MLLocalTranslatorModel.Factory(lang).create();

        localModelManager.deleteModel(model)
                .addOnSuccessListener(aVoid -> responseHandler.success(true))
                .addOnFailureListener(responseHandler::exception);
    }

    private void stop() {
        if (mlLocalTranslator == null) {
            responseHandler.noService();
            return;
        }

        mlLocalTranslator.stop();
        responseHandler.success(true);
    }
}

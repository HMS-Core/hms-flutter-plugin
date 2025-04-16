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

import com.huawei.hmf.tasks.Tasks;
import com.huawei.hms.flutter.mllanguage.utils.FromMap;
import com.huawei.hms.flutter.mllanguage.utils.RequestBuilder;
import com.huawei.hms.mlsdk.translate.MLTranslatorFactory;
import com.huawei.hms.mlsdk.translate.cloud.MLRemoteTranslator;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class RemoteTranslateHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = "RemoteTranslator";

    private final ResponseHandler rsHandler;

    private MLRemoteTranslator mlRemoteTranslator;

    public RemoteTranslateHandler(Activity activity) {
        this.rsHandler = ResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        rsHandler.setup(TAG, call.method, result);
        switch (call.method) {
            case "asyncTranslate":
                asyncTranslate(call, result);
                break;
            case "syncTranslate":
                syncTranslate(call, result);
                break;
            case "stop":
                stop();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void asyncTranslate(@NonNull MethodCall call, MethodChannel.Result result) {
        String text2 = FromMap.toString("sourceText", call.argument("sourceText"), false);

        mlRemoteTranslator = MLTranslatorFactory.getInstance()
                .getRemoteTranslator(RequestBuilder.createRemoteTranslateSetting(call));

        mlRemoteTranslator.asyncTranslate(text2)
                .addOnSuccessListener(result::success)
                .addOnFailureListener(rsHandler::exception);
    }

    private void syncTranslate(@NonNull MethodCall call, MethodChannel.Result result) {
        String text3 = FromMap.toString("sourceText", call.argument("sourceText"), false);

        mlRemoteTranslator = MLTranslatorFactory.getInstance()
                .getRemoteTranslator(RequestBuilder.createRemoteTranslateSetting(call));

        Tasks.callInBackground(() -> mlRemoteTranslator.syncTranslate(text3))
                .addOnSuccessListener(result::success)
                .addOnFailureListener(rsHandler::exception);
    }

    private void stop() {
        if (mlRemoteTranslator == null) {
            rsHandler.noService();
            return;
        }
        mlRemoteTranslator.stop();
        rsHandler.success(true);
    }
}

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

import com.huawei.hms.flutter.mllanguage.listeners.RttListenerImpl;
import com.huawei.hms.flutter.mllanguage.utils.RequestBuilder;
import com.huawei.hms.mlsdk.speechrtt.MLSpeechRealTimeTranscription;

import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class RttHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = "RttHandler";

    private final Activity activity;
    private final MethodChannel mChannel;
    private final ResponseHandler rHandler;

    private MLSpeechRealTimeTranscription mSpeechRecognizer;

    public RttHandler(Activity activity, MethodChannel mChannel) {
        this.activity = activity;
        this.mChannel = mChannel;
        this.rHandler = ResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        rHandler.setup(TAG, call.method, result);
        switch (call.method) {
            case "startRecognizing":
                startRec(call);
                break;
            case "destroy":
                destroyRtt();
                break;
            case "getLanguages":
                getRttLanguages();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void getRttLanguages() {
        MLSpeechRealTimeTranscription.getInstance().getLanguages(new MLSpeechRealTimeTranscription.LanguageCallback() {
            @Override
            public void onResult(List<String> result) {
                rHandler.success(result);
            }

            @Override
            public void onError(int errorCode, String errorMsg) {
                rHandler.callbackError(String.valueOf(errorCode), errorMsg);
            }
        });
    }

    private void startRec(MethodCall call) {
        mSpeechRecognizer = MLSpeechRealTimeTranscription.getInstance();
        mSpeechRecognizer.setRealTimeTranscriptionListener(new RttListenerImpl(activity, mChannel));
        mSpeechRecognizer.startRecognizing(RequestBuilder.createRttConfig(call));
    }

    private void destroyRtt() {
        if (mSpeechRecognizer == null) {
            rHandler.noService();
            return;
        }
        mSpeechRecognizer.destroy();
        rHandler.success(true);
    }
}

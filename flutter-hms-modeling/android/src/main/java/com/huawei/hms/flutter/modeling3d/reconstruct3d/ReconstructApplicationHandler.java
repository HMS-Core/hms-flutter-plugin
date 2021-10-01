/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.modeling3d.reconstruct3d;

import android.content.Context;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.modeling3d.utils.Constants;
import com.huawei.hms.flutter.modeling3d.utils.Constants.ReconstructAppMethods;
import com.huawei.hms.flutter.modeling3d.utils.HMSLogger;
import com.huawei.hms.objreconstructsdk.ReconstructApplication;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public final class ReconstructApplicationHandler implements MethodChannel.MethodCallHandler {
    private static final String DOTTING_TAG = "ReconstructApplication.";

    private ReconstructApplication reconstructApplication;

    private final HMSLogger hmsLogger;

    public ReconstructApplicationHandler(Context context) {
        this.hmsLogger = HMSLogger.getInstance(context);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        hmsLogger.startMethodExecutionTimer(DOTTING_TAG + call.method);
        switch (Constants.ReconstructAppMethods.getEnum(call.method)) {
            case GET_INSTANCE:
                reconstructApplication = ReconstructApplication.getInstance();
                hmsLogger.sendSingleEvent(DOTTING_TAG + ReconstructAppMethods.GET_INSTANCE.getMethodName());
                result.success(true);
                break;
            case SET_ACCESS_TOKEN:
                if (reconstructApplication != null) {
                    reconstructApplication.setAccessToken((String) call.arguments);
                    hmsLogger.sendSingleEvent(DOTTING_TAG + ReconstructAppMethods.SET_ACCESS_TOKEN.getMethodName());
                    result.success(true);
                } else {
                    hmsLogger.sendSingleEvent(DOTTING_TAG + ReconstructAppMethods.SET_ACCESS_TOKEN.getMethodName(),
                        Constants.ERROR_CODE);
                    result.error(Constants.ERROR_CODE, "Can't find ReconstructApplication instance", null);
                }
                break;
            case SET_API_KEY:
                if (reconstructApplication != null) {
                    reconstructApplication.setApiKey((String) call.arguments);
                    hmsLogger.sendSingleEvent(DOTTING_TAG + ReconstructAppMethods.SET_API_KEY.getMethodName());
                    result.success(true);
                } else {
                    hmsLogger.sendSingleEvent(DOTTING_TAG + ReconstructAppMethods.SET_API_KEY.getMethodName(),
                        Constants.ERROR_CODE);
                    result.error(Constants.ERROR_CODE, "Can't find ReconstructApplication instance", null);
                }
                break;
            default:
                result.notImplemented();
                break;
        }
    }
}

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

package com.huawei.hms.flutter.safetydetect.util;

import com.huawei.hmf.tasks.OnFailureListener;
import com.huawei.hms.common.ApiException;
import com.huawei.hms.flutter.safetydetect.constants.Constants;
import com.huawei.hms.flutter.safetydetect.logger.HMSLogger;

import io.flutter.plugin.common.MethodChannel.Result;

public class CommonFailureListener implements OnFailureListener {
    private final Result result;
    private HMSLogger hmsLogger;
    private String methodName;

    public CommonFailureListener(final Result result, HMSLogger logger, String methodName) {
        this.result = result;
        this.hmsLogger = logger;
        this.methodName = methodName;
    }

    @Override
    public void onFailure(Exception e) {
        if (e instanceof ApiException) {
            ApiException apiException = ((ApiException) e);
            hmsLogger.sendSingleEvent(methodName, String.valueOf(apiException.getStatusCode()));
            result.error(String.valueOf(apiException.getStatusCode()), e.getMessage(), e.getCause());
        } else {
            hmsLogger.sendSingleEvent(methodName, Constants.ERROR);
            result.error(Constants.ERROR, e.getMessage(), e.getCause());
        }
    }
}

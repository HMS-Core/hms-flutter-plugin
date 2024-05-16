/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.iap.listeners;

import com.huawei.hmf.tasks.OnFailureListener;
import com.huawei.hms.flutter.iap.MethodCallHandlerImpl;
import com.huawei.hms.flutter.iap.logger.HMSLogger;
import com.huawei.hms.flutter.iap.utils.Errors;
import com.huawei.hms.iap.IapApiException;
import com.huawei.hms.iap.entity.OrderStatusCode;
import com.huawei.hms.support.api.client.Status;

import io.flutter.plugin.common.MethodChannel.Result;

public class IsEnvReadyFailureListener implements OnFailureListener {
    private final Result mResult;

    private final int mRequestCode;

    private final MethodCallHandlerImpl mMethodCallHandler;

    private final HMSLogger hmsLogger;

    public IsEnvReadyFailureListener(MethodCallHandlerImpl methodCallHandler, Result result, int requestCode,
        HMSLogger logger) {
        mResult = result;
        mRequestCode = requestCode;
        mMethodCallHandler = methodCallHandler;
        hmsLogger = logger;
    }

    @Override
    public void onFailure(Exception e) {
        if (e instanceof IapApiException) {
            final IapApiException apiException = (IapApiException) e;
            final Status status = apiException.getStatus();
            if (status.getStatusCode() == OrderStatusCode.ORDER_HWID_NOT_LOGIN) {
                if (status.hasResolution()) {
                    mMethodCallHandler.handleResolution(status, mResult, mRequestCode);
                } else {
                    hmsLogger.sendSingleEvent("isEnvReady", Errors.NO_RESOLUTION.getErrorCode());
                    mResult.error(Errors.NO_RESOLUTION.getErrorCode(), Errors.NO_RESOLUTION.getErrorMessage(), null);
                }
            } else {
                hmsLogger.sendSingleEvent("isEnvReady", Integer.toString(status.getStatusCode()));
                mResult.error(Integer.toString(status.getStatusCode()), status.getStatusMessage(), null);
            }
        } else {
            mResult.error(Errors.UNKNOWN_REQUEST_CODE.getErrorCode(), e.getMessage(), null);
        }

    }
}
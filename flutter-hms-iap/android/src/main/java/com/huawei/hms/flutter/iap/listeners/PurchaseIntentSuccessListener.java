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

import com.huawei.hmf.tasks.OnSuccessListener;
import com.huawei.hms.flutter.iap.MethodCallHandlerImpl;
import com.huawei.hms.flutter.iap.logger.HMSLogger;
import com.huawei.hms.iap.entity.PurchaseIntentResult;
import com.huawei.hms.support.api.client.Status;

import io.flutter.plugin.common.MethodChannel.Result;

public class PurchaseIntentSuccessListener implements OnSuccessListener<PurchaseIntentResult> {
    private final MethodCallHandlerImpl mMethodCallHandler;

    private final Result mResult;

    private final int mRequestCode;

    private final HMSLogger hmsLogger;

    public PurchaseIntentSuccessListener(MethodCallHandlerImpl methodCallHandler, Result result, int requestCode,
        HMSLogger logger) {
        mMethodCallHandler = methodCallHandler;
        mResult = result;
        mRequestCode = requestCode;
        hmsLogger = logger;
    }

    @Override
    public void onSuccess(PurchaseIntentResult purchaseIntentResult) {
        final Status status = purchaseIntentResult.getStatus();
        hmsLogger.sendSingleEvent("createPurchaseIntent");
        if (status.hasResolution()) {
            mMethodCallHandler.handleResolution(status, mResult, mRequestCode);
        }
    }
}

/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.iap.listeners;

import com.huawei.hmf.tasks.OnFailureListener;
import com.huawei.hms.iap.IapApiException;

import io.flutter.plugin.common.MethodChannel.Result;

public class DefaultFailureListener implements OnFailureListener {
    private final Result mResult;
    private final String mErrorCode;

    public DefaultFailureListener(Result result, String errorCode) {
        mResult = result;
        mErrorCode = errorCode;
    }

    @Override
    public void onFailure(Exception e) {
        if (e instanceof IapApiException) {
            final IapApiException iapException = (IapApiException) e;
            final int returnCode = iapException.getStatusCode();
            mResult.error(Integer.toString(returnCode), iapException.getMessage(), null);
        } else {
            mResult.error(mErrorCode, e.getMessage(), null);
        }
    }
}

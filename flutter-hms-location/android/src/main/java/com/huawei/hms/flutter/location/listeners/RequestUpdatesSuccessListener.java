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

package com.huawei.hms.flutter.location.listeners;

import com.huawei.hmf.tasks.OnSuccessListener;

import io.flutter.plugin.common.MethodChannel.Result;

public class RequestUpdatesSuccessListener implements OnSuccessListener<Void> {
    private final Result mResult;

    private final Integer mRequestCode;

    public RequestUpdatesSuccessListener(final Result result, final Integer requestCode) {
        mResult = result;
        mRequestCode = requestCode;
    }

    @Override
    public void onSuccess(final Void avoid) {
        mResult.success(mRequestCode);
    }
}

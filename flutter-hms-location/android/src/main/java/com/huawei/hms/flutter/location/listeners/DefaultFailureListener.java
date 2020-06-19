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

import com.huawei.hmf.tasks.OnFailureListener;
import com.huawei.hms.common.ApiException;
import com.huawei.hms.flutter.location.utils.ObjectUtils;

import io.flutter.plugin.common.MethodChannel.Result;

public class DefaultFailureListener implements OnFailureListener {
    private final Result mResult;

    public DefaultFailureListener(final Result result) {
        mResult = result;
    }

    @Override
    public void onFailure(final Exception e) {
        final ApiException ex = ObjectUtils.cast(e, ApiException.class);
        mResult.error(Integer.toString(ex.getStatusCode()), ex.getMessage(), null);
    }
}

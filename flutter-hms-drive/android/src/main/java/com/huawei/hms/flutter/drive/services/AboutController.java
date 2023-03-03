/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.drive.services;

import android.content.Context;
import android.content.Intent;

import androidx.annotation.NonNull;

import com.huawei.cloud.services.drive.Drive;
import com.huawei.cloud.services.drive.model.About;
import com.huawei.hms.flutter.drive.common.service.DriveRequestFactory;
import com.huawei.hms.flutter.drive.common.service.DriveRequestOptions;
import com.huawei.hms.flutter.drive.common.utils.DriveUtils;

import java.util.Map;
import java.util.Optional;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

public class AboutController extends DriveRequestFactory {

    public AboutController(Drive drive, Context context) {
        super(drive, context);
    }

    public void onMethodCall(final @NonNull MethodCall call, final @NonNull Result result) {
        String methodName = DriveUtils.methodNameExtractor(call).second;
        if (methodName.equals("Get")) {
            aboutGet(call, result);
        }
    }

    private void aboutGet(MethodCall call, Result result) {
        try {
            DriveRequestOptions requestOptions = getGson().fromJson((String) call.arguments, DriveRequestOptions.class);
            Drive.About.Get request = getDrive().about().get();
            setBasicRequestOptions(request, requestOptions);
            runTaskOnBackground(result, About.class, request, "About", "About.get");
        } catch (Exception e) {
            DriveUtils.defaultErrorHandler(result, "About.get failed, Error is: " + e.getMessage());
        }
    }

    public Optional<Drive.About.Get> aboutGet(Map<String, Object> args) {
        try {
            DriveRequestOptions requestOptions = getGson().fromJson(toJson(args), DriveRequestOptions.class);
            Drive.About.Get request = getDrive().about().get();
            setBasicRequestOptions(request, requestOptions);
            return Optional.of(request);
        } catch (Exception e) {
            DriveUtils.errorHandler(getContext(), new Intent(getContext().getPackageName() + ".BATCH_ACTION"),
                toJson(e));
        }
        return Optional.empty();
    }
}

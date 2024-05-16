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

package com.huawei.hms.flutter.location.listeners;

import static com.huawei.hms.location.LocationSettingsStatusCodes.RESOLUTION_REQUIRED;

import android.app.Activity;
import android.content.IntentSender.SendIntentException;

import com.huawei.hmf.tasks.OnFailureListener;
import com.huawei.hms.common.ApiException;
import com.huawei.hms.common.ResolvableApiException;
import com.huawei.hms.flutter.location.constants.Error;
import com.huawei.hms.flutter.location.logger.HMSLogger;
import com.huawei.hms.flutter.location.utils.ObjectUtils;

import io.flutter.plugin.common.MethodChannel.Result;

public class LocationSettingsFailureListener implements OnFailureListener {
    private final Result result;

    private final Activity activity;

    public LocationSettingsFailureListener(final Result result, final Activity activity) {
        this.result = result;
        this.activity = activity;
    }

    @Override
    public void onFailure(final Exception e) {
        final ApiException apiException = ObjectUtils.cast(e, ApiException.class);
        final int statusCode = apiException.getStatusCode();
        final String statusCodeString = Integer.toString(statusCode);

        if (statusCode == RESOLUTION_REQUIRED) {
            try {
                final ResolvableApiException resolvableApiException = ObjectUtils.cast(e, ResolvableApiException.class);
                resolvableApiException.startResolutionForResult(activity, 0);
            } catch (final SendIntentException ex) {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("checkLocationSettings", "-1");
                result.error(Error.SEND_INTENT_EXCEPTION.name(), ex.getMessage(), null);
            }
        } else {
            HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent("checkLocationSettings", statusCodeString);
            result.error(statusCodeString, apiException.getMessage(), null);
        }
    }
}

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

package com.huawei.hms.flutter.fido.bioauthnx;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.fido.logger.HMSLogger;
import com.huawei.hms.flutter.fido.utils.BioAuthBuilder;
import com.huawei.hms.flutter.fido.utils.EventHandler;
import com.huawei.hms.support.api.fido.bioauthn.BioAuthnCallback;
import com.huawei.hms.support.api.fido.bioauthn.BioAuthnResult;

import java.util.HashMap;
import java.util.Map;

public class BioAuthEvent extends BioAuthnCallback {
    private final Activity activity;

    public BioAuthEvent(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onAuthError(int i, @NonNull CharSequence charSequence) {
        Map<String, Object> map = new HashMap<>();
        map.put("event", "onAuthError");
        map.put("msgCode", i);
        map.put("msg", charSequence);
        HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent("onAuthError");
        EventHandler.getInstance().getSink().success(map);
    }

    @Override
    public void onAuthHelp(int i, @NonNull CharSequence charSequence) {
        Map<String, Object> map = new HashMap<>();
        map.put("event", "onAuthHelp");
        map.put("msgCode", i);
        map.put("msg", charSequence);
        HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent("onAuthHelp");
        EventHandler.getInstance().getSink().success(map);
    }

    @Override
    public void onAuthSucceeded(@NonNull BioAuthnResult bioAuthnResult) {
        Map<String, Object> map = new HashMap<>();
        map.put("event", "onAuthSucceeded");
        map.put("result", BioAuthBuilder.bioAuthnResultToMap(bioAuthnResult));
        HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent("onAuthSucceeded");
        EventHandler.getInstance().getSink().success(map);
    }

    @Override
    public void onAuthFailed() {
        Map<String, Object> map = new HashMap<>();
        map.put("event", "onAuthFailed");
        HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent("onAuthFailed");
        EventHandler.getInstance().getSink().success(map);
    }
}

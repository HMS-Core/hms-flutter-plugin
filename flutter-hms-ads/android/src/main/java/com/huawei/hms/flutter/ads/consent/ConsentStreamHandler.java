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

package com.huawei.hms.flutter.ads.consent;

import android.content.Context;
import android.util.Log;

import com.huawei.hms.ads.consent.bean.AdProvider;
import com.huawei.hms.ads.consent.constant.ConsentStatus;
import com.huawei.hms.ads.consent.inter.Consent;
import com.huawei.hms.ads.consent.inter.ConsentUpdateListener;
import com.huawei.hms.flutter.ads.logger.HMSLogger;
import com.huawei.hms.flutter.ads.utils.ToMap;

import java.util.List;

import io.flutter.plugin.common.EventChannel;

public class ConsentStreamHandler implements EventChannel.StreamHandler {
    private static final String TAG = "ConsentStreamHandler";
    private final Context context;

    public ConsentStreamHandler(Context context) {
        this.context = context;
    }

    @Override
    public void onListen(Object args, final EventChannel.EventSink event) {
        Consent.getInstance(context).requestConsentUpdate(new ConsentUpdateListenerImpl(context, event));
    }

    @Override
    public void onCancel(Object arguments) {

    }

    static class ConsentUpdateListenerImpl implements ConsentUpdateListener {
        private final Context context;
        private EventChannel.EventSink event;

        ConsentUpdateListenerImpl(Context context, EventChannel.EventSink event) {
            this.context = context;
            this.event = event;
        }

        @Override
        public void onSuccess(ConsentStatus consentStatus, boolean isNeedConsent, List<AdProvider> list) {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onConsentUpdateSuccess");
            Log.i(TAG, "onConsentUpdateSuccess");
            event.success(ToMap.fromArgs("event", "onConsentUpdateSuccess",
                "consentStatus", consentStatus.getValue(),
                "isNeedConsent", isNeedConsent,
                "adProviders", ToMap.createAdProviderMapList(list)));
            HMSLogger.getInstance(context).sendSingleEvent("onConsentUpdateSuccess");
        }

        @Override
        public void onFail(String description) {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onConsentUpdateFail");
            Log.w(TAG, "onConsentUpdateFail");
            event.success(ToMap.fromArgs("event", "onConsentUpdateFail", "description", description));
            HMSLogger.getInstance(context).sendSingleEvent("onConsentUpdateFail");
        }
    }
}

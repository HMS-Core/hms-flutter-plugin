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

package com.huawei.hms.flutter.analytics.viewmodel;

import android.content.Context;
import android.os.Bundle;

import com.huawei.agconnect.AGConnectInstance;
import com.huawei.hms.analytics.HiAnalyticsInstance;
import com.huawei.hms.analytics.HiAnalyticsTools;
import com.huawei.hms.analytics.type.ReportPolicy;
import com.huawei.hms.flutter.analytics.presenter.HMSAnalyticsContract;
import com.huawei.hms.flutter.analytics.presenter.HMSAnalyticsContract.ResultListener;

import java.util.Map;
import java.util.Set;

public class HMSAnalyticsViewModel implements HMSAnalyticsContract.Presenter {

    // HiAnalytics instance
    private final HiAnalyticsInstance analyticsInstance;

    public HMSAnalyticsViewModel(Context context, HiAnalyticsInstance hiAnalyticsInstance) {
        if (AGConnectInstance.getInstance() == null) {
            AGConnectInstance.initialize(context);
        }
        this.analyticsInstance = hiAnalyticsInstance;
    }

    @Override
    public void setAnalyticsEnabled(boolean enabled) {
        analyticsInstance.setAnalyticsEnabled(enabled);
    }

    @Override
    public void setUserId(String id) {
        analyticsInstance.setUserId(id);
    }

    @Override
    public void setUserProfile(String name, String value) {
        analyticsInstance.setUserProfile(name, value);
    }

    @Override
    public void setPushToken(String token) {
        analyticsInstance.setPushToken(token);
    }

    @Override
    public void setMinActivitySessions(long milliseconds) {
        analyticsInstance.setMinActivitySessions(milliseconds);
    }

    @Override
    public void setSessionDuration(long milliseconds) {
        analyticsInstance.setSessionDuration(milliseconds);
    }

    @Override
    public void onEvent(String eventId, Bundle params) {
        analyticsInstance.onEvent(eventId, params);
    }

    @Override
    public void clearCachedData() {
        analyticsInstance.clearCachedData();
    }

    @Override
    public void getAAID(ResultListener<String> resultListener) {
        analyticsInstance.getAAID().addOnCompleteListener(resultTask -> {
            if (resultTask.isSuccessful()) {
                String aaid = resultTask.getResult();
                resultListener.onSuccess(aaid);
            } else {
                resultListener.onFail(resultTask.getException());
            }
        });
    }

    @Override
    public void getUserProfiles(ResultListener<Map<String, String>> resultListener, boolean preDefined) {
        resultListener.onSuccess(analyticsInstance.getUserProfiles(preDefined));
    }

    @Override
    public void pageStart(String pageName, String pageClassOverride) {
        analyticsInstance.pageStart(pageName, pageClassOverride);
    }

    @Override
    public void pageEnd(String pageName) {
        analyticsInstance.pageEnd(pageName);
    }

    @Override
    public void setReportPolicies(Set<ReportPolicy> policies) {
        analyticsInstance.setReportPolicies(policies);
    }

    @Override
    public void getReportPolicyThreshold(ResultListener<Long> resultListener, ReportPolicy reportPolicyType) {
        resultListener.onSuccess(reportPolicyType.getThreshold());
    }

    @Override
    public void setRestrictionEnabled(boolean isEnabled) {
        analyticsInstance.setRestrictionEnabled(isEnabled);
    }

    @Override
    public void isRestrictionEnabled(ResultListener<Boolean> resultListener) {
        resultListener.onSuccess(analyticsInstance.isRestrictionEnabled());
    }

    @Override
    public void setCollectAdsIdEnabled(boolean value) {
        analyticsInstance.setAnalyticsEnabled(value);
    }

    @Override
    public void addDefaultEventParams(Bundle params) {
        analyticsInstance.addDefaultEventParams(params);
    }

    @Override
    public void setChannel(String channel) {
        analyticsInstance.setChannel(channel);
    }

    @Override
    public void setPropertyCollection(String property, boolean enabled) {
        analyticsInstance.setPropertyCollection(property, enabled);
    }

    @Override
    public void setCustomReferrer(String customReferrer) {
        analyticsInstance.setCustomReferrer(customReferrer);
    }

    /* HiAnalyticsTools */

    @Override
    public void enableLogWithLevel(int level) {
        HiAnalyticsTools.enableLog(level);
    }

    @Override
    public void enableLog() {
        HiAnalyticsTools.enableLog();
    }

    @Override
    public void getDataUploadSiteInfo(ResultListener<String> resultListener) {
        resultListener.onSuccess(analyticsInstance.getDataUploadSiteInfo());
    }

}


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

package com.huawei.hms.flutter.analytics;

import android.content.Context;
import android.os.Bundle;

import com.huawei.hms.analytics.HiAnalytics;
import com.huawei.hms.analytics.HiAnalyticsInstance;
import com.huawei.hms.analytics.type.ReportPolicy;
import com.huawei.hms.flutter.analytics.logger.HMSLogger;
import com.huawei.hms.flutter.analytics.presenter.HMSAnalyticsContract;
import com.huawei.hms.flutter.analytics.utils.MapUtils;
import com.huawei.hms.flutter.analytics.viewmodel.HMSAnalyticsViewModel;

import java.lang.ref.WeakReference;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

public class HMSAnalyticsModule {

    // Weak Context Instance
    private final WeakReference<Context> weakContext;

    // ViewModel instance
    private HMSAnalyticsContract.Presenter viewModel;

    public HMSAnalyticsModule(WeakReference<Context> context) {
        this.weakContext = context;
    }

    private Context getContext() {
        return weakContext.get();
    }

    public void setAnalyticsEnabled(MethodCall methodCall, Result result) {
        boolean enabled = MapUtils.toBoolean("enabled", methodCall.argument("enabled"));
        viewModel.setAnalyticsEnabled(enabled);
        result.success(null);
    }

    public void setUserId(MethodCall methodCall, Result result) {
        String userId = MapUtils.getString("userId", methodCall.argument("userId"));
        viewModel.setUserId(userId);
        result.success(null);
    }

    public void deleteUserId(Result result) {
        viewModel.setUserId(null);
        result.success(null);
    }

    public void setUserProfile(MethodCall methodCall, Result result) {
        String key = MapUtils.getString("key", methodCall.argument("key"));
        String value = MapUtils.getString("value", methodCall.argument("value"));
        viewModel.setUserProfile(key, value);
        result.success(null);
    }

    public void deleteUserProfile(MethodCall methodCall, Result result) {
        String key = MapUtils.getString("key", methodCall.argument("key"));
        viewModel.setUserProfile(key, null);
        result.success(null);
    }

    public void setPushToken(MethodCall methodCall, Result result) {
        String token = MapUtils.getString("token", methodCall.argument("token"));
        viewModel.setPushToken(token);
        result.success(null);
    }

    public void setMinActivitySessions(MethodCall methodCall, Result result) {
        Long milliseconds = MapUtils.toLong("interval", methodCall.argument("interval"));
        if (milliseconds != null) {
            viewModel.setMinActivitySessions(milliseconds);
            HMSLogger.getInstance(weakContext.get()).sendSingleEvent("setMinActivitySessions");
            result.success(null);
        } else {
            HMSLogger.getInstance(weakContext.get()).sendSingleEvent("setMinActivitySessions", "NULL_PARAM");
            result.error("NULL_PARAM", "interval was null.", null);
        }
    }

    public void setSessionDuration(MethodCall methodCall, Result result) {
        Long milliseconds = MapUtils.toLong("duration", methodCall.argument("duration"));
        if (milliseconds != null) {
            viewModel.setSessionDuration(milliseconds);
            HMSLogger.getInstance(weakContext.get()).sendSingleEvent("setSessionDuration");
            result.success(null);
        } else {
            HMSLogger.getInstance(weakContext.get()).sendSingleEvent("setSessionDuration", "NULL_PARAM");
            result.error("NULL_PARAM", "duration was null.", null);
        }
    }

    public void onEvent(MethodCall methodCall, Result result) {
        String key = MapUtils.getString("eventId", methodCall.argument("eventId"));
        Map<String, Object> val = MapUtils.objectToMap(methodCall.argument("params"));
        Bundle bundle = MapUtils.mapToBundle(val, false);
        viewModel.onEvent(key, bundle);
        result.success(null);
    }

    public void clearCachedData(Result result) {
        viewModel.clearCachedData();
        result.success(null);
    }

    public void getAAID(Result result) {
        viewModel.getAAID(new HMSAnalyticsModule.HMSAnalyticsResultHandler<>(result, "getAAID", weakContext));
    }

    public void getUserProfiles(MethodCall methodCall, Result result) {
        boolean predefined = MapUtils.toBoolean("predefined", methodCall.argument("predefined"));
        viewModel.getUserProfiles(new HMSAnalyticsModule.HMSAnalyticsResultHandler<>(result, "predefined", weakContext),
                predefined);
    }

    public void pageStart(MethodCall methodCall, Result result) {
        String pageName = MapUtils.getString("pageName", methodCall.argument("pageName"));
        String pageClassOverride = MapUtils.getString("pageClassOverride", methodCall.argument("pageClassOverride"));
        viewModel.pageStart(pageName, pageClassOverride);
        result.success(null);
    }

    public void pageEnd(MethodCall methodCall, Result result) {
        String pageName = MapUtils.getString("pageName", methodCall.argument("pageName"));
        viewModel.pageEnd(pageName);
        result.success(null);
    }

    public void setReportPolicies(MethodCall methodCall, Result result) {
        Map<String, Object> params = MapUtils.objectToMap(methodCall.argument("policyType"));
        viewModel.setReportPolicies(mapToSetReportPolicy(params));
        result.success(null);
    }

    public void getReportPolicyThreshold(MethodCall methodCall, Result result) {
        viewModel.getReportPolicyThreshold(
                new HMSAnalyticsModule.HMSAnalyticsResultHandler<>(result, "getReportPolicyThreshold", weakContext),
                getReportPolicyType(MapUtils.getString("reportPolicyType", methodCall.argument("reportPolicyType"))));
    }

    public void setRestrictionEnabled(MethodCall methodCall, Result result) {
        boolean value = MapUtils.toBoolean("enabled", methodCall.argument("enabled"));
        viewModel.setRestrictionEnabled(value);
        result.success(null);
    }

    public void isRestrictionEnabled(Result result) {
        viewModel.isRestrictionEnabled(
                new HMSAnalyticsModule.HMSAnalyticsResultHandler<>(result, "isRestrictionEnabled", weakContext));
    }

    public void setCollectAdsIdEnabled(MethodCall methodCall, Result result) {
        boolean value = MapUtils.toBoolean("enabled", methodCall.argument("enabled"));
        viewModel.setCollectAdsIdEnabled(value);
        result.success(null);
    }

    public void addDefaultEventParams(MethodCall methodCall, Result result) {
        Map<String, Object> val = MapUtils.objectToMap(methodCall.argument("params"));
        Bundle params = MapUtils.mapToBundle(val, false);
        if (params.isEmpty()) {
            params = null;
        }
        viewModel.addDefaultEventParams(params);
        result.success(null);
    }

    public void enableLog(Result result) {
        viewModel.enableLog();
        result.success(null);
    }

    public void enableLogWithLevel(MethodCall methodCall, Result result) {
        String level = MapUtils.getString("logLevel", methodCall.argument("logLevel"));
        Integer intValueOfLevel = null;

        try {
            intValueOfLevel = LogLevel.valueOf(level).intValue;
        } catch (IllegalArgumentException ex) {
            HMSLogger.getInstance(weakContext.get())
                    .sendSingleEvent("enableLogWithLevel", "Invalid log level. level = " + level);

            result.error("INVALID_PARAM", "Invalid log level. level = " + level, null);
            return;
        }

        viewModel.enableLogWithLevel(intValueOfLevel);
        result.success(null);
    }

    public void enableLogger(Result result) {
        HMSLogger.getInstance(weakContext.get()).enableLogger();
        result.success(null);
    }

    public void disableLogger(Result result) {
        HMSLogger.getInstance(weakContext.get()).disableLogger();
        result.success(null);
    }

    public void setChannel(MethodCall methodCall, Result result) {
        String channel = MapUtils.getString("channel", methodCall.argument("channel"));
        viewModel.setChannel(channel);
        result.success(null);
    }

    public void setPropertyCollection(MethodCall methodCall, Result result) {
        String property = MapUtils.getString("property", methodCall.argument("property"));
        boolean enabled = MapUtils.toBoolean("enabled", methodCall.argument("enabled"));
        viewModel.setPropertyCollection(property, enabled);
        result.success(null);
    }

    public void setCustomReferrer(MethodCall methodCall, Result result) {
        String customReferrer = MapUtils.getString("customReferrer", methodCall.argument("customReferrer"));
        viewModel.setCustomReferrer(customReferrer);
        result.success(null);
    }

    public void getInstance(MethodCall methodCall, Result result) {
        // HiAnalytics instance
        HiAnalyticsInstance analyticsInstance;

        String routePolicy = MapUtils.getString("routePolicy", methodCall.argument("routePolicy"));

        if (!routePolicy.equals("")) {
            analyticsInstance = HiAnalytics.getInstance((getContext()), routePolicy);
        } else {
            analyticsInstance = HiAnalytics.getInstance(getContext());
        }
        viewModel = new HMSAnalyticsViewModel(getContext(), analyticsInstance);
        result.success(null);
    }

    public void getDataUploadSiteInfo(Result result) {
        viewModel.getDataUploadSiteInfo(new HMSAnalyticsModule.HMSAnalyticsResultHandler<>(result, "getDataUploadSiteInfo", weakContext));
    }

    /* Private Inner Class */

    private Set<ReportPolicy> mapToSetReportPolicy(Map<String, Object> reportPolicies) {
        Set<ReportPolicy> policies = new HashSet<>();
        Set<String> allKeys = reportPolicies.keySet();
        for (String key : allKeys) {
            switch (key) {
                case "scheduledTime":
                    Long scheduledTime = MapUtils.toLong(key, reportPolicies.get("scheduledTime"));
                    ReportPolicy rp = ReportPolicy.ON_SCHEDULED_TIME_POLICY;
                    rp.setThreshold(scheduledTime);
                    policies.add(rp);
                    break;
                case "appLaunch":
                    policies.add(ReportPolicy.ON_APP_LAUNCH_POLICY);
                    break;
                case "moveBackground":
                    policies.add(ReportPolicy.ON_MOVE_BACKGROUND_POLICY);
                    break;
                case "cacheThreshold":
                    Long threshold = MapUtils.toLong(key, reportPolicies.get("cacheThreshold"));
                    ReportPolicy rpThreshold = ReportPolicy.ON_CACHE_THRESHOLD_POLICY;
                    rpThreshold.setThreshold(threshold);
                    policies.add(rpThreshold);
                    break;
                default:
            }
        }
        return policies;
    }

    private ReportPolicy getReportPolicyType(String reportPolicyType) {
        if ("ON_SCHEDULED_TIME_POLICY".equals(reportPolicyType)) {
            return ReportPolicy.ON_SCHEDULED_TIME_POLICY;
        } else if ("ON_APP_LAUNCH_POLICY".equals(reportPolicyType)) {
            return ReportPolicy.ON_APP_LAUNCH_POLICY;
        } else if ("ON_MOVE_BACKGROUND_POLICY".equals(reportPolicyType)) {
            return ReportPolicy.ON_MOVE_BACKGROUND_POLICY;
        } else if ("ON_CACHE_THRESHOLD_POLICY".equals(reportPolicyType)) {
            return ReportPolicy.ON_CACHE_THRESHOLD_POLICY;
        } else {
            return null;
        }
    }

    private enum LogLevel {
        DEBUG(3),
        INFO(4),
        WARN(5),
        ERROR(6);

        int intValue;

        LogLevel(int logLevel) {
            this.intValue = logLevel;
        }
    }

    /**
     * HMSAnalyticsResultHandler static nested class is a helper class for reaching {@link
     * HMSAnalyticsContract.ResultListener}.
     */
    private static final class HMSAnalyticsResultHandler<Object>
            implements HMSAnalyticsContract.ResultListener<Object> {
        private final Result mResult;
        private final String mMethodName;
        private final WeakReference<Context> mWeakContext;

        HMSAnalyticsResultHandler(final Result result, String methodName, WeakReference<Context> weakContext) {
            this.mResult = result;
            this.mMethodName = methodName;
            this.mWeakContext = weakContext;
        }

        @Override
        public void onSuccess(Object result) {
            HMSLogger.getInstance(mWeakContext.get()).sendSingleEvent(mMethodName);
            mResult.success(result);
        }

        @Override
        public void onFail(Exception exception) {
            HMSLogger.getInstance(mWeakContext.get()).sendSingleEvent(mMethodName, exception.getMessage());
            mResult.error("", exception.getMessage(), exception.getLocalizedMessage());
        }
    }
}


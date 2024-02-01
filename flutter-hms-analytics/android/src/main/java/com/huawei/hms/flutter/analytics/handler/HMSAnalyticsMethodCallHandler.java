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

package com.huawei.hms.flutter.analytics.handler;

import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.analytics.HMSAnalyticsModule;
import com.huawei.hms.flutter.analytics.logger.HMSLogger;

import java.lang.ref.WeakReference;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class HMSAnalyticsMethodCallHandler implements MethodCallHandler {
    private static final String TAG = HMSAnalyticsMethodCallHandler.class.getSimpleName();
    private HMSAnalyticsModule analyticsModule;

    // Weak Context Instance
    private final WeakReference<Context> weakContext;

    public HMSAnalyticsMethodCallHandler(HMSAnalyticsModule module, WeakReference<Context> weakContext) {
        this.analyticsModule = module;
        this.weakContext = weakContext;
    }

    public HMSAnalyticsMethodCallHandler(WeakReference<Context> weakContext) {
        this.weakContext = weakContext;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall methodCall, @NonNull Result result) {
        Log.i(TAG, " Running method : " + methodCall.method);
        HMSLogger.getInstance(weakContext.get()).startMethodExecutionTimer(methodCall.method);

        if (analyticsModule == null) {
            analyticsModule = new HMSAnalyticsModule(weakContext);
        }
        switch (Methods.valueOf(methodCall.method)) {
            case clearCachedData:
                analyticsModule.clearCachedData(result);
                HMSLogger.getInstance(weakContext.get()).sendSingleEvent(methodCall.method);
                break;
            case setAnalyticsEnabled:
                analyticsModule.setAnalyticsEnabled(methodCall, result);
                HMSLogger.getInstance(weakContext.get()).sendSingleEvent(methodCall.method);
                break;
            case getAAID:
                analyticsModule.getAAID(result);
                break;
            case getUserProfiles:
                analyticsModule.getUserProfiles(methodCall, result);
                break;
            case pageStart:
                analyticsModule.pageStart(methodCall, result);
                HMSLogger.getInstance(weakContext.get()).sendSingleEvent(methodCall.method);
                break;
            case pageEnd:
                analyticsModule.pageEnd(methodCall, result);
                HMSLogger.getInstance(weakContext.get()).sendSingleEvent(methodCall.method);
                break;
            case setMinActivitySessions:
                analyticsModule.setMinActivitySessions(methodCall, result);
                break;
            case setPushToken:
                analyticsModule.setPushToken(methodCall, result);
                HMSLogger.getInstance(weakContext.get()).sendSingleEvent(methodCall.method);
                break;
            case setSessionDuration:
                analyticsModule.setSessionDuration(methodCall, result);
                break;
            case setUserId:
                analyticsModule.setUserId(methodCall, result);
                HMSLogger.getInstance(weakContext.get()).sendSingleEvent(methodCall.method);
                break;
            case setUserProfile:
                analyticsModule.setUserProfile(methodCall, result);
                HMSLogger.getInstance(weakContext.get()).sendSingleEvent(methodCall.method);
                break;
            case onEvent:
                analyticsModule.onEvent(methodCall, result);
                HMSLogger.getInstance(weakContext.get()).sendSingleEvent(methodCall.method);
                break;
            case enableLog:
                analyticsModule.enableLog(result);
                HMSLogger.getInstance(weakContext.get()).sendSingleEvent(methodCall.method);
                break;
            case enableLogWithLevel:
                analyticsModule.enableLogWithLevel(methodCall, result);
                HMSLogger.getInstance(weakContext.get()).sendSingleEvent(methodCall.method);
                break;
            case enableLogger:
                analyticsModule.enableLogger(result);
                break;
            case disableLogger:
                analyticsModule.disableLogger(result);
                break;
            case getReportPolicyThreshold:
                analyticsModule.getReportPolicyThreshold(methodCall, result);
                break;
            case setReportPolicies:
                analyticsModule.setReportPolicies(methodCall, result);
                HMSLogger.getInstance(weakContext.get()).sendSingleEvent(methodCall.method);
                break;
            case setRestrictionEnabled:
                analyticsModule.setRestrictionEnabled(methodCall, result);
                HMSLogger.getInstance(weakContext.get()).sendSingleEvent(methodCall.method);
                break;
            case isRestrictionEnabled:
                analyticsModule.isRestrictionEnabled(result);
                break;
            case setCollectAdsIdEnabled:
                analyticsModule.setCollectAdsIdEnabled(methodCall, result);
                HMSLogger.getInstance(weakContext.get()).sendSingleEvent(methodCall.method);
                break;
            case addDefaultEventParams:
                analyticsModule.addDefaultEventParams(methodCall, result);
                HMSLogger.getInstance(weakContext.get()).sendSingleEvent(methodCall.method);
                break;
            case deleteUserProfile:
                analyticsModule.deleteUserProfile(methodCall, result);
                HMSLogger.getInstance(weakContext.get()).sendSingleEvent(methodCall.method);
                break;
            case deleteUserId:
                analyticsModule.deleteUserId(result);
                HMSLogger.getInstance(weakContext.get()).sendSingleEvent(methodCall.method);
                break;
            case setChannel:
                analyticsModule.setChannel(methodCall, result);
                HMSLogger.getInstance(weakContext.get()).sendSingleEvent(methodCall.method);
                break;
            case setPropertyCollection:
                analyticsModule.setPropertyCollection(methodCall, result);
                HMSLogger.getInstance(weakContext.get()).sendSingleEvent(methodCall.method);
                break;
            case setCustomReferrer:
                analyticsModule.setCustomReferrer(methodCall, result);
                HMSLogger.getInstance(weakContext.get()).sendSingleEvent(methodCall.method);
                break;
            case getInstance:
                analyticsModule.getInstance(methodCall, result);
                HMSLogger.getInstance(weakContext.get()).sendSingleEvent(methodCall.method);
                break;
            case getDataUploadSiteInfo:
                analyticsModule.getDataUploadSiteInfo(result);
                HMSLogger.getInstance(weakContext.get()).sendSingleEvent(methodCall.method);
                break;
            default:
                result.error("platformError", "Not supported on Android platform", "");
        }
    }

    private enum Methods {
        clearCachedData,
        setAnalyticsEnabled,
        getAAID,
        getUserProfiles,
        pageStart,
        pageEnd,
        setMinActivitySessions,
        setPushToken,
        setSessionDuration,
        setUserId,
        setUserProfile,
        onEvent,
        enableLog,
        enableLogWithLevel,
        enableLogger,
        disableLogger,
        getReportPolicyThreshold,
        setReportPolicies,
        setRestrictionEnabled,
        isRestrictionEnabled,
        setCollectAdsIdEnabled,
        addDefaultEventParams,
        deleteUserProfile,
        deleteUserId,
        setChannel,
        setPropertyCollection,
        setCustomReferrer,
        getInstance,
        getDataUploadSiteInfo
    }
}

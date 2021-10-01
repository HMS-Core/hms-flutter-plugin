/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.analytics.viewmodel;

import android.content.Context;
import android.os.Bundle;

import com.huawei.agconnect.AGConnectInstance;
import com.huawei.hms.analytics.HiAnalytics;
import com.huawei.hms.analytics.HiAnalyticsInstance;
import com.huawei.hms.analytics.HiAnalyticsTools;
import com.huawei.hms.analytics.type.ReportPolicy;
import com.huawei.hms.flutter.analytics.presenter.HMSAnalyticsContract;
import com.huawei.hms.flutter.analytics.presenter.HMSAnalyticsContract.ResultListener;

import java.util.Map;
import java.util.Set;

/**
 * HMSAnalyticsViewModel works as a mediator between {@link HMSAnalyticsContract.Presenter} .
 *
 * @since v.5.1.0
 */
public class HMSAnalyticsViewModel implements HMSAnalyticsContract.Presenter {

    // HiAnalytics instance
    private final HiAnalyticsInstance analyticsInstance;

    public HMSAnalyticsViewModel(Context context) {
        if (AGConnectInstance.getInstance() == null) {
            AGConnectInstance.initialize(context);
        }
        this.analyticsInstance = HiAnalytics.getInstance(context);
    }

    /**
     * Specifies whether to enable event logging. The default value is true.
     * <p>
     * If event logging is disabled, no data is recorded or analyzed.
     *
     * @param enabled : Indicates whether to enable event logging.
     */
    @Override
    public void setAnalyticsEnabled(boolean enabled) {
        analyticsInstance.setAnalyticsEnabled(enabled);
    }

    /**
     * When the method is called, a new session is generated if the old value of id is not empty and is different from
     * the new value. If you do not want to use id to identify a user (for example, when a user signs out), you must set
     * id to null.
     *
     * @param id : User ID, a string containing a maximum of 256 characters. The value cannot be empty. {@param id} is
     *           used by Analytics Kit to associate user data.
     */
    @Override
    public void setUserId(String id) {
        analyticsInstance.setUserId(id);
    }

    /**
     * Sets user attributes. The values of user attributes remain unchanged throughout the app lifecycle and during each
     * session.
     *
     * @param name  :  Name of a user attribute, a string containing a maximum of 256 characters. The value cannot be
     *              empty. It can consist of digits, letters, and underscores (_) and must start with a letter.
     * @param value : User attribute value, a string containing a maximum of 256 characters.
     */
    @Override
    public void setUserProfile(String name, String value) {
        analyticsInstance.setUserProfile(name, value);
    }

    /**
     * Sets the push token. After obtaining a push token through Push Kit, call this method to save the push token so
     * that you can use the audience defined by Analytics Kit to create HCM notification tasks.
     *
     * @param token : Push token, a string containing a maximum of 256 characters. The value cannot be empty.
     */
    @Override
    public void setPushToken(String token) {
        analyticsInstance.setPushToken(token);
    }

    /**
     * Sets the minimum interval for starting a new session. A new session is generated when an app is switched back to
     * the foreground after it runs in the background for the specified minimum interval.
     * <p>
     * By default, the minimum interval is 30,000 milliseconds (that is, 30 seconds).
     *
     * @param milliseconds : Minimum interval for starting a session, in milliseconds.
     */
    @Override
    public void setMinActivitySessions(long milliseconds) {
        analyticsInstance.setMinActivitySessions(milliseconds);
    }

    /**
     * Sets the session timeout interval. A new session is generated when an app is running in the foreground but the
     * interval between two adjacent events exceeds the specified timeout interval. By default, the timeout interval is
     * 1,800,000 milliseconds (that is, 30 minutes).
     *
     * @param milliseconds : Session timeout interval, in milliseconds.
     */
    @Override
    public void setSessionDuration(long milliseconds) {
        analyticsInstance.setSessionDuration(milliseconds);
    }

    /**
     * Records an event.
     *
     * @param eventId : Event ID, a string containing a maximum of 256 characters. The value cannot be empty or the ID
     *                of an automatically collected event. It can consist of digits, letters, and underscores (_) but
     *                cannot contain spaces or start with a digit.
     * @param params  :  Information carried in an event. The number of built-in key-value pairs
     */
    @Override
    public void onEvent(String eventId, Bundle params) {
        analyticsInstance.onEvent(eventId, params);
    }

    /**
     * Clears all collected data cached locally, including cached data that failed to be sent.
     */
    @Override
    public void clearCachedData() {
        analyticsInstance.clearCachedData();
    }

    /**
     * Obtains the app instance ID from AppGallery Connect.
     *
     * @param resultListener : In the success scenario,
     *                       <p>
     *                       {@link ResultListener<String>} instance is returned via listener. {@param resultListener}
     *                       that obtains the app instance ID.
     */
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

    /**
     * Obtains the automatically collected or custom user attributes.
     *
     * @param resultListener : In the success scenario, {@link ResultListener<Map>} instance is returned via listener.
     *                       {@param resultListener} that obtains automatically collected or custom user attributes.
     * @param preDefined     :     Indicates whether to obtain the automatically collected or custom user attributes.
     */
    @Override
    public void getUserProfiles(ResultListener<Map<String, String>> resultListener, boolean preDefined) {
        resultListener.onSuccess(analyticsInstance.getUserProfiles(preDefined));
    }

    /**
     * Customizes a page entry event. This method applies only to non-activity pages because automatic collection is
     * supported for activity pages. If it is called for an activity page, statistics on page entry and exit events will
     * be inaccurate.
     * <p>
     * After this method is called, the pageEnd() API must be called.
     *
     * @param pageName          :          Name of the current page, a string containing a maximum of 256 characters.
     * @param pageClassOverride : Class name of the current page, a string containing a maximum of 256 characters.
     */
    @Override
    public void pageStart(String pageName, String pageClassOverride) {
        analyticsInstance.pageStart(pageName, pageClassOverride);
    }

    /**
     * Customizes a page end event. This method applies only to non-activity pages because automatic collection is
     * supported for activity pages. If it is called for an activity page, statistics on page entry and exit events will
     * be inaccurate.
     * <p>
     * Before this method is called, the pageStart() API must be called.
     *
     * @param pageName : Name of the current page, a string containing a maximum of 256 characters. It must be the same
     *                 as the value of pageName passed in pageStart().
     */
    @Override
    public void pageEnd(String pageName) {
        analyticsInstance.pageEnd(pageName);
    }

    /**
     * Sets the automatic event reporting policy.
     *
     * @param policies : Policy for data reporting. Four policies are supported. One or more policies can be specified.
     */
    @Override
    public void setReportPolicies(Set<ReportPolicy> policies) {
        analyticsInstance.setReportPolicies(policies);
    }

    /**
     * Obtains the threshold for event reporting.
     *
     * @param resultListener:   In the success scenario, {@link HMSAnalyticsContract.ResultListener<>} instance is
     *                          returned via listener. {@param resultListener} that obtains the threshold for event
     *                          reporting.
     * @param reportPolicyType: Event reporting policy name.
     */
    @Override
    public void getReportPolicyThreshold(ResultListener<Long> resultListener, ReportPolicy reportPolicyType) {
        resultListener.onSuccess(reportPolicyType.getThreshold());
    }

    /**
     * Specifies whether to enable restriction of HUAWEI Analytics.
     * <p>
     * The default value is false, which indicates that HUAWEI Analytics is enabled by default.
     *
     * @param isEnabled : Indicates whether to enable restriction of HUAWEI Analytics.
     */
    @Override
    public void setRestrictionEnabled(boolean isEnabled) {
        analyticsInstance.setRestrictionEnabled(isEnabled);
    }

    /**
     * Obtains the restriction status of HUAWEI Analytics.
     *
     * @param resultListener : In the success scenario, {@link ResultListener<Boolean>} instance is returned via
     *                       listener. {@param resultListener} that obtains the restriction status of HUAWEI Analytics.
     */
    @Override
    public void isRestrictionEnabled(ResultListener<Boolean> resultListener) {
        resultListener.onSuccess(analyticsInstance.isRestrictionEnabled());
    }

    /**
     * Enables the debug log function and sets the minimum log level. Default log level DEBUG.
     *
     * @param level : Level of recorded debug logs.
     */
    @Override
    public void enableLogWithLevel(int level) {
        HiAnalyticsTools.enableLog(level);
    }

    /**
     * Enables the debug log function and sets the minimum log level. Default log level DEBUG.
     */
    @Override
    public void enableLog() {
        HiAnalyticsTools.enableLog();
    }
}


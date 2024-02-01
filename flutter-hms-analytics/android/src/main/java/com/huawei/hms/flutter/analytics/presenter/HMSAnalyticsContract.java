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

package com.huawei.hms.flutter.analytics.presenter;

import android.os.Bundle;

import com.huawei.hms.analytics.type.ReportPolicy;

import java.util.Map;
import java.util.Set;

public interface HMSAnalyticsContract {
    /**
     * Defines blueprints of {@link HMSAnalyticsViewModel} methods
     */
    interface Presenter {
        //------------------------------------------------------------------------------------------
        // HiAnalyticsInstance
        //------------------------------------------------------------------------------------------

        /**
         * Specifies whether to enable event logging.
         * <p>
         * If event logging is disabled, no data is recorded or analyzed.
         *
         * @param enabled: Indicates whether to enable event logging. The default value is true.
         */
        void setAnalyticsEnabled(final boolean enabled);

        /**
         * When the method is called, a new session is generated if the old value of id is not empty and is different
         * from the new value. If you do not want to use id to identify a user (for example, when a user signs out), you
         * must set id to null.
         *
         * @param id: User ID, a string containing a maximum of 256 characters. The value cannot be empty. {@param id}
         *            is used by Analytics Kit to associate user data.
         */
        void setUserId(final String id);

        /**
         * Sets user attributes. The values of user attributes remain unchanged throughout the app lifecycle and during
         * each session.
         *
         * @param name:  Name of a user attribute, a string containing a maximum of 256 characters. The value cannot be
         *               empty. It can consist of digits, letters, and underscores (_) and must start with a letter.
         * @param value: User attribute value, a string containing a maximum of 256 characters. The value cannot be
         *               empty.
         */
        void setUserProfile(final String name, final String value);

        /**
         * Sets the push token. After obtaining a push token through Push Kit, call this method to save the push token
         * so that you can use the audience defined by Analytics Kit to create HCM notification tasks.
         *
         * @param token: Push token, a string containing a maximum of 256 characters. The value cannot be empty.
         */
        void setPushToken(final String token);

        /**
         * Sets the minimum interval for starting a new session. A new session is generated when an app is switched back
         * to the foreground after it runs in the background for the specified minimum interval.
         * <p>
         * By default, the minimum interval is 30,000 milliseconds (that is, 30 seconds).
         *
         * @param milliseconds: Minimum interval for starting a session, in milliseconds.
         */
        void setMinActivitySessions(final long milliseconds);

        /**
         * Sets the session timeout interval. A new session is generated when an app is running in the foreground but
         * the interval between two adjacent events exceeds the specified timeout interval. By default, the timeout
         * interval is 1,800,000 milliseconds (that is, 30 minutes).
         *
         * @param milliseconds: Session timeout interval, in milliseconds.
         */
        void setSessionDuration(final long milliseconds);

        /**
         * Records an event.
         *
         * @param eventId: Event ID, a string containing a maximum of 256 characters. The value cannot be empty or the
         *                 ID of an automatically collected event. It can consist of digits, letters, and underscores
         *                 (_) but cannot contain spaces or start with a digit.
         * @param params:  Information carried in an event. The number of built-in key-value pairs in the Bundle cannot
         *                 exceed 2048 and the size cannot exceed 200 KB.
         */
        void onEvent(final String eventId, final Bundle params);

        /**
         * Clears all collected data cached locally, including cached data that failed to be sent.
         */
        void clearCachedData();

        /**
         * Obtains the app instance ID from AppGallery Connect.
         *
         * @param resultListener: In the success scenario, {@link HMSAnalyticsContract.ResultListener<String>} instance
         *                        is returned via listener. {@param resultListener} that obtains the app instance ID.
         */
        void getAAID(final HMSAnalyticsContract.ResultListener<String> resultListener);

        /**
         * Obtains the automatically collected or custom user attributes.
         *
         * @param resultListener: In the success scenario, {@link HMSAnalyticsContract.ResultListener<>} instance is
         *                        returned via listener. {@param resultListener} that obtains automatically collected or
         *                        custom user attributes.
         * @param preDefined:     Indicates whether to obtain the automatically collected or custom user attributes.
         */
        void getUserProfiles(final HMSAnalyticsContract.ResultListener<Map<String, String>> resultListener, final boolean preDefined);

        /**
         * Customizes a page entry event. This method applies only to non-activity pages because automatic collection is
         * supported for activity pages. If it is called for an activity page, statistics on page entry and exit events
         * will be inaccurate.
         * <p>
         * After this method is called, the pageEnd() API must be called.
         *
         * @param pageName:          Name of the current page, a string containing a maximum of 256 characters.
         * @param pageClassOverride: Class name of the current page, a string containing a maximum of 256 characters.
         */
        void pageStart(final String pageName, final String pageClassOverride);

        /**
         * Customizes a page end event. This method applies only to non-activity pages because automatic collection is
         * supported for activity pages. If it is called for an activity page, statistics on page entry and exit events
         * will be inaccurate.
         * <p>
         * Before this method is called, the pageStart() API must be called.
         *
         * @param pageName: Name of the current page, a string containing a maximum of 256 characters. It must be the
         *                  same as the value of pageName passed in pageStart().
         */
        void pageEnd(final String pageName);

        /**
         * Sets the automatic event reporting policy.
         *
         * @param policies: Policy for data reporting. Four policies are supported. One or more policies can be
         *                  specified.
         */
        void setReportPolicies(final Set<ReportPolicy> policies);

        /**
         * Obtains the threshold for event reporting.
         *
         * @param resultListener:   In the success scenario, {@link HMSAnalyticsContract.ResultListener<>} instance is
         *                          returned via listener. {@param resultListener} that obtains the threshold for event
         *                          reporting.
         * @param reportPolicyType: Event reporting policy name.
         */
        void getReportPolicyThreshold(final HMSAnalyticsContract.ResultListener<Long> resultListener, ReportPolicy reportPolicyType);

        /**
         * Specifies whether to enable restriction of Huawei Analytics.
         * <p>
         * The default value is false, which indicates that Huawei Analytics is enabled by default.
         *
         * @param isEnabled: Indicates whether to enable restriction of Huawei Analytics.
         */
        void setRestrictionEnabled(final boolean isEnabled);

        /**
         * Obtains the restriction status of Huawei Analytics.
         *
         * @param resultListener: In the success scenario, {@link HMSAnalyticsContract.ResultListener<Boolean>} instance
         *                        is returned via listener. {@param resultListener} that obtains the restriction status
         *                        of Huawei Analytics.
         */
        void isRestrictionEnabled(final HMSAnalyticsContract.ResultListener<Boolean> resultListener);


        /**
         * Sets whether to collect advertising IDs.
         *
         * @param value : Indicates whether to collect advertising IDs. The default value is true.
         */
        void setCollectAdsIdEnabled(boolean value);


        /**
         * Adds default event parameters.
         * These parameters will be added to all events except the automatically collected events.
         * If the name of a default event parameter is the same as that of an event parameter,
         * the event parameter will be used.
         *
         * @param params : Default event parameters.
         *               A maximum of 100 key-value pairs are supported.
         *               The key in each key-value pair can contain a maximum of 256 characters and
         *               can consist of only digits, letters, and underscores (_),
         *               but cannot start with a digit. The value in each key-value pair can contain
         *               a maximum of 256 characters, and can only be of the string, int, long,
         *               double, boolean, float, char, byte, or short type.
         */
        void addDefaultEventParams(Bundle params);

        /**
         * Sets the app installation source.
         * <p>
         * The setting takes effect only when the method is called for the first time.
         *
         * @param channel : App installation source, a string containing a maximum of 128 characters.
         *                The value cannot be empty. The value can consist of only letters, digits,
         *                underscores (_), hyphens (-), and spaces. It cannot start or end with a space.
         */
        void setChannel(String channel);

        /**
         * Sets whether to collect system attributes.
         * <p>
         * Currently, this method applies only to the userAgent attribute.
         *
         * @param property : System attribute. Only userAgent is supported now.
         * @param enabled  : Indicates whether to collect system attributes. The default value is true.
         */
        void setPropertyCollection(final String property, final boolean enabled);

        /**
         * Sets a custom referrer.
         * <p>
         * This method takes effect only when it is called for the first time.
         *
         * @param customReferrer : A string containing a maximum of 256 characters. The value cannot be empty.
         */
        void setCustomReferrer(final String customReferrer);

        //------------------------------------------------------------------------------------------
        // HiAnalyticsTools
        //------------------------------------------------------------------------------------------

        /**
         * Enables the debug log function and sets the minimum log level. Default log level DEBUG.
         *
         * @param level: Level of recorded debug logs.
         */
        void enableLogWithLevel(final int level);

        /**
         * Enables the debug log function and sets the minimum log level. Default log level DEBUG.
         */
        void enableLog();

        /**
         * Obtains the app instance ID from AppGallery Connect.
         *
         * @param resultListener: In the success scenario, {@link HMSAnalyticsContract.ResultListener<String>} instance
         *                        is returned via listener. {@param resultListener} that obtains the processing location
         *                        of the uploaded data.
         */
        void getDataUploadSiteInfo(final HMSAnalyticsContract.ResultListener<String> resultListener);

    }

    /**
     * ResultListener
     *
     * @param <T>>: Generic Instance.
     */
    interface ResultListener<T> {
        /**
         * Presents the success scenario, Generic result instance is returned.
         *
         * @param result: Result instance.
         */
        void onSuccess(T result);

        /**
         * Presents the failure scenario, Exception instance is returned.
         *
         * @param exception: Exception instance.
         */
        void onFail(Exception exception);
    }
}


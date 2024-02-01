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

import android.content.ContentProvider;
import android.content.ContentValues;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.net.Uri;
import android.util.Log;

import com.huawei.hms.analytics.HiAnalytics;
import com.huawei.hms.analytics.HiAnalyticsInstance;

import java.util.Arrays;

public class AnalyticsContentProvider extends ContentProvider {
    private static final String TAG = AnalyticsContentProvider.class.getSimpleName();
    private final String[] routePolicyList = new String[]{"CN", "DE", "SG", "RU"};

    @Override
    public boolean onCreate() {
        Log.i(TAG, "AnalyticsContentProvider -> onCreate");
        try {
            ApplicationInfo appInfo = this.getContext().getApplicationContext().getPackageManager().getApplicationInfo(this.getContext().getApplicationContext().getPackageName(), PackageManager.GET_META_DATA);
            boolean isEnabled = appInfo.metaData.getBoolean("hms_is_analytics_enabled", true);

            if (!isEnabled) {
                return true;
            }

            String routePolicy = appInfo.metaData.getString("route_policy");

            if (Arrays.asList(routePolicyList).contains(routePolicy)) {
                HiAnalytics.getInstance(this.getContext(), routePolicy);
                return true;
            }
        } catch (Exception e) {
            Log.e(TAG, "HiAnalytics -> Invalid routePolicy! Initialization failed. Message: " + e.getMessage());
        }

        HiAnalyticsInstance instance = HiAnalytics.getInstance(this.getContext().getApplicationContext());
        instance.setAnalyticsEnabled(true);
        return true;
    }

    @Override
    public Cursor query(Uri uri, String[] projection, String selection, String[] selectionArgs, String sortOrder) {
        return null;
    }

    @Override
    public String getType(Uri uri) {
        return null;
    }

    @Override
    public Uri insert(Uri uri, ContentValues values) {
        return null;
    }

    @Override
    public int delete(Uri uri, String selection, String[] selectionArgs) {
        return 0;
    }

    @Override
    public int update(Uri uri, ContentValues values, String selection, String[] selectionArgs) {
        return 0;
    }

    @Override
    public void shutdown() {
        Log.i(TAG, "HMSContentProvider -> shutdown");
    }
}

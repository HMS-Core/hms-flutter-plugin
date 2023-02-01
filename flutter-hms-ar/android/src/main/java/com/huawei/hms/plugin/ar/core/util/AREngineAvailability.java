/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.plugin.ar.core.util;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;

import com.huawei.hiar.AREnginesApk;

public final class AREngineAvailability {
    private static final String DOWNLOAD_APP_ACTION = "com.huawei.appmarket.intent.action.AppDetail";

    private static final String HUAWEI_MARKET_NAME = "com.huawei.appmarket";

    private static final String PACKAGE_NAME_KEY = "APP_PACKAGENAME";

    private static final String PACKAGENAME_ARSERVICE = "com.huawei.arengine.service";

    private AREngineAvailability() {
    }

    public static boolean isArEngineServiceApkReady(Context context) {
        return AREnginesApk.isAREngineApkReady(context);
    }

    public static void navigateToAppMarketPage(Activity activity) {
        Intent intent = new Intent(DOWNLOAD_APP_ACTION);
        intent.putExtra(PACKAGE_NAME_KEY, PACKAGENAME_ARSERVICE);
        intent.setPackage(HUAWEI_MARKET_NAME);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        activity.startActivity(intent);
    }
}

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

package com.huawei.hms.flutter.ads.installreferrer;

import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.os.Binder;
import android.os.IBinder;
import android.util.Log;

import com.huawei.android.hms.ppskit.IPPSChannelInfoService;

import static com.huawei.hms.flutter.ads.utils.constants.InstallReferrer.INSTALL_REFERRER_FILE;

public class PpsChannelInfoService extends Service {
    private static final String TAG = "PpsChannelInfoService";
    private final IPPSChannelInfoService.Stub mBinder = new IPPSChannelInfoService.Stub() {
        @Override
        public String getChannelInfo() {
            PackageManager packageManager = getPackageManager();
            final String callerPkg = getCallerPkgSafe(packageManager, Binder.getCallingUid());
            SharedPreferences sp = getSharedPreferences(INSTALL_REFERRER_FILE, Context.MODE_PRIVATE);
            return sp.getString(callerPkg, "");
        }
    };

    @Override
    public void onCreate() {
        super.onCreate();
        Log.i(TAG, "onCreate");
    }

    @Override
    public IBinder onBind(Intent intent) {
        Log.i(TAG, "onBind");
        return mBinder;
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Log.i(TAG, "onStartCommand");
        return super.onStartCommand(intent, flags, startId);
    }

    @Override
    public boolean onUnbind(Intent intent) {
        Log.i(TAG, "onUnbind");
        return super.onUnbind(intent);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        Log.i(TAG, "onDestroy");
    }

    public static String getCallerPkgSafe(PackageManager packageManager, int uid) {
        if (null == packageManager) {
            return "";
        }
        String pkg = "";
        try {
            pkg = packageManager.getNameForUid(uid);
        } catch (Exception e) {
            Log.w(TAG, "get name for uid error");
        }
        return pkg;
    }
}


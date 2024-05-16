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

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.util.SparseArray;

import com.huawei.hms.flutter.ads.utils.constants.ReferrerStatus;

import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public abstract class HmsInstallReferrer {
    private static final String TAG = "HmsInstallReferrer";
    private static SparseArray<HmsInstallReferrer> allReferrers = new SparseArray<>();

    final int id;
    private String status;

    HmsInstallReferrer(int id) {
        this.id = id;
        setStatus(ReferrerStatus.CREATED);
        allReferrers.put(id, this);
    }

    public static HmsInstallReferrer get(Integer id) {
        if (id == null) {
            Log.e(TAG, "Ad id is null.");
            return null;
        }
        return allReferrers.get(id);
    }

    static InstallReferrerSdkUtil createSdkReferrer(Integer id, Context context, MethodChannel channel) {
        HmsInstallReferrer referrer = get(id);
        return (referrer != null) ? (InstallReferrerSdkUtil) referrer : new InstallReferrerSdkUtil(id, context, channel);
    }

    void setStatus(String status) {
        this.status = status;
    }

    public boolean isCreated() {
        return this.status.equals(ReferrerStatus.CREATED);
    }

    boolean isConnected() {
        return this.status.equals(ReferrerStatus.CONNECTED);
    }

    boolean isDisconnected() {
        return this.status.equals(ReferrerStatus.DISCONNECTED);
    }

    /**
     * Starts the connection of an Install Referrer object
     *
     * @param isTest : Whether the connection should be started in test mode.
     */
    public abstract void startConnection(boolean isTest);

    /**
     * End the connection of an Install Referrer object
     */
    public abstract void endConnection();

    /**
     * Retrieve the referrer details from an Install Referrer connection
     *
     * @param result : Flutter method channel result
     */
    public abstract void getReferrerDetails(MethodChannel.Result result);

    /**
     * Indicates whether the connection is ready
     *
     * @return : boolean value that indicates connection status
     */
    public abstract boolean isReady();

    void destroy() {
        allReferrers.remove(id);
    }

    public static void disposeAll() {
        for (int i = 0; i < allReferrers.size(); i++) {
            allReferrers.valueAt(i).destroy();
        }
        allReferrers.clear();
    }

    static class ReferrerDetailsHandler extends Handler {
        final Map<String, Object> response;
        private final MethodChannel.Result result;

        ReferrerDetailsHandler(Looper looper, Map<String, Object> response, MethodChannel.Result result) {
            super(looper);
            this.response = response;
            this.result = result;
        }

        void backToMain() {
            super.post(new Runnable() {
                @Override
                public void run() {
                    result.success(response);
                }
            });
        }
    }
}

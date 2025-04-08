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

package com.huawei.hms.flutter.push.backgroundmessaging;

import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.core.app.JobIntentService;

import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.CountDownLatch;

public class BackgroundMessagingService extends JobIntentService {
    private static final String TAG = BackgroundMessagingService.class.getSimpleName();

    private static final int JOB_ID = 1001;

    private static final List<Intent> QUEUE = Collections.synchronizedList(new LinkedList<>());

    private static FlutterBackgroundRunner backgroundRunner;

    private synchronized void setBackgroundRunner(FlutterBackgroundRunner bgRunner) {
        BackgroundMessagingService.backgroundRunner = bgRunner;
    }

    public static void setUserCallback(final Context context, final long userCallback) {
        FlutterBackgroundRunner.setUserCallback(context, userCallback);
    }

    public static void setCallbackDispatcher(final Context context, final long callbackHandle) {
        FlutterBackgroundRunner.setCallBackDispatcher(context, callbackHandle);
    }

    public static void enqueueWork(final Context context, final Intent intent) {
        JobIntentService.enqueueWork(context, BackgroundMessagingService.class, JOB_ID, intent);
    }

    public static synchronized void startBgIsolate(final Context context, final long callbackHandle) {
        if (backgroundRunner != null) {
            Log.i(TAG, "Background messaging runner is already initialized...Returning");
            return;
        }
        backgroundRunner = new FlutterBackgroundRunner();
        backgroundRunner.startBgIsolate(context, callbackHandle);
    }

    static void onInitialized() {
        if (!QUEUE.isEmpty()) {
            synchronized (QUEUE) {
                for (final Intent intent : QUEUE) {
                    backgroundRunner.executeDartCallbackInBgIsolate(intent, null);
                }
                QUEUE.clear();
            }
        }
    }

    @Override
    public void onCreate() {
        super.onCreate();
        if (backgroundRunner == null) {
            setBackgroundRunner(new FlutterBackgroundRunner());
        }
        backgroundRunner.startBgIsolate(getApplicationContext());
    }

    @Override
    protected void onHandleWork(@NonNull final Intent intent) {
        synchronized (QUEUE) {
            if (backgroundRunner.isNotReady()) {
                Log.i(TAG, "Background Service has not started yet, datas will be queued.");
                QUEUE.add(intent);
                return;
            }
            final CountDownLatch latch = new CountDownLatch(1);
            new Handler(getMainLooper()).post(() -> backgroundRunner.executeDartCallbackInBgIsolate(intent, latch));
            try {
                latch.await();
            } catch (final InterruptedException ex) {
                Log.i(TAG, "Exception waiting to execute Dart callback", ex);
                Thread.currentThread().interrupt();
            }
        }
    }
}

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

package com.huawei.hms.flutter.ads.adslite.nativead;

import android.content.Context;
import android.util.Log;
import android.util.SparseArray;

import com.huawei.hms.ads.nativead.NativeAd;
import com.huawei.hms.flutter.ads.utils.constants.Channels;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class NativeAdControllerFactory {
    private static final String TAG = "NativeControllerFactory";
    private static SparseArray<NativeAdController> allControllers = new SparseArray<>();

    private NativeAdControllerFactory() {
    }

    public static void createController(int id, BinaryMessenger messenger, Context context) {
        if (allControllers.get(id) == null) {
            MethodChannel channel = new MethodChannel(messenger, Channels.NATIVE_METHOD_CHANNEL + '/' + id);
            NativeAdController controller = new NativeAdController(Integer.toString(id), channel, context);
            allControllers.put(id, controller);
        }
    }

    public static NativeAdController get(Integer id) {
        if (id == null) {
            Log.e(TAG, "Controller id is null.");
            return null;
        }
        return allControllers.get(id);
    }

    public static boolean dispose(int id) {
        final NativeAdController controller = allControllers.get(id);
        if (controller != null) {
            final NativeAd nativeAd = controller.getNativeAd();
            if (nativeAd != null) {
                nativeAd.destroy();
            }
            allControllers.remove(id);
            return true;
        }
        return false;
    }
}
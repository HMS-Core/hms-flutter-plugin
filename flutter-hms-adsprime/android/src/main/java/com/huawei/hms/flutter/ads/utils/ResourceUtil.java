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

package com.huawei.hms.flutter.ads.utils;

import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;

public class ResourceUtil {
    private static final String TAG = "ResourceUtil";

    public static int getStringResourceIdFromContext(@NonNull Context context, String resName) {
        final int stringRes = context.getResources().getIdentifier(resName, "string", context.getPackageName());
        if (stringRes == 0) {
            Log.e(TAG, "getStringResourceIdFromContext | " + resName + " value is not defined in your project's resources file.");
        }

        return stringRes;
    }

    public static int getLogoResourceIdFromContext(@NonNull Context context, String resName) {
        final int mipmapResId = context.getResources().getIdentifier(resName, "mipmap", context.getPackageName());
        final int drawableResId = context.getResources().getIdentifier(resName, "drawable", context.getPackageName());
        if (mipmapResId == 0 && drawableResId == 0) {
            Log.e(TAG, "getLogoResourceIdFromContext | " + resName + " value is not defined in your project's resources file.");
        }

        return mipmapResId != 0 ? mipmapResId : drawableResId;
    }
}

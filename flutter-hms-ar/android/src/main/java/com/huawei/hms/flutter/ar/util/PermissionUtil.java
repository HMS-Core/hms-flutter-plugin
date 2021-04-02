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

package com.huawei.hms.flutter.ar.util;

import android.Manifest;
import android.app.Activity;

import androidx.annotation.NonNull;
import androidx.core.content.PermissionChecker;

public final class PermissionUtil {
    private static final int REQUEST_CODE_ASK_PERMISSIONS = 1;
    private static final String[] PERMISSIONS_ARRAYS = new String[]{Manifest.permission.CAMERA};

    private PermissionUtil() {
    }

    public static boolean hasPermission(@NonNull final Activity activity) {
        for (String permission : PERMISSIONS_ARRAYS)
            if (PermissionChecker.checkSelfPermission(activity, permission) != PermissionChecker.PERMISSION_GRANTED)
                return false;
        return true;
    }

    public static void requestCameraPermission(Activity activity) {
        activity.requestPermissions(PERMISSIONS_ARRAYS, REQUEST_CODE_ASK_PERMISSIONS);
    }
}

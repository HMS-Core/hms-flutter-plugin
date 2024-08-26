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

package com.huawei.hms.flutter.push.utils;

import android.app.NotificationManager;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Build;
import android.os.Bundle;

import androidx.core.app.NotificationCompat;

import com.huawei.hms.flutter.push.constants.Core;
import com.huawei.hms.flutter.push.constants.LocalNotification;
import com.huawei.hms.flutter.push.constants.NotificationConstants;

import java.security.SecureRandom;
import java.util.Date;
import java.util.Locale;

public class NotificationConfigUtils {
    private NotificationConfigUtils() {
        throw new IllegalStateException("Utility class");
    }

    public static String configTitle(Bundle bundle, Context context) {
        String title = BundleUtils.get(bundle, NotificationConstants.TITLE);
        if (title != null) {
            return title;
        }

        ApplicationInfo applicationInfo = context.getApplicationInfo();
        return context.getPackageManager().getApplicationLabel(applicationInfo).toString();
    }

    public static String configMessage(Bundle bundle, Context context) {
        String message = BundleUtils.get(bundle, NotificationConstants.MESSAGE);
        if (message != null) {
            return message;
        }

        ApplicationInfo applicationInfo = context.getApplicationInfo();
        message = context.getPackageManager().getApplicationLabel(applicationInfo).toString();
        bundle.putString(NotificationConstants.MESSAGE, message);
        return message;
    }

    public static int configSmallIcon(Bundle bundle, Context context) {
        Resources res = context.getResources();
        String packageName = context.getPackageName();

        int resourceId;
        String value = BundleUtils.get(bundle, NotificationConstants.SMALL_ICON);

        resourceId = value != null
            ? res.getIdentifier(value, Core.Resource.MIPMAP, packageName)
            : res.getIdentifier(Core.Resource.NOTIFICATION, Core.Resource.MIPMAP, packageName);

        if (resourceId == 0) {
            resourceId = res.getIdentifier(Core.Resource.LAUNCHER, Core.Resource.MIPMAP, packageName);
            if (resourceId == 0) {
                resourceId = android.R.drawable.ic_dialog_info;
            }
        }
        return resourceId;
    }

    public static Bitmap configLargeIcon(Bundle bundle, Context context, Bitmap bitmap) {
        Resources res = context.getResources();
        String packageName = context.getPackageName();

        if (bitmap == null) {
            int resourceId = 0;
            String value = BundleUtils.get(bundle, NotificationConstants.LARGE_ICON);

            if (value != null) {
                resourceId = res.getIdentifier(value, Core.Resource.MIPMAP, packageName);
            }

            if (resourceId != 0 && Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                bitmap = BitmapFactory.decodeResource(res, resourceId);
            }
        }
        return bitmap;
    }

    public static long configNextFireDate(Bundle bundle) {
        String repeatType = BundleUtils.get(bundle, NotificationConstants.REPEAT_TYPE);
        long repeatTime = BundleUtils.getL(bundle, NotificationConstants.REPEAT_TIME);

        if (repeatType == null) {
            return 0;
        }

        long fireDate = BundleUtils.getL(bundle, NotificationConstants.FIRE_DATE);
        if (fireDate == 0) {
            fireDate = new Date().getTime();
        }

        switch (repeatType.toLowerCase(Locale.ENGLISH)) {
            case LocalNotification.Repeat.Type.HOUR:
                return fireDate + LocalNotification.Repeat.Time.ONE_HOUR;
            case LocalNotification.Repeat.Type.MINUTE:
                return fireDate + LocalNotification.Repeat.Time.ONE_MINUTE;
            case LocalNotification.Repeat.Type.DAY:
                return fireDate + LocalNotification.Repeat.Time.ONE_DAY;
            case LocalNotification.Repeat.Type.WEEK:
                return fireDate + LocalNotification.Repeat.Time.ONE_WEEK;
            case LocalNotification.Repeat.Type.CUSTOM_TIME:
                if (repeatTime <= 0) {
                    return 0;
                }
                return fireDate + repeatTime;
            default:
                return 0;
        }
    }

    public static int configPriority(Bundle bundle) {
        final String value = BundleUtils.get(bundle, NotificationConstants.PRIORITY);
        if (value == null) {
            return NotificationCompat.PRIORITY_HIGH;
        }

        switch (value.toLowerCase(Locale.ENGLISH)) {
            case LocalNotification.Priority.MAX:
                return NotificationCompat.PRIORITY_MAX;
            case LocalNotification.Priority.LOW:
                return NotificationCompat.PRIORITY_LOW;
            case LocalNotification.Priority.MIN:
                return NotificationCompat.PRIORITY_MIN;
            case LocalNotification.Priority.DEFAULT:
                return NotificationCompat.PRIORITY_DEFAULT;
            case LocalNotification.Priority.HIGH:
            default:
                return NotificationCompat.PRIORITY_HIGH;
        }
    }

    public static int configImportance(Bundle bundle) {
        if (Build.VERSION_CODES.N < Build.VERSION.SDK_INT) {
            return 4; // IMPORTANCE_HIGH
        }

        final String value = BundleUtils.get(bundle, NotificationConstants.IMPORTANCE);
        if (value == null) {
            return 4; // IMPORTANCE_HIGH
        }

        try {
            switch (value.toLowerCase(Locale.ENGLISH)) {
                case LocalNotification.Importance.MAX:
                    return NotificationManager.IMPORTANCE_MAX;
                case LocalNotification.Importance.LOW:
                    return NotificationManager.IMPORTANCE_LOW;
                case LocalNotification.Importance.MIN:
                    return NotificationManager.IMPORTANCE_MIN;
                case LocalNotification.Importance.NONE:
                    return NotificationManager.IMPORTANCE_NONE;
                case LocalNotification.Importance.UNSPECIFIED:
                    return NotificationManager.IMPORTANCE_UNSPECIFIED;
                case LocalNotification.Importance.DEFAULT:
                    return NotificationManager.IMPORTANCE_DEFAULT;
                case LocalNotification.Importance.HIGH:
                default:
                    return NotificationManager.IMPORTANCE_HIGH;
            }
        } catch (RuntimeException e) {
            return 4;
        }
    }

    public static int configVisibility(Bundle bundle) {
        final String value = BundleUtils.get(bundle, NotificationConstants.VISIBILITY);
        if (value == null) {
            return NotificationCompat.VISIBILITY_PUBLIC;
        }
        switch (value.toLowerCase(Locale.ENGLISH)) {
            case LocalNotification.Visibility.PUBLIC:
                return NotificationCompat.VISIBILITY_PUBLIC;
            case LocalNotification.Visibility.SECRET:
                return NotificationCompat.VISIBILITY_SECRET;
            case LocalNotification.Visibility.PRIVATE:
            default:
                return NotificationCompat.VISIBILITY_PRIVATE;
        }
    }

    public static void configId(Bundle bundle) {
        if (BundleUtils.get(bundle, NotificationConstants.ID) == null) {
            bundle.putString(NotificationConstants.ID, generateNotificationId());
        }
    }

    public static String generateNotificationId() {
        return String.valueOf(new SecureRandom().nextInt());
    }
}

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

package com.huawei.hms.flutter.contactshield.utils;

import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;

import com.huawei.hms.contactshield.ContactShieldSetting;
import com.huawei.hms.contactshield.DiagnosisConfiguration;
import com.huawei.hms.contactshield.SharedKeyFileProvider;
import com.huawei.hms.contactshield.SharedKeysDataMapping;
import com.huawei.hms.flutter.contactshield.constants.IntentAction;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import io.flutter.plugin.common.MethodCall;

public final class ObjectProvider {
    private ObjectProvider() {
    }

    public static List<File> getFileList(final MethodCall call) {
        final List<String> filesPaths = call.argument("filePaths");
        if (filesPaths != null) {
            final List<File> files = new ArrayList<>();
            for (final String path : filesPaths) {
                final File file = new File(path);
                files.add(file);
            }
            return files;
        }
        return Collections.emptyList();
    }

    public static SharedKeyFileProvider getSharedKeyFileProvider(final MethodCall call) {
        final List<File> files = getFileList(call);
        return new SharedKeyFileProvider(files);
    }

    public static DiagnosisConfiguration getDiagnosisConfiguration(final MethodCall call) {
        final String diagnosisConfigJson = call.argument("diagnosisConfiguration");
        return ObjectSerializer.INSTANCE.fromJson(diagnosisConfigJson, DiagnosisConfiguration.class);
    }

    public static ContactShieldSetting getContactShieldSetting(final MethodCall call) {
        final int incubationPeriod = call.arguments();
        return new ContactShieldSetting.Builder().setIncubationPeriod(incubationPeriod).build();
    }

    public static SharedKeysDataMapping getSharedKeysDataMapping(final MethodCall call) {
        final String sharedKeysDataMappingJson = call.arguments();
        return ObjectSerializer.INSTANCE.fromJson(sharedKeysDataMappingJson, SharedKeysDataMapping.class);
    }

    public static PendingIntent getPendingIntent(final Context context, final String action, final int requestCode) {
        final Intent intent = new Intent(action).setPackage(context.getPackageName());
        return PendingIntent.getBroadcast(context, requestCode, intent, PendingIntent.FLAG_UPDATE_CURRENT);
    }

    public static IntentFilter getIntentFilter() {
        final IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction(IntentAction.START_CONTACT_SHIELD_CB);
        intentFilter.addAction(IntentAction.PUT_SHARED_KEY_FILES_CB);
        intentFilter.addAction(IntentAction.PUT_SHARED_KEY_FILES_CB_WITH_PROVIDER);
        intentFilter.addAction(IntentAction.PUT_SHARED_KEY_FILES_CB_WITH_KEYS);
        return intentFilter;
    }
}

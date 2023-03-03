/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.drive.common.utils;

import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.util.Pair;

import com.huawei.agconnect.LocalBrdMnger;
import com.huawei.hms.flutter.drive.common.Constants;
import com.huawei.hms.flutter.drive.services.comments.CommentsRequestOptions;

import org.json.JSONArray;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

public final class DriveUtils {
    private DriveUtils() {
    }

    public static boolean isNotNullAndEmpty(final Object o) {
        return o != null && !((String) o).isEmpty();
    }

    public static boolean isNullOrEmpty(final Object o) {
        if (o != null) {
            return ((String) o).isEmpty();
        }
        return true;
    }

    public static Pair<String, String> methodNameExtractor(final MethodCall call) {
        final String[] methodCallParts = call.method.split("#");
        if (methodCallParts.length > 0) {
            // First is module name second is method name.
            return new Pair<>(methodCallParts[0], methodCallParts[1]);
        }
        return new Pair<>("", "");
    }

    public static Pair<String, String> methodNameExtractor(final String methodName) {
        final String[] methodCallParts = methodName.split("#");
        if (methodCallParts.length > 0) {
            // First is module name second is method name.
            return new Pair<>(methodCallParts[0], methodCallParts[1]);
        }
        return new Pair<>("", "");
    }

    public static void defaultErrorHandler(final Result result, final String errorMessage) {
        new Handler(Looper.getMainLooper()).post(() -> result.error(Constants.UNKNOWN_ERROR, errorMessage, ""));
    }

    public static void errorHandler(final Result result, final String errorCode, final String errorMessage,
        final String errorDetails) {
        new Handler(Looper.getMainLooper()).post(
            () -> result.error(errorCode, errorMessage, errorDetails != null ? errorDetails : ""));
    }

    public static void errorHandler(final Context context, final Intent intent, final String error) {
        intent.putExtra("batchError", error);
        LocalBrdMnger.getInstance(context).sendBroadcast(intent);
        intent.removeExtra("batchError");
    }

    public static void successHandler(final Result result, final String jsonResult) {
        new Handler(Looper.getMainLooper()).post(() -> result.success(jsonResult));
    }

    public static void booleanSuccessHandler(final Result result, final boolean booleanResult) {
        new Handler(Looper.getMainLooper()).post(() -> result.success(booleanResult));
    }

    public static void byteArraySuccessHandler(final Result result, final byte[] byteArray) {
        new Handler(Looper.getMainLooper()).post(() -> result.success(byteArray));
    }

    public static JSONArray convertBytesToList(final byte[] bytes) {
        final JSONArray list = new JSONArray();
        for (final byte b : bytes) {
            list.put(b);
        }
        return list;
    }

    /**
     * Checks the fileId and commentId fields on a given {@link CommentsRequestOptions} instance. Fails the Flutter
     * result and returns true if one of the controlled fields can not be founded. Returns false if both fields are
     * present.
     *
     * @param requestOptions The request object to check for fileId and commentId existence.
     * @param result         The Flutter result to reply with an error if one of the fields is empty.
     * @return true if a fileId or commentId is missing false otherwise.
     */
    public static boolean missingFileIdOrCommentId(final CommentsRequestOptions requestOptions, final Result result) {
        if (!DriveUtils.isNotNullAndEmpty(requestOptions.getFileId())) {
            Log.i(Constants.TAG, "Please specify a FileId.");
            DriveUtils.defaultErrorHandler(result, "FileId can't be null or empty.");
            return true;
        } else if (!DriveUtils.isNotNullAndEmpty(requestOptions.getCommentId())) {
            Log.i(Constants.TAG, "Please specify a commentId.");
            DriveUtils.defaultErrorHandler(result, "CommentId can't be null or empty.");
            return true;
        }
        return false;
    }

    public static boolean missingFileIdOrCommentId(final CommentsRequestOptions requestOptions) {
        if (!DriveUtils.isNotNullAndEmpty(requestOptions.getFileId())) {
            Log.i(Constants.TAG, "Please specify a FileId.");
            return true;
        } else if (!DriveUtils.isNotNullAndEmpty(requestOptions.getCommentId())) {
            Log.i(Constants.TAG, "Please specify a commentId.");
            return true;
        }
        return false;
    }

    public static String decapitalize(final String text) {
        final char[] c = text.toCharArray();
        c[0] = Character.toLowerCase(c[0]);
        return new String(c);
    }

    public static Map<String, Object> newErrorMap(String errorMessage) {
        Map<String, Object> errorMap = new HashMap<>();
        errorMap.put("error", errorMessage);
        return errorMap;
    }

    public static Map<String, Object> newSuccessMap(String methodName) {
        Map<String, Object> errorMap = new HashMap<>();
        errorMap.put(methodName, "success");
        return errorMap;
    }
}

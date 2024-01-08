/*
 * Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.health.foundation.utils;

import static com.huawei.hms.flutter.health.foundation.constants.Constants.BASE_MODULE_NAME;
import static com.huawei.hms.flutter.health.foundation.constants.Constants.UNKNOWN_ERROR_CODE;

import android.util.Log;

import com.huawei.hms.common.ApiException;

import io.flutter.plugin.common.MethodChannel.Result;

public enum ExceptionHandler {
    INSTANCE;

    private static final String RETURN_CODE = "returnCode: ";

    private static final String EXCEPTION = "exception";

    /**
     * Result handler method, in failure.
     *
     * @param exception Exception instance.
     * @param result Flutter Result.
     */
    public static synchronized void fail(final Exception exception, Result result) {
        if (exception instanceof ApiException) {
            ApiException apiException = (ApiException) exception;
            Log.i(BASE_MODULE_NAME, RETURN_CODE + apiException.getStatusCode());
            result.error(String.valueOf(apiException.getStatusCode()), apiException.getLocalizedMessage(), "");
            return;
        }
        Log.i(BASE_MODULE_NAME, EXCEPTION + ": " + exception.getLocalizedMessage());
        result.error(UNKNOWN_ERROR_CODE, exception.getLocalizedMessage(), "");
    }

    /**
     * @param exception Exception instance.
     * @param result Flutter Result.
     * @param errorMessage Error Message to be shown as Error Details.
     */
    public static synchronized void fail(final Exception exception, Result result, String errorMessage) {
        if (exception instanceof ApiException) {
            ApiException apiException = (ApiException) exception;
            Log.i(BASE_MODULE_NAME, RETURN_CODE + apiException.getStatusCode());
            result.error(String.valueOf(apiException.getStatusCode()), apiException.getLocalizedMessage(),
                errorMessage);
            return;
        }
        Log.i(BASE_MODULE_NAME, EXCEPTION + ": " + exception.getLocalizedMessage());
        result.error(UNKNOWN_ERROR_CODE, exception.getLocalizedMessage(), errorMessage);
    }

    /**
     * Simple handle method, which returns errorListener, onMessageReceived.
     *
     * @param exception Exception instance.
     * @param errorListener ErrorListener instance.
     */
    public synchronized void fail(Exception exception, ErrorListener errorListener) {
        if (exception instanceof ApiException) {
            ApiException apiException = (ApiException) exception;
            Log.i(BASE_MODULE_NAME, RETURN_CODE + apiException.getStatusCode());
            if (errorListener == null) {
                return;
            }
            errorListener.onMessageReceived(String.valueOf(apiException.getStatusCode()));
        } else {
            Log.e(BASE_MODULE_NAME, exception.getMessage());
            if (errorListener == null) {
                return;
            }
            Log.i(BASE_MODULE_NAME, EXCEPTION + ": " + exception.getLocalizedMessage());
            errorListener.onMessageReceived(exception.getLocalizedMessage());
        }
    }

    /**
     * Simple handle method.
     *
     * @param exception Exception instance.
     */
    public synchronized void fail(Exception exception) {
        if (exception instanceof ApiException) {
            ApiException apiException = (ApiException) exception;
            Log.i(BASE_MODULE_NAME, RETURN_CODE + apiException.getStatusCode());
        } else {
            Log.e(BASE_MODULE_NAME, exception.getMessage());
        }
    }

    /**
     * Exception Error Listener.
     */
    public interface ErrorListener {
        /**
         * Error Message Description.
         *
         * @param errMessage String value.
         */
        void onMessageReceived(String errMessage);
    }
}

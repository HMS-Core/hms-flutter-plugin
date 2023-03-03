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

package com.huawei.hms.flutter.drive.services.historyversions;

import static com.huawei.hms.flutter.drive.common.Constants.UNKNOWN_ERROR;

import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.cloud.base.http.HttpResponse;
import com.huawei.cloud.base.json.gson.GsonFactory;
import com.huawei.cloud.client.task.Task;
import com.huawei.cloud.services.drive.Drive;
import com.huawei.cloud.services.drive.Drive.HistoryVersions.Get;
import com.huawei.cloud.services.drive.model.HistoryVersion;
import com.huawei.cloud.services.drive.model.HistoryVersionList;
import com.huawei.hms.flutter.drive.common.Constants;
import com.huawei.hms.flutter.drive.common.Constants.DriveRequestType;
import com.huawei.hms.flutter.drive.common.Constants.HistoryVersionsMethods;
import com.huawei.hms.flutter.drive.common.utils.CommonTaskManager;
import com.huawei.hms.flutter.drive.common.utils.DriveUtils;
import com.huawei.hms.flutter.drive.common.utils.HMSLogger;
import com.huawei.hms.flutter.drive.common.utils.ValueGetter;
import com.huawei.hms.utils.IOUtils;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import java.util.Optional;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

public class HistoryVersionsController {
    private static final String TAG = HistoryVersionsController.class.getSimpleName();
    private static final String SERVICE_NAME = "HistoryVersions";
    private static final String FILE_OR_HISTORY_ID_MISSING_ERROR = "FileId and HistoryVersionId should be specified.";

    private final HistoryVersionsRequestFactory requestFactory;
    private final HMSLogger hmsLogger;

    public HistoryVersionsController(final Drive drive, final Context context) {
        requestFactory = new HistoryVersionsRequestFactory(drive, context);
        hmsLogger = HMSLogger.getInstance(context);
    }

    public void onMethodCall(final @NonNull MethodCall call, final @NonNull Result result) {
        final String methodName = DriveUtils.methodNameExtractor(call).second;
        switch (HistoryVersionsMethods.getEnum(methodName)) {
            case HISTORY_VERSIONS_DELETE:
                delete(call, result);
                break;
            case HISTORY_VERSIONS_GET:
                get(call, result);
                break;
            case HISTORY_VERSIONS_EXECUTE_CONTENT:
                executeContent(call, result);
                break;
            case HISTORY_VERSIONS_EXECUTE_CONTENT_AND_DOWNLOAD_TO:
                executeContentAndDownloadTo(call, result);
                break;
            case HISTORY_VERSIONS_EXECUTE_CONTENT_AS_INPUT_STREAM:
                executeContentAsInputStream(call, result);
                break;
            case HISTORY_VERSIONS_LIST:
                list(call, result);
                break;
            case HISTORY_VERSIONS_UPDATE:
                update(call, result);
                break;
        }
    }

    private void delete(final MethodCall call, final Result result) {
        final HistoryVersionsRequestOptions requestOptions = toHistoryVersionRequestOptions(call, false);
        if (missingFileIdOrHistoryVersionId(requestOptions, result)) {
            return;
        }
        try {
            final Drive.HistoryVersions.Delete deleteRequest = requestFactory.buildRequest(DriveRequestType.DELETE,
                requestOptions, null, Drive.HistoryVersions.Delete.class);
            requestFactory.runTaskOnBackground(result, Void.class, deleteRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".delete"));
        } catch (final IOException e) {
            DriveUtils.defaultErrorHandler(result, "Delete history version error: " + e.getMessage());
        }
    }

    public Optional<Drive.HistoryVersions.Delete> delete(final Map<String, Object> args) {
        final HistoryVersionsRequestOptions requestOptions = toHistoryVersionRequestOptions(args);
        if (missingFileIdOrHistoryVersionId(requestOptions)) {
            DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                requestFactory.toJson(DriveUtils.newErrorMap(FILE_OR_HISTORY_ID_MISSING_ERROR)));
            return Optional.empty();
        }
        try {
            final Drive.HistoryVersions.Delete deleteRequest = requestFactory.buildRequest(DriveRequestType.DELETE,
                requestOptions, null, Drive.HistoryVersions.Delete.class);
            return Optional.of(deleteRequest);
        } catch (final IOException e) {
            DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                requestFactory.toJson(e));
        }
        return Optional.empty();
    }

    private void get(final MethodCall call, final Result result) {
        final HistoryVersionsRequestOptions requestOptions = toHistoryVersionRequestOptions(call, false);
        if (missingFileIdOrHistoryVersionId(requestOptions, result)) {
            return;
        }
        try {
            final Drive.HistoryVersions.Get getRequest = requestFactory.buildRequest(DriveRequestType.GET,
                requestOptions, null, Drive.HistoryVersions.Get.class);
            requestFactory.runTaskOnBackground(result, HistoryVersion.class, getRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".get"));
        } catch (final IOException e) {
            DriveUtils.defaultErrorHandler(result, "Get history version error: " + e.getMessage());
        }
    }

    public Optional<Drive.HistoryVersions.Get> get(final Map<String, Object> args) {
        final HistoryVersionsRequestOptions requestOptions = toHistoryVersionRequestOptions(args);
        if (missingFileIdOrHistoryVersionId(requestOptions)) {
            DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                requestFactory.toJson(DriveUtils.newErrorMap(FILE_OR_HISTORY_ID_MISSING_ERROR)));
            return Optional.empty();
        }
        try {
            final Drive.HistoryVersions.Get getRequest = requestFactory.buildRequest(DriveRequestType.GET,
                requestOptions, null, Drive.HistoryVersions.Get.class);
            return Optional.of(getRequest);
        } catch (final IOException e) {
            DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                requestFactory.toJson(e));
        }
        return Optional.empty();
    }

    private void executeContent(final MethodCall call, final Result result) {
        final String methodName = "HistoryVersions.executeContent";
        final Optional<Get> optionalGet = createGetRequest(call, result, false);
        CommonTaskManager.execute(new Task() {
            @Override
            public void call() {
                optionalGet.ifPresent(get -> {
                    try {
                        // Request execution
                        final HttpResponse response = get.executeContent();
                        if (response.isSuccessStatusCode()) {
                            // Response to Flutter
                            final JSONObject obj = new JSONObject();
                            obj.put("content",
                                DriveUtils.convertBytesToList(IOUtils.toByteArray(response.getContent())));
                            obj.put("contentEncoding", response.getContentEncoding());
                            obj.put("contentLoggingLimit", response.getContentLoggingLimit());
                            obj.put("contentType", response.getContentType());
                            DriveUtils.successHandler(result, obj.toString());
                            hmsLogger.sendSingleEvent(methodName);
                        } else {
                            // Error to Flutter
                            DriveUtils.errorHandler(result, response.getStatusMessage(), response.getStatusMessage(),
                                "Error while running getExecuteContent");
                            hmsLogger.sendSingleEvent(methodName, UNKNOWN_ERROR);
                        }
                    } catch (final IOException | JSONException e) {
                        DriveUtils.errorHandler(result, UNKNOWN_ERROR, "Error on getExecuteContent " + e.getMessage(),
                            "");
                        hmsLogger.sendSingleEvent(methodName, UNKNOWN_ERROR);
                    }
                });
            }
        });
    }

    private void executeContentAndDownloadTo(final MethodCall call, final Result result) {
        final String methodName = "HistoryVersions.executeContentAndDownloadTo";
        final Optional<Get> optionalGet = createGetRequest(call, result, true);
        CommonTaskManager.execute(new Task() {
            @Override
            public void call() {
                optionalGet.ifPresent(get -> {
                    FileOutputStream outputStream = null;
                    try {
                        // Request execution
                        final String filePath = ValueGetter.getString("path", call);
                        if (DriveUtils.isNotNullAndEmpty(filePath)) {
                            java.io.File path = new java.io.File(ValueGetter.getString("path", call));
                            outputStream = new FileOutputStream(path);
                            get.executeContentAndDownloadTo(outputStream);
                            DriveUtils.booleanSuccessHandler(result, true);
                            hmsLogger.sendSingleEvent(methodName);
                        } else {
                            DriveUtils.errorHandler(result, UNKNOWN_ERROR,
                                "getExecuteContentAndDownloadTo failed, Please specify a file path.", "");
                            hmsLogger.sendSingleEvent(methodName, UNKNOWN_ERROR);
                        }
                    } catch (final IOException e) {
                        DriveUtils.errorHandler(result, UNKNOWN_ERROR,
                            "Error on getExecuteContentAndDownloadTo " + e.getMessage(), "");
                        hmsLogger.sendSingleEvent(methodName, UNKNOWN_ERROR);
                    } finally {
                        if (outputStream != null) {
                            try {
                                outputStream.close();
                            } catch (IOException e) {
                                Log.e(TAG, "HistoryVersions: Close FileOutputStream error" + e.toString());
                            }
                        }
                    }
                });

            }
        });
    }

    private void executeContentAsInputStream(final MethodCall call, final Result result) {
        final String methodName = "HistoryVersions.executeContentAsInputStream";
        final Optional<Get> optionalGet = createGetRequest(call, result, false);
        optionalGet.ifPresent(get -> CommonTaskManager.execute(new Task() {
            @Override
            public void call() {
                try {
                    // Request execution
                    final InputStream response = get.executeContentAsInputStream();
                    // Response to Flutter
                    DriveUtils.byteArraySuccessHandler(result, IOUtils.toByteArray(response));
                    hmsLogger.sendSingleEvent(methodName);
                } catch (final IOException e) {
                    DriveUtils.errorHandler(result, UNKNOWN_ERROR,
                        "Error on getExecuteContentAsInputStream " + e.getMessage(), "");
                    hmsLogger.sendSingleEvent(methodName, UNKNOWN_ERROR);
                }
            }
        }));
    }

    private Optional<Get> createGetRequest(final MethodCall call, final Result result, final boolean fromMap) {
        final Get getRequest;
        try {
            final HistoryVersionsRequestOptions requestOptions = toHistoryVersionRequestOptions(call, fromMap);
            if (missingFileIdOrHistoryVersionId(requestOptions, result)) {
                return Optional.empty();
            }
            getRequest = requestFactory.buildRequest(DriveRequestType.GET, requestOptions, null, Get.class);
            return Optional.of(getRequest);
        } catch (final IOException e) {
            DriveUtils.defaultErrorHandler(result,
                "Error while creating history versions get request: " + e.getMessage());
            return Optional.empty();
        }
    }

    private void update(final MethodCall call, final Result result) {
        try {
            final HistoryVersion historyVersion = GsonFactory.getDefaultInstance()
                .fromString(call.argument("historyVersion"), HistoryVersion.class);
            final HistoryVersionsRequestOptions requestOptions = toHistoryVersionRequestOptions(call, true);
            if (missingFileIdOrHistoryVersionId(requestOptions, result)) {
                return;
            }
            requestFactory.setExtraParams(historyVersion, call);
            final Drive.HistoryVersions.Update updateRequest = requestFactory.buildRequest(DriveRequestType.UPDATE,
                requestOptions, historyVersion, Drive.HistoryVersions.Update.class);
            requestFactory.runTaskOnBackground(result, HistoryVersion.class, updateRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".update"));
        } catch (final IOException e) {
            DriveUtils.defaultErrorHandler(result, "Update history version error: " + e.getMessage());
        }
    }

    public Optional<Drive.HistoryVersions.Update> update(final Map<String, Object> args) {
        try {
            final HistoryVersion historyVersion = GsonFactory.getDefaultInstance()
                .fromString(requestFactory.toJson(args.get("historyVersion")), HistoryVersion.class);
            final HistoryVersionsRequestOptions requestOptions = toHistoryVersionRequestOptions(args);
            if (missingFileIdOrHistoryVersionId(requestOptions)) {
                DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                    requestFactory.toJson(DriveUtils.newErrorMap(FILE_OR_HISTORY_ID_MISSING_ERROR)));
                return Optional.empty();
            }
            final Drive.HistoryVersions.Update updateRequest = requestFactory.buildRequest(DriveRequestType.UPDATE,
                requestOptions, historyVersion, Drive.HistoryVersions.Update.class);
            return Optional.of(updateRequest);
        } catch (final IOException e) {
            DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                requestFactory.toJson(e));
        }
        return Optional.empty();
    }

    private void list(final MethodCall call, final Result result) {
        final HistoryVersionsRequestOptions requestOptions = toHistoryVersionRequestOptions(call, false);
        if (DriveUtils.isNullOrEmpty(requestOptions.getFileId())) {
            DriveUtils.defaultErrorHandler(result, "Please specify a FileId.");
            return;
        }
        try {
            final Drive.HistoryVersions.List listRequest = requestFactory.buildRequest(DriveRequestType.LIST,
                requestOptions, null, Drive.HistoryVersions.List.class);
            requestFactory.runTaskOnBackground(result, HistoryVersionList.class, listRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".list"));
        } catch (final IOException e) {
            DriveUtils.defaultErrorHandler(result, "List history versions error: " + e.getMessage());
        }
    }

    public Optional<Drive.HistoryVersions.List> list(final Map<String, Object> args) {
        final HistoryVersionsRequestOptions requestOptions = toHistoryVersionRequestOptions(args);
        if (DriveUtils.isNullOrEmpty(requestOptions.getFileId())) {
            DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                requestFactory.toJson(DriveUtils.newErrorMap("FileId should be specified.")));
            return Optional.empty();
        }
        try {
            final Drive.HistoryVersions.List listRequest = requestFactory.buildRequest(DriveRequestType.LIST,
                requestOptions, null, Drive.HistoryVersions.List.class);
            return Optional.of(listRequest);
        } catch (final IOException e) {
            DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                requestFactory.toJson(e));
        }
        return Optional.empty();
    }

    public static boolean missingFileIdOrHistoryVersionId(final HistoryVersionsRequestOptions requestOptions,
        final Result result) {
        if (!DriveUtils.isNotNullAndEmpty(requestOptions.getFileId())) {
            Log.i(Constants.TAG, "Please specify a FileId.");
            DriveUtils.defaultErrorHandler(result, "FileId can't be null or empty.");
            return true;
        } else if (!DriveUtils.isNotNullAndEmpty(requestOptions.getHistoryVersionId())) {
            Log.i(Constants.TAG, "Please specify a HistoryVersionId.");
            DriveUtils.defaultErrorHandler(result, "HistoryVersionId can't be null or empty.");
            return true;
        }
        return false;
    }

    public static boolean missingFileIdOrHistoryVersionId(final HistoryVersionsRequestOptions requestOptions) {
        if (!DriveUtils.isNotNullAndEmpty(requestOptions.getFileId())) {
            Log.i(TAG, "Please specify a FileId.");
            return true;
        } else if (!DriveUtils.isNotNullAndEmpty(requestOptions.getHistoryVersionId())) {
            Log.i(TAG, "Please specify a HistoryVersionId.");
            return true;
        }
        return false;
    }

    private HistoryVersionsRequestOptions toHistoryVersionRequestOptions(final MethodCall call, final boolean fromMap) {
        if (fromMap) {
            return requestFactory.getGson()
                .fromJson((String) call.argument("requestOptions"), HistoryVersionsRequestOptions.class);
        }
        return requestFactory.getGson().fromJson((String) call.arguments, HistoryVersionsRequestOptions.class);
    }

    private HistoryVersionsRequestOptions toHistoryVersionRequestOptions(final Map<String, Object> args) {
        return requestFactory.getGson().fromJson(requestFactory.toJson(args), HistoryVersionsRequestOptions.class);
    }
}

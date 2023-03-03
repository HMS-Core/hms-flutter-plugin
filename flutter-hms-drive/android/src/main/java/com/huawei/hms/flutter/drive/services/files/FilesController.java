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

package com.huawei.hms.flutter.drive.services.files;

import static com.huawei.hms.flutter.drive.common.Constants.UNKNOWN_ERROR;

import android.content.Context;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.agconnect.LocalBrdMnger;
import com.huawei.cloud.base.http.AbstractInputStreamContent;
import com.huawei.cloud.base.http.ByteArrayContent;
import com.huawei.cloud.base.http.FileContent;
import com.huawei.cloud.base.http.HttpResponse;
import com.huawei.cloud.base.json.gson.GsonFactory;
import com.huawei.cloud.base.media.MediaHttpDownloader;
import com.huawei.cloud.client.task.Task;
import com.huawei.cloud.services.drive.Drive;
import com.huawei.cloud.services.drive.DriveRequest;
import com.huawei.cloud.services.drive.model.Channel;
import com.huawei.cloud.services.drive.model.File;
import com.huawei.cloud.services.drive.model.FileList;
import com.huawei.hms.flutter.drive.common.Constants.FilesMethods;
import com.huawei.hms.flutter.drive.common.Constants.FilesRequestType;
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
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

public class FilesController {
    private static final int DIRECT_UPLOAD_MAX_SIZE = 20 * 1024 * 1024;
    private static final int DIRECT_DOWNLOAD_MAX_SIZE = 20 * 1024 * 1024;

    private static final String TAG = FilesController.class.getSimpleName();
    private static final String SERVICE_NAME = "Files";

    private final FilesRequestFactory requestFactory;
    private final HMSLogger hmsLogger;

    final String progressAction;
    String batchAction;
    final Intent progressIntent;
    final Intent batchIntent;
    Context context;
    final Drive drive;

    public FilesController(final Drive drive, final Context context) {
        requestFactory = new FilesRequestFactory(drive, context);
        this.drive = drive;
        this.context = context;
        hmsLogger = HMSLogger.getInstance(context);

        // Progress Intent
        progressAction = context.getPackageName() + ".PROGRESS_CHANGED";
        progressIntent = new Intent(progressAction);

        // Batch Actions Intent
        batchAction = context.getPackageName() + ".BATCH_ACTION";
        batchIntent = new Intent(batchAction);
    }

    public void onMethodCall(final @NonNull MethodCall call, final @NonNull Result result) {
        final String methodName = DriveUtils.methodNameExtractor(call).second;
        switch (FilesMethods.getEnum(methodName)) {
            case FILES_COPY:
                filesCopy(call, result);
                break;
            case FILES_CREATE:
                filesCreate(call, result);
                break;
            case FILES_DELETE:
                filesDelete(call, result);
                break;
            case FILES_EMPTY_RECYCLE:
                filesEmptyRecycle(call, result);
                break;
            case FILES_GET:
                filesGet(call, result);
                break;
            case FILES_LIST:
                filesList(call, result);
                break;
            case FILES_UPDATE:
                filesUpdate(call, result);
                break;
            case FILES_SUBSCRIBE:
                filesSubscribe(call, result);
                break;
            case FILES_EXECUTE_CONTENT:
                filesExecuteContent(call, result);
                break;
            case FILES_EXECUTE_AS_INPUT_STREAM:
                filesExecuteContentAsInputStream(call, result);
                break;
            case FILES_EXECUTE_AND_DOWNLOAD_TO:
                filesExecuteContentAndDownloadTo(call, result);
                break;
            default:
                break;
        }
    }

    private void setDirectUpload(final boolean isDirectUpload, final DriveRequest<?> request, final String fileName) {
        // Set the upload mode. By default, resumable upload is used. If the file is smaller than 20 MB, set this parameter to true.
        request.getMediaHttpUploader().setDirectUploadEnabled(isDirectUpload).setProgressListener(mediaHttpUploader -> {
            final HashMap<String, Object> map = new HashMap<>();
            map.put("fileName", fileName);
            map.put("progress", mediaHttpUploader.getProgress());
            map.put("totalTimeElapsed", mediaHttpUploader.getTotalTimeRequired());
            map.put("state", mediaHttpUploader.getUploadState().toString());
            progressIntent.putExtra("progress", map);
            LocalBrdMnger.getInstance(context).sendBroadcast(progressIntent);
        });
    }

    private void setDirectDownload(final boolean isDirectDownload, final Drive.Files.Get request, final String fileName,
        final long downloadedLength, final long totalLength) {
        // Set the download mode. By default, resumable download is used. If the file is smaller than 20 MB, set this
        // parameter to true.
        request.getMediaHttpDownloader()
            .setContentRange(downloadedLength, totalLength - 1)
            .setDirectDownloadEnabled(isDirectDownload)
            .setProgressListener(mediaHttpDownloader -> {
                final HashMap<String, Object> map = new HashMap<>();
                map.put("fileName", fileName);
                map.put("progress", mediaHttpDownloader.getProgress());
                map.put("totalTimeElapsed", mediaHttpDownloader.getTotalTimeRequired());
                map.put("state", mediaHttpDownloader.getDownloadState().toString());
                progressIntent.putExtra("progress", map);
                context.sendBroadcast(progressIntent);
            });
    }

    private long getFileSize(final String fileId) {
        final long size = 0L;
        try {
            final Drive.Files.Get request = drive.files().get(fileId);
            request.setFields("size");
            final File res = request.execute();
            return res.getSize();
        } catch (final IOException e) {
            Log.e(TAG, "getFileSize: Couldn't get the file size.", null);
        }
        return size;
    }

    private Channel toChannel(final MethodCall call) throws IOException {
        final Channel channel;
        try {
            channel = GsonFactory.getDefaultInstance()
                .fromString(Objects.requireNonNull(call.argument("channel")), Channel.class);
        } catch (final IOException | NullPointerException e) {
            throw new IOException("Could not create the Channel, please check the arguments.");
        }
        return channel;
    }

    private Channel toChannel(final String args) throws IOException {
        final Channel channel;
        try {
            channel = GsonFactory.getDefaultInstance().fromString(args, Channel.class);
        } catch (final IOException | NullPointerException e) {
            throw new IOException("Could not create the Channel, please check the arguments.");
        }
        return channel;
    }

    private File toFile(final MethodCall call) throws IOException {
        final File file;
        try {
            file = GsonFactory.getDefaultInstance().fromString(call.argument("file"), File.class);
        } catch (final IOException | NullPointerException e) {
            throw new IOException("Could not create the file, please check the arguments.");
        }
        return file;
    }

    private File toFile(final String args) throws IOException {
        final File file;
        try {
            file = GsonFactory.getDefaultInstance().fromString(args, File.class);
        } catch (final IOException | NullPointerException e) {
            throw new IOException("Could not create the file, please check the arguments.");
        }
        return file;
    }

    private FilesRequestOptions toFilesRequest(final MethodCall call, final boolean fromMap) {
        if (fromMap) {
            return requestFactory.getGson().fromJson((String) call.argument("request"), FilesRequestOptions.class);
        }
        return requestFactory.getGson().fromJson((String) call.arguments, FilesRequestOptions.class);
    }

    private FilesRequestOptions toFilesRequest(final String args) {
        return requestFactory.getGson().fromJson(args, FilesRequestOptions.class);
    }

    private void filesCopy(final MethodCall call, final Result result) {
        try {
            // Parameters
            final File file = toFile(call);
            final FilesRequestOptions copyOptions = toFilesRequest(call, true);
            requestFactory.setExtraParams(file, call);
            // Create comment create request.
            final Drive.Files.Copy copyRequest = requestFactory.buildRequest(FilesRequestType.COPY, copyOptions,
                Drive.Files.Copy.class, file, null, null);
            // Run on background and handle Flutter result.
            requestFactory.runTaskOnBackground(result, File.class, copyRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".copy"));
        } catch (final IOException e) {
            // Error to Flutter
            DriveUtils.defaultErrorHandler(result, "Copy file error: " + e.getMessage());
        }
    }

    public Optional<Drive.Files.Copy> filesCopy(final Map<String, Object> args) {
        try {
            // Parameters
            final File file = toFile(requestFactory.getGson().toJson(args.get("file")));
            final FilesRequestOptions copyOptions = toFilesRequest(requestFactory.getGson().toJson(args));
            // Create comment create request.
            final Drive.Files.Copy copyRequest = requestFactory.buildRequest(FilesRequestType.COPY, copyOptions,
                Drive.Files.Copy.class, file, null, null);

            return Optional.of(copyRequest);
        } catch (final IOException e) {
            DriveUtils.errorHandler(context, batchIntent, requestFactory.getGson().toJson(e));
        }
        return Optional.empty();
    }

    private void filesCreate(final MethodCall call, final Result result) {
        try {
            // Parameters
            final Drive.Files.Create createRequest;
            final java.io.File ioFile;
            final AbstractInputStreamContent fileContent;
            final File file = toFile(call);
            requestFactory.setExtraParams(file, call);
            final FilesRequestOptions createOptions = toFilesRequest(call, true);
            boolean isDirectUpload = false;

            // Creating request
            if (call.argument("fileContent") != null) {
                final Map<String, Object> content = call.argument("fileContent");
                if (Objects.requireNonNull(content).get("path") != null) {
                    ioFile = new java.io.File(ValueGetter.getString("path", content));
                    fileContent = new FileContent(ValueGetter.getString("type", content), ioFile);
                    // Create comment create request.
                    createRequest = requestFactory.buildRequest(FilesRequestType.CREATE, createOptions,
                        Drive.Files.Create.class, file, fileContent, null);
                    // Directly upload the file if it is smaller than 20 MB.
                    if (ioFile.length() < DIRECT_UPLOAD_MAX_SIZE) {
                        isDirectUpload = true;
                    }
                    setDirectUpload(isDirectUpload, createRequest, file.getFileName());
                } else if (content.get("byteArray") != null) {
                    fileContent = new ByteArrayContent(ValueGetter.getString("type", content),
                        ValueGetter.arrayListToByteArray(ValueGetter.toIntegerList("byteArray", content)));
                    // Create comment create request.
                    createRequest = requestFactory.buildRequest(FilesRequestType.CREATE, createOptions,
                        Drive.Files.Create.class, file, fileContent, null);
                    // Directly upload the file if it is smaller than 20 MB.
                    if (fileContent.getLength() < DIRECT_UPLOAD_MAX_SIZE) {
                        isDirectUpload = true;
                    }
                    setDirectUpload(isDirectUpload, createRequest, file.getFileName());
                } else {
                    Log.e(TAG, "Please provide path as String or content as byte array.", null);
                    return;
                }
            } else {
                // Create comment create request.
                createRequest = requestFactory.buildRequest(FilesRequestType.CREATE, createOptions,
                    Drive.Files.Create.class, file, null, null);
            }
            // Run on background and handle Flutter result.
            requestFactory.runTaskOnBackground(result, File.class, createRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".create"));
        } catch (final IOException e) {
            // Error to Flutter
            DriveUtils.defaultErrorHandler(result, "File create error: " + e.getMessage());
        }
    }

    public Optional<Drive.Files.Create> filesCreate(final Map<String, Object> args) {
        try {
            // Parameters
            final Drive.Files.Create createRequest;
            final File file = toFile(requestFactory.getGson().toJson(args.get("file")));
            final FilesRequestOptions createOptions = toFilesRequest(requestFactory.getGson().toJson(args));

            // Creating request
            if (args.get("fileContent") != null) {
                DriveUtils.errorHandler(context, batchIntent, "Batching media requests is not supported");
            } else {
                // Create comment create request.
                createRequest = requestFactory.buildRequest(FilesRequestType.CREATE, createOptions,
                    Drive.Files.Create.class, file, null, null);
                return Optional.of(createRequest);
            }
            // Run on background and handle Flutter result.

        } catch (final IOException e) {
            DriveUtils.errorHandler(context, batchIntent, requestFactory.getGson().toJson(e));
        }
        return Optional.empty();
    }

    private void filesDelete(final MethodCall call, final Result result) {
        try {
            // Parameters
            final FilesRequestOptions deleteOptions = toFilesRequest(call, false);
            // Create comment create request.
            final Drive.Files.Delete deleteRequest = requestFactory.buildRequest(FilesRequestType.DELETE, deleteOptions,
                Drive.Files.Delete.class, null, null, null);
            // Run on background and handle Flutter result.
            requestFactory.runTaskOnBackground(result, Void.class, deleteRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".delete"));
        } catch (final IOException e) {
            // Error to Flutter
            DriveUtils.defaultErrorHandler(result, "Delete file error: " + e.getMessage());
        }
    }

    public Optional<Drive.Files.Delete> filesDelete(final Map<String, Object> args) {
        try {
            // Parameters
            final FilesRequestOptions deleteOptions = toFilesRequest(requestFactory.getGson().toJson(args));
            // Create comment create request.
            final Drive.Files.Delete deleteRequest = requestFactory.buildRequest(FilesRequestType.DELETE, deleteOptions,
                Drive.Files.Delete.class, null, null, null);

            return Optional.of(deleteRequest);
        } catch (final IOException e) {
            DriveUtils.errorHandler(context, batchIntent, requestFactory.getGson().toJson(e));
        }
        return Optional.empty();
    }

    private void filesEmptyRecycle(final MethodCall call, final Result result) {
        try {
            // Parameters
            final FilesRequestOptions emptyRecycleOptions = toFilesRequest(call, false);
            // Create comment create request.
            final Drive.Files.EmptyRecycle emptyRecycleRequest = requestFactory.buildRequest(
                FilesRequestType.EMPTY_RECYCLE, emptyRecycleOptions, Drive.Files.EmptyRecycle.class, null, null, null);
            // Run on background and handle Flutter result.
            requestFactory.runTaskOnBackground(result, Void.class, emptyRecycleRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".emptyRecycle"));
        } catch (final IOException e) {
            // Error to Flutter
            DriveUtils.defaultErrorHandler(result, "Empty recycle error: " + e.getMessage());
        }
    }

    public Optional<Drive.Files.EmptyRecycle> filesEmptyRecycle(final Map<String, Object> args) {
        try {
            // Parameters
            final FilesRequestOptions emptyRecycleOptions = toFilesRequest(requestFactory.getGson().toJson(args));
            // Create comment create request.
            final Drive.Files.EmptyRecycle emptyRecycleRequest = requestFactory.buildRequest(
                FilesRequestType.EMPTY_RECYCLE, emptyRecycleOptions, Drive.Files.EmptyRecycle.class, null, null, null);

            return Optional.of(emptyRecycleRequest);
        } catch (final IOException e) {
            DriveUtils.errorHandler(context, batchIntent, requestFactory.getGson().toJson(e));
        }
        return Optional.empty();
    }

    private void filesGet(final MethodCall call, final Result result) {
        try {
            // Parameters
            final FilesRequestOptions getOptions = toFilesRequest(call, false);
            // Create comment create request.
            final Drive.Files.Get getRequest = requestFactory.buildRequest(FilesRequestType.GET, getOptions,
                Drive.Files.Get.class, null, null, null);
            // Run on background and handle Flutter result.
            MediaHttpDownloader downloader = getRequest.getMediaHttpDownloader();

            requestFactory.runTaskOnBackground(result, File.class, getRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".get"));
        } catch (final IOException e) {
            // Error to Flutter
            DriveUtils.defaultErrorHandler(result, "Get file error: " + e.getMessage());
        }
    }

    public Optional<Drive.Files.Get> filesGet(final Map<String, Object> args) {
        try {
            // Parameters
            final FilesRequestOptions getOptions = toFilesRequest(requestFactory.getGson().toJson(args));
            // Create comment create request.
            final Drive.Files.Get getRequest = requestFactory.buildRequest(FilesRequestType.GET, getOptions,
                Drive.Files.Get.class, null, null, null);

            return Optional.of(getRequest);
        } catch (final IOException e) {
            DriveUtils.errorHandler(context, batchIntent, requestFactory.getGson().toJson(e));
        }
        return Optional.empty();
    }

    private void filesList(final MethodCall call, final Result result) {
        try {
            // Parameters
            final FilesRequestOptions listOptions = toFilesRequest(call, false);
            // Create comment create request.
            final Drive.Files.List listRequest = requestFactory.buildRequest(FilesRequestType.LIST, listOptions,
                Drive.Files.List.class, null, null, null);
            // Run on background and handle Flutter result.
            requestFactory.runTaskOnBackground(result, FileList.class, listRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".list"));
        } catch (final IOException e) {
            // Error to Flutter
            DriveUtils.defaultErrorHandler(result, "List files error: " + e.getMessage());
        }
    }

    public Optional<Drive.Files.List> filesList(final Map<String, Object> args) {
        try {
            // Parameters
            final FilesRequestOptions listOptions = toFilesRequest(requestFactory.getGson().toJson(args));
            // Create comment create request.
            final Drive.Files.List listRequest = requestFactory.buildRequest(FilesRequestType.LIST, listOptions,
                Drive.Files.List.class, null, null, null);

            return Optional.of(listRequest);
        } catch (final IOException e) {
            DriveUtils.errorHandler(context, batchIntent, requestFactory.getGson().toJson(e));
        }
        return Optional.empty();
    }

    private void filesUpdate(final MethodCall call, final Result result) {
        try {
            // Parameters
            final Drive.Files.Update updateRequest;
            final java.io.File ioFile;
            final AbstractInputStreamContent fileContent;
            final File file = toFile(call);
            requestFactory.setExtraParams(file, call);
            final FilesRequestOptions updateOptions = toFilesRequest(call, true);
            boolean isDirectUpload = false;

            // Creating request
            if (call.argument("fileContent") != null) {
                final Map<String, Object> content = call.argument("fileContent");
                if (Objects.requireNonNull(content).get("path") != null) {
                    ioFile = new java.io.File(ValueGetter.getString("path", content));
                    fileContent = new FileContent(ValueGetter.getString("type", content), ioFile);
                    // Create comment create request.
                    updateRequest = requestFactory.buildRequest(FilesRequestType.UPDATE, updateOptions,
                        Drive.Files.Update.class, file, fileContent, null);
                    // Directly upload the file if it is smaller than 20 MB.
                    if (ioFile.length() < DIRECT_UPLOAD_MAX_SIZE) {
                        isDirectUpload = true;
                    }
                    setDirectUpload(isDirectUpload, updateRequest, file.getFileName());

                } else if (content.get("byteArray") != null) {
                    fileContent = new ByteArrayContent(ValueGetter.getString("type", content),
                        ValueGetter.arrayListToByteArray(ValueGetter.toIntegerList("byteArray", content)));
                    // Create comment create request.
                    updateRequest = requestFactory.buildRequest(FilesRequestType.UPDATE, updateOptions,
                        Drive.Files.Update.class, file, fileContent, null);
                    // Directly upload the file if it is smaller than 20 MB.
                    if (fileContent.getLength() < DIRECT_UPLOAD_MAX_SIZE) {
                        isDirectUpload = true;
                    }
                    setDirectUpload(isDirectUpload, updateRequest, file.getFileName());
                } else {
                    Log.e(TAG, "Please provide path as String or content as byte array.", null);
                    return;
                }
            } else {
                // Create comment create request.
                updateRequest = requestFactory.buildRequest(FilesRequestType.UPDATE, updateOptions,
                    Drive.Files.Update.class, file, null, null);
            }
            // Run on background and handle Flutter result.
            requestFactory.runTaskOnBackground(result, File.class, updateRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".update"));
        } catch (final IOException e) {
            // Error to Flutter
            DriveUtils.defaultErrorHandler(result, "Update file error: " + e.getMessage());
        }
    }

    public Optional<Drive.Files.Update> filesUpdate(final Map<String, Object> args) {
        try {
            // Parameters
            final Drive.Files.Update updateRequest;
            final File file = toFile(requestFactory.getGson().toJson(args.get("file")));
            final FilesRequestOptions updateOptions = toFilesRequest(requestFactory.getGson().toJson(args));

            // Creating request
            if (args.get("fileContent") != null) {
                DriveUtils.errorHandler(context, batchIntent, "Batching media requests is not supported");
                return Optional.empty();
            } else {
                // Create comment create request.
                updateRequest = requestFactory.buildRequest(FilesRequestType.UPDATE, updateOptions,
                    Drive.Files.Update.class, file, null, null);
                return Optional.of(updateRequest);
            }
        } catch (final IOException e) {
            DriveUtils.errorHandler(context, batchIntent, requestFactory.getGson().toJson(e));
        }
        return Optional.empty();
    }

    private void filesSubscribe(final MethodCall call, final Result result) {
        try {
            // Creating request
            final Channel channel = toChannel(call);
            requestFactory.setExtraParams(channel, call);
            // Parameters
            final FilesRequestOptions subscribeOptions = toFilesRequest(call, true);
            // Create comment create request.
            final Drive.Files.Subscribe subscribeRequest = requestFactory.buildRequest(FilesRequestType.SUBSCRIBE,
                subscribeOptions, Drive.Files.Subscribe.class, null, null, channel);
            // Run on background and handle Flutter result.
            requestFactory.runTaskOnBackground(result, Channel.class, subscribeRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".subscribe"));
        } catch (final IOException e) {
            // Error to Flutter
            DriveUtils.defaultErrorHandler(result, "Subscribe file error: " + e.getMessage());
        }
    }

    public Optional<Drive.Files.Subscribe> filesSubscribe(final Map<String, Object> args) {
        try {
            // Creating request
            final Channel channel = toChannel(requestFactory.getGson().toJson(args.get("channel")));
            // Parameters
            final FilesRequestOptions subscribeOptions = toFilesRequest(requestFactory.getGson().toJson(args));
            // Create comment create request.
            final Drive.Files.Subscribe subscribeRequest = requestFactory.buildRequest(FilesRequestType.SUBSCRIBE,
                subscribeOptions, Drive.Files.Subscribe.class, null, null, channel);

            return Optional.of(subscribeRequest);
        } catch (final IOException e) {
            DriveUtils.errorHandler(context, batchIntent, requestFactory.getGson().toJson(e));
        }
        return Optional.empty();
    }

    private void filesExecuteContent(final MethodCall call, final Result result) {
        final String methodName = "Files.executeContent";
        CommonTaskManager.execute(new Task() {
            @Override
            public void call() {
                try {
                    // Parameters
                    final FilesRequestOptions executeContentOptions = toFilesRequest(call, false);
                    // Create comment create request.
                    final Drive.Files.Get executeContentRequest = requestFactory.buildRequest(FilesRequestType.GET,
                        executeContentOptions, Drive.Files.Get.class, null, null, null);

                    // Request execution
                    final HttpResponse response = executeContentRequest.executeContent();

                    if (response.isSuccessStatusCode()) {
                        // Response to Flutter
                        final JSONObject obj = new JSONObject();
                        obj.put("content", DriveUtils.convertBytesToList(IOUtils.toByteArray(response.getContent())));
                        obj.put("contentEncoding", response.getContentEncoding());
                        obj.put("contentLoggingLimit", response.getContentLoggingLimit());
                        obj.put("contentType", response.getContentType());
                        DriveUtils.successHandler(result, obj.toString());
                        hmsLogger.sendSingleEvent(methodName);
                    } else {
                        // Error to Flutter
                        DriveUtils.defaultErrorHandler(result, response.getStatusMessage());
                        hmsLogger.sendSingleEvent(methodName, UNKNOWN_ERROR);
                    }

                } catch (final IOException | JSONException e) {
                    // Error to Flutter
                    DriveUtils.defaultErrorHandler(result, "File - ExecuteContent error: " + e.getMessage());
                    hmsLogger.sendSingleEvent(methodName, UNKNOWN_ERROR);
                }
            }
        });
    }

    private void filesExecuteContentAsInputStream(final MethodCall call, final Result result) {
        final String methodName = "Files.executeContentAsInputStream";
        CommonTaskManager.execute(new Task() {
            @Override
            public void call() {
                try {
                    // Parameters
                    final FilesRequestOptions executeContentAsInputStreamOptions = toFilesRequest(call, false);
                    // Create comment create request.
                    final Drive.Files.Get executeContentAsInputStreamRequest = requestFactory.buildRequest(
                        FilesRequestType.GET, executeContentAsInputStreamOptions, Drive.Files.Get.class, null, null,
                        null);

                    // Request execution
                    final InputStream response = executeContentAsInputStreamRequest.executeContentAsInputStream();

                    // Response to Flutter
                    DriveUtils.byteArraySuccessHandler(result, IOUtils.toByteArray(response));
                    hmsLogger.sendSingleEvent(methodName);
                } catch (final IOException e) {
                    // Error to Flutter
                    DriveUtils.defaultErrorHandler(result,
                        "File - ExecuteContentAsInputStream error: " + e.getMessage());
                    hmsLogger.sendSingleEvent(methodName, UNKNOWN_ERROR);
                }
            }
        });
    }

    private void filesExecuteContentAndDownloadTo(final MethodCall call, final Result result) {
        final String methodName = "Files.executeContentAndDownloadTo";
        CommonTaskManager.execute(new Task() {
            @Override
            public void call() {
                FileOutputStream stream = null;
                try {
                    boolean isDirectDownload = false;
                    // Parameters
                    final FilesRequestOptions executeContentAndDownloadToOptions = toFilesRequest(call, true);
                    // Create comment create request.
                    final Drive.Files.Get executeContentAndDownloadToRequest = requestFactory.buildRequest(
                        FilesRequestType.GET, executeContentAndDownloadToOptions, Drive.Files.Get.class, null, null,
                        null);

                    final long size = getFileSize(executeContentAndDownloadToRequest.getFileId());
                    final String filePath = ValueGetter.getString("path", call);
                    if (DriveUtils.isNotNullAndEmpty(filePath)) {
                        // Request execution
                        final java.io.File ioFile = new java.io.File(filePath);
                        final long currentFileLength = ioFile.length();

                        // Check if file has already been downloaded, and directly return in this case
                        if (currentFileLength == size) {
                            DriveUtils.booleanSuccessHandler(result, true);
                            hmsLogger.sendSingleEvent(methodName);
                            return;
                        }
                        stream = new FileOutputStream(ioFile, true);
                        if (size < DIRECT_DOWNLOAD_MAX_SIZE) {
                            isDirectDownload = true;
                        }
                        setDirectDownload(isDirectDownload, executeContentAndDownloadToRequest, ioFile.getName(), currentFileLength, size);
                        executeContentAndDownloadToRequest.executeContentAndDownloadTo(stream);

                        final HashMap<String, Object> map = new HashMap<>();
                        map.put("fileName", ioFile.getName());
                        map.put("progress", executeContentAndDownloadToRequest.getMediaHttpDownloader().getProgress());
                        map.put("state", executeContentAndDownloadToRequest.getMediaHttpDownloader().getDownloadState().toString());
                        progressIntent.putExtra("progress", map);
                        map.put("totalTimeElapsed", executeContentAndDownloadToRequest.getMediaHttpDownloader().getTotalTimeRequired());
                        LocalBrdMnger.getInstance(context).sendBroadcast(progressIntent);

                        DriveUtils.booleanSuccessHandler(result, true);
                        hmsLogger.sendSingleEvent(methodName);
                    } else {
                        DriveUtils.defaultErrorHandler(result, "getExecuteContentAndDownloadTo failed, Please specify a file path.");
                        hmsLogger.sendSingleEvent(methodName, UNKNOWN_ERROR);
                    }
                } catch (final IOException e) {
                    // Error to Flutter
                    DriveUtils.defaultErrorHandler(result, "File - ExecuteContentAndDownloadTo error: " + e.getMessage());
                    hmsLogger.sendSingleEvent(methodName, UNKNOWN_ERROR);
                } finally {
                    if (stream != null) {
                        try {
                            stream.close();
                        } catch (IOException e) {
                            Log.e(TAG, "Close FileOutputStream error" + e.toString());
                        }
                    }
                }
            }
        });
    }

}

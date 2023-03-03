/*
 * Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.modeling3d.reconstruct3d;

import android.app.Activity;
import android.os.Handler;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.modeling3d.utils.HMSLogger;
import com.huawei.hms.flutter.modeling3d.utils.ObjectMapper;
import com.huawei.hms.flutter.modeling3d.utils.ValueGetter;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructDownloadConfig;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructDownloadListener;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructDownloadResult;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructEngine;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructInitResult;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructPreviewConfig;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructPreviewListener;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructSetting;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructUploadListener;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructUploadResult;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers;
import io.reactivex.rxjava3.core.Observable;
import io.reactivex.rxjava3.core.ObservableOnSubscribe;
import io.reactivex.rxjava3.core.Observer;
import io.reactivex.rxjava3.disposables.Disposable;
import io.reactivex.rxjava3.schedulers.Schedulers;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

public final class Modeling3DEngineHandler implements MethodChannel.MethodCallHandler {
    private static final String DOTTING_TAG = "Modeling3DEngine.";
    private final Activity activity;
    private final MethodChannel methodChannel;

    public Modeling3DEngineHandler(Activity activity, MethodChannel methodChannel) {
        this.activity = activity;
        this.methodChannel = methodChannel;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(activity).startMethodExecutionTimer(DOTTING_TAG + call.method);
        switch (call.method) {
            case "initTask": {
                final int faceLevel = Objects.requireNonNull(call.argument("faceLevel"));
                final String needRescan = Objects.requireNonNull(call.argument("needRescan"));
                final int reconstructMode = Objects.requireNonNull(call.argument("reconstructMode"));
                final String taskId = Objects.requireNonNull(call.argument("taskId"));
                final int taskType = Objects.requireNonNull(call.argument("taskType"));
                final int textureMode = Objects.requireNonNull(call.argument("textureMode"));

                final Modeling3dReconstructSetting setting = new Modeling3dReconstructSetting.Factory()
                        .setFaceLevel(faceLevel)
                        .setNeedRescan(needRescan)
                        .setReconstructMode(reconstructMode)
                        .setTaskId(taskId)
                        .setTaskType(taskType)
                        .setTextureMode(textureMode)
                        .create();

                Observable.create((ObservableOnSubscribe<Modeling3dReconstructInitResult>) subscriber -> {
                            final Modeling3dReconstructInitResult initResult = Modeling3dReconstructEngine.getInstance(activity).initTask(setting);
                            subscriber.onNext(initResult);
                            subscriber.onComplete();
                        })
                        .subscribeOn(Schedulers.io())
                        .observeOn(AndroidSchedulers.mainThread())
                        .subscribe(new Observer<Modeling3dReconstructInitResult>() {
                            @Override
                            public void onError(@NonNull Throwable e) {
                                HMSLogger.getInstance(activity).sendSingleEvent(DOTTING_TAG + "initTask", "-1");
                                result.error("-1", "Error while initializing the Modeling3dReconstructEngine.", null);
                            }

                            @Override
                            public void onComplete() {
                                // Complete initialization.
                                HMSLogger.getInstance(activity).sendSingleEvent(DOTTING_TAG + "initTask");
                            }

                            @Override
                            public void onSubscribe(@NonNull Disposable d) {
                                // Subscribed.
                            }

                            @Override
                            public void onNext(@NonNull Modeling3dReconstructInitResult initResult) {
                                result.success(ObjectMapper.toMap(initResult));
                            }
                        });
                break;
            }
            case "close": {
                Modeling3dReconstructEngine.getInstance(activity).close();
                HMSLogger.getInstance(activity).sendSingleEvent(DOTTING_TAG + "close");
                result.success(true);
                break;
            }
            case "uploadFile": {
                final String taskId = Objects.requireNonNull(call.argument("taskId"));
                final String filePath = Objects.requireNonNull(call.argument("filePath"));
                Modeling3dReconstructEngine.getInstance(activity).uploadFile(taskId, filePath);
                HMSLogger.getInstance(activity).sendSingleEvent(DOTTING_TAG + "uploadFile");
                result.success(true);
                break;
            }
            case "cancelUpload": {
                final String taskId = Objects.requireNonNull(call.argument("taskId"));
                final int cancelUploadResult = Modeling3dReconstructEngine.getInstance(activity).cancelUpload(taskId);
                HMSLogger.getInstance(activity).sendSingleEvent(DOTTING_TAG + "cancelUpload");
                result.success(cancelUploadResult);
                break;
            }
            case "downloadModel": {
                final String taskId = Objects.requireNonNull(call.argument("taskId"));
                final String fileSavePath = ValueGetter.getString("fileSavePath", call);
                Modeling3dReconstructEngine.getInstance(activity).downloadModel(taskId, fileSavePath);
                HMSLogger.getInstance(activity).sendSingleEvent(DOTTING_TAG + "downloadModel");
                result.success(true);
                break;
            }
            case "downloadModelWithConfig": {
                final String taskId = Objects.requireNonNull(call.argument("taskId"));
                final String fileSavePath = Objects.requireNonNull(call.argument("fileSavePath"));
                final Map<String, Object> downloadConfigMap = Objects.requireNonNull(call.argument("downloadConfig"));

                final String modelFormat = (String) Objects.requireNonNull(downloadConfigMap.get("modelFormat"));
                final int textureMode = (int) Objects.requireNonNull(downloadConfigMap.get("textureMode"));

                final Modeling3dReconstructDownloadConfig config = new Modeling3dReconstructDownloadConfig.Factory()
                        .setModelFormat(modelFormat)
                        .setTextureMode(textureMode)
                        .create();
                Modeling3dReconstructEngine.getInstance(activity).downloadModelWithConfig(taskId, fileSavePath, config);
                HMSLogger.getInstance(activity).sendSingleEvent(DOTTING_TAG + "downloadModelWithConfig");
                result.success(true);
                break;
            }
            case "cancelDownload": {
                final String taskId = Objects.requireNonNull(call.argument("taskId"));
                final int cancelDownloadResult = Modeling3dReconstructEngine.getInstance(activity).cancelDownload(taskId);
                HMSLogger.getInstance(activity).sendSingleEvent(DOTTING_TAG + "cancelDownload");
                result.success(cancelDownloadResult);
                break;
            }
            case "previewModel": {
                final String taskId = Objects.requireNonNull(call.argument("taskId"));
                Modeling3dReconstructEngine.getInstance(activity).previewModel(taskId, activity, previewListener);
                HMSLogger.getInstance(activity).sendSingleEvent(DOTTING_TAG + "previewModel");
                result.success(true);
                break;
            }
            case "previewModelWithConfig": {
                final String taskId = Objects.requireNonNull(call.argument("taskId"));
                final Map<String, Object> previewConfigMap = Objects.requireNonNull(call.argument("previewConfig"));

                final int textureMode = (int) Objects.requireNonNull(previewConfigMap.get("textureMode"));

                final Modeling3dReconstructPreviewConfig config = new Modeling3dReconstructPreviewConfig.Factory()
                        .setTextureMode(textureMode)
                        .create();
                Modeling3dReconstructEngine.getInstance(activity).previewModelWithConfig(taskId, activity, config, previewListener);
                HMSLogger.getInstance(activity).sendSingleEvent(DOTTING_TAG + "previewModelWithConfig");
                result.success(true);
                break;
            }
            case "setReconstructUploadListener": {
                Modeling3dReconstructEngine.getInstance(activity).setReconstructUploadListener(uploadListener);
                HMSLogger.getInstance(activity).sendSingleEvent(DOTTING_TAG + "setReconstructUploadListener");
                result.success(true);
                break;
            }
            case "setReconstructDownloadListener": {
                Modeling3dReconstructEngine.getInstance(activity).setReconstructDownloadListener(downloadListener);
                HMSLogger.getInstance(activity).sendSingleEvent(DOTTING_TAG + "setReconstructDownloadListener");
                result.success(true);
                break;
            }
            default:
                result.notImplemented();
        }
    }

    private final Modeling3dReconstructUploadListener uploadListener = new Modeling3dReconstructUploadListener() {
        @Override
        public void onUploadProgress(String taskId, double progress, Object ext) {
            new Handler(activity.getMainLooper()).post(() -> methodChannel.invokeMethod("uploadListener#OnProgress", ObjectMapper.toProgressMap(taskId, progress)));
        }

        @Override
        public void onResult(String taskId, Modeling3dReconstructUploadResult uploadResult, Object ext) {
            final Map<String, Object> map = new HashMap<>();
            map.put("taskId", taskId);
            map.put("uploadResult", ObjectMapper.toMap(uploadResult));
            new Handler(activity.getMainLooper()).post(() -> methodChannel.invokeMethod("uploadListener#OnResult", map));
        }

        @Override
        public void onError(String taskId, int errorCode, String errorMessage) {
            new Handler(activity.getMainLooper()).post(() -> methodChannel.invokeMethod("uploadListener#OnError", ObjectMapper.toErrorMap(taskId, errorCode, errorMessage)));
        }
    };

    private final Modeling3dReconstructDownloadListener downloadListener = new Modeling3dReconstructDownloadListener() {
        @Override
        public void onDownloadProgress(String taskId, double progress, Object ext) {
            new Handler(activity.getMainLooper()).post(() -> methodChannel.invokeMethod("downloadListener#OnProgress", ObjectMapper.toProgressMap(taskId, progress)));
        }

        @Override
        public void onResult(String taskId, Modeling3dReconstructDownloadResult downloadResult, Object o) {
            final Map<String, Object> map = new HashMap<>();
            map.put("taskId", taskId);
            map.put("downloadResult", ObjectMapper.toMap(downloadResult));
            new Handler(activity.getMainLooper()).post(() -> methodChannel.invokeMethod("downloadListener#OnResult", map));
        }

        @Override
        public void onError(String taskId, int errorCode, String errorMessage) {
            new Handler(activity.getMainLooper()).post(() -> methodChannel.invokeMethod("downloadListener#OnError", ObjectMapper.toErrorMap(taskId, errorCode, errorMessage)));
        }
    };

    private final Modeling3dReconstructPreviewListener previewListener = new Modeling3dReconstructPreviewListener() {
        @Override
        public void onResult(String taskId, Object ext) {
            new Handler(activity.getMainLooper()).post(() -> methodChannel.invokeMethod("previewListener#OnResult", taskId));
        }

        @Override
        public void onError(String taskId, int errorCode, String errorMessage) {
            new Handler(activity.getMainLooper()).post(() -> methodChannel.invokeMethod("previewListener#OnError", ObjectMapper.toErrorMap(taskId, errorCode, errorMessage)));
        }
    };
}

/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.modeling3d.reconstruct3d;

import android.content.Context;
import android.os.Handler;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.modeling3d.utils.Constants;
import com.huawei.hms.flutter.modeling3d.utils.Constants.Modeling3DEngineMethods;
import com.huawei.hms.flutter.modeling3d.utils.HMSLogger;
import com.huawei.hms.flutter.modeling3d.utils.ObjectMapper;
import com.huawei.hms.flutter.modeling3d.utils.ValueGetter;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructDownloadListener;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructDownloadResult;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructEngine;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructInitResult;
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

public final class Modeling3DEngineHandler implements MethodChannel.MethodCallHandler {

    private static final String DOTTING_TAG = "Modeling3DEngine.";

    private final Context context;

    private Modeling3dReconstructEngine modeling3dReconstructEngine;

    private final MethodChannel engineMethodChannel;

    private final HMSLogger hmsLogger;

    public Modeling3DEngineHandler(Context context, MethodChannel modeling3dEngineMethodChannel) {
        this.context = context;
        this.engineMethodChannel = modeling3dEngineMethodChannel;
        hmsLogger = HMSLogger.getInstance(context);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        hmsLogger.startMethodExecutionTimer(DOTTING_TAG + call.method);
        switch (Modeling3DEngineMethods.getEnum(call.method)) {
            case GET_INSTANCE:
                modeling3dReconstructEngine = Modeling3dReconstructEngine.getInstance(context);
                hmsLogger.sendSingleEvent(DOTTING_TAG + Modeling3DEngineMethods.GET_INSTANCE.getMethodName());
                result.success(true);
                break;
            case INIT_TASK:
                int reconstructMode = ValueGetter.getInteger("reconstructMode", call);
                Observable.create((ObservableOnSubscribe<Modeling3dReconstructInitResult>) subscriber -> {
                    Modeling3dReconstructSetting setting1
                        = new Modeling3dReconstructSetting.Factory().setReconstructMode(reconstructMode).create();
                    Modeling3dReconstructInitResult magic3dReconstructInitResult = modeling3dReconstructEngine.initTask(
                        setting1);
                    subscriber.onNext(magic3dReconstructInitResult);
                    subscriber.onComplete();
                })
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribe(new Observer<Modeling3dReconstructInitResult>() {
                        @Override
                        public void onError(@NonNull Throwable e) {
                            hmsLogger.sendSingleEvent(DOTTING_TAG + Modeling3DEngineMethods.INIT_TASK.getMethodName(),
                                Constants.ERROR_CODE);
                            result.error(Constants.ERROR_CODE,
                                "Error while initializing the Modeling3dReconstructEngine.", null);
                        }

                        @Override
                        public void onComplete() {
                            // Complete initialization.
                            hmsLogger.sendSingleEvent(DOTTING_TAG + Modeling3DEngineMethods.INIT_TASK.getMethodName());
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
            case CLOSE:
                modeling3dReconstructEngine.close();
                hmsLogger.sendSingleEvent(DOTTING_TAG + Modeling3DEngineMethods.CLOSE.getMethodName());
                result.success(true);
                break;
            case UPLOAD_FILE:
                String taskId = ValueGetter.getString("taskId", call);
                String filePath = ValueGetter.getString("filePath", call);
                modeling3dReconstructEngine.uploadFile(taskId, filePath);
                hmsLogger.sendSingleEvent(DOTTING_TAG + Modeling3DEngineMethods.UPLOAD_FILE.getMethodName());
                result.success(true);
                break;
            case CANCEL_UPLOAD:
                taskId = ValueGetter.getString("taskId", call);
                int cancelUploadResult = modeling3dReconstructEngine.cancelUpload(taskId);
                hmsLogger.sendSingleEvent(DOTTING_TAG + Modeling3DEngineMethods.CANCEL_UPLOAD.getMethodName());
                result.success(cancelUploadResult);
                break;
            case DOWNLOAD_MODEL:
                taskId = ValueGetter.getString("taskId", call);
                String fileSavePath = ValueGetter.getString("fileSavePath", call);
                modeling3dReconstructEngine.downloadModel(taskId, fileSavePath);
                hmsLogger.sendSingleEvent(DOTTING_TAG + Modeling3DEngineMethods.DOWNLOAD_MODEL.getMethodName());
                result.success(true);
                break;
            case CANCEL_DOWNLOAD:
                taskId = ValueGetter.getString("taskId", call);
                int cancelDownloadResult = modeling3dReconstructEngine.cancelDownload(taskId);
                hmsLogger.sendSingleEvent(DOTTING_TAG + Modeling3DEngineMethods.CANCEL_DOWNLOAD.getMethodName());
                result.success(cancelDownloadResult);
                break;
            case PREVIEW_MODEL:
                taskId = ValueGetter.getString("taskId", call);
                modeling3dReconstructEngine.previewModel(taskId, context, previewListener);
                hmsLogger.sendSingleEvent(DOTTING_TAG + Modeling3DEngineMethods.PREVIEW_MODEL.getMethodName());
                result.success(true);
                break;
            case SET_RECONSTRUCT_UPLOAD_LISTENER:
                modeling3dReconstructEngine.setReconstructUploadListener(uploadListener);
                hmsLogger.sendSingleEvent(
                    DOTTING_TAG + Modeling3DEngineMethods.SET_RECONSTRUCT_UPLOAD_LISTENER.getMethodName());
                result.success(true);
                break;
            case SET_RECONSTRUCT_DOWNLOAD_LISTENER:
                modeling3dReconstructEngine.setReconstructDownloadListener(downloadListener);
                hmsLogger.sendSingleEvent(
                    DOTTING_TAG + Modeling3DEngineMethods.SET_RECONSTRUCT_DOWNLOAD_LISTENER.getMethodName());
                result.success(true);
                break;
            default:
                result.notImplemented();
        }
    }

    private final Modeling3dReconstructUploadListener uploadListener = new Modeling3dReconstructUploadListener() {
        @Override
        public void onUploadProgress(String taskId, double progress, Object ext) {
            new Handler(context.getMainLooper()).post(
                () -> engineMethodChannel.invokeMethod("uploadListener#OnProgress",
                    ObjectMapper.toProgressMap(taskId, progress)));
        }

        @Override
        public void onResult(String taskId, Modeling3dReconstructUploadResult uploadResult, Object ext) {
            HashMap<String, Object> resultMap = new HashMap<>();
            resultMap.put("taskId", taskId);
            resultMap.put("uploadResult", ObjectMapper.toMap(uploadResult));
            new Handler(context.getMainLooper()).post(
                () -> engineMethodChannel.invokeMethod("uploadListener#OnResult", resultMap));
        }

        @Override
        public void onError(String taskId, int errorCode, String errorMessage) {
            new Handler(context.getMainLooper()).post(() -> engineMethodChannel.invokeMethod("uploadListener#OnError",
                ObjectMapper.toErrorMap(taskId, errorCode, errorMessage)));
        }
    };

    private final Modeling3dReconstructDownloadListener downloadListener = new Modeling3dReconstructDownloadListener() {
        @Override
        public void onDownloadProgress(String taskId, double progress, Object ext) {
            new Handler(context.getMainLooper()).post(
                () -> engineMethodChannel.invokeMethod("downloadListener#OnProgress",
                    ObjectMapper.toProgressMap(taskId, progress)));
        }

        @Override
        public void onResult(String taskId, Modeling3dReconstructDownloadResult downloadResult, Object o) {
            HashMap<String, Object> resultMap = new HashMap<>();
            resultMap.put("taskId", taskId);
            resultMap.put("downloadResult", ObjectMapper.toMap(downloadResult));
            new Handler(context.getMainLooper()).post(
                () -> engineMethodChannel.invokeMethod("downloadListener#OnResult", resultMap));
        }

        @Override
        public void onError(String taskId, int errorCode, String errorMessage) {
            new Handler(context.getMainLooper()).post(() -> engineMethodChannel.invokeMethod("downloadListener#OnError",
                ObjectMapper.toErrorMap(taskId, errorCode, errorMessage)));
        }
    };

    private final Modeling3dReconstructPreviewListener previewListener = new Modeling3dReconstructPreviewListener() {
        @Override
        public void onResult(String taskId, Object ext) {
            new Handler(context.getMainLooper()).post(
                () -> engineMethodChannel.invokeMethod("previewListener#OnResult", taskId));
        }

        @Override
        public void onError(String taskId, int errorCode, String errorMessage) {
            new Handler(context.getMainLooper()).post(() -> engineMethodChannel.invokeMethod("previewListener#OnError",
                ObjectMapper.toErrorMap(taskId, errorCode, errorMessage)));
        }
    };

}

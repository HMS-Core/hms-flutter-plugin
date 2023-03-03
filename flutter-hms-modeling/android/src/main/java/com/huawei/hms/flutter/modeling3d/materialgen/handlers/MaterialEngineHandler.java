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

package com.huawei.hms.flutter.modeling3d.materialgen.handlers;

import android.app.Activity;
import android.os.Handler;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.modeling3d.materialgen.listeners.TextureDownloadListenerImpl;
import com.huawei.hms.flutter.modeling3d.materialgen.listeners.TextureUploadListenerImpl;
import com.huawei.hms.flutter.modeling3d.utils.FromMap;
import com.huawei.hms.flutter.modeling3d.utils.HMSLogger;
import com.huawei.hms.flutter.modeling3d.utils.ToMap;
import com.huawei.hms.materialgeneratesdk.cloud.Modeling3dTextureEngine;
import com.huawei.hms.materialgeneratesdk.cloud.Modeling3dTextureInitResult;
import com.huawei.hms.materialgeneratesdk.cloud.Modeling3dTexturePreviewListener;
import com.huawei.hms.materialgeneratesdk.cloud.Modeling3dTextureSetting;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers;
import io.reactivex.rxjava3.core.Observable;
import io.reactivex.rxjava3.core.ObservableOnSubscribe;
import io.reactivex.rxjava3.core.Observer;
import io.reactivex.rxjava3.disposables.Disposable;
import io.reactivex.rxjava3.schedulers.Schedulers;

public class MaterialEngineHandler implements MethodChannel.MethodCallHandler {
    private final String TAG = MaterialEngineHandler.class.getSimpleName();
    private final Activity activity;
    private final MethodChannel methodChannel;

    private TextureUploadListenerImpl uploadListener;
    private TextureDownloadListenerImpl downloadListener;

    public MaterialEngineHandler(Activity activity, MethodChannel methodChannel) {
        this.activity = activity;
        this.methodChannel = methodChannel;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(activity).startMethodExecutionTimer("#materialGen-" + call.method);
        switch (call.method) {
            case "initTask":
                initTask(call, result);
                break;
            case "upload":
                uploadFiles(call, result);
                break;
            case "download":
                downloadFiles(call, result);
                break;
            case "previewTexture":
                previewModel(call, result);
                break;
            case "syncGenerateTexture":
                syncGenerate(call, result);
                break;
            case "cancelUpload":
                cancelUpload(call, result);
                break;
            case "cancelDownload":
                cancelDownload(call, result);
                break;
            case "close":
                close(result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void close(MethodChannel.Result result) {
        Modeling3dTextureEngine.getInstance(activity).close();
        HMSLogger.getInstance(activity).sendSingleEvent("#materialGen-close");
        result.success(true);
    }

    private void cancelUpload(MethodCall call, MethodChannel.Result result) {
        final String taskId = Objects.requireNonNull(call.argument("taskId"));
        final int res = Modeling3dTextureEngine.getInstance(activity).cancelUpload(taskId);
        HMSLogger.getInstance(activity).sendSingleEvent("#materialGen-cancelUpload");
        result.success(res);
    }

    private void cancelDownload(MethodCall call, MethodChannel.Result result) {
        final String taskId = Objects.requireNonNull(call.argument("taskId"));
        final int res = Modeling3dTextureEngine.getInstance(activity).cancelDownload(taskId);
        HMSLogger.getInstance(activity).sendSingleEvent("#materialGen-cancelDownload");
        result.success(res);
    }

    private void syncGenerate(MethodCall call, MethodChannel.Result result) {
        final String filePath = Objects.requireNonNull(call.argument("filePath"));
        final String fileSavePath = Objects.requireNonNull(call.argument("fileSavePath"));
        final Map<String, Object> settingMap = Objects.requireNonNull(call.argument("setting"));
        final Integer textureMode = (Integer) Objects.requireNonNull(settingMap.get("textureMode"));

        final Modeling3dTextureSetting setting = new Modeling3dTextureSetting.Factory().setTextureMode(textureMode).create();

        Observable.create((ObservableOnSubscribe<Integer>) subscriber -> {
            final int res = Modeling3dTextureEngine.getInstance(activity).syncGenerateTexture(filePath, fileSavePath, setting);
            subscriber.onNext(res);
            subscriber.onComplete();
        }).subscribeOn(Schedulers.io()).observeOn(AndroidSchedulers.mainThread()).subscribe(new Observer<Integer>() {
            @Override
            public void onSubscribe(@NonNull Disposable d) {

            }

            @Override
            public void onNext(@NonNull Integer integer) {
                HMSLogger.getInstance(activity).sendSingleEvent("#materialGen-syncGenerate");
                result.success(integer);
            }

            @Override
            public void onError(@NonNull Throwable e) {
                HMSLogger.getInstance(activity).sendSingleEvent("#materialGen-syncGenerate", "-1");
                result.error(TAG, e.getMessage(), "");
            }

            @Override
            public void onComplete() {

            }
        });
    }

    private void initTask(MethodCall call, MethodChannel.Result result) {
        final Integer textureMode = Objects.requireNonNull(call.argument("textureMode"));
        final Modeling3dTextureSetting setting = new Modeling3dTextureSetting.Factory().setTextureMode(textureMode).create();

        Observable.create((ObservableOnSubscribe<Modeling3dTextureInitResult>) subscriber -> {
            final Modeling3dTextureInitResult modeling3dTextureInitResult = Modeling3dTextureEngine.getInstance(activity).initTask(setting);
            subscriber.onNext(modeling3dTextureInitResult);
            subscriber.onComplete();
        }).subscribeOn(Schedulers.io()).observeOn(AndroidSchedulers.mainThread()).subscribe(new Observer<Modeling3dTextureInitResult>() {
            @Override
            public void onSubscribe(@NonNull Disposable d) {

            }

            @Override
            public void onNext(@NonNull Modeling3dTextureInitResult modeling3dTextureInitResult) {
                HMSLogger.getInstance(activity).sendSingleEvent("#materialGen-initTask");
                result.success(ToMap.textureInitToMap(modeling3dTextureInitResult));
            }

            @Override
            public void onError(@NonNull Throwable e) {
                HMSLogger.getInstance(activity).sendSingleEvent("#materialGen-initTask", "-1");
                result.error(TAG, e.getMessage(), "");
            }

            @Override
            public void onComplete() {

            }
        });
    }

    private void uploadFiles(MethodCall call, MethodChannel.Result result) {
        final String taskId = FromMap.toString("taskId", call.argument("taskId"), false);
        final String filePath = FromMap.toString("filePath", call.argument("filePath"), false);

        if (uploadListener == null) {
            uploadListener = new TextureUploadListenerImpl(activity, methodChannel);
        }
        Modeling3dTextureEngine.getInstance(activity).setTextureUploadListener(uploadListener);
        Modeling3dTextureEngine.getInstance(activity).asyncUploadFile(taskId, filePath);
        result.success(true);
    }

    private void downloadFiles(MethodCall call, MethodChannel.Result result) {
        final String taskId = FromMap.toString("taskId", call.argument("taskId"), false);
        final String filePath = FromMap.toString("filePath", call.argument("filePath"), false);

        if (downloadListener == null) {
            downloadListener = new TextureDownloadListenerImpl(activity, methodChannel);
        }
        Modeling3dTextureEngine.getInstance(activity).setTextureDownloadListener(downloadListener);
        Modeling3dTextureEngine.getInstance(activity).asyncDownloadTexture(taskId, filePath);
        result.success(true);
    }

    private final Modeling3dTexturePreviewListener previewListener = new Modeling3dTexturePreviewListener() {
        @Override
        public void onResult(String s, Object o) {
            final Map<String, Object> args = new HashMap<>();
            args.put("taskId", s);
            args.put("ext", o);
            new Handler(activity.getMainLooper()).post(() -> methodChannel.invokeMethod("texturePreviewResult", args));
        }

        @Override
        public void onError(String s, int i, String s1) {
            final Map<String, Object> args = new HashMap<>();
            args.put("taskId", s);
            args.put("errorCode", i);
            args.put("message", s1);
            new Handler(activity.getMainLooper()).post(() -> methodChannel.invokeMethod("texturePreviewError", args));
        }
    };

    private void previewModel(MethodCall call, MethodChannel.Result result) {
        final String taskId = FromMap.toString("taskId", call.argument("taskId"), false);
        Modeling3dTextureEngine.getInstance(activity).previewTexture(taskId, activity, previewListener);
        result.success(true);
    }
}

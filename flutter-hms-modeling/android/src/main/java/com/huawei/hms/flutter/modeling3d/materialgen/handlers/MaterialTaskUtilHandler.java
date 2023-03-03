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

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.modeling3d.utils.FromMap;
import com.huawei.hms.flutter.modeling3d.utils.HMSLogger;
import com.huawei.hms.flutter.modeling3d.utils.ToMap;
import com.huawei.hms.materialgeneratesdk.cloud.Modeling3dTextureQueryResult;
import com.huawei.hms.materialgeneratesdk.cloud.Modeling3dTextureTaskUtils;

import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers;
import io.reactivex.rxjava3.core.Observable;
import io.reactivex.rxjava3.core.ObservableOnSubscribe;
import io.reactivex.rxjava3.core.Observer;
import io.reactivex.rxjava3.disposables.Disposable;
import io.reactivex.rxjava3.schedulers.Schedulers;

public class MaterialTaskUtilHandler implements MethodChannel.MethodCallHandler {
    private final String TAG = MaterialTaskUtilHandler.class.getSimpleName();
    private final Activity activity;

    private Modeling3dTextureQueryResult modeling3dTextureQueryResult;

    public MaterialTaskUtilHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(activity).startMethodExecutionTimer("#materialTask-" + call.method);
        switch (call.method) {
            case "queryTask":
                performQueryTask(call, result);
                break;
            case "deleteTask":
                performDeleteTask(call, result);
                break;
            case "setTaskRestrictStatus":
                performSetTaskRestrictStatus(call, result);
                break;
            case "queryTaskRestrictStatus":
                performQueryTaskRestrictStatus(call, result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void performQueryTask(MethodCall call, MethodChannel.Result result) {
        final String taskId = FromMap.toString("taskId", call.argument("taskId"), false);

        Observable.create((ObservableOnSubscribe<Modeling3dTextureQueryResult>) subscriber -> {
            modeling3dTextureQueryResult = Modeling3dTextureTaskUtils.getInstance(activity).queryTask(taskId);
            subscriber.onNext(modeling3dTextureQueryResult);
            subscriber.onComplete();
        }).subscribeOn(Schedulers.io()).observeOn(AndroidSchedulers.mainThread()).subscribe(new Observer<Modeling3dTextureQueryResult>() {
            @Override
            public void onSubscribe(@NonNull Disposable d) {

            }

            @Override
            public void onNext(@NonNull Modeling3dTextureQueryResult modeling3dTextureQueryResult) {
                HMSLogger.getInstance(activity).sendSingleEvent("#materialTask-queryTask");
                result.success(ToMap.textureQueryToMap(modeling3dTextureQueryResult));
            }

            @Override
            public void onError(@NonNull Throwable e) {
                HMSLogger.getInstance(activity).sendSingleEvent("#materialTask-queryTask", "-1");
                result.error(TAG, e.getMessage(), "");
            }

            @Override
            public void onComplete() {

            }
        });
    }

    private void performDeleteTask(MethodCall call, MethodChannel.Result result) {
        final String taskId = FromMap.toString("taskId", call.argument("taskId"), false);

        Observable.create((ObservableOnSubscribe<Integer>) subscriber -> {
            final int res = Modeling3dTextureTaskUtils.getInstance(activity).deleteTask(taskId);
            subscriber.onNext(res);
            subscriber.onComplete();
        }).subscribeOn(Schedulers.io()).observeOn(AndroidSchedulers.mainThread()).subscribe(new Observer<Integer>() {
            @Override
            public void onSubscribe(@NonNull Disposable d) {

            }

            @Override
            public void onNext(@NonNull Integer res) {
                if (res == 0 || res == 1) {
                    HMSLogger.getInstance(activity).sendSingleEvent("#materialTask-deleteTask");
                } else {
                    HMSLogger.getInstance(activity).sendSingleEvent("#materialTask-deleteTask", String.valueOf(res));
                }
                result.success(res);
            }

            @Override
            public void onError(@NonNull Throwable e) {
                HMSLogger.getInstance(activity).sendSingleEvent("#materialTask-deleteTask", "-1");
                result.error(TAG, e.getMessage(), "");
            }

            @Override
            public void onComplete() {

            }
        });
    }

    private void performSetTaskRestrictStatus(MethodCall call, MethodChannel.Result result) {
        final String taskId = FromMap.toString("taskId", call.argument("taskId"), false);
        final Integer restrictStatus = Objects.requireNonNull(FromMap.toInteger("restrictStatus", call.argument("restrictStatus")));

        Observable.create((ObservableOnSubscribe<Integer>) subscriber -> {
            final int res = Modeling3dTextureTaskUtils.getInstance(activity).setTaskRestrictStatus(taskId, restrictStatus);
            subscriber.onNext(res);
            subscriber.onComplete();
        }).subscribeOn(Schedulers.io()).observeOn(AndroidSchedulers.mainThread()).subscribe(new Observer<Integer>() {
            @Override
            public void onSubscribe(@NonNull Disposable d) {

            }

            @Override
            public void onNext(@NonNull Integer res) {
                if (res == 0 || res == 1) {
                    HMSLogger.getInstance(activity).sendSingleEvent("#materialTask-setTaskRestrictStatus");
                } else {
                    HMSLogger.getInstance(activity).sendSingleEvent("#materialTask-setTaskRestrictStatus", String.valueOf(res));
                }
                result.success(res);
            }

            @Override
            public void onError(@NonNull Throwable e) {
                HMSLogger.getInstance(activity).sendSingleEvent("#materialTask-setTaskRestrictStatus", "-1");
                result.error(TAG, e.getMessage(), "");
            }

            @Override
            public void onComplete() {

            }
        });
    }

    private void performQueryTaskRestrictStatus(MethodCall call, MethodChannel.Result result) {
        final String taskId = FromMap.toString("taskId", call.argument("taskId"), false);

        Observable.create((ObservableOnSubscribe<Integer>) subscriber -> {
            final int res = Modeling3dTextureTaskUtils.getInstance(activity).queryTaskRestrictStatus(taskId);
            subscriber.onNext(res);
            subscriber.onComplete();
        }).subscribeOn(Schedulers.io()).observeOn(AndroidSchedulers.mainThread()).subscribe(new Observer<Integer>() {
            @Override
            public void onSubscribe(@NonNull Disposable d) {

            }

            @Override
            public void onNext(@NonNull Integer res) {
                if (res == 0 || res == 1) {
                    HMSLogger.getInstance(activity).sendSingleEvent("#materialTask-queryTaskRestrictStatus");
                } else {
                    HMSLogger.getInstance(activity).sendSingleEvent("#materialTask-queryTaskRestrictStatus", String.valueOf(res));
                }
                result.success(res);
            }

            @Override
            public void onError(@NonNull Throwable e) {
                HMSLogger.getInstance(activity).sendSingleEvent("#materialTask-queryTaskRestrictStatus", "-1");
                result.error(TAG, e.getMessage(), "");
            }

            @Override
            public void onComplete() {

            }
        });
    }
}

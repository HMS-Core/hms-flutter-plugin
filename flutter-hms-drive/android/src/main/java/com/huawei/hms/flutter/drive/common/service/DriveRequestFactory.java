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

package com.huawei.hms.flutter.drive.common.service;

import static com.huawei.hms.flutter.drive.common.utils.DriveUtils.isNotNullAndEmpty;

import android.content.Context;
import android.content.Intent;

import com.google.gson.Gson;
import com.huawei.agconnect.LocalBrdMnger;
import com.huawei.cloud.base.json.GenericJson;
import com.huawei.cloud.base.json.gson.GsonFactory;
import com.huawei.cloud.client.task.Task;
import com.huawei.cloud.services.drive.Drive;
import com.huawei.cloud.services.drive.DriveRequest;
import com.huawei.cloud.services.drive.model.File;
import com.huawei.hms.flutter.drive.common.Constants;
import com.huawei.hms.flutter.drive.common.utils.CommonTaskManager;
import com.huawei.hms.flutter.drive.common.utils.DriveUtils;
import com.huawei.hms.flutter.drive.common.utils.HMSLogger;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

public abstract class DriveRequestFactory implements IDriveRequest {
    public Drive getDrive() {
        return drive;
    }

    public Gson getGson() {
        return gson;
    }

    public void setDrive(final Drive drive) {
        this.drive = drive;
    }

    private Drive drive;
    private final Gson gson;
    private HMSLogger hmsLogger;
    private Context context;

    public Context getContext() {
        return context;
    }

    public DriveRequestFactory(final Drive drive, Context context) {
        this.drive = drive;
        this.gson = new Gson();
        this.context = context;
        hmsLogger = HMSLogger.getInstance(context);
    }

    public void setBasicRequestOptions(final DriveRequest<?> request, final DriveRequestOptions requestOptions) {
        if (requestOptions == null) {
            return;
        }
        if (requestOptions.getParameters() != null) {
            for (final Map.Entry<String, Object> paramPair : requestOptions.getParameters().entrySet()) {
                set(request, paramPair.getKey(), paramPair.getValue());
            }
        }
        setFields(request, requestOptions.getFields());
        setForm(request, requestOptions.getForm());
        setPrettyPrint(request, requestOptions.isPrettyPrint());
        setQuotaId(request, requestOptions.getQuotaId());
    }

    @Override
    public void setPrettyPrint(final DriveRequest<?> driveRequest, final Boolean prettyPrint) {
        driveRequest.setPrettyPrint(prettyPrint);
    }

    @Override
    public void setForm(final DriveRequest<?> driveRequest, final String form) {
        if (isNotNullAndEmpty(form)) {
            driveRequest.setForm(form);
        }
    }

    @Override
    public void setFields(final DriveRequest<?> driveRequest, final String fields) {
        if (isNotNullAndEmpty(fields)) {
            driveRequest.setFields(fields);
        }
    }

    @Override
    public void setQuotaId(final DriveRequest<?> driveRequest, final String quotaId) {
        if (isNotNullAndEmpty(quotaId)) {
            driveRequest.setQuotaId(quotaId);
        }
    }

    @Override
    public void set(final DriveRequest<?> driveRequest, final String parameterName, final Object value) {
        if (isNotNullAndEmpty(parameterName) && value != null) {
            driveRequest.set(parameterName, value);
        }
    }

    public <T extends GenericJson> void setExtraParams(T modelObject, final MethodCall call) {
        Map<String, Object> extraParams = call.argument("extraParams");
        if (extraParams != null) {
            for (Map.Entry<String, Object> param : extraParams.entrySet()) {
                modelObject.set(param.getKey(), param.getValue());
            }
        }
    }

    public String toJson(Object object) {
        return gson.toJson(object);
    }

    public Intent newBatchIntent() {
        return new Intent(context.getPackageName() + ".BATCH_ACTION");
    }

    @Override
    public <K> K execute(final DriveRequest<?> driveRequest, final Class<K> type) throws IOException {
        return type.cast(driveRequest.execute());
    }

    public <K> void runTaskOnBackground(final Result result, Class<K> type, DriveRequest<?> request, String serviceName,
        String methodName) {
        CommonTaskManager.execute(new Task() {
            @Override
            public void call() {
                try {
                    if (type.equals(Void.class)) {
                        execute(request, type);
                        DriveUtils.booleanSuccessHandler(result, true);
                    } else {
                        Object executeResult = execute(request, type);
                        DriveUtils.successHandler(result, GsonFactory.getDefaultInstance().toString(executeResult));
                        handleFileUploadDownload(request, executeResult);
                    }
                    hmsLogger.sendSingleEvent(methodName);
                } catch (IOException ex) {
                    DriveUtils.defaultErrorHandler(result, serviceName + " request error: " + ex.toString());
                    hmsLogger.sendSingleEvent(methodName, Constants.UNKNOWN_ERROR);
                }
            }
        });
    }

    private void handleFileUploadDownload(DriveRequest<?> request, Object executeResult) throws IOException {
        if (request instanceof Drive.Files.Create || request instanceof Drive.Files.Update) {
            if (executeResult instanceof File) {
                Intent progressIntent = new Intent(context.getPackageName() + ".PROGRESS_CHANGED");
                final HashMap<String, Object> map = new HashMap<>();
                map.put("fileName", ((File) executeResult).getFileName());
                map.put("progress", request.getMediaHttpUploader().getProgress());
                map.put("totalTimeElapsed", request.getMediaHttpUploader().getTotalTimeRequired());
                map.put("state", request.getMediaHttpUploader().getUploadState().toString());
                progressIntent.putExtra("progress", map);
                LocalBrdMnger.getInstance(context).sendBroadcast(progressIntent);
            }
        }
    }
}

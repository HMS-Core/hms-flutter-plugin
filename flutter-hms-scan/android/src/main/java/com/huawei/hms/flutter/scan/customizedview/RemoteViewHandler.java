/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.scan.customizedview;

import android.widget.ImageView;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.scan.R;
import com.huawei.hms.flutter.scan.logger.HMSLogger;
import com.huawei.hms.flutter.scan.utils.Errors;
import com.huawei.hms.hmsscankit.RemoteView;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class RemoteViewHandler implements MethodChannel.MethodCallHandler {

    private RemoteView remoteView;

    private ImageView flushBtn;

    private HMSLogger mHMSLogger;

    private int[] img = {R.drawable.flashlight_on, R.drawable.flashlight_off};

    RemoteViewHandler(RemoteView mRemoteView, ImageView imageView, HMSLogger logger) {
        remoteView = mRemoteView;
        flushBtn = imageView;
        mHMSLogger = logger;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            // remote view pause
            case "pause":
                mHMSLogger.startMethodExecutionTimer("remoteView.pauseContinuouslyScan");
                if (remoteView != null) {
                    remoteView.pauseContinuouslyScan();
                    mHMSLogger.sendSingleEvent("remoteView.pauseContinuouslyScan");
                } else {
                    result.error(Errors.REMOTE_VIEW_ERROR.getErrorCode(), Errors.REMOTE_VIEW_ERROR.getErrorMessage(), null);
                    mHMSLogger.sendSingleEvent("remoteView.pauseContinuouslyScan",
                        Errors.REMOTE_VIEW_ERROR.getErrorCode());
                }
                break;
            // remote view resume
            case "resume":
                mHMSLogger.startMethodExecutionTimer("remoteView.resumeContinuouslyScan");
                if (remoteView != null) {
                    remoteView.resumeContinuouslyScan();
                    mHMSLogger.sendSingleEvent("remoteView.resumeContinuouslyScan");
                } else {
                    result.error(Errors.REMOTE_VIEW_ERROR.getErrorCode(), Errors.REMOTE_VIEW_ERROR.getErrorMessage(), null);
                    mHMSLogger.sendSingleEvent("remoteView.resumeContinuouslyScan",
                        Errors.REMOTE_VIEW_ERROR.getErrorCode());
                }
                break;
            // Switch light
            case "switchLight":
                mHMSLogger.startMethodExecutionTimer("remoteView.switchLight");
                if (remoteView != null) {
                    remoteView.switchLight();
                    mHMSLogger.sendSingleEvent("remoteView.switchLight");
                    mHMSLogger.startMethodExecutionTimer("remoteView.getLightStatus");
                    boolean lightStatus = remoteView.getLightStatus();
                    mHMSLogger.sendSingleEvent("remoteView.getLightStatus");
                    if (lightStatus) {
                        flushBtn.setImageResource(img[1]);
                    } else {
                        flushBtn.setImageResource(img[0]);
                    }
                } else {
                    result.error(Errors.REMOTE_VIEW_ERROR.getErrorCode(), Errors.REMOTE_VIEW_ERROR.getErrorMessage(), null);
                    mHMSLogger.sendSingleEvent("remoteView.switchLight", Errors.REMOTE_VIEW_ERROR.getErrorCode());
                }
                break;
            // get light status
            case "getLightStatus":
                mHMSLogger.startMethodExecutionTimer("remoteView.getLightStatus");
                if (remoteView != null) {
                    result.success(remoteView.getLightStatus());
                    mHMSLogger.sendSingleEvent("remoteView.getLightStatus");
                } else {
                    result.error(Errors.REMOTE_VIEW_ERROR.getErrorCode(), Errors.REMOTE_VIEW_ERROR.getErrorMessage(), null);
                    mHMSLogger.sendSingleEvent("remoteView.getLightStatus", Errors.REMOTE_VIEW_ERROR.getErrorCode());
                }
                break;
            default:
                result.notImplemented();
                break;
        }
    }
}

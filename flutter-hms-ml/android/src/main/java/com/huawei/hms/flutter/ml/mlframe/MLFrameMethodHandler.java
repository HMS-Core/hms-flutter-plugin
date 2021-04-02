/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.ml.mlframe;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.FrameHolder;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.mlsdk.common.MLFrame;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import static com.huawei.hms.flutter.ml.utils.HmsMlUtils.pathToBase64;

public class MLFrameMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = MLFrameMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;

    private MLFrame mlFrame;

    public MLFrameMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        mlFrame = FrameHolder.getInstance().getFrame();
        switch (call.method) {
            case "getPreviewBitmap":
                getPreviewBitmap0();
                break;
            case "readBitmap":
                readBitmap0();
                break;
            case "rotate":
                rotateFrame(call);
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    private void getPreviewBitmap0() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getPreviewBitmap");
        if (mlFrame == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getPreviewBitmap", MlConstants.NULL_OBJECT);
            mResult.error(TAG, "No frame detected", MlConstants.NULL_OBJECT);
            return;
        }
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getPreviewBitmap");
        mResult.success(HmsMlUtils.saveBitmapAndGetPath(activity.getApplicationContext(), mlFrame.getPreviewBitmap()));
    }

    private void readBitmap0() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("readBitmap");
        if (mlFrame == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("readBitmap", MlConstants.NULL_OBJECT);
            mResult.error(TAG, "No frame detected", MlConstants.NULL_OBJECT);
            return;
        }
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("readBitmap");
        mResult.success(HmsMlUtils.saveBitmapAndGetPath(activity.getApplicationContext(), mlFrame.readBitmap()));
    }

    private void rotateFrame(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("rotateFrame");
        String path = call.argument("path");
        Integer quadrant = call.argument("quadrant");

        final String encodedImage = pathToBase64(path);
        final byte[] decodedString = Base64.decode(encodedImage, Base64.DEFAULT);
        final Bitmap bitmap = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);

        final Bitmap result = MLFrame.rotate(bitmap, quadrant != null ? quadrant : 0);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("rotateFrame");
        mResult.success(HmsMlUtils.saveBitmapAndGetPath(activity.getApplicationContext(), result));
    }
}

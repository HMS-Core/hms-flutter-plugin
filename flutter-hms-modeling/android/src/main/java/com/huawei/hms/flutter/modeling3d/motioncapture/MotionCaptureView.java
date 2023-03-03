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

package com.huawei.hms.flutter.modeling3d.motioncapture;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.ImageFormat;
import android.graphics.Rect;
import android.media.Image;
import android.media.MediaMetadataRetriever;
import android.opengl.GLSurfaceView;
import android.os.Build;
import android.util.Log;
import android.util.SparseArray;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;

import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.modeling3d.helper.BoneGLSurfaceView;
import com.huawei.hms.flutter.modeling3d.helper.MyConfigChooser;
import com.huawei.hms.flutter.modeling3d.utils.Constants;
import com.huawei.hms.flutter.modeling3d.utils.FilterUtils;
import com.huawei.hms.flutter.modeling3d.utils.HMSLogger;
import com.huawei.hms.flutter.modeling3d.utils.ToJson;
import com.huawei.hms.flutter.modeling3d.utils.VideoToFrames;
import com.huawei.hms.motioncapturesdk.Modeling3dFrame;
import com.huawei.hms.motioncapturesdk.Modeling3dMotionCaptureEngine;
import com.huawei.hms.motioncapturesdk.Modeling3dMotionCaptureEngineFactory;
import com.huawei.hms.motioncapturesdk.Modeling3dMotionCaptureEngineSetting;
import com.huawei.hms.motioncapturesdk.Modeling3dMotionCaptureSkeleton;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

public class MotionCaptureView implements PlatformView, VideoToFrames.Callback, MethodChannel.MethodCallHandler {
    private static final String TAG = "MotionCaptureView.";
    private final MethodChannel methodChannel;
    private final Context context;

    private final GLSurfaceView glSurfaceView;
    private final BoneGLSurfaceView boneRenderManager;
    private final MotionCaptureView self = this;

    private final boolean isPhoto;
    private final List<Modeling3dMotionCaptureSkeleton> results = new ArrayList<>();
    private Modeling3dMotionCaptureEngine engine;
    private Modeling3dFrame frame;

    private List<List<List<Float>>> joints3d = new ArrayList<>();
    private List<List<List<Float>>> quaternion = new ArrayList<>();
    private List<List<Float>> shift = new ArrayList<>();

    private VideoToFrames videoToFrames;
    private int index;
    private int rotation;
    private Modeling3dFrame.Property property;
    private MethodChannel.Result result;
    private byte[] imageData;
    private String methodName;

    public MotionCaptureView(BinaryMessenger messenger, Activity activity, int id, Map<String, Object> creationParams) {
        this.context = activity.getApplicationContext();
        methodChannel = new MethodChannel(messenger, Constants.ViewType.VIEW_TYPE + "/" + id);
        methodChannel.setMethodCallHandler(this);
        isPhoto = (Boolean) Objects.requireNonNull(creationParams.get("isPhoto"));
        glSurfaceView = new GLSurfaceView(activity.getApplicationContext());
        boneRenderManager = new BoneGLSurfaceView();
        glSurfaceView.setPreserveEGLContextOnPause(true);
        glSurfaceView.setEGLConfigChooser(new MyConfigChooser());
        glSurfaceView.setEGLContextClientVersion(3);
        glSurfaceView.setRenderer(boneRenderManager);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer(TAG + call.method);
        this.result = result;
        methodName = call.method;
        switch (call.method) {
            case "analyseFrame":
                init(call);
                if (isPhoto) {
                    analyseFrame(result);
                }
                break;
            case "asyncAnalyseFrame":
                init(call);
                if (isPhoto) {
                    asyncAnalyseFrame(result);
                }
                break;
            case "stop":
                stop(call, result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void init(MethodCall call) {
        Modeling3dMotionCaptureEngineSetting setting = new Modeling3dMotionCaptureEngineSetting.Factory()
                .setAnalyzeType(Modeling3dMotionCaptureEngineSetting.TYPE_3DSKELETON_QUATERNION | Modeling3dMotionCaptureEngineSetting.TYPE_3DSKELETON)
                .create();
        engine = Modeling3dMotionCaptureEngineFactory.getInstance().getMotionCaptureEngine(setting);

        String path = Objects.requireNonNull(call.argument("path"));
        if (isPhoto) {
            Bitmap originBitmap = BitmapFactory.decodeFile(path);
            frame = Modeling3dFrame.fromBitmap(originBitmap);
            if (originBitmap == null) {
                return;
            }
        } else {
            rotation = getVideoRotation(path);
            videoToFrames = new VideoToFrames();
            videoToFrames.setCallback(self);
            videoToFrames.decode(path);
        }
    }

    public int getVideoRotation(String path) {
        int rotation = 0;
        MediaMetadataRetriever mediaMetadataRetriever = new MediaMetadataRetriever();
        try {
            mediaMetadataRetriever.setDataSource(path);
            String rotationStr = mediaMetadataRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_VIDEO_ROTATION); // Video rotation direction
            return Integer.parseInt(rotationStr) / 90;
        } catch (Exception ex) {
            Log.e(TAG, ex.getMessage(), ex);
        } finally {
            mediaMetadataRetriever.release();
        }
        return rotation;
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    @Override
    public void getIndexBitmap(Image image, byte[] imageData) {
        this.imageData = imageData;
        Rect crop = image.getCropRect();
        int width = crop.width();
        int height = crop.height();
        property = new Modeling3dFrame.Property.Creator().setFormatType(ImageFormat.NV21)
                .setWidth(width)
                .setHeight(height)
                .setQuadrant(rotation)
                .setItemIdentity(index)
                .create();
        index++;
        switch (methodName) {
            case "analyseFrame":
                analyseFrame(result);
                break;
            case "asyncAnalyseFrame":
                asyncAnalyseFrame(result);
                break;
            default:
                result.notImplemented();
                break;
        }
        image.close();
    }

    public void analyseFrame(MethodChannel.Result result) {
        SparseArray<Modeling3dMotionCaptureSkeleton> data;
        if (isPhoto) {
            data = engine.analyseFrame(frame);
        } else {
            data = engine.analyseFrame(Modeling3dFrame.fromByteArray(imageData, property));
        }
        if (data.size() != 0) {
            for (int i = 0; i < data.size(); i++) {
                int key = data.keyAt(i);
                Modeling3dMotionCaptureSkeleton obj = data.get(key);
                results.add(data.get(i));
                filterData(obj);
            }
            joints3d = new ArrayList<>();
            quaternion = new ArrayList<>();
            shift = new ArrayList<>();
            if (isPhoto) {
                HMSLogger.getInstance(context).sendSingleEvent(TAG + methodName);
                result.success(ToJson.modeling3dMotionCaptureSkeletonListToJSON(results));
            }
        } else {
            Log.i(TAG, "data array is empty");
        }
    }

    private void asyncAnalyseFrame(MethodChannel.Result result) {
        Task<List<Modeling3dMotionCaptureSkeleton>> task;
        if (isPhoto) {
            task = engine.asyncAnalyseFrame(frame);
        } else {
            task = engine.asyncAnalyseFrame(Modeling3dFrame.fromByteArray(imageData, property));
        }
        task.addOnSuccessListener(results -> {
            setResults(results);
            for (int i = 0; i < results.size(); i++) {
                Modeling3dMotionCaptureSkeleton obj = results.get(i);
                filterData(obj);
            }
            joints3d = new ArrayList<>();
            quaternion = new ArrayList<>();
            shift = new ArrayList<>();
            if (isPhoto) {
                HMSLogger.getInstance(context).sendSingleEvent(TAG + methodName);
                result.success(ToJson.modeling3dMotionCaptureSkeletonListToJSON(results));
            }
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(context).sendSingleEvent(TAG + methodName, "-1");
            result.error(TAG, e.getMessage(), "");
        });
    }

    public void filterData(Modeling3dMotionCaptureSkeleton fromData) {
        quaternion.add(FilterUtils.filterDataQuaternions(fromData));
        shift.add(FilterUtils.filterDataJointShift(fromData));
        joints3d.add(FilterUtils.filterDataJoints3ds(fromData));
        boneRenderManager.setData(joints3d.get(joints3d.size() - 1), shift.get(shift.size() - 1));
    }

    private void stop(MethodCall call, MethodChannel.Result result) {
        try {
            engine.stop();
            HMSLogger.getInstance(context).sendSingleEvent(TAG + call.method);
            result.success(true);
        } catch (IOException e) {
            Log.e(TAG, "Exception thrown while trying to close cloud image labeler!", e);
            HMSLogger.getInstance(context).sendSingleEvent(TAG + call.method, "-1");
            result.error(TAG, e.getMessage(), "");
        }
    }

    @Nullable
    @Override
    public View getView() {
        return glSurfaceView;
    }

    @Override
    public void dispose() {
        try {
            if (engine != null) {
                engine.stop();
            }
        } catch (IOException e) {
            Log.e(TAG, "Exception thrown while trying to close cloud image labeler!", e);
        }
        if (videoToFrames != null) {
            videoToFrames.stopDecode();
        }
    }

    @Override
    public void onFinishDecode() {
        HMSLogger.getInstance(context).sendSingleEvent(TAG + methodName);
        result.success(ToJson.modeling3dMotionCaptureSkeletonListToJSON(results));
    }

    public void setResults(List<Modeling3dMotionCaptureSkeleton> results) {
        this.results.addAll(results);
    }
}
/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.nearbyservice.discovery;

import android.content.Context;
import android.util.Log;

import com.huawei.hms.flutter.nearbyservice.logger.HMSLogger;
import com.huawei.hms.flutter.nearbyservice.utils.ToMap;
import com.huawei.hms.flutter.nearbyservice.utils.constants.ErrorCodes;
import com.huawei.hms.nearby.transfer.Data;
import com.huawei.hms.nearby.transfer.DataCallback;
import com.huawei.hms.nearby.transfer.TransferStateUpdate;
import com.huawei.hms.utils.IOUtils;

import io.flutter.plugin.common.EventChannel;

import java.io.IOException;
import java.util.HashMap;

public class DataCallbackStreamHandler extends DataCallback implements EventChannel.StreamHandler {
    private static final String TAG = "DataCallbackHandler";

    private final Context context;

    private EventChannel.EventSink event;

    DataCallbackStreamHandler(Context context) {
        this.context = context;
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink event) {
        this.event = event;
    }

    @Override
    public void onCancel(Object arguments) {
        this.event = null;
    }

    @Override
    public void onReceived(String endpointId, Data data) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("DataCallbackStreamHandler.onReceived");
        Log.i(TAG, "onReceived");
        if (event == null) {
            HMSLogger.getInstance(context)
                .sendSingleEvent("DataCallbackStreamHandler.onReceived", ErrorCodes.ERROR_TRANSFER);
            Log.e(TAG, "onReceived | EventSink is null. You should define a listener for the DataCallbackStream.");
            return;
        }

        HashMap<String, Object> dataMap = new HashMap<>();
        String errorCode = null;
        dataMap.put("type", data.getType());
        dataMap.put("id", data.getId());
        dataMap.put("hash", data.hashCode());
        if (data.getType() == Data.Type.FILE) {
            HashMap<String, Object> fileMap = new HashMap<>();
            fileMap.put("size", data.asFile().getSize());
            fileMap.put("filePath", data.asFile().asJavaFile().toURI().toString());
            dataMap.put("file", fileMap);
        } else if (data.getType() == Data.Type.BYTES) {
            dataMap.put("bytes", data.asBytes());
        } else {
            try {
                HashMap<String, Object> streamMap = new HashMap<>();
                streamMap.put("content", IOUtils.toByteArray(data.asStream().asInputStream()));
                dataMap.put("stream", streamMap);
            } catch (IOException e) {
                HMSLogger.getInstance(context)
                    .sendSingleEvent("DataCallbackStreamHandler.onReceived", ErrorCodes.STREAM_CONVERSION);
                Log.e(TAG, "onReceived | " + e.getMessage());
                errorCode = ErrorCodes.STREAM_CONVERSION;
            }
        }

        event.success(
            ToMap.fromArgs("event", "onReceived", "endpointId", endpointId, "data", dataMap, "errorCode", errorCode));
        HMSLogger.getInstance(context).sendSingleEvent("DataCallbackStreamHandler.onReceived");
    }

    @Override
    public void onTransferUpdate(String endpointId, TransferStateUpdate transferStateUpdate) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("DataCallbackStreamHandler.onTransferUpdate");
        Log.i(TAG, "onTransferUpdate");
        if (event == null) {
            HMSLogger.getInstance(context)
                .sendSingleEvent("DataCallbackStreamHandler.onTransferUpdate", ErrorCodes.ERROR_TRANSFER);
            Log.e(TAG,
                "onTransferUpdate | EventSink is null. You should define a listener for the DataCallbackStream.");
            return;
        }

        HashMap<String, Object> stateUpdate = new HashMap<>();
        stateUpdate.put("endpointId", endpointId);
        stateUpdate.put("bytesTransferred", transferStateUpdate.getBytesTransferred());
        stateUpdate.put("hash", transferStateUpdate.hashCode());
        stateUpdate.put("dataId", transferStateUpdate.getDataId());
        stateUpdate.put("status", transferStateUpdate.getStatus());
        stateUpdate.put("totalBytes", transferStateUpdate.getTotalBytes());

        event.success(
            ToMap.fromArgs("event", "onTransferUpdate", "endpointId", endpointId, "transferStateUpdate", stateUpdate));
        HMSLogger.getInstance(context).sendSingleEvent("DataCallbackStreamHandler.onTransferUpdate");
    }
}

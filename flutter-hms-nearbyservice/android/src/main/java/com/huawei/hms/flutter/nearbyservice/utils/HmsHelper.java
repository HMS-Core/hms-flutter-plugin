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

package com.huawei.hms.flutter.nearbyservice.utils;

import android.content.ContentResolver;
import android.net.Uri;
import android.os.Handler;
import android.os.Looper;
import android.os.ParcelFileDescriptor;
import android.util.Log;

import com.huawei.hms.flutter.nearbyservice.message.HmsPendingGetCallback;
import com.huawei.hms.flutter.nearbyservice.message.MessageEngineStreamHandler;
import com.huawei.hms.nearby.discovery.BroadcastOption;
import com.huawei.hms.nearby.discovery.ChannelPolicy;
import com.huawei.hms.nearby.discovery.Policy;
import com.huawei.hms.nearby.discovery.ScanOption;
import com.huawei.hms.nearby.message.GetOption;
import com.huawei.hms.nearby.message.Message;
import com.huawei.hms.nearby.message.MessagePicker;
import com.huawei.hms.nearby.message.PutOption;
import com.huawei.hms.nearby.transfer.Data;

import io.flutter.plugin.common.MethodChannel;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class HmsHelper {

    private static final String TAG = "HmsHelper";

    public static BroadcastOption createBroadcastOption(Map<String, Object> policyMap) {
        BroadcastOption.Builder builder = new BroadcastOption.Builder();
        builder.setPolicy(getPolicy(policyMap));
        Log.i(TAG, "BroadcastOption.Builder | set policy");
        return builder.build();
    }

    public static ScanOption createScanOption(Map<String, Object> policyMap) {
        ScanOption.Builder builder = new ScanOption.Builder();
        builder.setPolicy(getPolicy(policyMap));
        Log.i(TAG, "ScanOption.Builder | set policy");
        return builder.build();
    }

    public static Message createMessage(Map<String, Object> messageMap) {
        if (messageMap.isEmpty()) {
            Log.e(TAG, "createMessage | Message is null or empty.");
            return null;
        }

        byte[] content = FromMap.toByteArray("content", messageMap.get("content"));

        String type = FromMap.toString("type", messageMap.get("type"), true);
        String namespace = FromMap.toString("namespace", messageMap.get("namespace"), true);
        if (namespace != null && type != null) {
            return new Message(content, type, namespace);
        } else if (namespace == null && type == null) {
            Log.i(TAG, "createMessage | No namespace or type detected.");
            return new Message(content);
        } else if (namespace == null) {
            Log.i(TAG, "createMessage | No namespace detected.");
            return new Message(content, type);
        } else {
            Log.e(TAG, "createMessage | Type is null.");
            return null;
        }
    }

    public static PutOption createPutOption(Map<String, Object> optionMap, MessageEngineStreamHandler streamHandler) {
        PutOption.Builder builder = new PutOption.Builder();
        Integer id = FromMap.toInteger("putCallback", optionMap.get("putCallback"));
        if (id != null) {
            Log.i(TAG, "createPutOption | set putCallback.");
            builder.setCallback(streamHandler.createPutCallback(id));
        } else {
            Log.w(TAG, "createPutOption | putCallback is null.");
        }

        com.huawei.hms.nearby.message.Policy policy = HmsHelper.getMessagePolicy(
            ToMap.fromObject(optionMap.get("policy")));
        builder.setPolicy(policy);
        Log.i(TAG, "createPutOption | set policy.");
        return builder.build();
    }

    public static GetOption createGetOption(Map<String, Object> optionMap, MessageEngineStreamHandler streamHandler) {
        GetOption.Builder builder = new GetOption.Builder();
        Integer id = FromMap.toInteger("getCallback", optionMap.get("getCallback"));
        if (id != null) {
            Log.i(TAG, "HmsHelper createGetOption | set getCallback.");
            builder.setCallback(streamHandler.createGetCallback(id));
        } else {
            Log.w(TAG, "HmsHelper createGetOption | getCallback is null.");
        }

        MessagePicker picker = createMessagePicker(ToMap.fromObject(optionMap.get("messagePicker")));
        if (picker == null) {
            Log.w(TAG, "HmsHelper createGetOption | Message picker is null.");
        } else {
            builder.setPicker(picker);
        }

        com.huawei.hms.nearby.message.Policy policy = HmsHelper.getMessagePolicy(
            ToMap.fromObject(optionMap.get("policy")));
        builder.setPolicy(policy);
        Log.i(TAG, "HmsHelper createGetOption | set policy.");
        return builder.build();
    }

    public static GetOption createGetOption(Map<String, Object> optionMap, HmsPendingGetCallback callback) {
        GetOption.Builder builder = new GetOption.Builder();

        builder.setCallback(callback);

        MessagePicker picker = createMessagePicker(ToMap.fromObject(optionMap.get("messagePicker")));
        if (picker == null) {
            Log.w(TAG, "createGetOption | Message picker is null.");
        } else {
            builder.setPicker(picker);
        }

        com.huawei.hms.nearby.message.Policy policy = HmsHelper.getMessagePolicy(
            ToMap.fromObject(optionMap.get("policy")));
        builder.setPolicy(policy);
        Log.i(TAG, "createGetOption | set policy.");
        return builder.build();
    }

    private static MessagePicker createMessagePicker(Map<String, Object> pickerMap) {
        MessagePicker.Builder builder = new MessagePicker.Builder();
        if (pickerMap.isEmpty()) {
            Log.w(TAG, "createMessagePicker | MessagePicker is null.");
            return null;
        }

        Boolean includeAllTypes = FromMap.toBoolean("includeAllTypes", pickerMap.get("includeAllTypes"));
        if (includeAllTypes) {
            Log.i(TAG, "createMessagePicker | includeAllTypes");
            builder.includeAllTypes();
        }

        if (pickerMap.containsKey("iBeaconIds")) {
            List<Map<String, Object>> iBeaconMapList = FromMap.toMapArrayList("iBeaconIds",
                pickerMap.get("iBeaconIds"));
            for (Map<String, Object> el : iBeaconMapList) {
                String uuid = FromMap.toString("uuid", el.get("uuid"), true);
                Short major = FromMap.toShort("major", el.get("major"));
                Short minor = FromMap.toShort("minor", el.get("minor"));
                if (uuid == null) {
                    Log.w(TAG, "createMessagePicker | Null value provided for uuid. Skipping...");
                    continue;
                }
                try {
                    builder.includeIBeaconIds(UUID.fromString(uuid), major, minor);
                } catch (IllegalArgumentException ex) {
                    Log.e(TAG, "createMessagePicker | " + ex.getMessage());
                }
            }
        }

        if (pickerMap.containsKey("eddystoneUids")) {
            List<Map<String, Object>> eddystoneMapList = FromMap.toMapArrayList("eddystoneUids",
                pickerMap.get("eddystoneUids"));
            for (Map<String, Object> el : eddystoneMapList) {
                String uid = FromMap.toString("uid", el.get("uid"), true);
                String instance = FromMap.toString("instance", el.get("instance"), false);
                if (uid == null) {
                    Log.w(TAG, "createMessagePicker | Null value provided for hex namespace (uid). Skipping...");
                    continue;
                }
                builder.includeEddystoneUids(uid, instance);
            }
        }

        if (pickerMap.containsKey("namespaceTypes")) {
            List<Map<String, Object>> namespaceMapList = FromMap.toMapArrayList("namespaceTypes",
                pickerMap.get("namespaceTypes"));
            for (Map<String, Object> el : namespaceMapList) {
                String namespace = FromMap.toString("namespace", el.get("namespace"), true);
                String type = FromMap.toString("type", el.get("type"), true);
                if (namespace == null || type == null) {
                    Log.w(TAG, "createMessagePicker | Null value provided for namespace or type. Skipping...");
                    continue;
                }
                builder.includeNamespaceType(namespace, type);
            }
        }

        return builder.build();
    }

    private static com.huawei.hms.nearby.message.Policy getMessagePolicy(Map<String, Object> policyMap) {
        if (policyMap.isEmpty()) {
            Log.e(TAG, "getMessagePolicy | MessagePolicy is null or empty. Returning DEFAULT.");
            return com.huawei.hms.nearby.message.Policy.DEFAULT;
        }

        com.huawei.hms.nearby.message.Policy.Builder builder = new com.huawei.hms.nearby.message.Policy.Builder();
        Integer findingMode = FromMap.toInteger("findingMode", policyMap.get("findingMode"));
        if (findingMode != null) {
            Log.i(TAG, "Policy.Builder setFindingMode");
            builder.setFindingMode(findingMode);
        }

        Integer ttlSeconds = FromMap.toInteger("ttlSeconds", policyMap.get("ttlSeconds"));
        if (ttlSeconds != null) {
            Log.i(TAG, "Policy.Builder setTtlSeconds");
            builder.setTtlSeconds(ttlSeconds);
        }

        Integer distanceType = FromMap.toInteger("distanceType", policyMap.get("distanceType"));
        if (distanceType != null) {
            Log.i(TAG, "Policy.Builder setDistanceType");
            builder.setDistanceType(distanceType);
        }
        return builder.build();
    }

    private static Policy getPolicy(Map<String, Object> policyMap) {
        Policy policy = Policy.POLICY_MESH;

        if (policyMap.isEmpty()) {
            Log.e(TAG, "getPolicy | Policy is null or empty. Returning POLICY_MESH as default.");
            return policy;
        }

        Integer topology = FromMap.toInteger("topology", policyMap.get("topology"));
        if (topology == null) {
            Log.w(TAG, "getPolicy | Policy topology is null. Returning POLICY_MESH as default.");
            return policy;
        }

        switch (topology) {
            case 1:
                policy = Policy.POLICY_MESH;
                break;
            case 2:
                policy = Policy.POLICY_P2P;
                break;
            case 3:
                policy = Policy.POLICY_STAR;
                break;
            default:
                Log.w(TAG, "Unknown policy.");
                break;
        }

        return policy;
    }

    public static Data parseData(Map<String, Object> dataMap, int type, boolean isUri,
        ContentResolver contentResolver) {
        Data data;
        Long id = FromMap.toLong("id", dataMap.get("id"));
        if (id == null) {
            Log.w(TAG, "parseData | Data id is null. Generating random UUID.");
        }

        switch (type) {
            case Data.Type.BYTES:
                data = parseBytes(id, dataMap);
                break;
            case Data.Type.FILE:
                data = parseFile(id, dataMap, isUri, contentResolver);
                break;
            case Data.Type.STREAM:
                data = parseStream(id, dataMap, isUri, contentResolver);
                break;
            default:
                Log.e(TAG, "parseData | Unknown data type.");
                return null;
        }

        return data;
    }

    private static Data parseBytes(Long id, Map<String, Object> dataMap) {
        byte[] bytes = FromMap.toByteArray("bytes", dataMap.get("bytes"));
        if (bytes.length == 0) {
            Log.e(TAG, "parseBytes | Byte data is null or empty.");
            return null;
        }

        if (id != null) {
            return Data.a(bytes, id);
        } else {
            return Data.fromBytes(bytes);
        }
    }

    private static Data parseFile(Long id, Map<String, Object> dataMap, boolean isUri,
        ContentResolver contentResolver) {
        Map<String, Object> fileMap = ToMap.fromObject(dataMap.get("file"));
        Data data = null;
        if (fileMap.isEmpty()) {
            Log.e(TAG, "parseFile | TransferDataFile is null.");
            return null;
        }

        String filePath = FromMap.toString("filePath", fileMap.get("filePath"), false);
        if (filePath == null) {
            Log.e(TAG, "parseFile | File uri is null or empty.");
            return null;
        }

        try {
            if (isUri) {
                ParcelFileDescriptor pfd = contentResolver.openFileDescriptor(Uri.parse(filePath), "r");
                data = Data.fromFile(pfd);
            } else {
                data = Data.fromFile(new File(filePath));
            }

            if (id != null) {
                data = Data.a(data.asFile(), id);
            }
        } catch (FileNotFoundException e) {
            Log.e(TAG, "parseFile | " + e.getMessage());
        }
        return data;
    }

    private static Data parseStream(Long id, Map<String, Object> dataMap, boolean isUri,
        ContentResolver contentResolver) {
        Map<String, Object> streamMap = ToMap.fromObject(dataMap.get("stream"));
        Data data = null;
        if (streamMap.isEmpty()) {
            Log.e(TAG, "parseStream | TransferDataStream is null.");
            return null;
        }

        String paramUrl = FromMap.toString("url", streamMap.get("url"), false);
        try {
            if (paramUrl != null) {
                if (isUri) {
                    ParcelFileDescriptor pfd = contentResolver.openFileDescriptor(Uri.parse(paramUrl), "r");
                    if (id != null) {
                        data = Data.a(Data.Stream.a(pfd), id);
                    } else {
                        data = Data.fromStream(pfd);
                    }
                } else {
                    URL url = new URL(paramUrl);
                    InputStream stream = url.openStream();
                    if (id != null) {
                        data = Data.a(Data.Stream.a(stream), id);
                    } else {
                        data = Data.fromStream(stream);
                    }
                }
            } else {
                Log.i(TAG, "parseStream | No url is specified, proceeding to transfer stream content instead.");
                byte[] content = FromMap.toByteArray("content", streamMap.get("content"));

                InputStream stream = new ByteArrayInputStream(content);
                if (id != null) {
                    data = Data.a(Data.Stream.a(stream), id);
                } else {
                    data = Data.fromStream(stream);
                }
            }
        } catch (IOException e) {
            Log.e(TAG, "parseStream | " + e.getMessage());
        }
        return data;
    }

    public static ChannelPolicy getChannelPolicyByNumber(int channelPolicyNumber) {
        if (channelPolicyNumber == 1) {
            return ChannelPolicy.CHANNEL_AUTO;
        } else if (channelPolicyNumber == 2) {
            return ChannelPolicy.CHANNEL_HIGH_THROUGHPUT;
        } else if (channelPolicyNumber == 3) {
            return ChannelPolicy.CHANNEL_INSTANCE;
        } else {
            return null;
        }
    }

    public static int getChannelPolicyNumber(ChannelPolicy channelPolicy) {
        if (channelPolicy.equals(ChannelPolicy.CHANNEL_AUTO)) {
            return 1;
        } else if (channelPolicy.equals(ChannelPolicy.CHANNEL_HIGH_THROUGHPUT)) {
            return 2;
        } else if (channelPolicy.equals(ChannelPolicy.CHANNEL_INSTANCE)) {
            return 3;
        } else {
            return -1;
        }
    }

    public static void errorHandler(MethodChannel.Result result, String errorCode, String errorMessage,
        String errorDetails) {
        new Handler(Looper.getMainLooper()).post(() -> result.error(errorCode, errorMessage, ""));
    }

    public static void successHandler(MethodChannel.Result result) {
        new Handler(Looper.getMainLooper()).post(() -> result.success(null));
    }
}

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

package com.huawei.hms.flutter.health.modules.blecontroller.utils;

import static com.huawei.hms.flutter.health.modules.blecontroller.utils.BleControllerConstants.AVAILABLE_PROFILES_KEY;
import static com.huawei.hms.flutter.health.modules.blecontroller.utils.BleControllerConstants.DATA_TYPES_KEY;
import static com.huawei.hms.flutter.health.modules.blecontroller.utils.BleControllerConstants.DEVICE_ADDRESS_KEY;
import static com.huawei.hms.flutter.health.modules.blecontroller.utils.BleControllerConstants.DEVICE_NAME_KEY;

import com.huawei.hms.flutter.health.foundation.utils.Utils;
import com.huawei.hms.flutter.health.modules.activityrecord.utils.ActivityRecordUtils;
import com.huawei.hms.hihealth.data.BleDeviceInfo;
import com.huawei.hms.hihealth.data.DataType;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public final class BleControllerUtils {
    private BleControllerUtils() {
    }

    public static synchronized List<Map<String, Object>> bleDeviceInfoListToMap(List<BleDeviceInfo> bleDeviceInfoList) {
        List<Map<String, Object>> resultMap = new ArrayList<>();
        for (BleDeviceInfo bleDeviceInfo : bleDeviceInfoList) {
            resultMap.add(bleDeviceInfoToMap(bleDeviceInfo));
        }
        return resultMap;
    }

    public static synchronized Map<String, Object> bleDeviceInfoToMap(BleDeviceInfo bleDeviceInfo) {
        HashMap<String, Object> bleMap = new HashMap<>();
        bleMap.put(DEVICE_NAME_KEY, bleDeviceInfo.getDeviceName());
        bleMap.put(DEVICE_ADDRESS_KEY, bleDeviceInfo.getDeviceAddress());
        bleMap.put(AVAILABLE_PROFILES_KEY, bleDeviceInfo.getAvailableProfiles());
        List<Map<String, Object>> dataTypeList = new ArrayList<>();
        List<DataType> dataTypes = bleDeviceInfo.getDataTypes();
        for (DataType dataType : dataTypes) {
            dataTypeList.add(ActivityRecordUtils.dataTypeToMap(dataType));
        }
        bleMap.put(DATA_TYPES_KEY, dataTypeList);
        return bleMap;
    }

    public static BleDeviceInfo toBleDeviceInfo(Map<String, Object> bleDeviceInfoMap, String packageName) {
        BleDeviceInfo bleDeviceInfo = new BleDeviceInfo();
        bleDeviceInfo.setDeviceName((String) bleDeviceInfoMap.get(DEVICE_NAME_KEY));
        bleDeviceInfo.setDeviceAddress((String) bleDeviceInfoMap.get(DEVICE_ADDRESS_KEY));
        List<String> profiles = (List<String>) bleDeviceInfoMap.get(AVAILABLE_PROFILES_KEY);
        bleDeviceInfo.setAvailableProfiles(profiles);
        List<DataType> dataTypes = new ArrayList<>();
        List<Map<String, Object>> dataTypesMap = (List<Map<String, Object>>) bleDeviceInfoMap.get(DATA_TYPES_KEY);
        if (dataTypesMap != null) {
            for (Map<String, Object> dataTypeMap : dataTypesMap) {
                dataTypes.add(Utils.toDataType(dataTypeMap, packageName));
            }
            bleDeviceInfo.setDataTypes(dataTypes);
        }
        return bleDeviceInfo;
    }
}

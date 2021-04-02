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

import 'dart:ui';

import 'package:huawei_health/huawei_health.dart';
import 'package:huawei_health/src/hihealth/data/data_type.dart';
import 'package:huawei_health/src/hihealth/util/util.dart';

/// Describes the BLE device information.
///
/// Includes the supported GATT protocols, supported [DataType]s device address,
/// and device name.
class BleDeviceInfo {
  String deviceName;
  String deviceAddress;
  List<DataType> dataTypes;

  /// GATT protocol information.
  List<String> availableProfiles;

  BleDeviceInfo(
      {this.deviceName,
      this.deviceAddress,
      this.dataTypes,
      this.availableProfiles});

  Map<String, dynamic> toMap() {
    return {
      "deviceName": deviceName,
      "deviceAddress": deviceAddress,
      "dataTypes": dataTypes != null
          ? List<Map<String, dynamic>>.from(dataTypes.map((e) => e.toMap()))
          : null,
      "availableProfiles": availableProfiles
    }..removeWhere((k, v) => v == null);
  }

  @override
  String toString() {
    return toMap().toString();
  }

  factory BleDeviceInfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return BleDeviceInfo(
      deviceName: map['deviceName'] != null ? map['deviceName'] : null,
      deviceAddress: map['deviceAddress'] != null ? map['deviceAddress'] : null,
      availableProfiles: map['availableProfiles'] != null
          ? List<String>.from(map['availableProfiles'])
          : null,
      dataTypes: map['dataTypes'] != null
          ? List.from(map['dataTypes']
              .map((e) => DataType.fromMap(Map<String, dynamic>.from(e))))
          : null,
    );
  }

  int compareTo(BleDeviceInfo bleDeviceInfo) =>
      deviceAddress.compareTo(bleDeviceInfo.deviceAddress);

  @override
  bool operator ==(Object other) {
    if (!isTypeEqual(this, other)) return false;
    BleDeviceInfo compare = other;
    List<dynamic> currentArgs = [
      deviceName,
      deviceAddress,
      dataTypes,
      availableProfiles
    ];
    List<dynamic> otherArgs = [
      compare.deviceAddress,
      compare.deviceAddress,
      compare.dataTypes,
      compare.availableProfiles,
    ];
    return isEquals(this, other, currentArgs, otherArgs);
  }

  @override
  int get hashCode => hashValues(deviceName, deviceAddress, hashList(dataTypes),
      hashList(availableProfiles));
}

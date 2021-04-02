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

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:huawei_health/huawei_health.dart';
import 'package:huawei_health/src/hihealth/data/ble_device_info.dart';
import 'package:huawei_health/src/hihealth/data/data_type.dart';

/// Used for scanning and using BLE devices.
///
/// Device information scanning and saving are supported.
class BleController {
  static const MethodChannel _channel = health_ble_controller_method_channel;
  static const EventChannel _eventChannel = health_ble_controller_event_channel;

  /// Starts the scanning for available Bluetooth devices.
  ///
  /// Each time a device is found the [BleDeviceInfo] for that device will be emitted
  /// to the [bleScanStream]. The scan will be finished after the specified [timeoutSecs]
  /// is reached or the [endScan] method is called.
  /// A device can be scanned if it matches any of the types in the passed [dataTypes] list.
  /// For details about the protocols the devices that can be scanned should comply with,
  /// please see the [Bluetooth Standards](https://www.bluetooth.com/specifications/assigned-numbers/).
  ///
  /// Before starting the scanning, ensure that the following conditions are met:
  /// * The HMS Core (APK) has obtained the Bluetooth and location authorization.
  /// * The app has obtained the Bluetooth and location authorization.
  /// * The app has obtained the authorization from HUAWEI Developers.
  /// * The Bluetooth and location features are enabled on the phone.
  static Future<void> beginScan(
    List<DataType> dataTypes,
    int timeoutSecs,
  ) async {
    _channel.invokeMethod('beginScan', {
      "dataTypes":
          List<Map<String, dynamic>>.from(dataTypes.map((e) => e.toMap())),
      "timeoutSecs": timeoutSecs
    });
  }

  /// The getter for the stream that emits the [BleDeviceInfo] of the discovered
  /// BLE devices with the [beginScan] method.
  static Stream<BleDeviceInfo> get bleScanStream => _eventChannel
      .receiveBroadcastStream()
      .map((event) => event = BleDeviceInfo.fromMap(jsonDecode(event)))
      .cast<BleDeviceInfo>();

  /// Stops the current scanning.
  static Future<bool> endScan() async {
    return await _channel.invokeMethod('endScan');
  }

  /// Associates the device with the current user using the device information and saves the device.
  static Future<void> saveDeviceByInfo(BleDeviceInfo bleDeviceInfo) async {
    await _channel.invokeMethod('saveDeviceByInfo', bleDeviceInfo.toMap());
  }

  /// Associates the device with the current user using the device address and saves the device.
  static Future<void> saveDeviceByAddress(String deviceAddress) async {
    await _channel.invokeMethod('saveDeviceByAddress', deviceAddress);
  }

  /// Obtains all saved devices.
  static Future<List<BleDeviceInfo>> getSavedDevices() async {
    final List result = await _channel.invokeMethod('getSavedDevices');
    List<BleDeviceInfo> bleDevices = <BleDeviceInfo>[];
    for (var e in result) {
      bleDevices.add(BleDeviceInfo.fromMap(Map<String, dynamic>.from(e)));
    }
    return bleDevices;
  }

  /// Deletes the device that has been saved by passing the device information.
  static Future<void> deleteDeviceByInfo(BleDeviceInfo bleDeviceInfo) async {
    await _channel.invokeMethod('deleteDeviceByInfo', bleDeviceInfo.toMap());
  }

  /// Deletes the device that has been saved by passing the device address.
  static Future<void> deleteDeviceByAddress(String deviceAddress) async {
    await _channel.invokeMethod('deleteDeviceByAddress', deviceAddress);
  }
}

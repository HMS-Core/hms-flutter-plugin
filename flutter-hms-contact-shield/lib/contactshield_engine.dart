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
import 'package:huawei_contactshield/models/daily_sketch.dart';

import 'constants/contactshield_status.dart';
import 'contactshield_callback.dart';
import 'models/contact_detail.dart';
import 'models/contact_sketch.dart';
import 'models/contact_window.dart';
import 'models/daily_sketch_configuration.dart';
import 'models/diagnosis_configuration.dart';
import 'models/periodic_key.dart';
import 'models/shared_keys_data_mapping.dart';

class ContactShieldEngine {
  static const int DEFAULT_INCUBATION_PERIOD = 14;
  static const String TOKEN_A = 'TOKEN_WINDOW_MODE';

  static ContactShieldEngine _instance;
  final MethodChannel _channel;

  ContactShieldCallback contactShieldCallback;

  ContactShieldEngine._create(this._channel) {
    _channel.setMethodCallHandler(_methodCallHandler);
  }

  factory ContactShieldEngine() {
    if (_instance == null) {
      _instance = ContactShieldEngine._create(
        const MethodChannel(
            'com.huawei.hms.flutter.contactshield_MethodChannel'),
      );
    }
    return _instance;
  }

  Future<void> _methodCallHandler(MethodCall methodCall) async {
    if (contactShieldCallback != null) {
      final String token = methodCall.arguments;
      switch (methodCall.method) {
        case _Method._ON_HAS_CONTACT:
          contactShieldCallback.onHasContact(token);
          break;
        case _Method._ON_NO_CONTACT:
          contactShieldCallback.onNoContact(token);
          break;
        default:
          break;
      }
    }
  }

  Future<bool> isContactShieldRunning() async {
    return await _channel
        .invokeMethod<bool>(_Method._IS_CONTACT_SHIELD_RUNNING);
  }

  @deprecated
  Future<void> startContactShieldCb(
      [int incubationPeriod = DEFAULT_INCUBATION_PERIOD]) async {
    return await _channel.invokeMethod<void>(
        _Method._START_CONTACT_SHIELD_CB, incubationPeriod);
  }

  Future<void> startContactShield(
      [int incubationPeriod = DEFAULT_INCUBATION_PERIOD]) async {
    return await _channel.invokeMethod<void>(
        _Method._START_CONTACT_SHIELD, incubationPeriod);
  }

  Future<void> startContactShieldNonPersistent(
      [int incubationPeriod = DEFAULT_INCUBATION_PERIOD]) async {
    return await _channel.invokeMethod<void>(
        _Method._START_CONTACT_SHIELD_NON_PERSISTENT, incubationPeriod);
  }

  Future<List<PeriodicKey>> getPeriodicKey() async {
    final String response =
        await _channel.invokeMethod<String>(_Method._GET_PERIODIC_KEY);
    final List<dynamic> items = json.decode(response);
    return List<PeriodicKey>.from(items.map((i) => PeriodicKey.fromMap(i)));
  }

  @deprecated
  Future<void> putSharedKeyFiles(List<String> filePaths,
      DiagnosisConfiguration config, String token) async {
    final Map<String, dynamic> args = <String, dynamic>{
      'filePaths': filePaths,
      'diagnosisConfiguration': config.toJson(),
      'token': token,
    };
    return await _channel.invokeMethod<void>(
        _Method._PUT_SHARED_KEY_FILES, args);
  }

  Future<void> putSharedKeyFilesCb(List<String> filePaths,
      DiagnosisConfiguration config, String token) async {
    final Map<String, dynamic> args = <String, dynamic>{
      'filePaths': filePaths,
      'diagnosisConfiguration': config.toJson(),
      'token': token,
    };
    return await _channel.invokeMethod<void>(
        _Method._PUT_SHARED_KEY_FILES_CB, args);
  }

  Future<void> putSharedKeyFilesCbWithProvider(List<String> filePaths) async {
    return await _channel.invokeMethod<void>(
        _Method._PUT_SHARED_KEY_FILES_CB_WITH_PROVIDER,
        <String, dynamic>{'filePaths': filePaths});
  }

  Future<void> putSharedKeyFilesCbWithKeys(
    List<String> filePaths,
    List<String> publicKeys,
    DiagnosisConfiguration config,
    String token,
  ) async {
    final Map<String, dynamic> args = <String, dynamic>{
      'filePaths': filePaths,
      'publicKeys': publicKeys,
      'diagnosisConfiguration': config.toJson(),
      'token': token,
    };
    return await _channel.invokeMethod<void>(
        _Method._PUT_SHARED_KEY_FILES_CB_WITH_KEYS, args);
  }

  @deprecated
  Future<List<ContactDetail>> getContactDetail(String token) async {
    final String response =
        await _channel.invokeMethod<String>(_Method._GET_CONTACT_DETAIL, token);
    final List<dynamic> items = json.decode(response);
    return List<ContactDetail>.from(items.map((i) => ContactDetail.fromMap(i)));
  }

  Future<ContactSketch> getContactSketch(String token) async {
    final String response =
        await _channel.invokeMethod<String>(_Method._GET_CONTACT_SKETCH, token);
    return ContactSketch.fromJson(response);
  }

  Future<List<ContactWindow>> getContactWindow([String token = TOKEN_A]) async {
    final String response =
        await _channel.invokeMethod<String>(_Method._GET_CONTACT_WINDOW, token);
    final List<dynamic> items = json.decode(response);
    return List<ContactWindow>.from(items.map((i) => ContactWindow.fromMap(i)));
  }

  Future<void> setSharedKeysDataMapping(
      SharedKeysDataMapping sharedKeysDataMapping) async {
    return await _channel.invokeMethod<void>(
        _Method._SET_SHARED_KEYS_DATA_MAPPING, sharedKeysDataMapping.toJson());
  }

  Future<SharedKeysDataMapping> getSharedKeysDataMapping() async {
    final String response = await _channel
        .invokeMethod<String>(_Method._GET_SHARED_KEYS_DATA_MAPPING);
    return SharedKeysDataMapping.fromJson(response);
  }

  Future<List<DailySketch>> getDailySketch(
      DailySketchConfiguration config) async {
    final String response = await _channel.invokeMethod<String>(
        _Method._GET_DAILY_SKETCH, config.toJson());
    final List<dynamic> items = json.decode(response);
    return List<DailySketch>.from(items.map((i) => DailySketch.fromMap(i)));
  }

  Future<int> getContactShieldVersion() async {
    return await _channel
        .invokeMethod<int>(_Method._GET_CONTACT_SHIELD_VERSION);
  }

  Future<int> getDeviceCalibrationConfidence() async {
    return await _channel
        .invokeMethod<int>(_Method._GET_DEVICE_CALIBRATION_CONFIDENCE);
  }

  Future<bool> isSupportScanningWithoutLocation() async {
    return await _channel
        .invokeMethod<bool>(_Method._IS_SUPPORT_SCANNING_WITHOUT_LOCATION);
  }

  Future<Set<ContactShieldStatus>> getStatus() async {
    final String response =
        await _channel.invokeMethod<String>(_Method._GET_STATUS);
    final List<dynamic> items = json.decode(response);
    return Set<ContactShieldStatus>.from(
        items.map((i) => ContactShieldStatus.fromText(i)));
  }

  Future<void> clearData() async {
    return await _channel.invokeMethod<void>(_Method._CLEAR_DATA);
  }

  Future<void> stopContactShield() async {
    return await _channel.invokeMethod<void>(_Method._STOP_CONTACT_SHIELD);
  }

  Future<void> enableLogger() async {
    return await _channel.invokeMethod<void>(_Method._ENABLE_LOGGER);
  }

  Future<void> disableLogger() async {
    return await _channel.invokeMethod<void>(_Method._DISABLE_LOGGER);
  }
}

class _Method {
  static const String _GET_CONTACT_DETAIL = "getContactDetail";
  static const String _GET_CONTACT_SKETCH = "getContactSketch";
  static const String _GET_CONTACT_WINDOW = "getContactWindow";
  static const String _GET_PERIODIC_KEY = "getPeriodicKey";
  static const String _IS_CONTACT_SHIELD_RUNNING = "isContactShieldRunning";
  static const String _PUT_SHARED_KEY_FILES = "putSharedKeyFiles";
  static const String _PUT_SHARED_KEY_FILES_CB = "putSharedKeyFilesCb";
  static const String _PUT_SHARED_KEY_FILES_CB_WITH_PROVIDER =
      "putSharedKeyFilesCbWithProvider";
  static const String _PUT_SHARED_KEY_FILES_CB_WITH_KEYS =
      "putSharedKeyFilesCbWithKeys";
  static const String _SET_SHARED_KEYS_DATA_MAPPING =
      "setSharedKeysDataMapping";
  static const String _GET_SHARED_KEYS_DATA_MAPPING =
      "getSharedKeysDataMapping";
  static const String _GET_DAILY_SKETCH = "getDailySketch";
  static const String _START_CONTACT_SHIELD_CB = "startContactShieldCb";
  static const String _START_CONTACT_SHIELD = "startContactShield";
  static const String _START_CONTACT_SHIELD_NON_PERSISTENT =
      "startContactShieldNonPersistent";
  static const String _STOP_CONTACT_SHIELD = "stopContactShield";
  static const String _ON_HAS_CONTACT = "onHasContact";
  static const String _ON_NO_CONTACT = "onNoContact";
  static const String _GET_CONTACT_SHIELD_VERSION = "getContactShieldVersion";
  static const String _GET_DEVICE_CALIBRATION_CONFIDENCE =
      "getDeviceCalibrationConfidence";
  static const String _IS_SUPPORT_SCANNING_WITHOUT_LOCATION =
      "isSupportScanningWithoutLocation";
  static const String _GET_STATUS = "getStatus";
  static const String _CLEAR_DATA = "clearData";
  static const String _ENABLE_LOGGER = "enableLogger";
  static const String _DISABLE_LOGGER = "disableLogger";
}

/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'contactshield_callback.dart';

import 'models/contact_detail.dart';
import 'models/contact_sketch.dart';
import 'models/contact_window.dart';
import 'models/diagnosis_configuration.dart';
import 'models/periodic_key.dart';

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
        case Method._ON_HAS_CONTACT:
          contactShieldCallback.onHasContact(token);
          break;
        case Method._ON_NO_CONTACT:
          contactShieldCallback.onNoContact(token);
          break;
        default:
          break;
      }
    }
  }

  Future<bool> isContactShieldRunning() async {
    return _channel.invokeMethod<bool>(Method._IS_CONTACT_SHIELD_RUNNING);
  }

  @Deprecated('Will be removed in future. Use `startContactShield` instead.')
  Future<void> startContactShieldOld(
      [int incubationPeriod = DEFAULT_INCUBATION_PERIOD]) async {
    return _channel.invokeMethod<void>(
        Method._START_CONTACT_SHIELD_OLD, incubationPeriod);
  }

  Future<void> startContactShield(
      [int incubationPeriod = DEFAULT_INCUBATION_PERIOD]) async {
    return _channel.invokeMethod<void>(
        Method._START_CONTACT_SHIELD, incubationPeriod);
  }

  Future<void> startContactShieldNonPersistent(
      [int incubationPeriod = DEFAULT_INCUBATION_PERIOD]) async {
    return _channel.invokeMethod<void>(
        Method._START_CONTACT_SHIELD_NON_PERSISTENT, incubationPeriod);
  }

  Future<List<PeriodicKey>> getPeriodicKey() async {
    String response =
        await _channel.invokeMethod<String>(Method._GET_PERIODIC_KEY);
    List<dynamic> items = json.decode(response);
    return List<PeriodicKey>.from(items.map((i) => PeriodicKey.fromMap(i)));
  }

  @Deprecated('Will be removed in future. Use `putSharedKeyFiles` instead. ')
  Future<void> putSharedKeyFilesOld(List<String> filePaths,
      DiagnosisConfiguration config, String token) async {
    final Map<String, dynamic> args = <String, dynamic>{
      'filePaths': filePaths,
      'diagnosisConfiguration': config.toJson(),
      'token': token,
    };
    return _channel.invokeMethod<void>(Method._PUT_SHARED_KEY_FILES_OLD, args);
  }

  Future<void> putSharedKeyFiles(List<String> filePaths,
      DiagnosisConfiguration config, String token) async {
    final Map<String, dynamic> args = <String, dynamic>{
      'filePaths': filePaths,
      'diagnosisConfiguration': config.toJson(),
      'token': token,
    };
    return _channel.invokeMethod<void>(Method._PUT_SHARED_KEY_FILES, args);
  }

  @Deprecated('Will be removed in future.')
  Future<List<ContactDetail>> getContactDetail(String token) async {
    String response =
        await _channel.invokeMethod<String>(Method._GET_CONTACT_DETAIL, token);
    List<dynamic> items = json.decode(response);
    return List<ContactDetail>.from(items.map((i) => ContactDetail.fromMap(i)));
  }

  Future<ContactSketch> getContactSketch(String token) async {
    return ContactSketch.fromJson(
        await _channel.invokeMethod<String>(Method._GET_CONTACT_SKETCH, token));
  }

  Future<List<ContactWindow>> getContactWindow([String token = TOKEN_A]) async {
    String response =
        await _channel.invokeMethod<String>(Method._GET_CONTACT_WINDOW, token);
    List<dynamic> items = json.decode(response);
    return List<ContactWindow>.from(items.map((i) => ContactWindow.fromMap(i)));
  }

  Future<void> clearData() async {
    return _channel.invokeMethod<void>(Method._CLEAR_DATA);
  }

  Future<void> stopContactShield() async {
    return _channel.invokeMethod<void>(Method._STOP_CONTACT_SHIELD);
  }

  Future<void> enableLogger() async {
    return await _channel.invokeMethod<void>(Method._ENABLE_LOGGER);
  }

  Future<void> disableLogger() async {
    return await _channel.invokeMethod<void>(Method._DISABLE_LOGGER);
  }
}

class Method {
  static const String _CLEAR_DATA = "clearData";
  static const String _GET_CONTACT_DETAIL = "getContactDetail";
  static const String _GET_CONTACT_SKETCH = "getContactSketch";
  static const String _GET_CONTACT_WINDOW = "getContactWindow";
  static const String _GET_PERIODIC_KEY = "getPeriodicKey";
  static const String _IS_CONTACT_SHIELD_RUNNING = "isContactShieldRunning";
  static const String _PUT_SHARED_KEY_FILES_OLD = "putSharedKeyFilesOld";
  static const String _PUT_SHARED_KEY_FILES = "putSharedKeyFiles";
  static const String _START_CONTACT_SHIELD_OLD = "startContactShieldOld";
  static const String _START_CONTACT_SHIELD = "startContactShield";
  static const String _START_CONTACT_SHIELD_NON_PERSISTENT =
      "startContactShieldNonPersistent";
  static const String _STOP_CONTACT_SHIELD = "stopContactShield";
  static const String _ON_HAS_CONTACT = "onHasContact";
  static const String _ON_NO_CONTACT = "onNoContact";
  static const String _ENABLE_LOGGER = "enableLogger";
  static const String _DISABLE_LOGGER = "disableLogger";
}

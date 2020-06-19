/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'dart:async' show Future;

import 'package:flutter/services.dart';

import 'activity_conversion_info.dart';
import 'activity_conversion_response.dart';
import 'activity_identification_response.dart';

class ActivityIdentificationService {
  static ActivityIdentificationService _instance;

  final MethodChannel _methodChannel;
  final EventChannel _activityIdentificationEventChannel;
  final EventChannel _activityConversionEventChannel;

  Stream<ActivityIdentificationResponse> _onActivityIdentification;
  Stream<ActivityConversionResponse> _onActivityConversion;

  ActivityIdentificationService._create(
    this._methodChannel,
    this._activityIdentificationEventChannel,
    this._activityConversionEventChannel,
  );

  factory ActivityIdentificationService() {
    if (_instance == null) {
      final MethodChannel methodChannel = const MethodChannel(
          'com.huawei.flutter.location/activityidentification_methodchannel');

      final EventChannel activityIdentificationEventChannel = const EventChannel(
          'com.huawei.flutter.location/activityidentification_eventchannel');

      final EventChannel activityConversionEventChannel = const EventChannel(
          'com.huawei.flutter.location/activityconversion_eventchannel');

      _instance = ActivityIdentificationService._create(
        methodChannel,
        activityIdentificationEventChannel,
        activityConversionEventChannel,
      );
    }
    return _instance;
  }

  Future<int> createActivityIdentificationUpdates(
      int detectionIntervalMillis) async {
    return _methodChannel.invokeMethod<int>(
        'createActivityIdentificationUpdates', detectionIntervalMillis);
  }

  Future<int> createActivityConversionUpdates(
      List<ActivityConversionInfo> activityConversions) async {
    return _methodChannel.invokeMethod<int>('createActivityConversionUpdates',
        activityConversions?.map((x) => x?.toMap())?.toList());
  }

  Future<void> deleteActivityIdentificationUpdates(int requestCode) async {
    return _methodChannel.invokeMethod<void>(
        'deleteActivityIdentificationUpdates', requestCode);
  }

  Future<void> deleteActivityConversionUpdates(int requestCode) async {
    return _methodChannel.invokeMethod<void>(
        'deleteActivityConversionUpdates', requestCode);
  }

  Stream<ActivityIdentificationResponse> get onActivityIdentification {
    if (_onActivityIdentification == null) {
      _onActivityIdentification = _activityIdentificationEventChannel
          .receiveBroadcastStream()
          .map((event) => ActivityIdentificationResponse.fromMap(event));
    }
    return _onActivityIdentification;
  }

  Stream<ActivityConversionResponse> get onActivityConversion {
    if (_onActivityConversion == null) {
      _onActivityConversion = _activityConversionEventChannel
          .receiveBroadcastStream()
          .map((event) => ActivityConversionResponse.fromMap(event));
    }
    return _onActivityConversion;
  }
}

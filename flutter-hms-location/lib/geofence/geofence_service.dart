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

import 'geofence_data.dart' show GeofenceData;
import 'geofence_request.dart' show GeofenceRequest;

class GeofenceService {
  static GeofenceService _instance;

  final MethodChannel _methodChannel;
  final EventChannel _eventChannel;

  Stream<GeofenceData> _onGeofenceData;

  GeofenceService._create(
    this._methodChannel,
    this._eventChannel,
  );

  factory GeofenceService() {
    if (_instance == null) {
      final MethodChannel methodChannel = const MethodChannel(
          'com.huawei.flutter.location/geofence_methodchannel');
      final EventChannel eventChannel = const EventChannel(
          'com.huawei.flutter.location/geofence_eventchannel');

      _instance = GeofenceService._create(
        methodChannel,
        eventChannel,
      );
    }
    return _instance;
  }

  Future<int> createGeofenceList(GeofenceRequest geofenceRequest) async {
    return _methodChannel.invokeMethod<int>(
        'createGeofenceList', geofenceRequest.toMap());
  }

  Future<void> deleteGeofenceList(int requestCode) async {
    return _methodChannel.invokeMethod<void>('deleteGeofenceList', requestCode);
  }

  Future<void> deleteGeofenceListWithIds(List<String> geofenceIds) async {
    return _methodChannel.invokeMethod<void>(
        'deleteGeofenceListWithIds', geofenceIds);
  }

  Stream<GeofenceData> get onGeofenceData {
    if (_onGeofenceData == null) {
      _onGeofenceData = _eventChannel
          .receiveBroadcastStream()
          .map((event) => GeofenceData.fromMap(event));
    }
    return _onGeofenceData;
  }
}

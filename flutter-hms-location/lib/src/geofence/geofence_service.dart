/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
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

part of '../../huawei_location.dart';

class GeofenceService {
  static GeofenceService? _instance;

  final MethodChannel _methodChannel;
  final EventChannel _eventChannel;

  Stream<GeofenceData>? _onGeofenceData;

  factory GeofenceService() {
    if (_instance == null) {
      const MethodChannel methodChannel =
          MethodChannel('com.huawei.flutter.location/geofence_methodchannel');
      const EventChannel eventChannel =
          EventChannel('com.huawei.flutter.location/geofence_eventchannel');

      _instance = GeofenceService._create(
        methodChannel,
        eventChannel,
      );
    }
    return _instance!;
  }

  GeofenceService._create(
    this._methodChannel,
    this._eventChannel,
  );

  /// Initializes the `Geofence` Service.
  Future<void> initGeofenceService() async {
    await _methodChannel.invokeMethod<void>('initGeofenceService');
  }

  /// Adds geofences.
  ///
  /// When a geofence is triggered, the [onGeofenceData] method can listen for
  /// a notification.
  Future<int> createGeofenceList(GeofenceRequest geofenceRequest) async {
    return (await _methodChannel.invokeMethod<int>(
      'createGeofenceList',
      geofenceRequest.toMap(),
    ))!;
  }

  /// Removes geofences associated with a request code.
  Future<void> deleteGeofenceList(int requestCode) async {
    return _methodChannel.invokeMethod<void>('deleteGeofenceList', requestCode);
  }

  /// Removes geofences by their unique IDs.
  Future<void> deleteGeofenceListWithIds(List<String> geofenceIds) async {
    return _methodChannel.invokeMethod<void>(
      'deleteGeofenceListWithIds',
      geofenceIds,
    );
  }

  /// Listens for geofence updates that come from the [createGeofenceList]
  /// method.
  Stream<GeofenceData>? get onGeofenceData {
    _onGeofenceData ??= _eventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => GeofenceData.fromMap(event));
    return _onGeofenceData;
  }
}

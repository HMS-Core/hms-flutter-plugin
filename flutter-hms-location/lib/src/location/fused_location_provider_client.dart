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

class FusedLocationProviderClient {
  static FusedLocationProviderClient? _instance;

  final MethodChannel _methodChannel;
  final EventChannel _eventChannel;
  final Map<int, LocationCallback> _callbacks;

  Stream<Location>? _onLocationData;

  factory FusedLocationProviderClient() {
    _instance ??= FusedLocationProviderClient._create(
      const MethodChannel(
        'com.huawei.flutter.location/fusedlocation_methodchannel',
      ),
      const EventChannel(
        'com.huawei.flutter.location/fusedlocation_eventchannel',
      ),
      <int, LocationCallback>{},
    );
    return _instance!;
  }

  FusedLocationProviderClient._create(
    this._methodChannel,
    this._eventChannel,
    this._callbacks,
  ) {
    _methodChannel.setMethodCallHandler(_methodCallHandler);
  }

  Future<void> _methodCallHandler(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'onLocationResult':
        _callbacks[methodCall.arguments['callbackId']]!.onLocationResult(
          LocationResult.fromMap(
            methodCall.arguments['locationResult'],
          ),
        );
        break;
      case 'onLocationAvailability':
        _callbacks[methodCall.arguments['callbackId']]!.onLocationAvailability(
          LocationAvailability.fromMap(
            methodCall.arguments['locationAvailability'],
          ),
        );
        break;
      default:
        break;
    }
  }

  /// Initializes the `Fused Location` service.
  Future<void> initFusedLocationService() async {
    await _methodChannel.invokeMethod<void>('initFusedLocationService');
  }

  /// Checks location settings of the device.
  Future<LocationSettingsStates> checkLocationSettings(
    LocationSettingsRequest locationSettingsRequest,
  ) async {
    return LocationSettingsStates.fromMap(
      (await (_methodChannel.invokeMapMethod<String, dynamic>(
        'checkLocationSettings',
        locationSettingsRequest.toMap(),
      )))!,
    );
  }

  /// Obtains the available location of the last request.
  ///
  /// Instead of proactively requesting a location, this method uses the
  /// location cached during the last request.
  Future<Location> getLastLocation() async {
    return Location.fromMap(
      await _methodChannel.invokeMapMethod<String, dynamic>('getLastLocation'),
    );
  }

  /// Obtains the available location of the last request, including the
  /// detailed address information.
  ///
  /// If no location is available, `null` is returned.
  Future<HWLocation> getLastLocationWithAddress(
    LocationRequest locationRequest,
  ) async {
    return HWLocation.fromMap(
      (await (_methodChannel.invokeMapMethod<String, dynamic>(
        'getLastLocationWithAddress',
        locationRequest.toMap(),
      )))!,
    );
  }

  /// Checks whether the location data is available.
  Future<LocationAvailability> getLocationAvailability() async {
    return LocationAvailability.fromMap(
      (await (_methodChannel
          .invokeMapMethod<String, dynamic>('getLocationAvailability')))!,
    );
  }

  /// Sets whether to use the location mock mode.
  ///
  /// If the value `true` is passed, the GNSS or network location is not used
  /// and the location set through [setMockLocation(Location)] is directly
  /// returned.
  Future<void> setMockMode(bool mockMode) async {
    return _methodChannel.invokeMethod<void>('setMockMode', mockMode);
  }

  /// Sets a specific mock location.
  ///
  /// You must call the [setMockMode(boolean)] method and set the flag to `true`
  /// before calling this method.
  Future<void> setMockLocation(Location location) async {
    return _methodChannel.invokeMethod<void>(
      'setMockLocation',
      location.toMap(),
    );
  }

  /// Continuously requests location updates.
  ///
  /// You can call the [onLocationData] API method to listen for location
  /// updates.
  Future<int?> requestLocationUpdates(LocationRequest locationRequest) async {
    return _methodChannel.invokeMethod<int>(
      'requestLocationUpdates',
      locationRequest.toMap(),
    );
  }

  /// Requests location updates using the callback.
  Future<int> requestLocationUpdatesCb(
    LocationRequest locationRequest,
    LocationCallback locationCallback,
  ) async {
    int callbackId = (await (_methodChannel.invokeMethod<int>(
      'requestLocationUpdatesCb',
      locationRequest.toMap(),
    )))!;
    _callbacks.putIfAbsent(callbackId, () => locationCallback);
    return callbackId;
  }

  /// Continuously requests location updates.
  ///
  /// This method is an extended location information service API. It
  /// supports high-precision location and is compatible with common location
  /// APIs. If the device does not support high-precision location or the app
  /// does not request the high-precision location, this method returns
  /// common location information similar to
  /// that returned by the [requestLocationUpdatesCb] method.
  Future<int> requestLocationUpdatesExCb(
    LocationRequest locationRequest,
    LocationCallback locationCallback,
  ) async {
    int callbackId = (await (_methodChannel.invokeMethod<int>(
      'requestLocationUpdatesExCb',
      (locationRequest..priority = LocationRequest.PRIORITY_HD_ACCURACY)
          .toMap(),
    )))!;
    _callbacks.putIfAbsent(callbackId, () => locationCallback);
    return callbackId;
  }

  /// Removes location updates based on the specified request code.
  Future<void> removeLocationUpdates(int requestCode) async {
    return _methodChannel.invokeMethod<void>(
      'removeLocationUpdates',
      requestCode,
    );
  }

  /// Removes location updates based on the specified callback ID.
  Future<void> removeLocationUpdatesCb(int callbackId) async {
    await _methodChannel.invokeMethod<void>(
      'removeLocationUpdatesCb',
      callbackId,
    );
    _callbacks.remove(callbackId);
  }

  /// Obtains the status information.
  Future<NavigationResult> getNavigationContextState(
    NavigationRequest navigationRequest,
  ) async {
    return NavigationResult.fromMap(
      (await (_methodChannel.invokeMapMethod<String, dynamic>(
        'getNavigationContextState',
        navigationRequest.toMap(),
      )))!,
    );
  }

  /// Listens for location updates that come from the [requestLocationUpdates]
  /// method.
  Stream<Location>? get onLocationData {
    _onLocationData ??= _eventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => Location.fromMap(event));
    return _onLocationData;
  }

  /// Disables the background location function.
  Future<void> disableBackgroundLocation() async {
    await _methodChannel.invokeMethod<void>('disableBackgroundLocation');
  }

  /// Enables the background location function.
  Future<void> enableBackgroundLocation(
    int notificationId,
    BackgroundNotification notification,
  ) async {
    await _methodChannel.invokeMethod<void>(
      'enableBackgroundLocation',
      <String, dynamic>{
        'notificationId': notificationId,
        'notification': notification.toMap(),
      },
    );
  }

  /// Sets whether to enable log recording.
  Future<void> setLogConfig(LogConfig logConfig) async {
    await _methodChannel.invokeMethod<void>('setLogConfig', logConfig.toMap());
  }

  /// Obtains the log config object.
  Future<LogConfig> getLogConfig() async {
    return LogConfig.fromMap(
      await _methodChannel.invokeMapMethod<String, dynamic>('getLogConfig'),
    );
  }
}

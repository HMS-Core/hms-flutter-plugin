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

import 'hwlocation.dart';
import 'location.dart';
import 'location_availability.dart';
import 'location_callback.dart';
import 'location_request.dart';
import 'location_result.dart';
import 'location_settings_request.dart';
import 'location_settings_states.dart';

class FusedLocationProviderClient {
  static FusedLocationProviderClient _instance;

  final MethodChannel _methodChannel;
  final EventChannel _eventChannel;
  final Map<int, LocationCallback> _callbacks;

  Stream<Location> _onLocationData;

  FusedLocationProviderClient._create(
    this._methodChannel,
    this._eventChannel,
    this._callbacks,
  ) {
    _methodChannel.setMethodCallHandler(_methodCallHandler);
  }

  factory FusedLocationProviderClient() {
    if (_instance == null) {
      _instance = FusedLocationProviderClient._create(
        const MethodChannel(
            'com.huawei.flutter.location/fusedlocation_methodchannel'),
        const EventChannel(
            'com.huawei.flutter.location/fusedlocation_eventchannel'),
        <int, LocationCallback>{},
      );
    }
    return _instance;
  }

  Future<void> _methodCallHandler(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'onLocationResult':
        _callbacks[methodCall.arguments['callbackId']].onLocationResult(
            LocationResult.fromMap(methodCall.arguments['locationResult']));
        break;
      case 'onLocationAvailability':
        _callbacks[methodCall.arguments['callbackId']].onLocationAvailability(
            LocationAvailability.fromMap(
                methodCall.arguments['locationAvailability']));
        break;
      default:
        break;
    }
  }

  Future<LocationSettingsStates> checkLocationSettings(
      LocationSettingsRequest locationSettingsRequest) async {
    return LocationSettingsStates.fromMap(
        await _methodChannel.invokeMapMethod<String, dynamic>(
            'checkLocationSettings', locationSettingsRequest.toMap()));
  }

  Future<Location> getLastLocation() async {
    return Location.fromMap(await _methodChannel
        .invokeMapMethod<String, dynamic>('getLastLocation'));
  }

  Future<HWLocation> getLastLocationWithAddress(
      LocationRequest locationRequest) async {
    return HWLocation.fromMap(
        await _methodChannel.invokeMapMethod<String, dynamic>(
            'getLastLocationWithAddress', locationRequest.toMap()));
  }

  Future<LocationAvailability> getLocationAvailability() async {
    return LocationAvailability.fromMap(await _methodChannel
        .invokeMapMethod<String, dynamic>('getLocationAvailability'));
  }

  Future<void> setMockMode(bool mockMode) async {
    return _methodChannel.invokeMethod<void>('setMockMode', mockMode);
  }

  Future<void> setMockLocation(Location location) async {
    return _methodChannel.invokeMethod<void>(
        'setMockLocation', location.toMap());
  }

  Future<int> requestLocationUpdates(LocationRequest locationRequest) async {
    return _methodChannel.invokeMethod<int>(
        'requestLocationUpdates', locationRequest.toMap());
  }

  Future<int> requestLocationUpdatesCb(LocationRequest locationRequest,
      LocationCallback locationCallback) async {
    int callbackId = await _methodChannel.invokeMethod<int>(
        'requestLocationUpdatesCb', locationRequest.toMap());
    _callbacks.putIfAbsent(callbackId, () => locationCallback);
    return callbackId;
  }

  Future<int> requestLocationUpdatesExCb(LocationRequest locationRequest,
      LocationCallback locationCallback) async {
    int callbackId = await _methodChannel.invokeMethod<int>(
        'requestLocationUpdatesExCb', locationRequest.toMap());
    _callbacks.putIfAbsent(callbackId, () => locationCallback);
    return callbackId;
  }

  Future<void> removeLocationUpdates(int requestCode) async {
    return _methodChannel.invokeMethod<void>(
        'removeLocationUpdates', requestCode);
  }

  Future<void> removeLocationUpdatesCb(int callbackId) async {
    await _methodChannel.invokeMethod<void>(
        'removeLocationUpdatesCb', callbackId);
    _callbacks.remove(callbackId);
  }

  Stream<Location> get onLocationData {
    if (_onLocationData == null) {
      _onLocationData = _eventChannel
          .receiveBroadcastStream()
          .map((event) => Location.fromMap(event));
    }
    return _onLocationData;
  }
}

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

import 'package:flutter/foundation.dart' show required;
import 'package:flutter/services.dart' show MethodChannel;
import 'package:huawei_awareness/hmsAwarenessLibrary.dart';
import 'constants/channel.dart';
import 'constants/method.dart';
import 'constants/param.dart';

class AwarenessCaptureClient {
  static const MethodChannel _captureChannel =
      const MethodChannel(Channel.AwarenessCaptureChannel);

  static Future<BeaconResponse> getBeaconStatus(
      {@required List<BeaconFilter> filters}) async {
    return BeaconResponse.fromJson(
        await _captureChannel.invokeMethod(Method.GetBeaconStatus, {
      Param.beaconFilters: List<dynamic>.from(filters.map((x) => x.toMap())),
    }));
  }

  static Future<BehaviorResponse> getBehavior() async {
    return BehaviorResponse.fromJson(
        await _captureChannel.invokeMethod(Method.GetBehavior));
  }

  static Future<HeadsetResponse> getHeadsetStatus() async {
    return HeadsetResponse.fromJson(
        await _captureChannel.invokeMethod(Method.GetHeadsetStatus));
  }

  static Future<LocationResponse> getLocation() async {
    return LocationResponse.fromJson(
        await _captureChannel.invokeMethod(Method.GetLocation));
  }

  static Future<LocationResponse> getCurrentLocation() async {
    return LocationResponse.fromJson(
        await _captureChannel.invokeMethod(Method.GetCurrentLocation));
  }

  static Future<TimeCategoriesResponse> getTimeCategories() async {
    return TimeCategoriesResponse.fromJson(
        await _captureChannel.invokeMethod(Method.GetTimeCategories));
  }

  static Future<TimeCategoriesResponse> getTimeCategoriesByUser(
      {@required double latitude, @required double longitude}) async {
    return TimeCategoriesResponse.fromJson(
        await _captureChannel.invokeMethod(Method.GetTimeCategoriesByUser, {
      Param.latitude: latitude,
      Param.longitude: longitude,
    }));
  }

  static Future<TimeCategoriesResponse> getTimeCategoriesByCountryCode(
      {@required String countryCode}) async {
    return TimeCategoriesResponse.fromJson(await _captureChannel
        .invokeMethod(Method.GetTimeCategoriesByCountryCode, {
      Param.countryCode: countryCode,
    }));
  }

  static Future<TimeCategoriesResponse> getTimeCategoriesByIP() async {
    return TimeCategoriesResponse.fromJson(
        await _captureChannel.invokeMethod(Method.GetTimeCategoriesByIP));
  }

  static Future<TimeCategoriesResponse> getTimeCategoriesForFuture(
      {@required int futureTimestamp}) async {
    return TimeCategoriesResponse.fromJson(
        await _captureChannel.invokeMethod(Method.GetTimeCategoriesForFuture, {
      Param.futureTimestamp: futureTimestamp,
    }));
  }

  static Future<LightIntensityResponse> getLightIntensity() async {
    return LightIntensityResponse.fromJson(
        await _captureChannel.invokeMethod(Method.GetLightIntensity));
  }

  static Future<WeatherResponse> getWeatherByDevice() async {
    return WeatherResponse.fromJson(
        await _captureChannel.invokeMethod(Method.GetWeatherByDevice));
  }

  static Future<WeatherResponse> getWeatherByPosition(
      {@required WeatherPosition weatherPosition}) async {
    return WeatherResponse.fromJson(await _captureChannel.invokeMethod(
        Method.GetWeatherByPosition, weatherPosition.toMap()));
  }

  static Future<BluetoothResponse> getBluetoothStatus(
      {@required int deviceType}) async {
    return BluetoothResponse.fromJson(
        await _captureChannel.invokeMethod(Method.GetBluetoothStatus, {
      Param.deviceType: deviceType,
    }));
  }

  static Future<CapabilityResponse> querySupportingCapabilities() async {
    return CapabilityResponse.fromJson(
        await _captureChannel.invokeMethod(Method.QuerySupportingCapabilities));
  }

  static Future<void> enableUpdateWindow(bool status) async {
    return _captureChannel.invokeMethod(Method.EnableUpdateWindow, {
      Param.status: status,
    });
  }

  static Future<ScreenStatusResponse> getScreenStatus() async {
    return ScreenStatusResponse.fromJson(
        await _captureChannel.invokeMethod(Method.GetScreenStatus));
  }

  static Future<WiFiResponse> getWifiStatus() async {
    return WiFiResponse.fromJson(
        await _captureChannel.invokeMethod(Method.GetWifiStatus));
  }

  static Future<ApplicationResponse> getApplicationStatus(
      {@required String packageName}) async {
    return ApplicationResponse.fromJson(
        await _captureChannel.invokeMethod(Method.GetApplicationStatus, {
      Param.packageName: packageName,
    }));
  }

  static Future<DarkModeResponse> getDarkModeStatus() async {
    return DarkModeResponse.fromJson(
        await _captureChannel.invokeMethod(Method.GetDarkModeStatus));
  }
}

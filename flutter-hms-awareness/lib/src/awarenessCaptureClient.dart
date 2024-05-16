/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_awareness;

class AwarenessCaptureClient {
  static const MethodChannel _captureChannel =
      MethodChannel(_Channel.awarenessCaptureChannel);

  static Future<BeaconResponse> getBeaconStatus(
      {required List<BeaconFilter> filters}) async {
    return BeaconResponse.fromJson(
      await _captureChannel.invokeMethod(
        _Method.getBeaconStatus,
        <String, dynamic>{
          _Param.beaconFilters: List<dynamic>.from(
            filters.map(
              (BeaconFilter x) => x.toMap(),
            ),
          ),
        },
      ),
    );
  }

  static Future<BehaviorResponse> getBehavior() async {
    return BehaviorResponse.fromJson(
        await _captureChannel.invokeMethod(_Method.getBehavior));
  }

  static Future<HeadsetResponse> getHeadsetStatus() async {
    return HeadsetResponse.fromJson(
        await _captureChannel.invokeMethod(_Method.getHeadsetStatus));
  }

  static Future<LocationResponse> getLocation() async {
    return LocationResponse.fromJson(
        await _captureChannel.invokeMethod(_Method.getLocation));
  }

  static Future<LocationResponse> getCurrentLocation() async {
    return LocationResponse.fromJson(
        await _captureChannel.invokeMethod(_Method.getCurrentLocation));
  }

  static Future<TimeCategoriesResponse> getTimeCategories() async {
    return TimeCategoriesResponse.fromJson(
        await _captureChannel.invokeMethod(_Method.getTimeCategories));
  }

  static Future<TimeCategoriesResponse> getTimeCategoriesByUser({
    required double latitude,
    required double longitude,
  }) async {
    return TimeCategoriesResponse.fromJson(
      await _captureChannel.invokeMethod(
        _Method.getTimeCategoriesByUser,
        <String, dynamic>{
          _Param.latitude: latitude,
          _Param.longitude: longitude,
        },
      ),
    );
  }

  static Future<TimeCategoriesResponse> getTimeCategoriesByCountryCode({
    required String countryCode,
  }) async {
    return TimeCategoriesResponse.fromJson(
      await _captureChannel.invokeMethod(
        _Method.getTimeCategoriesByCountryCode,
        <String, dynamic>{
          _Param.countryCode: countryCode,
        },
      ),
    );
  }

  static Future<TimeCategoriesResponse> getTimeCategoriesByIP() async {
    return TimeCategoriesResponse.fromJson(
      await _captureChannel.invokeMethod(_Method.getTimeCategoriesByIP),
    );
  }

  static Future<TimeCategoriesResponse> getTimeCategoriesForFuture({
    required int futureTimestamp,
  }) async {
    return TimeCategoriesResponse.fromJson(
      await _captureChannel.invokeMethod(
        _Method.getTimeCategoriesForFuture,
        <String, dynamic>{
          _Param.futureTimestamp: futureTimestamp,
        },
      ),
    );
  }

  static Future<LightIntensityResponse> getLightIntensity() async {
    return LightIntensityResponse.fromJson(
      await _captureChannel.invokeMethod(_Method.getLightIntensity),
    );
  }

  static Future<WeatherResponse> getWeatherByDevice() async {
    return WeatherResponse.fromJson(
        await _captureChannel.invokeMethod(_Method.getWeatherByDevice));
  }

  static Future<WeatherResponse> getWeatherByPosition({
    required WeatherPosition weatherPosition,
  }) async {
    return WeatherResponse.fromJson(await _captureChannel.invokeMethod(
        _Method.getWeatherByPosition, weatherPosition.toMap()));
  }

  static Future<BluetoothResponse> getBluetoothStatus({
    required int deviceType,
  }) async {
    return BluetoothResponse.fromJson(
      await _captureChannel.invokeMethod(
        _Method.getBluetoothStatus,
        <String, dynamic>{
          _Param.deviceType: deviceType,
        },
      ),
    );
  }

  static Future<CapabilityResponse> querySupportingCapabilities() async {
    return CapabilityResponse.fromJson(
      await _captureChannel.invokeMethod(_Method.querySupportingCapabilities),
    );
  }

  static Future<void> enableUpdateWindow(
    bool status,
  ) async {
    return _captureChannel.invokeMethod(
      _Method.enableUpdateWindow,
      <String, dynamic>{
        _Param.status: status,
      },
    );
  }

  static Future<ScreenStatusResponse> getScreenStatus() async {
    return ScreenStatusResponse.fromJson(
      await _captureChannel.invokeMethod(_Method.getScreenStatus),
    );
  }

  static Future<WiFiResponse> getWifiStatus() async {
    return WiFiResponse.fromJson(
      await _captureChannel.invokeMethod(_Method.getWifiStatus),
    );
  }

  static Future<ApplicationResponse> getApplicationStatus(
      {required String packageName}) async {
    return ApplicationResponse.fromJson(
      await _captureChannel.invokeMethod(
        _Method.getApplicationStatus,
        <String, dynamic>{
          _Param.packageName: packageName,
        },
      ),
    );
  }

  static Future<DarkModeResponse> getDarkModeStatus() async {
    return DarkModeResponse.fromJson(
      await _captureChannel.invokeMethod(_Method.getDarkModeStatus),
    );
  }
}

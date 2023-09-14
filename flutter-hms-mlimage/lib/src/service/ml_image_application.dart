/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_ml_image;

class MLImageApplication {
  late MethodChannel _channel;

  MLImageApplication() {
    _channel = const MethodChannel('$baseChannel.application');
  }

  /// Sets the API key for on-cloud services.
  Future<void> setApiKey(String apiKey) async {
    await _channel.invokeMethod(
      'setApiKey',
      <String, dynamic>{
        'key': apiKey,
      },
    );
  }

  /// Sets the access token for on-cloud services.
  Future<void> setAccessToken(String accessToken) async {
    await _channel.invokeMethod(
      'setAccessToken',
      <String, dynamic>{
        'token': accessToken,
      },
    );
  }

  /// Sets a data processing location when you choose to manually manage and specify such a location.
  ///
  /// REGION_DR_UNKNOWN = 1001,
  /// REGION_DR_CHINA = 1002,
  /// REGION_DR_RUSSIA = 1005,
  /// REGION_DR_GERMAN = 1006,
  /// REGION_DR_SINGAPORE = 1007
  Future<void> setUserRegion(int region) async {
    await _channel.invokeMethod(
      'setUserRegion',
      <String, dynamic>{
        'region': region,
      },
    );
  }

  /// Obtains the country/region code of the data processing location you have specified
  /// when you choose to manually manage and specify such a location.
  ///
  /// When the parameter value is invalid or not specified, null will be returned.
  Future<String?> getCountryCode() async {
    return await _channel.invokeMethod(
      'getCountryCode',
    );
  }

  /// Enables the HMS plugin method analytics.
  Future<void> enableLogger() async {
    await _channel.invokeMethod(
      'enableLogger',
    );
  }

  /// Disables the HMS plugin method analytics.
  Future<void> disableLogger() async {
    await _channel.invokeMethod(
      'disableLogger',
    );
  }
}

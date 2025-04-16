/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of '../../huawei_ml_body.dart';

class MLBodyApplication {
  late MethodChannel _channel;
  static const int REGION_DR_UNKNOWN = 1001;
  static const int REGION_DR_CHINA = 1002;
  static const int REGION_DR_RUSSIA = 1005;
  static const int REGION_DR_GERMAN = 1006;
  static const int REGION_DR_SINGAPORE = 1007;

  static final MLBodyApplication _instance = MLBodyApplication._init();
  static MLBodyApplication get instance => _instance;

  MLBodyApplication._init() {
    _channel = const MethodChannel('$baseChannel.app');
  }

  /// Sets the API key for on-cloud services.
  Future<void> setApiKey(String apiKey) async {
    await _channel.invokeMethod(
      'bodyApp#setApiKey',
      <String, dynamic>{
        'apiKey': apiKey,
      },
    );
  }

  /// Sets the access token for on-cloud services.
  Future<void> setAccessToken(String accessToken) async {
    await _channel.invokeMethod(
      'bodyApp#setAccessToken',
      <String, dynamic>{
        'token': accessToken,
      },
    );
  }

  /// Sets a data processing location when you choose to manually manage and specify such a location.
  ///
  /// REGION_DR_UNKNOWN = `1001`
  ///
  /// REGION_DR_CHINA = `1002`
  ///
  /// REGION_DR_RUSSIA = `1005`
  ///
  /// REGION_DR_GERMAN = `1006`
  ///
  /// REGION_DR_SINGAPORE = `1007`
  Future<void> setUserRegion(int region) async {
    await _channel.invokeMethod(
      'bodyApp#setUserRegion',
      <String, dynamic>{
        'region': region,
      },
    );
  }

  /// Obtains the country/region code of the data processing location you have specified when you choose to manually manage and specify such a location.
  ///
  /// When the parameter value is invalid or not specified, null will be returned.
  Future<String?> getCountryCode() async {
    return await _channel.invokeMethod(
      'bodyApp#getCountryCode',
    );
  }

  /// Enables the HMS plugin method analytics.
  Future<void> enableLogger() async {
    await _channel.invokeMethod(
      'bodyApp#enableLogger',
    );
  }

  /// Disables the HMS plugin method analytics.
  Future<void> disableLogger() async {
    await _channel.invokeMethod(
      'bodyApp#disableLogger',
    );
  }
}

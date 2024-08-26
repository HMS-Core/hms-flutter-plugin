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

part of '../../huawei_map.dart';

/// To use certain functions before obtaining a map, use this class to initialize the Map SDK.
abstract class HuaweiMapInitializer {
  static const MethodChannel _c = MethodChannel(_mapUtilChannel);

  /// Initializes the Map SDK.
  ///
  /// You can set the data routing location.
  /// The options for routePolicy are CN (China), DE (Germany), SG (Singapore), and RU (Russia).
  static void initializeMap([String? routePolicy]) {
    _c.invokeMethod(
      _Method.InitializeMap,
      routePolicy,
    );
  }

  /// Sets the API key of the Map SDK.
  ///
  /// This method does not need to be called if the api_key field
  /// in the agconnect-services.json file already specifies an API key.
  /// If an API key is set using setApiKey and the agconnect-services.json
  /// file also has an API key, the API key set using setApiKey takes precedence.
  static void setApiKey({required String apiKey}) {
    _c.invokeMethod(
      _Method.SetApiKey,
      apiKey,
    );
  }

  /// Sets the access token of the Map SDK.
  ///
  /// If both the API key and access token are set,
  /// the access token will be used for authentication.
  static void setAccessToken({required String accessToken}) {
    _c.invokeMethod(
      _Method.SetAccessToken,
      accessToken,
    );
  }
}

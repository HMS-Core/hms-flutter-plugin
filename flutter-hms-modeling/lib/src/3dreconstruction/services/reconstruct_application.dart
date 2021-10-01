/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:flutter/services.dart';

import '../constants/channel.dart';

/// App information. To use the on-cloud 3D object reconstruction service, set an access token or API key for your app.
class ReconstructApplication {
  static const MethodChannel _channel = reconstructApplicationMethodChannel;

  static final _instance = ReconstructApplication._();

  /// Obtains a ReconstructApplication instance.
  static Future<ReconstructApplication> get instance async {
    await _channel.invokeMethod("getInstance");
    return _instance;
  }

  ReconstructApplication._();

  /// Sets an access token for your app.
  Future<void> setAccessToken(String accessToken) async {
    await _channel.invokeMethod("setAccessToken", accessToken);
  }

  /// Sets an API key for your app.
  Future<void> setApiKey(String apiKey) async {
    await _channel.invokeMethod("setApiKey", apiKey);
  }
}

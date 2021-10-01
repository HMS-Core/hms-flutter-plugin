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

/// App information. To use the on-cloud material generation service,
/// set an access token or API key for your app.
class MaterialGenApplication {
  late MethodChannel _c;

  MaterialGenApplication._inner() {
    _c = const MethodChannel("com.huawei.modeling3d.materialgenapp/method");
  }

  static final MaterialGenApplication _instance =
      MaterialGenApplication._inner();

  /// Returns the instance of this class.
  static MaterialGenApplication get getInstance => _instance;

  /// Sets an access token for your app.
  void setAccessToken(String accessToken) {
    _c.invokeMethod('setAccessToken', {'accessToken': accessToken});
  }

  /// Sets an API key for your app.
  void setApiKey(String apiKey) {
    _c.invokeMethod('setApiKey', {'apiKey': apiKey});
  }
}

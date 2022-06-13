/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ml_image/src/common/constants.dart';

class MLImageApplication {
  late MethodChannel _channel;

  MLImageApplication() {
    _channel = const MethodChannel("$baseChannel.application");
  }

  void setApiKey(String apiKey) {
    _channel.invokeMethod("setApiKey", {'key': apiKey});
  }

  void setAccessToken(String accessToken) {
    _channel.invokeMethod("setAccessToken", {'token': accessToken});
  }

  void enableLogger() {
    _channel.invokeMethod("enableLogger");
  }

  void disableLogger() {
    _channel.invokeMethod("disableLogger");
  }
}

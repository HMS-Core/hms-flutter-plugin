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
import 'package:huawei_ml_body/huawei_ml_body.dart';

class MLBodyApplication {
  late MethodChannel _channel;

  MLBodyApplication._init() {
    _channel = const MethodChannel('$baseChannel.app');
  }

  static final MLBodyApplication _instance = MLBodyApplication._init();

  static MLBodyApplication get instance => _instance;

  void enableLogger() {
    _channel.invokeMethod('bodyApp#enableLogger');
  }

  void disableLogger() {
    _channel.invokeMethod('bodyApp#disableLogger');
  }

  void setApiKey(String apiKey) {
    _channel.invokeMethod('bodyApp#setApiKey', {'apiKey': apiKey});
  }

  void setAccessToken(String token) {
    _channel.invokeMethod('bodyApp#setAccessToken', {'token': token});
  }
}

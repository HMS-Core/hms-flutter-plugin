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

class MLLanguageApp {
  late MethodChannel _c;

  MLLanguageApp() {
    _c = const MethodChannel("hms_lang_app");
  }

  void enableLogger() {
    _c.invokeMethod("enableLogger");
  }

  void disableLogger() {
    _c.invokeMethod("disableLogger");
  }

  void setApiKey(String apiKey) {
    _c.invokeMethod(
      "setApiKey",
      {'apiKey': apiKey},
    );
  }

  void setAccessToken(String accessToken) {
    _c.invokeMethod(
      "setAccessToken",
      {'accessToken': accessToken},
    );
  }

  Future<String?> getAppDirectory() async {
    return await _c.invokeMethod('getAppDirectory');
  }
}

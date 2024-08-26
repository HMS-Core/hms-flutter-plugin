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

part of '../../huawei_ml_language.dart';

class MLTranslateLanguage {
  late MethodChannel _c;

  MLTranslateLanguage() {
    _c = const MethodChannel('hms_lang_translate_language');
  }

  Future<List<dynamic>> getCloudAllLanguages() async {
    return await _c.invokeMethod(
      'getCloudAllLanguages',
    );
  }

  Future<List<dynamic>> getLocalAllLanguages() async {
    return await _c.invokeMethod(
      'getLocalAllLanguages',
    );
  }

  Future<List<dynamic>> syncGetCloudAllLanguages() async {
    return await _c.invokeMethod(
      'syncGetCloudAllLanguages',
    );
  }

  Future<List<dynamic>> syncGetLocalAllLanguages() async {
    return await _c.invokeMethod(
      'syncGetLocalAllLanguages',
    );
  }
}

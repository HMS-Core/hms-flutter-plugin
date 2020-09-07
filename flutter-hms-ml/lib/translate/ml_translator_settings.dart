/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'dart:convert';

class MlTranslatorSettings {
  String targetLangCode;
  String sourceLangCode;
  String sourceText;

  MlTranslatorSettings() {
    targetLangCode = null;
    sourceLangCode = null;
    sourceText = null;
  }

  Map<String, dynamic> toMap() {
    return {
      "settings": {
        "targetLangCode": json.encode(targetLangCode),
        "sourceLangCode": json.encode(sourceLangCode),
        "sourceText": json.encode(sourceText)
      }
    };
  }
}

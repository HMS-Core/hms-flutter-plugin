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

class MLDetectedLang {
  dynamic probability;
  String? langCode;

  MLDetectedLang({
    this.probability,
    this.langCode,
  });

  factory MLDetectedLang.fromJson(Map<dynamic, dynamic> json) {
    return MLDetectedLang(
      probability: json['probability'],
      langCode: json['langCode'],
    );
  }
}

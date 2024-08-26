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

class MLTranslateSetting {
  String _sourceTextOnRemote;
  String? _sourceLangCode;
  String? _targetLangCode;

  MLTranslateSetting._(
    this._sourceTextOnRemote, [
    this._sourceLangCode,
    this._targetLangCode,
  ]);

  factory MLTranslateSetting.remote({
    required String sourceText,
    String? sourceLangCode,
    String? targetLangCode,
  }) {
    return MLTranslateSetting._(
      sourceText,
      sourceLangCode,
      targetLangCode,
    );
  }

  factory MLTranslateSetting.local({
    String? sourceLangCode,
    String? targetLangCode,
  }) {
    return MLTranslateSetting._(
      '',
      sourceLangCode,
      targetLangCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sourceText': _sourceTextOnRemote,
      'sourceLang': _sourceLangCode ?? 'en',
      'targetLang': _targetLangCode ?? 'zh',
    };
  }
}

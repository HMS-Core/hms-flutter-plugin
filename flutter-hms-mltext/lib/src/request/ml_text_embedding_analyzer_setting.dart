/*
 * Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

part of '../../huawei_ml_text.dart';

class MLTextEmbeddingAnalyzerSetting {
  static const String languageZh = 'zh';
  static const String languageEn = 'en';

  String? language;

  MLTextEmbeddingAnalyzerSetting({
    this.language,
  });

  String? get getLanguage => language;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'language': language ?? languageEn,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is MLTextEmbeddingAnalyzerSetting &&
        other.language == language;
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        language,
      ],
    );
  }
}

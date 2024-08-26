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

class MLRemoteAftSetting {
  static const String LANGUAGE_ZH = 'zh';
  static const String LANGUAGE_EN_US = 'en-US';

  String path;
  String? language;
  bool? enablePunctuation;
  bool? enableWordTimeOffset;
  bool? enableSentenceTimeOffset;

  MLRemoteAftSetting({
    required this.path,
    this.language,
    this.enablePunctuation,
    this.enableSentenceTimeOffset,
    this.enableWordTimeOffset,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'language': language ?? LANGUAGE_EN_US,
      'enablePunctuation': enablePunctuation ?? false,
      'enableWordTimeOffset': enableWordTimeOffset ?? false,
      'enableSentenceTimeOffset': enableSentenceTimeOffset ?? false,
    };
  }
}

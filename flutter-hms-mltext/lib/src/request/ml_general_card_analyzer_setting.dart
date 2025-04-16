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

class MLGeneralCardAnalyzerSetting {
  String path;
  String? language;
  int? backButtonResId;
  int? photoButtonResId;
  Color? scanBoxCornerColor;
  Color? tipTextColor;
  String? tipText;
  int? torchOnResId;
  int? torchOffResId;

  MLGeneralCardAnalyzerSetting._({
    required this.path,
    this.language,
    this.backButtonResId,
    this.photoButtonResId,
    this.scanBoxCornerColor,
    this.tipText,
    this.tipTextColor,
    this.torchOffResId,
    this.torchOnResId,
  });

  factory MLGeneralCardAnalyzerSetting.image({
    required String path,
    String? language,
  }) {
    return MLGeneralCardAnalyzerSetting._(
      path: path,
      language: language,
    );
  }

  factory MLGeneralCardAnalyzerSetting.capture({
    String? language,
    int? backButtonResId,
    int? photoButtonResId,
    Color? scanBoxCornerColor,
    Color? tipTextColor,
    String? tipText,
    int? torchOnResId,
    int? torchOffResId,
  }) {
    return MLGeneralCardAnalyzerSetting._(
      path: '',
      language: language,
      backButtonResId: backButtonResId,
      photoButtonResId: photoButtonResId,
      scanBoxCornerColor: scanBoxCornerColor,
      tipTextColor: tipTextColor,
      tipText: tipText,
      torchOnResId: torchOnResId,
      torchOffResId: torchOffResId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'language': language ?? 'zh',
      'scanBoxCornerColor':
          '#${(scanBoxCornerColor ?? Colors.green).value.toRadixString(16)}',
      'tipText': tipText ?? 'Recognizing..',
      'tipTextColor': scanBoxCornerColor != null
          ? '#${tipTextColor?.value.toRadixString(16)}'
          : '#${Colors.white.value.toRadixString(16)}',
      'backButtonResId': backButtonResId ?? 2131165292,
      'photoButtonResId': photoButtonResId ?? 2131165293,
      'torchOnResId': torchOnResId ?? 2131165294,
      'torchOffResId': torchOffResId ?? 2131165295,
    };
  }
}

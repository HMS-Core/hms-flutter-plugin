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

class MLTextAnalyzerSetting {
  /// Independent detection mode. Each supplied image is detected independently.
  /// This mode applies to single image detection.
  static const int ocrDetectMode = 1;

  /// Tracking mode. The detection result of the preceding frame is used as the basis to
  /// quickly detect the text position in the image. This mode applies to video stream text detection.
  static const int ocrTrackingMode = 2;

  /// Text bounding box that is a polygon.
  static const String arc = 'ARC';

  /// Text bounding box that is a quadrilateral.
  static const String ngon = 'NGON';

  /// Dense text type, such as user instructions.
  static const int ocrCompactScene = 2;

  /// Sparse text type, such as business cards.
  static const int ocrLooseScene = 1;

  String path;
  bool isRemote;
  int? ocrMode;
  String? language;
  List<String?> languageList;
  String? borderType;
  int? textDensityScene;

  MLTextAnalyzerSetting._({
    required this.path,
    required this.isRemote,
    this.ocrMode,
    this.language,
    this.languageList = const <String>[],
    this.borderType,
    this.textDensityScene,
  });

  /// Constructor for on device text recognition.
  factory MLTextAnalyzerSetting.local({
    required String path,
    int ocrMode = ocrDetectMode,
    String language = 'zh',
  }) {
    return MLTextAnalyzerSetting._(
      path: path,
      isRemote: false,
      ocrMode: ocrMode,
      language: language,
    );
  }

  /// Constructor for on cloud text recognition.
  factory MLTextAnalyzerSetting.remote({
    required String path,
    String borderType = arc,
    List<String> languageList = const <String>[],
    int textDensityScene = ocrCompactScene,
  }) {
    return MLTextAnalyzerSetting._(
      path: path,
      isRemote: true,
      borderType: borderType,
      languageList: languageList,
      textDensityScene: textDensityScene,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'ocrMode': ocrMode,
      'language': language,
      'languageList': languageList,
      'borderType': borderType,
      'textDensityScene': textDensityScene,
      'isRemote': isRemote,
    };
  }
}

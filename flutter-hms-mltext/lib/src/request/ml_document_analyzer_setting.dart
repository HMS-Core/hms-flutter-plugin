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

class MLDocumentAnalyzerSetting {
  String path;
  String? borderType;
  List<String?> languageList;
  bool? enableFingerPrintVerification;

  MLDocumentAnalyzerSetting._({
    required this.path,
    this.languageList = const <String>[],
    this.borderType,
    this.enableFingerPrintVerification,
  });

  factory MLDocumentAnalyzerSetting.create({
    required String path,
    String borderType = 'ARC',
    List<String> languageList = const <String>[],
    bool enableFingerPrintVerification = true,
  }) {
    return MLDocumentAnalyzerSetting._(
      path: path,
      borderType: borderType,
      languageList: languageList,
      enableFingerPrintVerification: enableFingerPrintVerification,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'borderType': borderType,
      'languageList': languageList,
      'fingerPrint': enableFingerPrintVerification,
    };
  }
}

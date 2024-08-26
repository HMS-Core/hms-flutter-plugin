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

part of '../../huawei_ml_text.dart';

class MlBankcardSettings {
  /// Failed to initialize the camera.
  static const int errorCodeInitCameraFailed = 10101;

  /// Adaptive mode. The physical sensor determines the screen orientation.
  static const int orientationAuto = 0;

  /// Portrait mode. The screen height is greater than the screen width.
  static const int orientationPortrait = 2;

  /// Landscape mode. The screen width is greater than the screen height.
  static const int orientationLandspace = 1;

  /// Only the bank card number is recognized.
  static const int resultNumOnly = 0;

  /// Only two items recognized, including bank card number and validity period.
  static const int resultSimple = 1;

  /// Recognized information, such as the bank card number,
  /// validity period, issuing bank, card organization, and card type.
  static const int resultAll = 2;

  /// Weak recognition mode.
  static const int weakMode = 0;

  /// Strict recognition mode.
  static const int strictMode = 1;

  String path;
  String? langType;
  int? orientation;
  int? resultType;
  int? rectMode;

  MlBankcardSettings._({
    required this.path,
    this.orientation,
    this.rectMode,
    this.resultType,
    this.langType,
  });

  factory MlBankcardSettings.capture({
    int? orientation,
    int? resultType,
    int? rectMode,
  }) {
    return MlBankcardSettings._(
      path: '',
      orientation: orientation,
      rectMode: rectMode,
      resultType: resultType,
    );
  }

  factory MlBankcardSettings.image({
    required String path,
    String? langType,
    int? resultType,
    int? rectMode,
  }) {
    return MlBankcardSettings._(
      path: path,
      langType: langType,
      resultType: resultType,
      rectMode: rectMode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'langType': langType ?? 'zh',
      'orientation': orientation ?? orientationAuto,
      'resultType': resultType ?? resultAll,
      'rectMode': rectMode ?? strictMode,
    };
  }
}

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

part of '../../huawei_ml_body.dart';

typedef CustomizedLifeCycleListener = Function(
  CustomizedViewEvent lifecycleStatus,
);

class MLCustomInteractiveLivenessDetectionSetting {
  /// Nod.
  static const int shakeDownAction = 1;

  /// Open mouth.
  static const int openMouthAction = 2;

  /// Blink.
  static const int eyeCloseAction = 3;

  /// Turn left.
  static const int shakeLeftAction = 4;

  /// Turn right.
  static const int shakeRightAction = 5;

  /// Stare at the screen.
  static const int gazedAction = 6;

  MlBodyActions? action;
  int detectionTimeOut;
  Rect cameraFrame;
  Rect faceFrame;
  int textMargin;
  TextOptions? textOptions;
  String? title;
  bool? showStatusCodes;
  Map<int, String>? statusCodes;
  CustomizedLifeCycleListener? customizedLifeCycleListener;

  MLCustomInteractiveLivenessDetectionSetting({
    required this.detectionTimeOut,
    required this.cameraFrame,
    required this.faceFrame,
    required this.textMargin,
    this.action,
    this.textOptions,
    this.customizedLifeCycleListener,
    this.title,
    this.showStatusCodes,
    this.statusCodes,
  });

  factory MLCustomInteractiveLivenessDetectionSetting.fromJson(String str) {
    return MLCustomInteractiveLivenessDetectionSetting.fromMap(
        json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory MLCustomInteractiveLivenessDetectionSetting.fromMap(
      Map<String, dynamic> json) {
    return MLCustomInteractiveLivenessDetectionSetting(
      action: json['action'] == null
          ? null
          : MlBodyActions.fromJson(json['action']),
      detectionTimeOut: json['detectionTimeOut'],
      cameraFrame: Rect.fromJson(json['cameraFrame']),
      faceFrame: Rect.fromJson(json['faceFrame']),
      textMargin: json['textMargin'],
      textOptions: json['textOptions'] == null
          ? null
          : TextOptions.fromJson(json['textOptions']),
      title: json['title'],
      showStatusCodes: json['showStatusCodes'],
      statusCodes: Map<int, String>.from(json['statusCodes']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'action': action == null ? null : action!.toMap(),
      'detectionTimeOut': detectionTimeOut,
      'cameraFrame': cameraFrame.toJson(),
      'faceFrame': faceFrame.toJson(),
      'textMargin': textMargin,
      'textOptions': textOptions == null ? null : textOptions!.toJson(),
      'title': title,
      'showStatusCodes': showStatusCodes,
      'statusCodes': statusCodes,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is MLCustomInteractiveLivenessDetectionSetting &&
        other.action == action &&
        other.detectionTimeOut == detectionTimeOut &&
        other.cameraFrame == cameraFrame &&
        other.faceFrame == faceFrame &&
        other.textMargin == textMargin &&
        other.textOptions == textOptions &&
        other.showStatusCodes == showStatusCodes &&
        other.statusCodes == statusCodes &&
        other.title == title;
  }
}

enum CustomizedViewEvent { onStart, onResume, onPause, onDestroy, onStop }

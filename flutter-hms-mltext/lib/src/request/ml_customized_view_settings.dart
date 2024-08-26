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

typedef CustomizedLifeCycleListener = Function(
  CustomizedViewEvent lifecycleStatus,
);

class MLCustomizedViewSetting {
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

  bool? isTitleAvailable;
  String? title;
  bool? isFlashAvailable;
  double? heightFactor;
  double? widthFactor;
  int? resultType;
  int? rectMode;

  CustomizedLifeCycleListener? customizedLifeCycleListener;

  MLCustomizedViewSetting({
    this.isTitleAvailable = true,
    this.title = "Place the card within the frame",
    this.isFlashAvailable = true,
    this.heightFactor = 0.8,
    this.widthFactor = 0.8,
    this.resultType,
    this.rectMode,
    this.customizedLifeCycleListener,
  });

  factory MLCustomizedViewSetting.fromJson(String str) {
    return MLCustomizedViewSetting.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory MLCustomizedViewSetting.fromMap(Map<String, dynamic> json) {
    return MLCustomizedViewSetting(
      isTitleAvailable: json['isTitleAvailable'],
      title: json['title'],
      isFlashAvailable: json['isFlashAvailable'],
      heightFactor: json['heightFactor'].toDouble(),
      widthFactor: json['widthFactor'].toDouble(),
      resultType: json['resultType'],
      rectMode: json['rectMode'],
    );
  }

  Map<dynamic, dynamic> toMap() {
    return <dynamic, dynamic>{
      'isTitleAvailable': isTitleAvailable,
      'title': title,
      'isFlashAvailable': isFlashAvailable,
      'heightFactor': heightFactor,
      'widthFactor': widthFactor,
      'resultType': resultType,
      'rectMode': rectMode,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is MLCustomizedViewSetting &&
        other.isTitleAvailable == isTitleAvailable &&
        other.title == title &&
        other.isFlashAvailable == isFlashAvailable &&
        other.heightFactor == heightFactor &&
        other.widthFactor == widthFactor &&
        other.resultType == resultType &&
        other.rectMode == rectMode;
  }

  @override
  int get hashCode {
    return Object.hash(
      isTitleAvailable,
      title,
      isFlashAvailable,
      heightFactor,
      widthFactor,
      resultType,
      rectMode,
    );
  }
}

enum CustomizedViewEvent { onStart, onResume, onPause, onDestroy, onStop }

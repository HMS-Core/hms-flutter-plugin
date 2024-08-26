/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of '../../../huawei_ads.dart';

class PlayerConfig {
  /// Whether the player adapts to a notched screen.
  bool isEnableCutout;

  /// Whether the portrait mode is enabled.
  bool isEnablePortrait;

  /// Whether the landscape mode is enabled.
  bool isEnableRotation;

  /// Whether the player is forcibly muted.
  bool isForceMute;

  /// Whether the industry icon is displayed.
  bool isIndustryIconShow;

  /// Whether a linear ad is skippable.
  bool isSkipLinearAd;

  PlayerConfig({
    this.isEnableCutout = true,
    this.isEnablePortrait = false,
    this.isEnableRotation = true,
    this.isForceMute = false,
    this.isIndustryIconShow = true,
    this.isSkipLinearAd = true,
  });

  factory PlayerConfig._fromMap(Map<dynamic, dynamic> map) {
    return PlayerConfig(
      isEnableCutout: map['isEnableCutout'],
      isEnablePortrait: map['isEnablePortrait'],
      isEnableRotation: map['isEnableRotation'],
      isForceMute: map['isForceMute'],
      isIndustryIconShow: map['isIndustryIconShow'],
      isSkipLinearAd: map['isSkipLinearAd'],
    );
  }

  Map<String, bool> _toMap() {
    return <String, bool>{
      'isEnableCutout': isEnableCutout,
      'isEnablePortrait': isEnablePortrait,
      'isEnableRotation': isEnableRotation,
      'isForceMute': isForceMute,
      'isIndustryIconShow': isIndustryIconShow,
      'isSkipLinearAd': isSkipLinearAd,
    };
  }
}

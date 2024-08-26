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

class BaseAdSlot {
  /// Ad unit ID.
  String slotId;

  /// Total ad duration.
  int totalDuration;

  /// Ad unit width.
  int? width;

  /// Ad unit height.
  int? height;

  /// Request configurations.
  VastRequestOptions requestOptions;

  /// Screen orientation.
  Orientation orientation;

  /// Maximum number of ads in a pod that can be requested each time.
  int? maxAdPods;

  /// Ad creative matching strategy.
  CreativeMatchStrategy? creativeMatchStrategy;

  /// Whether mobile data can be used to preload ad content.
  bool allowMobileTraffic;

  BaseAdSlot({
    required this.slotId,
    required this.totalDuration,
    required this.requestOptions,
    this.width,
    this.height,
    this.orientation = Orientation.PORTRAIT,
    this.maxAdPods,
    this.creativeMatchStrategy,
    this.allowMobileTraffic = false,
  });

  Map<String, dynamic> _toMap() {
    return <String, dynamic>{
      'slotId': slotId,
      'totalDuration': totalDuration,
      'width': width,
      'height': height,
      'requestOptions': requestOptions._toMap(),
      'orientation': orientation.value,
      'maxAdPods': maxAdPods,
      'creativeMatchStrategy': creativeMatchStrategy?.value,
      'allowMobileTraffic': allowMobileTraffic,
    };
  }
}

class Orientation {
  static const Orientation PORTRAIT = Orientation._(0);
  static const Orientation LANDSCAPE = Orientation._(1);

  final int value;
  const Orientation._(this.value);
}

class CreativeMatchStrategy {
  /// Exactly matches ads according to the expected width and height.
  static const CreativeMatchStrategy EXACT = CreativeMatchStrategy._('EXACT');

  /// Intelligently matches ads according to the expected width and height.
  static const CreativeMatchStrategy SMART = CreativeMatchStrategy._('SMART');

  /// Unknown creative dimensions.
  static const CreativeMatchStrategy UNKNOWN =
      CreativeMatchStrategy._('UNKNOWN');

  /// Ad creatives of all dimension types will be returned randomly.
  static const CreativeMatchStrategy ANY = CreativeMatchStrategy._('ANY');

  /// Only ad creatives in landscape mode, whose width is greater than its height, will be returned.
  static const CreativeMatchStrategy LANDSCAPE =
      CreativeMatchStrategy._('LANDSCAPE');

  /// Only ad creatives in portrait mode, whose height is greater than its width, will be returned.
  static const CreativeMatchStrategy PORTRAIT =
      CreativeMatchStrategy._('PORTRAIT');

  /// Only square ad creatives will be returned.
  static const CreativeMatchStrategy SQUARE = CreativeMatchStrategy._('SQUARE');

  final String value;
  const CreativeMatchStrategy._(this.value);
}

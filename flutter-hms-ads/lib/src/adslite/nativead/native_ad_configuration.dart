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

class NativeAdConfiguration {
  /// Size of a native ad.
  AdSize? adSize;

  /// NativeAdChoicesPosition of an AdChoices icon.
  NativeAdChoicesPosition? choicesPosition;

  /// Orientation of an ad image.
  int? mediaDirection;

  /// Aspect ratio of an ad image.
  int? mediaAspect;

  /// Indicates whether to customize the function of not displaying the ad.
  bool? requestCustomDislikeAd;

  /// Indicates whether multiple ad images are requested.
  bool? requestMultiImages;

  /// Indicates whether the SDK is allowed to download native ad images.
  bool? returnUrlsForImages;

  /// Obtains video configuration.
  VideoConfiguration? videoConfiguration;

  NativeAdConfiguration({
    this.adSize,
    this.choicesPosition,
    this.mediaDirection,
    this.mediaAspect,
    this.requestCustomDislikeAd,
    this.requestMultiImages,
    this.returnUrlsForImages,
    VideoConfiguration? configuration,
  }) : videoConfiguration = configuration ?? VideoConfiguration();

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'adSize': adSize?.toJson(),
      'choicesPosition': choicesPosition?.value,
      'direction': mediaDirection,
      'aspect': mediaAspect,
      'requestCustomDislikeAd': requestCustomDislikeAd,
      'requestMultiImages': requestMultiImages,
      'returnUrlsForImages': returnUrlsForImages,
      'videoConfiguration': videoConfiguration?.toJson(),
    }..removeWhere((_, dynamic v) => v == null);
  }
}

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

class BannerAdSize extends AdSize {
  static const BannerAdSize s360x57 = BannerAdSize(width: 360, height: 57);
  static const BannerAdSize s360x144 = BannerAdSize(width: 360, height: 144);
  static const BannerAdSize s320x50 = BannerAdSize(width: 320, height: 50);
  static const BannerAdSize s468x60 = BannerAdSize(width: 468, height: 60);
  static const BannerAdSize s320x100 = BannerAdSize(width: 320, height: 100);
  static const BannerAdSize s728x90 = BannerAdSize(width: 728, height: 90);
  static const BannerAdSize s300x250 = BannerAdSize(width: 300, height: 250);
  static const BannerAdSize s160x600 = BannerAdSize(width: 160, height: 600);

  /// Invalid dimensions. No ad can be requested using the dimensions.
  static const BannerAdSize sInvalid = BannerAdSize(width: 0, height: 0);

  /// Dynamic banner ad dimensions. The width of the parent layout and the height of the ad content are used.
  static const BannerAdSize sDynamic = BannerAdSize(width: -3, height: -4);

  /// Dynamic banner ad dimensions. The screen width and an adaptive height are used.
  static const BannerAdSize sSmart = BannerAdSize(width: -1, height: -2);

  /// Adaptive banner size, calculate the appropriate size
  /// according to the size of the device and the horizontal and vertical screen state.
  static const BannerAdSize sAdvanced = BannerAdSize(width: -1, height: -5);

  const BannerAdSize({
    required int width,
    required int height,
  }) : super(width: width, height: height);

  /// Obtains the ad width, in pixels. If it fails to be obtained, `–1` is returned.
  Future<int?> get getWidthPx async {
    return Ads.instance.channel.invokeMethod(
      'bannerSize-getWidthPx',
      super.toJson(),
    );
  }

  /// Obtains the ad height, in pixels. If it fails to be obtained, `–1` is returned.
  Future<int?> get getHeightPx async {
    return Ads.instance.channel.invokeMethod(
      'bannerSize-getHeightPx',
      super.toJson(),
    );
  }

  /// Checks whether an adaptive height is used.
  bool get isAutoHeightSize => super.height == -2;

  /// Checks whether a dynamic size is used.
  bool get isDynamicSize => super.width == -3 && super.height == -4;

  /// Checks whether a full-screen width is used.
  bool get isFullWidthSize => super.width == -1;

  /// Creates a banner ad size based on the current device orientation and a custom width.
  static Future<BannerAdSize> getCurrentDirectionBannerSize(int width) async {
    Map<dynamic, dynamic> bannerJson = await Ads.instance.channel.invokeMethod(
      'getCurrentDirectionBannerSize',
      <String, dynamic>{
        'width': width,
      },
    );
    return fromJson(bannerJson);
  }

  /// Creates a banner ad size based on a custom width in landscape orientation.
  static Future<BannerAdSize> getLandscapeBannerSize(int width) async {
    Map<dynamic, dynamic> bannerJson = await Ads.instance.channel.invokeMethod(
      'getLandscapeBannerSize',
      <String, dynamic>{
        'width': width,
      },
    );
    return fromJson(bannerJson);
  }

  /// Creates a banner ad size based on a custom width in portrait orientation.
  static Future<BannerAdSize> getPortraitBannerSize(int width) async {
    Map<dynamic, dynamic> bannerJson = await Ads.instance.channel.invokeMethod(
      'getPortraitBannerSize',
      <String, dynamic>{
        'width': width,
      },
    );
    return fromJson(bannerJson);
  }

  static BannerAdSize fromJson(Map<dynamic, dynamic> args) {
    return BannerAdSize(
      width: args['width'] ?? 0,
      height: args['height'] ?? 0,
    );
  }
}

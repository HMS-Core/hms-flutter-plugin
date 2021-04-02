/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ads/adslite/ad_size.dart';
import 'package:huawei_ads/hms_ads.dart';
import 'package:flutter/foundation.dart';

class BannerAdSize extends AdSize {
  const BannerAdSize({@required int width, @required int height})
      : super(width: width, height: height);

  static const BannerAdSize s360x57 = BannerAdSize(width: 360, height: 57);
  static const BannerAdSize s360x144 = BannerAdSize(width: 360, height: 144);
  static const BannerAdSize s320x50 = BannerAdSize(width: 320, height: 50);
  static const BannerAdSize s468x60 = BannerAdSize(width: 468, height: 60);
  static const BannerAdSize s320x100 = BannerAdSize(width: 320, height: 100);
  static const BannerAdSize s728x90 = BannerAdSize(width: 728, height: 90);
  static const BannerAdSize s300x250 = BannerAdSize(width: 300, height: 250);
  static const BannerAdSize s160x600 = BannerAdSize(width: 160, height: 600);
  static const BannerAdSize sInvalid = BannerAdSize(width: 0, height: 0);
  static const BannerAdSize sDynamic = BannerAdSize(width: -3, height: -4);
  static const BannerAdSize sSmart = BannerAdSize(width: -1, height: -2);

  Future<int> get getWidthPx async {
    return Ads.instance.channel
        .invokeMethod("bannerSize-getWidthPx", super.toJson());
  }

  Future<int> get getHeightPx async {
    return Ads.instance.channel
        .invokeMethod("bannerSize-getHeightPx", super.toJson());
  }

  bool get isAutoHeightSize => super.height == -2;
  bool get isDynamicSize => super.width == -3 && super.height == -4;
  bool get isFullWidthSize => super.width == -1;

  static Future<BannerAdSize> getCurrentDirectionBannerSize(int width) async {
    final Map<String, dynamic> json = <String, dynamic>{};
    if (width != null) json['width'] = width;
    Map<dynamic, dynamic> bannerJson = await Ads.instance.channel
        .invokeMethod("getCurrentDirectionBannerSize", json);
    return fromJson(bannerJson);
  }

  static Future<BannerAdSize> getLandscapeBannerSize(int width) async {
    final Map<String, dynamic> json = <String, dynamic>{};
    if (width != null) json['width'] = width;
    Map<dynamic, dynamic> bannerJson =
        await Ads.instance.channel.invokeMethod("getLandscapeBannerSize", json);
    return fromJson(bannerJson);
  }

  static Future<BannerAdSize> getPortraitBannerSize(int width) async {
    final Map<String, dynamic> json = <String, dynamic>{};
    if (width != null) json['width'] = width;
    Map<dynamic, dynamic> bannerJson =
        await Ads.instance.channel.invokeMethod("getPortraitBannerSize", json);
    return fromJson(bannerJson);
  }

  static BannerAdSize fromJson(Map<dynamic, dynamic> args) {
    int width = args['width'] ?? 0;
    int height = args['height'] ?? 0;
    return BannerAdSize(width: width, height: height);
  }
}

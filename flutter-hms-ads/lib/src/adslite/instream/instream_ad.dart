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

class InstreamAd {
  /// Identifier for a platform channel, which is used by the plugin.
  final int id;

  final MethodChannel _channel;

  InstreamAd({
    required this.id,
  }) : _channel = MethodChannel('$_INSTREAM_METHOD_CHANNEL/AD/$id');

  /// Returns real-time bidding data.
  Future<BiddingInfo?> getBiddingInfo() async {
    return BiddingInfo.fromJson(await Ads.instance.channelBanner.invokeMethod(
      'getBiddingInfo',
    ));
  }

  /// Obtains ad source text.
  Future<String?> getAdSource() async {
    return await _channel.invokeMethod(
      'getAdSource',
    );
  }

  /// Obtains the text to be displayed on a button.
  Future<String?> getCallToAction() async {
    return await _channel.invokeMethod(
      'getCallToAction',
    );
  }

  /// Obtains ad duration, in milliseconds.
  Future<int?> getDuration() async {
    return await _channel.invokeMethod(
      'getDuration',
    );
  }

  /// Obtains the URL of the `Why this ad` page.
  Future<String?> getWhyThisAd() async {
    return await _channel.invokeMethod(
      'getWhyThisAd',
    );
  }

  /// Obtains the ad sign.
  Future<String?> getAdSign() async {
    return await _channel.invokeMethod(
      'getAdSign',
    );
  }

  /// Checks whether an ad is clicked.
  Future<bool?> isClicked() async {
    return await _channel.invokeMethod(
      'isClicked',
    );
  }

  /// Checks whether an ad is expired.
  Future<bool?> isExpired() async {
    return await _channel.invokeMethod(
      'isExpired',
    );
  }

  /// Checks whether an ad is an image ad.
  Future<bool?> isImageAd() async {
    return await _channel.invokeMethod(
      'isImageAd',
    );
  }

  /// Checks whether an ad is displayed.
  Future<bool?> isShown() async {
    return await _channel.invokeMethod(
      'isShown',
    );
  }

  /// Checks whether an ad is a video ad.
  Future<bool?> isVideoAd() async {
    return await _channel.invokeMethod(
      'isVideoAd',
    );
  }

  /// Goes to the `Why this ad` page.
  Future<bool?> gotoWhyThisAdPage() async {
    return await _channel.invokeMethod(
      'gotoWhyThisAdPage',
    );
  }

  /// Checks whether advertiser information is delivered for the current ad.
  Future<bool> hasAdvertiserInfo() async {
    return await _channel.invokeMethod(
      'hasAdvertiserInfo',
    );
  }

  /// Obtains the advertiser information.
  Future<List<AdvertiserInfo>> getAdvertiserInfo() async {
    final List<dynamic> result = await _channel.invokeMethod(
      'getAdvertiserInfo',
    );
    final List<AdvertiserInfo> list = <AdvertiserInfo>[];
    for (dynamic map in result) {
      list.add(AdvertiserInfo._fromMap(map as Map<dynamic, dynamic>));
    }
    return list;
  }

  /// Indicates whether ad transparency information is displayed.
  Future<bool> isTransparencyOpen() async {
    return await _channel.invokeMethod(
      'isTransparencyOpen',
    );
  }

  /// Obtains the redirection URL of the ad transparency information.
  Future<String> transparencyTplUrl() async {
    return await _channel.invokeMethod(
      'transparencyTplUrl',
    );
  }
}

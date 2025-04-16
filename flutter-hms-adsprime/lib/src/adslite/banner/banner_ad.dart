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

part of '../../../huawei_adsprime.dart';

class BannerAd {
  static final Map<int, BannerAd?> bannerAds = <int, BannerAd?>{};
  int get id => hashCode;

  static const String _adType = 'Banner';

  /// Ad slot ID
  String adSlotId;

  /// Ad request parameters.
  AdParam adParam;

  /// Banner ad size
  BannerAdSize size;

  /// Refresh interval for banner ads.
  ///
  /// Refresh interval, in seconds. The value ranges from 30 to 120.
  int? bannerRefreshTime;

  /// Obtains an ad listener.
  AdListener? _listener;

  late EventChannel _streamBanner;

  StreamSubscription<dynamic>? _listenerSub;

  BannerAd({
    required this.adSlotId,
    required this.size,
    this.bannerRefreshTime,
    AdListener? listener,
    AdParam? adParam,
  }) : adParam = adParam ?? AdParam() {
    bannerAds[id] = this;
    _streamBanner = EventChannel('$_BANNER_EVENT_CHANNEL/$id');
    _listener = listener;
  }

  /// Sets an ad listener for an ad.
  set setAdListener(AdListener listener) {
    _listener = listener;
  }

  /// Obtains an ad listener for an ad.
  AdListener? get getAdListener => _listener;

  Future<bool?> _initAd() async {
    return await Ads.instance.channelBanner.invokeMethod(
      'initBannerAd',
      <String, dynamic>{
        'id': id,
        'width': size.width,
        'height': size.height,
        'refreshTime': bannerRefreshTime,
      },
    );
  }

  /// Returns real-time bidding data.
  Future<BiddingInfo?> getBiddingInfo() async {
    return BiddingInfo.fromJson(await Ads.instance.channelBanner.invokeMethod(
      'getBiddingInfo',
    ));
  }

  /// Loads an ad.
  Future<bool?> loadAd() async {
    await _initAd();
    _startListening();
    return await Ads.instance.channelBanner.invokeMethod(
      'loadBannerAd',
      <String, dynamic>{
        'id': id,
        'adSlotId': adSlotId,
        'adParam': adParam._toMap(),
      },
    );
  }

  /// Checks whether an ad is loading.
  Future<bool?> isLoading() async {
    return await Ads.instance.channelBanner.invokeMethod(
      'isAdLoading',
      <String, dynamic>{
        'id': id,
        'adSlotId': adSlotId,
        'adType': _adType,
      },
    );
  }

  /// Pauses any additional processing related to an ad.
  Future<bool?> pause() async {
    return await Ads.instance.channelBanner.invokeMethod(
      'pauseAd',
      <String, dynamic>{
        'id': id,
        'adSlotId': adSlotId,
        'adType': _adType,
      },
    );
  }

  /// Resumes an ad after the [pause()] method is called last time.
  Future<bool?> resume() async {
    return await Ads.instance.channelBanner.invokeMethod(
      'resumeAd',
      <String, dynamic>{
        'id': id,
        'adSlotId': adSlotId,
        'adType': _adType,
      },
    );
  }

  /// Displays an ad.
  Future<bool?> show({
    Gravity gravity = Gravity.bottom,
    double offset = 0.0,
  }) async {
    final bool? result = await Ads.instance.channelBanner.invokeMethod(
      'showBannerAd',
      <String, dynamic>{
        'id': id,
        'offset': offset.toString(),
        'gravity': describeEnum(gravity),
        'adType': _adType
      },
    );
    return result;
  }

  /// Destroys an ad.
  Future<bool?> destroy() async {
    bannerAds[id] = null;
    _listenerSub?.cancel();
    final bool? result = await Ads.instance.channelBanner.invokeMethod(
      'destroyAd',
      <String, dynamic>{
        'id': id,
        'adType': _adType,
      },
    );
    return result;
  }

  void _startListening() {
    _listenerSub?.cancel();
    _listenerSub = _streamBanner.receiveBroadcastStream(id).listen(
      (dynamic channelEvent) {
        final Map<dynamic, dynamic> argumentsMap = channelEvent;
        final AdEvent? event = Ads.toAdEvent(argumentsMap['event']);
        if (event != null) {
          event == AdEvent.failed
              ? _listener?.call(event, errorCode: argumentsMap['errorCode'])
              : _listener?.call(event);
        }
      },
    );
  }
}

/// Enum that specifies where a banner ad should be displayed on the screen.
///
/// The options include `bottom`, `center`, and `top`.
enum Gravity {
  bottom,
  center,
  top,
}

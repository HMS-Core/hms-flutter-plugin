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
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:huawei_ads/adslite/ad_param.dart';
import 'package:huawei_ads/hms_ads.dart';
import 'package:huawei_ads/utils/channels.dart';

class SplashAd {
  static final Map<int, SplashAd?> splashAds = <int, SplashAd?>{};
  int get id => hashCode;

  static final String _adType = 'Splash';
  SplashAdType adType;
  String? ownerText;
  String? footerText;
  String? logoResId;
  String? logoBgResId;
  String? mediaNameResId;
  String? sloganResId;
  String? wideSloganResId;
  int? audioFocusType;
  SplashAdDisplayListener? displayListener;
  SplashAdLoadListener? loadListener;
  EventChannel? _streamSplash;
  StreamSubscription? _listenerSub;

  SplashAd({
    required this.adType,
    this.displayListener,
    this.loadListener,
    this.ownerText,
    this.footerText,
    this.logoResId,
    this.logoBgResId,
    this.mediaNameResId,
    this.sloganResId,
    this.wideSloganResId,
    this.audioFocusType,
  }) {
    splashAds[id] = this;
    _streamSplash = EventChannel('$SPLASH_EVENT_CHANNEL/$id');
  }

  static Future<bool?> preloadAd(
      {required String adSlotId, int? orientation, AdParam? adParam}) {
    return Ads.instance.channelSplash
        .invokeMethod("preloadSplashAd", <String, dynamic>{
      'adSlotId': adSlotId,
      'adParam': adParam?.toJson(),
    });
  }

  Future<bool> loadAd(
      {required String adSlotId,
      required int orientation,
      required AdParam adParam,
      double topMargin = 0.0}) async {
    await Ads.instance.channelSplash
        .invokeMethod("prepareSplashAd", <String, dynamic>{
      'id': id,
      'adSlotId': adSlotId,
      'adType': describeEnum(adType),
      'orientation': orientation,
      'adParam': adParam.toJson(),
      "resources": _resourcesToJson(),
      "audioFocusType": audioFocusType,
      "topMargin": topMargin,
      "owner": ownerText,
      "footer": footerText,
    });
    _startListening();
    await Ads.instance.channelSplash
        .invokeMethod("loadSplashAd", <String, dynamic>{
      "id": id,
    });
    return true;
  }

  Future<bool?> isLoading() {
    return Ads.instance.channelSplash.invokeMethod(
        "isAdLoading", <String, dynamic>{'id': id, "adType": _adType});
  }

  Future<bool?> isLoaded() {
    return Ads.instance.channelSplash.invokeMethod(
        "isAdLoaded", <String, dynamic>{'id': id, "adType": _adType});
  }

  Future<bool?> pause() {
    return Ads.instance.channel.invokeMethod(
        "pauseAd", <String, dynamic>{'id': id, "adType": _adType});
  }

  Future<bool?> resume() {
    return Ads.instance.channelSplash.invokeMethod(
        "resumeAd", <String, dynamic>{'id': id, "adType": _adType});
  }

  Future<bool?> destroy() {
    splashAds[id] = null;
    _streamSplash = null;
    _listenerSub?.cancel();
    return Ads.instance.channelSplash
        .invokeMethod("destroyAd", <String, dynamic>{'id': id});
  }

  Map<String, dynamic> _resourcesToJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    if (logoResId != null) json['logoResId'] = logoResId;
    if (logoBgResId != null) json['logoBgResId'] = logoBgResId;
    if (mediaNameResId != null) json['mediaNameResId'] = mediaNameResId;
    if (sloganResId != null) json['sloganResId'] = sloganResId;
    if (wideSloganResId != null) json['wideSloganResId'] = wideSloganResId;
    if (ownerText != null) json['ownerText'] = ownerText;
    if (footerText != null) json['footerText'] = footerText;
    return json;
  }

  void _startListening() {
    _listenerSub?.cancel();
    _listenerSub =
        _streamSplash!.receiveBroadcastStream(id).listen((channelEvent) {
      final Map<dynamic, dynamic> argumentsMap = channelEvent;
      final SplashAdLoadEvent? loadEvent = _toLoadEvent(argumentsMap['event']);
      final SplashAdDisplayEvent? displayEvent =
          _toDisplayEvent(argumentsMap['event']);
      if (displayEvent != null) {
        displayListener?.call(displayEvent);
      } else if (loadEvent != null) {
        loadEvent == SplashAdLoadEvent.failedToLoad
            ? loadListener?.call(loadEvent,
                errorCode: argumentsMap['errorCode'])
            : loadListener?.call(loadEvent);
      }
    });
  }

  SplashAdLoadEvent? _toLoadEvent(String? event) => _loadEventMap[event!];

  SplashAdDisplayEvent? _toDisplayEvent(String? event) =>
      _displayEventMap[event!];

  static const Map<String, SplashAdLoadEvent> _loadEventMap =
      <String, SplashAdLoadEvent>{
    'onSplashAdLoaded': SplashAdLoadEvent.loaded,
    'onSplashAdDismissed': SplashAdLoadEvent.dismissed,
    'onSplashAdFailedToLoad': SplashAdLoadEvent.failedToLoad,
  };

  static const Map<String, SplashAdDisplayEvent> _displayEventMap =
      <String, SplashAdDisplayEvent>{
    'onSplashAdShowed': SplashAdDisplayEvent.showed,
    'onSplashAdClick': SplashAdDisplayEvent.click,
  };
}

typedef void SplashAdLoadListener(SplashAdLoadEvent event, {int? errorCode});

typedef void SplashAdDisplayListener(SplashAdDisplayEvent event);

enum SplashAdLoadEvent { loaded, dismissed, failedToLoad }

enum SplashAdDisplayEvent {
  showed,
  click,
}

enum SplashAdType { above, below, aboveNoLogo, belowNoLogo }

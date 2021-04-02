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
import 'package:flutter/services.dart';
import 'package:huawei_ads/hms_ads_lib.dart';
import 'utils/channels.dart';

class Ads {
  final MethodChannel channel;
  final MethodChannel channelSplash;
  final MethodChannel channelBanner;
  final MethodChannel channelReward;
  final MethodChannel channelInterstitial;
  final MethodChannel channelInstream;
  final MethodChannel channelConsent;
  final MethodChannel channelReferrer;
  final EventChannel streamConsent;

  Ads._({
    this.channel,
    this.channelSplash,
    this.channelBanner,
    this.channelReward,
    this.channelInterstitial,
    this.channelInstream,
    this.streamConsent,
    this.channelConsent,
    this.channelReferrer,
  }) {
    channelReferrer.setMethodCallHandler(InstallReferrerClient.onMethodCall);
  }

  static final Ads _instance = Ads._(
    channel: const MethodChannel(LIBRARY_METHOD_CHANNEL),
    channelSplash: const MethodChannel(SPLASH_METHOD_CHANNEL),
    channelBanner: const MethodChannel(BANNER_METHOD_CHANNEL),
    channelReward: const MethodChannel(REWARD_METHOD_CHANNEL),
    channelInterstitial: const MethodChannel(INTERSTITIAL_METHOD_CHANNEL),
    channelInstream: const MethodChannel(INSTREAM_METHOD_CHANNEL),
    streamConsent: const EventChannel(CONSENT_EVENT_CHANNEL),
    channelConsent: const MethodChannel(CONSENT_METHOD_CHANNEL),
    channelReferrer: const MethodChannel(REFERRER_METHOD_CHANNEL),
  );

  static Ads get instance => _instance;

  static AdEvent toAdEvent(String event) => _adEventMap[event];
  static const Map<String, AdEvent> _adEventMap = <String, AdEvent>{
    'onAdLoaded': AdEvent.loaded,
    'onAdFailed': AdEvent.failed,
    'onAdClicked': AdEvent.clicked,
    'onAdImpression': AdEvent.impression,
    'onAdOpened': AdEvent.opened,
    'onAdLeave': AdEvent.leave,
    'onAdClosed': AdEvent.closed,
    'onAdDisliked': AdEvent.disliked,
  };
}

typedef void AdListener(AdEvent event, {int errorCode});

enum AdEvent {
  clicked,
  closed,
  failed,
  impression,
  leave,
  loaded,
  opened,
  disliked
}

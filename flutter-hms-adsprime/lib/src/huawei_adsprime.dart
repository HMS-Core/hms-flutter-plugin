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

part of '../huawei_adsprime.dart';

class Ads {
  final MethodChannel channel;
  final MethodChannel channelSplash;
  final MethodChannel channelBanner;
  final MethodChannel channelReward;
  final MethodChannel channelInterstitial;
  final MethodChannel channelInstream;
  final MethodChannel channelVast;
  final MethodChannel channelConsent;
  final MethodChannel channelReferrer;
  final EventChannel streamConsent;

  Ads._({
    required this.channel,
    required this.channelSplash,
    required this.channelBanner,
    required this.channelReward,
    required this.channelInterstitial,
    required this.channelInstream,
    required this.channelVast,
    required this.streamConsent,
    required this.channelConsent,
    required this.channelReferrer,
  }) {
    channelReferrer.setMethodCallHandler(InstallReferrerClient.onMethodCall);
  }

  static final Ads _instance = Ads._(
    channel: const MethodChannel(_LIBRARY_METHOD_CHANNEL),
    channelSplash: const MethodChannel(_SPLASH_METHOD_CHANNEL),
    channelBanner: const MethodChannel(_BANNER_METHOD_CHANNEL),
    channelReward: const MethodChannel(_REWARD_METHOD_CHANNEL),
    channelInterstitial: const MethodChannel(_INTERSTITIAL_METHOD_CHANNEL),
    channelInstream: const MethodChannel(_INSTREAM_METHOD_CHANNEL),
    channelVast: const MethodChannel(_VAST_METHOD_CHANNEL),
    streamConsent: const EventChannel(_CONSENT_EVENT_CHANNEL),
    channelConsent: const MethodChannel(_CONSENT_METHOD_CHANNEL),
    channelReferrer: const MethodChannel(_REFERRER_METHOD_CHANNEL),
  );

  static Ads get instance => _instance;

  static AdEvent? toAdEvent(String event) {
    return _adEventMap[event];
  }

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

typedef AdListener = void Function(
  AdEvent event, {
  int? errorCode,
});

enum AdEvent {
  clicked,
  closed,
  failed,
  impression,
  leave,
  loaded,
  opened,
  disliked,
}

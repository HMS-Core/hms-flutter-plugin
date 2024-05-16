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

part of huawei_adsprime;

class InterstitialAd {
  static final Map<int, InterstitialAd?> interstitialAds =
      <int, InterstitialAd?>{};
  static final UniqueKey _rId = UniqueKey();
  bool? openInHmsCore;
  int get id => hashCode;
  int get rId => _rId.hashCode;

  static const String _adType = 'Interstitial';
  String adSlotId;
  AdParam adParam;
  AdListener? _listener;
  RewardAdListener? _rewardAdListener;
  late EventChannel _streamInterstitial;
  late EventChannel _streamReward;
  StreamSubscription<dynamic>? _listenerSub;
  StreamSubscription<dynamic>? _rewardAdListenerSub;

  InterstitialAd({
    required this.adSlotId,
    @Deprecated('') this.openInHmsCore,
    AdParam? adParam,
    AdListener? listener,
    RewardAdListener? rewardAdListener,
  }) : adParam = adParam ?? AdParam() {
    interstitialAds[id] = this;
    _streamInterstitial = EventChannel('$_INTERSTITIAL_EVENT_CHANNEL/$id');
    _streamReward = EventChannel('$_REWARD_EVENT_CHANNEL/$rId');
    _listener = listener;
    _rewardAdListener = rewardAdListener;
  }

  Future<bool?> _initAd() async {
    return await Ads.instance.channelInterstitial.invokeMethod(
      'initInterstitialAd',
      <String, dynamic>{
        'id': id,
        'rId': rId,
        'openInHmsCore': openInHmsCore,
      },
    );
  }

  Future<bool?> loadAd() async {
    await _initAd();
    _startListening();
    _startListeningReward();
    return await Ads.instance.channelInterstitial.invokeMethod(
      'loadInterstitialAd',
      <String, dynamic>{
        'id': id,
        'adSlotId': adSlotId,
        'adParam': adParam._toMap(),
      },
    );
  }

  set setAdListener(AdListener listener) {
    _listener = listener;
  }

  AdListener? get getAdListener => _listener;

  set setRewardAdListener(RewardAdListener rewardAdListener) {
    _rewardAdListener = rewardAdListener;
  }

  RewardAdListener? get getRewardAdListener => _rewardAdListener;

  Future<bool?> isLoading() async {
    return await Ads.instance.channelInterstitial.invokeMethod(
      'isAdLoading',
      <String, dynamic>{
        'id': id,
        'adSlotId': adSlotId,
        'adType': _adType,
      },
    );
  }

  Future<bool?> isLoaded() async {
    return await Ads.instance.channelInterstitial.invokeMethod(
      'isAdLoaded',
      <String, dynamic>{
        'id': id,
        'adType': _adType,
      },
    );
  }

  Future<bool?> show() async {
    final bool? result = await Ads.instance.channelInterstitial.invokeMethod(
      'showInterstitialAd',
      <String, dynamic>{
        'id': id,
        'adType': _adType,
      },
    );
    return result;
  }

  Future<bool?> destroy() async {
    interstitialAds[id] = null;
    final bool? result = await Ads.instance.channelInterstitial.invokeMethod(
      'destroyAd',
      <String, dynamic>{
        'id': id,
        'rId': rId,
        'adType': _adType,
      },
    );
    return result;
  }

  void _startListening() {
    _listenerSub?.cancel();
    _listenerSub = _streamInterstitial.receiveBroadcastStream(id).listen(
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

  void _startListeningReward() {
    _rewardAdListenerSub?.cancel();
    _rewardAdListenerSub = _streamReward.receiveBroadcastStream(rId).listen(
      (dynamic channelEvent) {
        final Map<dynamic, dynamic> argumentsMap = channelEvent;
        final RewardAdEvent? rewardAdEvent =
            RewardAd.toRewardAdEvent(argumentsMap['event']);
        if (rewardAdEvent == RewardAdEvent.failedToLoad) {
          _rewardAdListener?.call(
            rewardAdEvent,
            errorCode: argumentsMap['errorCode'],
          );
        } else if (rewardAdEvent == RewardAdEvent.rewarded) {
          _rewardAdListener?.call(
            rewardAdEvent,
            reward: Reward.fromJson(argumentsMap),
          );
        } else {
          _rewardAdListener?.call(rewardAdEvent);
        }
      },
    );
  }
}

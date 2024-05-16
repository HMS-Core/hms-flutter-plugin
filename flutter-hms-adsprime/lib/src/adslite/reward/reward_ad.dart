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

class Reward {
  final String? name;
  final int? amount;

  const Reward({
    this.name,
    this.amount,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'amount': amount,
    };
  }

  static Reward fromJson(Map<dynamic, dynamic> args) {
    return Reward(
      name: args['name'],
      amount: args['amount'] ?? 0,
    );
  }
}

class RewardAd {
  static final Map<int, RewardAd> rewardAds = <int, RewardAd>{};
  int get id => hashCode;

  static const String _adType = 'Reward';
  String? userId;
  String? data;
  bool? openInHmsCore;
  bool? setMobileDataAlertSwitch;
  RewardVerifyConfig? rewardVerifyConfig;
  RewardAdListener? _listener;
  late EventChannel _streamReward;
  StreamSubscription<dynamic>? _listenerSub;

  RewardAd({
    this.userId,
    this.data,
    @Deprecated('') this.openInHmsCore,
    this.setMobileDataAlertSwitch = true,
    RewardAdListener? listener,
  }) {
    rewardAds[id] = this;
    _streamReward = EventChannel('$_REWARD_EVENT_CHANNEL/$id');
    _listener = listener;
  }

  RewardAdListener? get getRewardAdListener => _listener;

  Future<Reward> getReward() async {
    final Map<dynamic, dynamic> args =
        await Ads.instance.channelReward.invokeMethod(
      'getRewardAdReward',
    );
    return Reward.fromJson(args);
  }

  set setRewardAdListener(RewardAdListener listener) {
    _listener = listener;
  }

  Future<bool?> _initAd() async {
    return await Ads.instance.channelReward.invokeMethod(
      'initRewardAd',
      <String, dynamic>{
        'id': id,
        'openInHmsCore': openInHmsCore,
      },
    );
  }

  Future<bool?> loadAd({
    required String adSlotId,
    required AdParam adParam,
  }) async {
    await _initAd();
    _startListening();
    return await Ads.instance.channelReward.invokeMethod(
      'loadRewardAd',
      <String, dynamic>{
        'id': id,
        'adSlotId': adSlotId,
        'adParam': adParam._toMap(),
        'userId': userId,
        'data': data,
        'setMobileDataAlertSwitch': setMobileDataAlertSwitch,
        'rewardVerifyConfig': rewardVerifyConfig?.toJson(),
      },
    );
  }

  Future<bool?> isLoaded() async {
    return await Ads.instance.channelReward.invokeMethod(
      'isAdLoaded',
      <String, dynamic>{
        'id': id,
        'adType': _adType,
      },
    );
  }

  Future<bool?> show() async {
    return await Ads.instance.channelReward.invokeMethod(
      'showRewardAd',
      <String, dynamic>{
        'id': id,
      },
    );
  }

  Future<bool?> pause() async {
    return await Ads.instance.channelReward.invokeMethod(
      'pauseAd',
      <String, dynamic>{
        'id': id,
        'adType': _adType,
      },
    );
  }

  Future<bool?> resume() async {
    return await Ads.instance.channelReward.invokeMethod(
      'resumeAd',
      <String, dynamic>{
        'id': id,
        'adType': _adType,
      },
    );
  }

  Future<bool?> destroy() async {
    return await Ads.instance.channelReward.invokeMethod(
      'destroyAd',
      <String, dynamic>{
        'id': id,
        'adType': _adType,
      },
    );
  }

  void _startListening() {
    _listenerSub?.cancel();
    _listenerSub = _streamReward.receiveBroadcastStream(id).listen(
      (dynamic channelEvent) {
        final Map<dynamic, dynamic> argumentsMap = channelEvent;
        final RewardAdEvent? rewardAdEvent = toRewardAdEvent(
          argumentsMap['event'],
        );
        if (rewardAdEvent == RewardAdEvent.failedToLoad) {
          _listener?.call(
            rewardAdEvent,
            errorCode: argumentsMap['errorCode'],
          );
        } else if (rewardAdEvent == RewardAdEvent.rewarded) {
          _listener?.call(
            rewardAdEvent,
            reward: Reward.fromJson(argumentsMap),
          );
        } else {
          _listener?.call(
            rewardAdEvent,
          );
        }
      },
    );
  }

  static RewardAdEvent? toRewardAdEvent(String? event) {
    return _rewardAdEventMap[event!];
  }

  static const Map<String, RewardAdEvent> _rewardAdEventMap =
      <String, RewardAdEvent>{
    'onRewarded': RewardAdEvent.rewarded,
    'onRewardAdClosed': RewardAdEvent.closed,
    'onRewardAdFailedToLoad': RewardAdEvent.failedToLoad,
    'onRewardAdLeftApp': RewardAdEvent.leftApp,
    'onRewardAdLoaded': RewardAdEvent.loaded,
    'onRewardAdOpened': RewardAdEvent.opened,
    'onRewardAdStarted': RewardAdEvent.started,
    'onRewardAdCompleted': RewardAdEvent.completed,
  };
}

typedef RewardAdListener = void Function(
  RewardAdEvent? event, {
  Reward? reward,
  int? errorCode,
});

enum RewardAdEvent {
  loaded,
  failedToLoad,
  opened,
  leftApp,
  closed,
  rewarded,
  started,
  completed,
}

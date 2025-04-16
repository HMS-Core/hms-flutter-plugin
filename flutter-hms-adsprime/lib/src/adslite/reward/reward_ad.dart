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

class Reward {
  /// Name of a reward item.
  final String? name;

  /// Number of reward items.
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

  /// User ID.
  String? userId;

  /// Custom data.
  String? data;

  /// Sets whether to remind users of mobile data usage in a pop-up upon video playback or app download.
  ///
  /// If `alertSwitch` is not set, the default value true is used, indicating that the pop-up will be displayed.
  bool? setMobileDataAlertSwitch;

  /// Server-side verification parameters.
  RewardVerifyConfig? rewardVerifyConfig;

  bool? openInHmsCore;
  RewardAdListener? _listener;
  late EventChannel _streamReward;
  StreamSubscription<dynamic>? _listenerSub;

  RewardAd({
    this.userId,
    this.data,
    @Deprecated('') this.openInHmsCore,
    this.setMobileDataAlertSwitch = true,
    this.rewardVerifyConfig,
    RewardAdListener? listener,
  }) {
    rewardAds[id] = this;
    _streamReward = EventChannel('$_REWARD_EVENT_CHANNEL/$id');
    _listener = listener;
  }

  int get id => hashCode;

  static const String _adType = 'Reward';

  /// Obtains a rewarded ad listener.
  RewardAdListener? get getRewardAdListener => _listener;

  /// Returns real-time bidding data.
  Future<BiddingInfo?> getBiddingInfo() async {
    return BiddingInfo.fromJson(await Ads.instance.channelBanner.invokeMethod(
      'getBiddingInfo',
    ));
  }

  /// Obtains reward item information.
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

  /// Requests a rewarded ad.
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

  /// Checks whether a rewarded ad has been loaded.
  Future<bool?> isLoaded() async {
    return await Ads.instance.channelReward.invokeMethod(
      'isAdLoaded',
      <String, dynamic>{
        'id': id,
        'adType': _adType,
      },
    );
  }

  /// Displays a rewarded ad.
  Future<bool?> show() async {
    return await Ads.instance.channelReward.invokeMethod(
      'showRewardAd',
      <String, dynamic>{
        'id': id,
      },
    );
  }

  /// Pauses a rewarded ad.
  Future<bool?> pause() async {
    return await Ads.instance.channelReward.invokeMethod(
      'pauseAd',
      <String, dynamic>{
        'id': id,
        'adType': _adType,
      },
    );
  }

  /// Resumes a rewarded ad.
  Future<bool?> resume() async {
    return await Ads.instance.channelReward.invokeMethod(
      'resumeAd',
      <String, dynamic>{
        'id': id,
        'adType': _adType,
      },
    );
  }

  /// Destroys a rewarded ad.
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

///  Function type defined for listening to rewarded ad events.
typedef RewardAdListener = void Function(
  RewardAdEvent? event, {
  Reward? reward,
  int? errorCode,
});

/// Enumerated object that represents the events of rewarded ads.
enum RewardAdEvent {
  /// A rewarded ad is successfully loaded.
  loaded,

  /// A rewarded ad fails to be loaded.
  failedToLoad,

  /// A rewarded ad is opened.
  opened,

  /// An ad leaves an app.
  leftApp,

  /// A rewarded ad is closed.
  closed,

  /// A reward item is provided when rewarded ad playback is complete.
  rewarded,

  /// A rewarded ad starts to be played.
  started,

  /// Rewarded ad playback is complete.
  completed,
}

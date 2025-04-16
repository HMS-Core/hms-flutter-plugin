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

/// A function type defined for ad dislike events.
///
/// Ads that a user dislikes will not be displayed anymore.
typedef DislikeAdListener = void Function(AdEvent? event);

typedef NativeAdStateListener = void Function(NativeAdLoadState state);

class NativeAdController {
  late MethodChannel _channel;
  late EventChannel _streamNative;
  late NativeAdStateListener loadListener;

  /// Configurations for the ad.
  NativeAdConfiguration? _adConfiguration;

  /// Ad request parameters.
  AdParam? _adParam;

  /// Listener function for ad events.
  AdListener? listener;

  /// Listener function for ad dislike events.
  ///
  ///  Ads that a user dislikes will not be displayed anymore.
  DislikeAdListener? dislikeListener;
  VideoOperator? _videoOperator;
  StreamSubscription<dynamic>? _listenerSub;
  NativeAdController({
    this.listener,
    this.dislikeListener,
    NativeAdConfiguration? adConfiguration,
    AdParam? adParam,
  }) {
    _streamNative = EventChannel('$_NATIVE_EVENT_CHANNEL/$id');
    _channel = MethodChannel('$_NATIVE_METHOD_CHANNEL/$id');
    _channel.setMethodCallHandler(_onMethodCall);
    _adConfiguration = adConfiguration;
    _adParam = adParam;

    Ads.instance.channel.invokeMethod(
      'initNativeAdController',
      <String, dynamic>{
        'id': id,
      },
    );
  }

  AdParam get adParam {
    return _adParam ?? AdParam();
  }

  int get id => hashCode;

  NativeAdConfiguration get _configuration {
    return _adConfiguration ?? NativeAdConfiguration();
  }

  /// Destroys an ad object.
  Future<bool?> destroy() {
    _listenerSub?.cancel();
    return Ads.instance.channel.invokeMethod(
      'destroyNativeAdController',
      <String, dynamic>{
        'id': id,
      },
    );
  }

  /// Does not display the current ad.
  ///
  /// When this method is called, the current ad is closed.
  ///
  /// `Sample code:`
  /// ```dart
  /// NativeAdController controller = NativeAdController();
  /// // Use controller in NativeAd Widget...
  /// NativeAd( adSlotId: _testAdSlotId, controller: controller)
  /// await controller.dislikeAd(DislikeAdReason());
  /// ```
  Future<bool?> dislikeAd(DislikeAdReason reason) {
    return _channel.invokeMethod(
      'dislikeAd',
      <String, dynamic>{
        'reason': reason.getDescription,
      },
    );
  }

  /// Obtains the sign of an ad.
  Future<String?> getAdSign() async {
    final String? adSign = await _channel.invokeMethod(
      'getAdSign',
    );
    return adSign;
  }

  /// Obtains an ad source.
  Future<String?> getAdSource() async {
    final String? source = await _channel.invokeMethod(
      'getAdSource',
    );
    return source;
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

  /// Obtains the information about the promoted app
  Future<AppInfo> getAppInfo() async {
    return AppInfo.fromJson(await _channel.invokeMethod('getAppInfo'));
  }

  /// Obtains the text to be displayed on a button.
  ///
  /// For example, `View Details` or `Install`.
  ///
  /// `Sample code:`
  /// ```dart
  /// NativeAdController controller = NativeAdController();
  /// // Use controller in NativeAd Widget...
  /// NativeAd( adSlotId: _testAdSlotId, controller: controller)
  /// String? callToAction = await controller.getCallToAction();
  /// ```
  Future<String?> getCallToAction() async {
    final String? callToAction = await _channel.invokeMethod(
      'getCallToAction',
    );
    return callToAction;
  }

  /// Obtains the description of an ad.
  Future<String?> getDescription() async {
    final String? description = await _channel.invokeMethod(
      'getDescription',
    );
    return description;
  }

  /// Obtains reasons why an ad is disliked.
  Future<List<DislikeAdReason>> getDislikeAdReasons() async {
    final List<String>? reasonsList = await _channel.invokeMethod(
      'getDislikeReasons',
    );
    final List<DislikeAdReason> responseList = <DislikeAdReason>[];
    for (String reason in (reasonsList ?? <String>[])) {
      responseList.add(DislikeAdReason(reason));
    }
    return responseList;
  }

  /// Obtains the promotion object.
  Future<PromoteInfo> getPromoteInfo() async {
    return PromoteInfo.fromJson(await _channel.invokeMethod('getPromoteInfo'));
  }

  /// Returns real-time bidding data.
  Future<BiddingInfo?> getBiddingInfo() async {
    return BiddingInfo.fromJson(await _channel.invokeMethod('getBiddingInfo'));
  }

  /// Obtains the title of an ad.
  ///
  /// `Sample code:`
  /// ```dart
  /// NativeAdController controller = NativeAdController();
  /// // Use controller in NativeAd Widget...
  /// NativeAd( adSlotId: _testAdSlotId, controller: controller)
  /// String? title = await controller.getTitle();
  /// ```
  Future<String?> getTitle() async {
    final String? title = await _channel.invokeMethod(
      'getTitle',
    );
    return title;
  }

  Future<String?> getUniqueId() async {
    final String? uniqueId = await _channel.invokeMethod(
      'getUniqueId',
    );
    return uniqueId;
  }

  /// Obtains the video controller of an ad.
  Future<VideoOperator?> getVideoOperator() async {
    final bool hasOperator = await (_channel.invokeMethod(
      'getVideoOperator',
    ));
    if (hasOperator) _videoOperator = VideoOperator(_channel);
    return _videoOperator;
  }

  /// Obtains the URL of the `Why this ad` page.
  Future<String?> getWhyThisAd() async {
    final String? whyThisAd = await _channel.invokeMethod(
      'getWhyThisAd',
    );
    return whyThisAd;
  }

  /// Goes to the page explaining why an ad is displayed.
  void gotoWhyThisAdPage() {
    _channel.invokeMethod(
      'gotoWhyThisAdPage',
    );
  }

  /// Checks whether advertiser information is delivered for the current ad.
  Future<bool> hasAdvertiserInfo() async {
    return await _channel.invokeMethod(
      'hasAdvertiserInfo',
    );
  }

  /// Hides the advertiser information dialog box.
  Future<void> hideAdvertiserInfoDialog() async {
    return await _channel.invokeMethod(
      'hideAdvertiserInfoDialog',
    );
  }

  /// Checks whether custom tap gestures are enabled.
  ///
  /// `Sample code:`
  /// ```dart
  /// NativeAdController controller = NativeAdController();
  /// // Use controller in NativeAd Widget...
  /// NativeAd( adSlotId: _testAdSlotId, controller: controller)
  /// bool? allowed = await controller.isCustomClickAllowed();
  /// ```
  Future<bool?> isCustomClickAllowed() async {
    final bool? isAllowed = await _channel.invokeMethod(
      'isCustomClickAllowed',
    );
    return isAllowed;
  }

  /// Checks whether custom tap gestures are enabled.
  ///
  /// `Sample code:`
  /// ```dart
  /// NativeAdController controller = NativeAdController();
  /// // Use controller in NativeAd Widget...
  /// NativeAd( adSlotId: _testAdSlotId, controller: controller)
  /// bool? enabled = await controller.isCustomDislikeThisAdEnabled();
  /// ```
  Future<bool?> isCustomDislikeThisAdEnabled() async {
    final bool? isEnabled = await _channel.invokeMethod(
      'isCustomDislikeThisAdEnabled',
    );
    return isEnabled;
  }

  /// Checks whether an ad is being loaded.
  ///
  /// `Sample code:`
  /// ```dart
  /// NativeAdController controller = NativeAdController();
  /// // Use controller in NativeAd Widget...
  /// NativeAd( adSlotId: _testAdSlotId, controller: controller)
  /// bool? loading = await controller.isLoading();
  /// ```
  Future<bool?> isLoading() async {
    final bool? isLoading = await _channel.invokeMethod(
      'isLoading',
    );
    return isLoading;
  }

  /// Indicates whether ad transparency information is displayed.
  ///
  /// `Sample code:`
  /// ```dart
  /// NativeAdController controller = NativeAdController();
  /// // Use controller in NativeAd Widget...
  /// NativeAd( adSlotId: _testAdSlotId, controller: controller)
  /// String? transparencyTplUrl = await controller.transparencyTplUrl();
  /// ```
  Future<bool> isTransparencyOpen() async {
    return await _channel.invokeMethod(
      'isTransparencyOpen',
    );
  }

  /// Indicates that the method has finished execution.
  ///
  /// `Sample code:`
  /// ```dart
  /// NativeAdController controller = NativeAdController();
  /// // Use controller in NativeAd Widget...
  /// NativeAd( adSlotId: _testAdSlotId, controller: controller)
  /// await controller.recordClickEvent();
  /// ```
  Future<bool?> recordClickEvent() {
    return _channel.invokeMethod(
      'recordClickEvent',
    );
  }

  /// Reports an ad impression.
  Future<bool?> recordImpressionEvent(Bundle bundle) {
    return _channel.invokeMethod(
      'recordImpressionEvent',
      bundle.bundle,
    );
  }

  /// Checks whether an ad is being loaded.
  ///
  /// `Sample code:`
  /// ```dart
  /// NativeAdController controller = NativeAdController();

  /// // Use controller in NativeAd Widget...
  /// NativeAd( adSlotId: _testAdSlotId, controller: controller)

  ///controller.setAllowCustomClick();
  /// ```
  void setAllowCustomClick() {
    _channel.invokeMethod(
      'setAllowCustomClick',
    );
  }

  void setup(String adSlotId) {
    _startListening();
    _channel.invokeMethod(
      'setup',
      <String, dynamic>{
        'adSlotId': adSlotId,
        'adParam': adParam._toMap(),
        'adConfiguration': _configuration.toJson()
      },
    );
  }

  /// Displays the advertiser information dialog box.
  Future<void> showAdvertiserInfoDialog() async {
    return await _channel.invokeMethod(
      'showAdvertiserInfoDialog',
    );
  }

  /// Shows the introduction page of the promoted app.
  Future<void> showAppDetailPage() async {
    await _channel.invokeMethod('showAppDetailPage');
  }

  /// Shows the app permission list.
  Future<void> showPermissionPage() async {
    await _channel.invokeMethod('showPermissionPage');
  }

  /// Shows the privacy policy of the app.
  Future<void> showPrivacyPolicy() async {
    await _channel.invokeMethod('showPrivacyPolicy');
  }

  /// Obtains the redirection URL.
  Future<String> transparencyTplUrl() async {
    return await _channel.invokeMethod(
      'transparencyTplUrl',
    );
  }

  /// Reports a tap.
  Future<bool?> triggerClick(Bundle bundle) {
    return _channel.invokeMethod(
      'triggerClick',
      bundle.bundle,
    );
  }

  Future<dynamic> _onMethodCall(MethodCall call) async {
    if ('onAdLoading' == call.method) {
      loadListener(NativeAdLoadState.loading);
    }
    return Future<dynamic>.value(null);
  }

  void _startListening() {
    _listenerSub = _streamNative.receiveBroadcastStream(id).listen(
      (dynamic channelEvent) {
        final Map<dynamic, dynamic> argumentsMap = channelEvent;
        final AdEvent? event = Ads.toAdEvent(argumentsMap['event']);
        final VideoLifecycleEvent? videoEvent =
            VideoOperator.toVideoLifeCycleEvent(argumentsMap['event']);

        if (event != null && listener != null) {
          event == AdEvent.failed
              ? listener!(event, errorCode: argumentsMap['errorCode'])
              : listener!(event);
        }
        if (event == AdEvent.disliked && dislikeListener != null) {
          dislikeListener!(event);
        }
        if (videoEvent != null &&
            _videoOperator!.getVideoLifecycleListener != null) {
          videoEvent == VideoLifecycleEvent.mute
              ? _videoOperator!.getVideoLifecycleListener!(
                  videoEvent,
                  isMuted: argumentsMap['isMuted'],
                )
              : _videoOperator!.getVideoLifecycleListener!(videoEvent);
        }
        switch (event) {
          case AdEvent.failed:
            loadListener(NativeAdLoadState.failed);
            break;
          case AdEvent.loaded:
            loadListener(NativeAdLoadState.loaded);
            break;
          default:
            break;
        }
      },
    );
  }
}

enum NativeAdLoadState {
  loading,
  loaded,
  failed,
}

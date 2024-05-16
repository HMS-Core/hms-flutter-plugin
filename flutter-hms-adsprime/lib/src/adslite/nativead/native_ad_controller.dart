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

class NativeAdController {
  int get id => hashCode;

  late MethodChannel _channel;
  late EventChannel _streamNative;
  late NativeAdStateListener loadListener;
  NativeAdConfiguration? _adConfiguration;
  AdParam? _adParam;
  AdListener? listener;
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

  NativeAdConfiguration get _configuration {
    return _adConfiguration ?? NativeAdConfiguration();
  }

  AdParam get adParam {
    return _adParam ?? AdParam();
  }

  Future<dynamic> _onMethodCall(MethodCall call) async {
    if ('onAdLoading' == call.method) {
      loadListener(NativeAdLoadState.loading);
    }
    return Future<dynamic>.value(null);
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

  Future<VideoOperator?> getVideoOperator() async {
    final bool hasOperator = await (_channel.invokeMethod(
      'getVideoOperator',
    ));
    if (hasOperator) _videoOperator = VideoOperator(_channel);
    return _videoOperator;
  }

  void gotoWhyThisAdPage() {
    _channel.invokeMethod(
      'gotoWhyThisAdPage',
    );
  }

  Future<bool?> isLoading() async {
    final bool? isLoading = await _channel.invokeMethod(
      'isLoading',
    );
    return isLoading;
  }

  void setAllowCustomClick() {
    _channel.invokeMethod(
      'setAllowCustomClick',
    );
  }

  Future<bool?> isCustomClickAllowed() async {
    final bool? isAllowed = await _channel.invokeMethod(
      'isCustomClickAllowed',
    );
    return isAllowed;
  }

  Future<String?> getAdSource() async {
    final String? source = await _channel.invokeMethod(
      'getAdSource',
    );
    return source;
  }

  Future<String?> getDescription() async {
    final String? description = await _channel.invokeMethod(
      'getDescription',
    );
    return description;
  }

  Future<String?> getCallToAction() async {
    final String? callToAction = await _channel.invokeMethod(
      'getCallToAction',
    );
    return callToAction;
  }

  Future<String?> getTitle() async {
    final String? title = await _channel.invokeMethod(
      'getTitle',
    );
    return title;
  }

  Future<String?> getAdSign() async {
    final String? adSign = await _channel.invokeMethod(
      'getAdSign',
    );
    return adSign;
  }

  Future<String?> getWhyThisAd() async {
    final String? whyThisAd = await _channel.invokeMethod(
      'getWhyThisAd',
    );
    return whyThisAd;
  }

  Future<String?> getUniqueId() async {
    final String? uniqueId = await _channel.invokeMethod(
      'getUniqueId',
    );
    return uniqueId;
  }

  Future<bool?> dislikeAd(DislikeAdReason reason) {
    return _channel.invokeMethod(
      'dislikeAd',
      <String, dynamic>{
        'reason': reason.getDescription,
      },
    );
  }

  Future<bool?> isCustomDislikeThisAdEnabled() async {
    final bool? isEnabled = await _channel.invokeMethod(
      'isCustomDislikeThisAdEnabled',
    );
    return isEnabled;
  }

  Future<bool?> triggerClick(Bundle bundle) {
    return _channel.invokeMethod(
      'triggerClick',
      bundle.bundle,
    );
  }

  Future<bool?> recordClickEvent() {
    return _channel.invokeMethod(
      'recordClickEvent',
    );
  }

  Future<bool?> recordImpressionEvent(Bundle bundle) {
    return _channel.invokeMethod(
      'recordImpressionEvent',
      bundle.bundle,
    );
  }

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

  Future<void> showAppDetailPage() async {
    await _channel.invokeMethod('showAppDetailPage');
  }

  Future<PromoteInfo> getPromoteInfo() async {
    return PromoteInfo.fromJson(await _channel.invokeMethod('getPromoteInfo'));
  }

  Future<AppInfo> getAppInfo() async {
    return AppInfo.fromJson(await _channel.invokeMethod('getAppInfo'));
  }

  Future<void> showPrivacyPolicy() async {
    await _channel.invokeMethod('showPrivacyPolicy');
  }

  Future<void> showPermissionPage() async {
    await _channel.invokeMethod('showPermissionPage');
  }

  Future<bool?> destroy() {
    _listenerSub?.cancel();
    return Ads.instance.channel.invokeMethod(
      'destroyNativeAdController',
      <String, dynamic>{
        'id': id,
      },
    );
  }

  Future<bool> isTransparencyOpen() async {
    return await _channel.invokeMethod(
      'isTransparencyOpen',
    );
  }

  Future<String> transparencyTplUrl() async {
    return await _channel.invokeMethod(
      'transparencyTplUrl',
    );
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

typedef NativeAdStateListener = void Function(NativeAdLoadState state);

typedef DislikeAdListener = void Function(AdEvent? event);

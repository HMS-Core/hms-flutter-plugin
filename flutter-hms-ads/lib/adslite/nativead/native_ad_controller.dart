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

import 'package:huawei_ads/hms_ads_lib.dart';
import 'package:huawei_ads/adslite/video_operator.dart';
import 'package:huawei_ads/adslite/nativead/dislike_ad_reason.dart';
import 'package:huawei_ads/utils/bundle.dart';
import 'package:flutter/services.dart';
import 'package:huawei_ads/hms_ads.dart';
import 'package:huawei_ads/utils/channels.dart';

class NativeAdController {
  int get id => hashCode;

  MethodChannel _channel;
  EventChannel _streamNative;
  NativeAdStateListener loadListener;
  NativeAdConfiguration _adConfiguration;
  AdParam _adParam;
  AdListener listener;
  DislikeAdListener dislikeListener;
  VideoOperator _videoOperator;
  StreamSubscription _listenerSub;

  NativeAdController(
      {this.listener,
      this.dislikeListener,
      NativeAdConfiguration adConfiguration,
      AdParam adParam}) {
    _streamNative = EventChannel('$NATIVE_EVENT_CHANNEL/$id');
    _channel = MethodChannel('$NATIVE_METHOD_CHANNEL/$id');
    _channel.setMethodCallHandler(_onMethodCall);
    _adConfiguration = adConfiguration;
    _adParam = adParam;

    Ads.instance.channel.invokeMethod("initNativeAdController", {
      "id": id,
    });
  }

  NativeAdConfiguration get _configuration =>
      _adConfiguration ?? NativeAdConfiguration();
  AdParam get adParam => _adParam ?? AdParam();

  Future<dynamic> _onMethodCall(MethodCall call) async {
    if ("onAdLoading" == call.method) {
      loadListener(NativeAdLoadState.loading);
    }
    return Future<dynamic>.value(null);
  }

  void setup(String adSlotId) {
    _startListening();
    _channel.invokeMethod("setup", {
      "adSlotId": adSlotId,
      "adParam": adParam.toJson(),
      "adConfiguration": _configuration.toJson()
    });
  }

  Future<VideoOperator> getVideoOperator() async {
    bool hasOperator = await _channel.invokeMethod("getVideoOperator");
    if (hasOperator) _videoOperator = VideoOperator(_channel);
    return _videoOperator ?? null;
  }

  void gotoWhyThisAdPage() {
    _channel.invokeMethod("gotoWhyThisAdPage");
  }

  Future<bool> isLoading() async {
    bool isLoading = await _channel.invokeMethod("isLoading");
    return isLoading;
  }

  void setAllowCustomClick() {
    _channel.invokeMethod("setAllowCustomClick");
  }

  Future<bool> isCustomClickAllowed() async {
    bool isAllowed = await _channel.invokeMethod("isCustomClickAllowed");
    return isAllowed;
  }

  Future<String> getAdSource() async {
    String source = await _channel.invokeMethod("getAdSource");
    return source;
  }

  Future<String> getDescription() async {
    String description = await _channel.invokeMethod("getDescription");
    return description;
  }

  Future<String> getCallToAction() async {
    String callToAction = await _channel.invokeMethod("getCallToAction");
    return callToAction;
  }

  Future<String> getTitle() async {
    String title = await _channel.invokeMethod("getTitle");
    return title;
  }

  Future<String> getAdSign() async {
    String adSign = await _channel.invokeMethod("getAdSign");
    return adSign;
  }

  Future<String> getWhyThisAd() async {
    String whyThisAd = await _channel.invokeMethod("getWhyThisAd");
    return whyThisAd;
  }

  Future<String> getUniqueId() async {
    String uniqueId = await _channel.invokeMethod("getUniqueId");
    return uniqueId;
  }

  Future<bool> dislikeAd(DislikeAdReason reason) {
    return _channel
        .invokeMethod("dislikeAd", {"reason": reason.getDescription});
  }

  Future<bool> isCustomDislikeThisAdEnabled() async {
    bool isEnabled =
        await _channel.invokeMethod("isCustomDislikeThisAdEnabled");
    return isEnabled;
  }

  Future<bool> triggerClick(Bundle bundle) {
    return _channel.invokeMethod("triggerClick", bundle.bundle);
  }

  Future<bool> recordClickEvent() {
    return _channel.invokeMethod("recordClickEvent");
  }

  Future<bool> recordImpressionEvent(Bundle bundle) {
    return _channel.invokeMethod("recordImpressionEvent", bundle.bundle);
  }

  Future<List<DislikeAdReason>> getDislikeAdReasons() async {
    List<String> reasonsList = await _channel.invokeMethod("getDislikeReasons");
    List<DislikeAdReason> responseList = new List<DislikeAdReason>();
    if (reasonsList != null) {
      reasonsList.forEach((String reason) {
        responseList.add(new DislikeAdReason(reason));
      });
    }
    return responseList;
  }

  Future<bool> destroy() {
    _listenerSub?.cancel();
    return Ads.instance.channel.invokeMethod("destroyNativeAdController", {
      "id": id,
    });
  }

  void _startListening() {
    _listenerSub =
        _streamNative.receiveBroadcastStream(id).listen((channelEvent) {
      final Map<dynamic, dynamic> argumentsMap = channelEvent;
      final AdEvent event = Ads.toAdEvent(argumentsMap['event']);
      final VideoLifecycleEvent videoEvent =
          VideoOperator.toVideoLifeCycleEvent(argumentsMap['event']);

      if (event != null && listener != null)
        event == AdEvent.failed
            ? listener(event, errorCode: argumentsMap['errorCode'])
            : listener(event);

      if (event == AdEvent.disliked && dislikeListener != null)
        dislikeListener(event);

      if (videoEvent != null &&
          _videoOperator.getVideoLifecycleListener != null)
        videoEvent == VideoLifecycleEvent.mute
            ? _videoOperator.getVideoLifecycleListener(videoEvent,
                isMuted: argumentsMap['isMuted'])
            : _videoOperator.getVideoLifecycleListener(videoEvent);

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
    });
  }
}

enum NativeAdLoadState { loading, loaded, failed }

typedef void NativeAdStateListener(NativeAdLoadState state);

typedef void DislikeAdListener(AdEvent event);

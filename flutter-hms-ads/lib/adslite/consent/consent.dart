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
import 'package:huawei_ads/hms_ads_lib.dart';

class Consent {
  Consent._();
  static final Consent _instance = Consent._();
  static Consent get instance => _instance;
  ConsentUpdateListener _listener;
  StreamSubscription _listenerSub;

  Future<String> getTestDeviceId() async {
    String deviceId =
        await Ads.instance.channelConsent.invokeMethod('getTestDeviceId');
    return deviceId;
  }

  Future<bool> addTestDeviceId(String deviceId) {
    return Ads.instance.channelConsent
        .invokeMethod('addTestDeviceId', {'deviceId': deviceId});
  }

  // DebugNeedConsent constants
  Future<bool> setDebugNeedConsent(DebugNeedConsent needConsent) {
    return Ads.instance.channelConsent.invokeMethod(
        'setDebugNeedConsent', {"needConsent": describeEnum(needConsent)});
  }

  Future<bool> setUnderAgeOfPromise(bool ageOfPromise) {
    return Ads.instance.channelConsent
        .invokeMethod('setUnderAgeOfPromise', {'ageOfPromise': ageOfPromise});
  }

  Future<bool> setConsentStatus(ConsentStatus status) {
    return Ads.instance.channelConsent
        .invokeMethod("setConsentStatus", {"status": describeEnum(status)});
  }

  void requestConsentUpdate(ConsentUpdateListener listener) {
    this._listener = listener;
    _startListening();
  }

  static Future<bool> updateSharedPreferences(String key, int value) {
    return Ads.instance.channelConsent
        .invokeMethod('updateConsentSharedPreferences', {
      'key': key,
      'value': value,
    });
  }

  static Future<int> getSharedPreferences(String key) async {
    int pref = await Ads.instance.channelConsent
        .invokeMethod('getConsentSharedPreferences', {'key': key});
    return pref;
  }

  void _startListening() {
    _listenerSub?.cancel();
    _listenerSub = Ads.instance.streamConsent
        .receiveBroadcastStream()
        .listen((channelEvent) {
      final Map<dynamic, dynamic> argumentsMap = channelEvent;
      final ConsentUpdateEvent consentEvent =
          _toConsentUpdateEvent(argumentsMap['event']);
      if (consentEvent == ConsentUpdateEvent.success) {
        int status = argumentsMap['consentStatus'];
        bool isNeedConsent = argumentsMap['isNeedConsent'];
        List<dynamic> mapList = argumentsMap['adProviders'];
        List<AdProvider> adProviders = AdProvider.buildList(mapList);

        _listener(consentEvent,
            consentStatus: ConsentStatus.values.elementAt(status),
            isNeedConsent: isNeedConsent,
            adProviders: adProviders);
      } else
        _listener(consentEvent);
    });
  }

  static ConsentUpdateEvent _toConsentUpdateEvent(String event) =>
      _consentUpdateEventMap[event];

  static const Map<String, ConsentUpdateEvent> _consentUpdateEventMap =
      <String, ConsentUpdateEvent>{
    'onConsentUpdateSuccess': ConsentUpdateEvent.success,
    'onConsentUpdateFail': ConsentUpdateEvent.failed,
  };
}

typedef void ConsentUpdateListener(
  ConsentUpdateEvent event, {
  ConsentStatus consentStatus,
  bool isNeedConsent,
  List<AdProvider> adProviders,
  String description,
});

enum ConsentUpdateEvent {
  success,
  failed,
}

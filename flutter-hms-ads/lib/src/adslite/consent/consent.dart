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

class Consent {
  Consent._();
  static final Consent _instance = Consent._();
  late ConsentUpdateListener _listener;
  StreamSubscription<dynamic>? _listenerSub;

  /// Returns a singleton [Consent] instance.
  static Consent get instance => _instance;

  /// Obtains the test device ID. (For test.)
  Future<String?> getTestDeviceId() async {
    final String? deviceId = await Ads.instance.channelConsent.invokeMethod(
      'getTestDeviceId',
    );
    return deviceId;
  }

  /// Adds a new test device ID. (For test.)
  Future<bool?> addTestDeviceId(String deviceId) async {
    return await Ads.instance.channelConsent.invokeMethod(
      'addTestDeviceId',
      <String, dynamic>{
        'deviceId': deviceId,
      },
    );
  }

  // DebugNeedConsent constants
  Future<bool?> setDebugNeedConsent(DebugNeedConsent needConsent) async {
    return await Ads.instance.channelConsent.invokeMethod(
      'setDebugNeedConsent',
      <String, dynamic>{
        'needConsent': describeEnum(needConsent),
      },
    );
  }

  Future<bool?> setUnderAgeOfPromise(bool ageOfPromise) async {
    return await Ads.instance.channelConsent.invokeMethod(
      'setUnderAgeOfPromise',
      <String, dynamic>{
        'ageOfPromise': ageOfPromise,
      },
    );
  }

  Future<bool?> setConsentStatus(ConsentStatus status) async {
    return await Ads.instance.channelConsent.invokeMethod(
      'setConsentStatus',
      <String, dynamic>{
        'status': describeEnum(status),
      },
    );
  }

  void requestConsentUpdate(ConsentUpdateListener listener) {
    _listener = listener;
    _startListening();
  }

  static Future<bool?> updateSharedPreferences(String key, int value) async {
    return await Ads.instance.channelConsent.invokeMethod(
      'updateConsentSharedPreferences',
      <String, dynamic>{
        'key': key,
        'value': value,
      },
    );
  }

  static Future<int?> getSharedPreferences(String key) async {
    final int? pref = await Ads.instance.channelConsent.invokeMethod(
      'getConsentSharedPreferences',
      <String, dynamic>{
        'key': key,
      },
    );
    return pref;
  }

  void _startListening() {
    _listenerSub?.cancel();
    _listenerSub = Ads.instance.streamConsent.receiveBroadcastStream().listen(
      (dynamic channelEvent) {
        final Map<dynamic, dynamic> argumentsMap = channelEvent;
        final ConsentUpdateEvent? consentEvent =
            _toConsentUpdateEvent(argumentsMap['event']);
        if (consentEvent == ConsentUpdateEvent.success) {
          int status = argumentsMap['consentStatus'];
          bool? isNeedConsent = argumentsMap['isNeedConsent'];
          List<dynamic>? mapList = argumentsMap['adProviders'];
          List<AdProvider> adProviders = AdProvider.buildList(mapList);

          _listener(
            consentEvent,
            consentStatus: ConsentStatus.values.elementAt(status),
            isNeedConsent: isNeedConsent,
            adProviders: adProviders,
          );
        } else {
          _listener(consentEvent);
        }
      },
    );
  }

  static ConsentUpdateEvent? _toConsentUpdateEvent(String? event) {
    return _consentUpdateEventMap[event!];
  }

  static const Map<String, ConsentUpdateEvent> _consentUpdateEventMap =
      <String, ConsentUpdateEvent>{
    'onConsentUpdateSuccess': ConsentUpdateEvent.success,
    'onConsentUpdateFail': ConsentUpdateEvent.failed,
  };
}

typedef ConsentUpdateListener = void Function(
  ConsentUpdateEvent? event, {
  ConsentStatus? consentStatus,
  bool? isNeedConsent,
  List<AdProvider>? adProviders,
  String? description,
});

/// [Events] of a consent update attempt.
enum ConsentUpdateEvent {
  success,
  failed,
}

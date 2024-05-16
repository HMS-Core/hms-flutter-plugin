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

class InstallReferrerClient {
  static final Map<int, InstallReferrerClient> allReferrers =
      <int, InstallReferrerClient>{};

  int get id => hashCode;

  final ReferrerCallMode _callMode = ReferrerCallMode.sdk;
  bool? _test = false;
  InstallReferrerStateListener? stateListener;
  ReferrerDetails? _referrerDetails;

  InstallReferrerClient({
    this.stateListener,
    bool? test,
  }) {
    _test = test;
    allReferrers[id] = this;
  }

  set setTest(bool test) => _test = test;

  void startConnection([bool? isTest]) {
    Ads.instance.channelReferrer.invokeMethod(
      'referrerStartConnection',
      <String, dynamic>{
        'id': id,
        'callMode': describeEnum(_callMode),
        'isTest': isTest ?? _test,
      },
    );
  }

  void endConnection() {
    Ads.instance.channelReferrer.invokeMethod(
      'referrerEndConnection',
      <String, dynamic>{
        'id': id,
        'callMode': describeEnum(_callMode),
      },
    );
  }

  Future<bool?> isReady() {
    return Ads.instance.channelReferrer.invokeMethod(
      'referrerIsReady',
      <String, dynamic>{
        'id': id,
        'callMode': describeEnum(_callMode),
      },
    );
  }

  Future<ReferrerDetails?> get getInstallReferrer async {
    dynamic referrer = await Ads.instance.channelReferrer.invokeMethod(
      'getInstallReferrer',
      <String, dynamic>{
        'id': id,
        'callMode': describeEnum(_callMode),
      },
    );
    if (referrer != null) {
      Bundle bundle = Bundle();
      bundle.putString(
        ReferrerDetails.keyInstallReferrer,
        referrer[ReferrerDetails.keyInstallReferrer],
      );
      bundle.putInt(
        ReferrerDetails.keyReferrerClickTimeStamp,
        referrer[ReferrerDetails.keyReferrerClickTimeStamp],
      );
      bundle.putInt(
        ReferrerDetails.keyInstallBeginTimeStamp,
        referrer[ReferrerDetails.keyInstallBeginTimeStamp],
      );
      _referrerDetails = ReferrerDetails(bundle);
    }
    return _referrerDetails;
  }

  static Future<dynamic> onMethodCall(MethodCall call) {
    final Map<dynamic, dynamic> argumentsMap = call.arguments;
    final InstallReferrerStateEvent? referrerEvent = _toReferrerStateEvent(
      call.method,
    );

    final int? id = argumentsMap['id'];
    if (id != null && InstallReferrerClient.allReferrers[id] != null) {
      final InstallReferrerClient client =
          InstallReferrerClient.allReferrers[id]!;
      if (client.stateListener != null) {
        if (referrerEvent == InstallReferrerStateEvent.setupFinished &&
            argumentsMap['responseCode'] != null) {
          ReferrerResponse? response = _toReferrerResponse(
            argumentsMap['responseCode'],
          );
          client.stateListener!(
            referrerEvent,
            responseCode: response,
          );
        } else {
          client.stateListener!(
            referrerEvent,
          );
        }
      }
    }

    return Future<dynamic>.value(null);
  }

  static InstallReferrerStateEvent? _toReferrerStateEvent(String event) {
    return _referrerStateEventMap[event];
  }

  static ReferrerResponse? _toReferrerResponse(int? code) {
    return _referrerResponseCodeMap[code!];
  }

  static const Map<String, InstallReferrerStateEvent> _referrerStateEventMap =
      <String, InstallReferrerStateEvent>{
    'onInstallReferrerSetupFinished': InstallReferrerStateEvent.setupFinished,
    'onInstallReferrerSetupConnectionEnded':
        InstallReferrerStateEvent.connectionClosed,
    'onInstallReferrerSetupDisconnected':
        InstallReferrerStateEvent.disconnected,
  };

  static const Map<int, ReferrerResponse> _referrerResponseCodeMap =
      <int, ReferrerResponse>{
    -1: ReferrerResponse.disconnected,
    0: ReferrerResponse.ok,
    1: ReferrerResponse.unavailable,
    2: ReferrerResponse.featureNotSupported,
    3: ReferrerResponse.developerError,
  };
}

typedef InstallReferrerStateListener = void Function(
  InstallReferrerStateEvent? event, {
  ReferrerResponse? responseCode,
});

enum InstallReferrerStateEvent {
  setupFinished,
  connectionClosed,
  disconnected,
}

enum ReferrerResponse {
  disconnected,
  ok,
  unavailable,
  featureNotSupported,
  developerError,
}

enum ReferrerCallMode {
  sdk,
}

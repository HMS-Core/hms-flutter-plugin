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

part of '../../huawei_ads.dart';

class InstallReferrerClient {
  /// Indicates whether to use the test mode. Set it to `true` for testing.
  bool? _test = false;

  /// Listener function for install referrer state events.
  InstallReferrerStateListener? stateListener;

  ReferrerDetails? _referrerDetails;

  InstallReferrerClient({
    this.stateListener,
    bool? test,
    String? installChannel,
  }) {
    _test = test;
    allReferrers[id] = this;
    _installChannel = installChannel ?? _installChannel;
  }

  int get id => hashCode;

  final ReferrerCallMode _callMode = ReferrerCallMode.sdk;

  String? _installChannel = 'This is test install channel';

  static final Map<int, InstallReferrerClient> allReferrers =
      <int, InstallReferrerClient>{};

  /// Sets whether to run the service in test mode.
  set setTest(bool test) => _test = test;

  /// Sets channel information.
  set setInstallChannel(String installChannel) =>
      _installChannel = installChannel;

  /// Starts to connect to the install referrer service.
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

  /// Ends the service connection and releases all occupied resources.
  void endConnection() {
    Ads.instance.channelReferrer.invokeMethod(
      'referrerEndConnection',
      <String, dynamic>{
        'id': id,
        'callMode': describeEnum(_callMode),
      },
    );
  }

  /// Checks whether the service connection is ready.
  Future<bool?> isReady() {
    return Ads.instance.channelReferrer.invokeMethod(
      'referrerIsReady',
      <String, dynamic>{
        'id': id,
        'callMode': describeEnum(_callMode),
      },
    );
  }

  /// Obtains install referrer information.
  Future<ReferrerDetails?> get getInstallReferrer async {
    dynamic referrer = await Ads.instance.channelReferrer.invokeMethod(
      'getInstallReferrer',
      <String, dynamic>{
        'id': id,
        'callMode': describeEnum(_callMode),
        'installChannel': _installChannel,
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
      bundle.putString(
        ReferrerDetails.keyInstallChannel,
        referrer[ReferrerDetails.keyInstallChannel],
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

/// Function type defined for listening to install referrer state events.
typedef InstallReferrerStateListener = void Function(
  InstallReferrerStateEvent? event, {
  ReferrerResponse? responseCode,
});

/// Enumerated object that represents the events of install referrer connections.
enum InstallReferrerStateEvent {
  /// Service connection is complete.
  setupFinished,

  /// Service connection is closed.
  connectionClosed,

  /// Connection is lost and the service is disconnected.
  disconnected,
}

/// Enumerated object that represents install referrer result codes.
enum ReferrerResponse {
  /// Failed to connect to the service.
  disconnected,

  /// Connected to the service successfully.
  ok,

  /// The service does not exist.
  unavailable,

  /// The service is not supported.
  featureNotSupported,

  /// A call error occurred.
  developerError,
}

enum ReferrerCallMode {
  sdk,
}

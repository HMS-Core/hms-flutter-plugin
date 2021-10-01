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

class BleSignal {
  static final int bleUnknownTxPower = 0x80;
  final int? rssi;
  final int? txPower;

  BleSignal({this.rssi, this.txPower});

  factory BleSignal.fromMap(Map<dynamic, dynamic> map) =>
      BleSignal(rssi: map['rssi'], txPower: map['txPower']);

  Map<String, dynamic> toMap() => {
        'rssi': rssi ?? null,
        'txPower': txPower,
      };
}

class BroadcastOption {
  final DiscoveryPolicy? policy;

  BroadcastOption(this.policy);

  bool equals(object) =>
      identical(this, object) ||
      (object is BroadcastOption && policy == object.policy);

  factory BroadcastOption.fromMap(Map<dynamic, dynamic> map) =>
      BroadcastOption(map['policy']);

  Map<String, dynamic> toMap() => {
        'policy': policy?.toMap(),
      };
}

class ConnectInfo {
  final String? endpointName;
  final String? authCode;
  final bool? isRemoteConnect;

  ConnectInfo({this.endpointName, this.authCode, this.isRemoteConnect});

  factory ConnectInfo.fromMap(Map<dynamic, dynamic> map) => ConnectInfo(
        authCode: map['authCode'],
        endpointName: map['endpointName'],
        isRemoteConnect: map['isRemoteConnect'],
      );

  Map<String, dynamic> toMap() => {
        'authCode': authCode,
        'endpointName': endpointName,
        'isRemoteConnect': isRemoteConnect,
      };
}

class ConnectResult {
  final int? statusCode;
  ChannelPolicy _channelPolicy;
  ConnectResult(this.statusCode, this._channelPolicy);

  factory ConnectResult.fromMap(Map<dynamic, dynamic> map) =>
      ConnectResult(map['statusCode'], ChannelPolicy(map['getPolicy']));
  ChannelPolicy getPolicy() {
    return _channelPolicy;
  }
  Map<String, dynamic> toMap() => {
        'statusCode': statusCode,
        'getPolicy': _channelPolicy.toMap()
      };
}

class DiscoveryPolicy {
  final int _topology;

  const DiscoveryPolicy(this._topology);

  static const DiscoveryPolicy mesh = DiscoveryPolicy(1);
  static const DiscoveryPolicy p2p = DiscoveryPolicy(2);
  static const DiscoveryPolicy star = DiscoveryPolicy(3);

  bool equals(object) =>
      identical(this, object) ||
      (object is DiscoveryPolicy && _topology == object._topology);

  @override
  String toString() {
    String desc;
    switch (_topology) {
      case 1:
        desc = "POLICY_MESH";
        break;
      case 2:
        desc = "POLICY_P2P";
        break;
      case 3:
        desc = "POLICY_STAR";
        break;
      default:
        desc = "POLICY_UNKNOWN";
        break;
    }
    return desc;
  }

  Map<String, dynamic> toMap() => {'topology': _topology};
}

class Distance {
  static final int precisionLow = 1;
  final int? precision;
  final double? meters;

  const Distance({this.precision, this.meters});
  static const Distance unknown = Distance(precision: 1, meters: double.nan);

  factory Distance.fromMap(Map<dynamic, dynamic> map) =>
      Distance(precision: map['precision'], meters: map['meters']);

  Map<String, dynamic> toMap() => {
        'precision': precision,
        'meters': meters,
      };
}

class ScanEndpointInfo {
  final String serviceId;
  final String name;

  ScanEndpointInfo({required this.serviceId, required this.name});

  factory ScanEndpointInfo.fromMap(Map<dynamic, dynamic> map) =>
      ScanEndpointInfo(serviceId: map['serviceId'], name: map['name']);

  Map<String, dynamic> toMap() => {'serviceId': serviceId, 'name': name};
}

class ScanOption {
  final DiscoveryPolicy? policy;
  ScanOption(this.policy);

  bool equals(object) =>
      identical(this, object) ||
      (object is ScanOption && policy!.equals(object.policy));

  factory ScanOption.fromMap(Map<dynamic, dynamic> map) =>
      ScanOption(map['policy']);

  Map<String, dynamic> toMap() => {
        'policy': policy?.toMap(),
      };
}

class ChannelPolicy {
  final int _policy;

  const ChannelPolicy(this._policy);

  static const ChannelPolicy auto = ChannelPolicy(1);
  static const ChannelPolicy highThroughput = ChannelPolicy(2);
  static const ChannelPolicy instance = ChannelPolicy(3);

  bool equals(object) =>
      identical(this, object) ||
          (object is ChannelPolicy && _policy == object._policy);

  @override
  String toString() {
    String desc;
    switch (_policy) {
      case 1:
        desc = "CHANNEL_AUTO";
        break;
      case 2:
        desc = "CHANNEL_HIGH_THROUGHPUT";
        break;
      case 3:
        desc = "CHANNEL_INSTANCE";
        break;
      default:
        desc = "POLICY_UNKNOWN";
        break;
    }
    return desc;
  }

  Map<String, dynamic> toMap() => {'policy': _policy};
}

class ConnectOption {
  final ChannelPolicy? policy;
  ConnectOption(this.policy);

  bool equals(object) =>
      identical(this, object) ||
          (object is ConnectOption && policy!.equals(object.policy));

  factory ConnectOption.fromMap(Map<dynamic, dynamic> map) =>
      ConnectOption(map['policyMap']);

  Map<String, dynamic> toMap() => {
    'policyMap': policy?.toMap(),
  };
}
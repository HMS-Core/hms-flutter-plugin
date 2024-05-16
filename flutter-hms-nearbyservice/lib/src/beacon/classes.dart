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

part of huawei_nearbyservice;

/// Defines the filtering condition for beacons and beacon message attachments.
class BeaconPicker {
  /// Beacon type.
  ///
  /// Value `1` : iBeacon beacon.
  /// Value `2` : Eddystone UID beacon.
  /// Default value is `1`.
  int? beaconType;

  /// Beacon UUID.
  String? beaconId;

  /// Namespace of a message.
  ///
  /// The value is a character string, which is your custom identifier for a series of message types, cannot be left empty or contain asterisks (*), and can contain a maximum of 32 characters.
  String? namespace;

  /// Type of a message.
  ///
  /// The value is a character string, which is your custom identifier for a series of messages, cannot be left empty or contain asterisks (*), and can contain a maximum of 16 characters.
  String? type;

  BeaconPicker({
    this.beaconType,
    this.beaconId,
    this.namespace,
    this.type,
  });

  factory BeaconPicker.fromMap(Map<String, dynamic> map) {
    return BeaconPicker(
      beaconType: map['beaconType'],
      beaconId: map['beaconId'],
      namespace: map['namespace'],
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'beaconType': beaconType,
      'beaconId': beaconId,
      'namespace': namespace,
      'type': type,
    };
  }
}

/// Defines the filtering condition for beacons.
///
/// Only beacons that meet this condition will trigger a notification.
class RawBeaconCondition {
  /// Beacon ID.
  String? beaconId;

  /// Beacon type. For details, see [BeaconPicker].
  int? beaconType;

  RawBeaconCondition({
    this.beaconId,
    this.beaconType,
  });

  factory RawBeaconCondition.fromMap(Map<String, dynamic> map) {
    return RawBeaconCondition(
      beaconId: map['beaconId'],
      beaconType: map['beaconType'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'beaconId': beaconId,
      'beaconType': beaconType,
    };
  }

  @override
  String toString() {
    return 'RawBeaconCondition { '
        'beaconId: $beaconId, '
        'beaconType: $beaconType '
        '}';
  }
}

/// Defines the filtering condition for beacon message attachments.
///
/// Only beacons that meet this condition will trigger a notification.
class BeaconMsgCondition {
  /// Beacon ID.
  String? beaconId;

  /// Beacon type.
  int? beaconType;

  /// Namespace of a message.
  String? namespace;

  /// Type of a message.
  String? type;

  BeaconMsgCondition({
    this.beaconId,
    this.beaconType,
    this.namespace,
    this.type,
  });

  factory BeaconMsgCondition.fromMap(Map<String, dynamic> map) {
    return BeaconMsgCondition(
      beaconId: map['beaconId'],
      beaconType: map['beaconType'],
      namespace: map['namespace'],
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'beaconId': beaconId,
      'beaconType': beaconType,
      'namespace': namespace,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'BeaconMsgCondition { '
        'beaconId: $beaconId, '
        'beaconType: $beaconType, '
        'namespace: $namespace, '
        'type: $type '
        '}';
  }
}

/// Scanned beacon information.
class Beacon {
  /// Beacon ID.
  String? beaconId;

  /// Namespace of a message.
  String? namespace;

  /// Type of a message.
  String? type;

  Beacon({
    this.beaconId,
    this.namespace,
    this.type,
  });

  factory Beacon.fromJson(String str) => Beacon.fromMap(json.decode(str));

  factory Beacon.fromMap(Map<String, dynamic> map) {
    return Beacon(
      beaconId: map['beaconId'],
      namespace: map['namespace'],
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'beaconId': beaconId,
      'namespace': namespace,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'Beacon { '
        'beaconId: $beaconId, '
        'namespace: $namespace, '
        'type: $type '
        '}';
  }
}

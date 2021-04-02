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

class BeaconId {
  static const int typeIBeacon = 1;
  static const int typeEddystoneUid = 2;
  static const int iBeaconIdLength = 20;
  static const int eddystoneUidLength = 16;
  static const int eddystoneNamespaceLength = 10;
  static const int eddystoneInstanceLength = 6;

  final String iBeaconUuid;
  final String hexId;
  final String instance;
  final String namespace;
  final int major;
  final int minor;
  final int length;
  final int type;

  BeaconId._builder(BeaconIdBuilder builder)
      : this.iBeaconUuid = builder._uuid,
        this.hexId = builder._hexId,
        this.instance = builder._instance,
        this.namespace = builder._namespace,
        this.major = builder._major,
        this.minor = builder._minor,
        this.length = builder._length,
        this.type = builder._type;

  @override
  String toString() => type == typeEddystoneUid
      ? 'EddystoneUid{id="$hexId"}'
      : '"IBeaconId{iBeaconUuid="$iBeaconUuid", major="$major", minor="$minor"}';

  bool equals(object) =>
      identical(this, object) ||
      (object is BeaconId &&
          this.type == object.type &&
          this.length == object.length &&
          this.major == object.major &&
          this.minor == object.minor &&
          this.iBeaconUuid == object.iBeaconUuid &&
          this.hexId == object.hexId &&
          this.instance == object.instance &&
          this.namespace == object.namespace);
}

/// Builder class for [BeaconId]
class BeaconIdBuilder {
  /// [BeaconId.typeIBeacon] or
  /// [BeaconId.typeEddystoneUid]
  int _type;

  /// 20 if [BeaconId.typeIBeacon]
  /// 16 if [BeaconId.typeEddystoneUid]
  int _length;

  /// [BeaconId.typeIBeacon] properties
  /// otherwise null
  String _uuid;
  int _major;
  int _minor;

  /// [BeaconId.typeEddystoneUid] beacon properties
  /// otherwise null
  String _hexId;
  String _instance;
  String _namespace;

  BeaconIdBuilder();

  /// For [BeaconId.typeIBeacon]
  BeaconIdBuilder setIBeaconUuid(String iBeaconUuid) {
    this._uuid = _uuid;
    this._type = BeaconId.typeIBeacon;
    return this;
  }

  /// For [BeaconId.typeIBeacon]
  BeaconIdBuilder setMajor(int major) {
    this._major = major;
    return this;
  }

  /// For [BeaconId.typeIBeacon]
  BeaconIdBuilder setMinor(int minor) {
    this._minor = minor;
    return this;
  }

  /// For [BeaconId.typeEddystoneUid]
  BeaconIdBuilder setHexId(String hexId) {
    this._hexId = hexId;
    this._type = BeaconId.typeEddystoneUid;
    return this;
  }

  /// For [BeaconId.typeEddystoneUid]
  BeaconIdBuilder setHexNamespace(String hexNamespace) {
    this._namespace = hexNamespace;
    return this;
  }

  /// For [BeaconId.typeEddystoneUid]
  BeaconIdBuilder setHexInstance(String hexInstance) {
    this._instance = hexInstance;
    this._type = BeaconId.typeEddystoneUid;
    return this;
  }

  BeaconId build() {
    if (_type != BeaconId.typeEddystoneUid && _type != BeaconId.typeIBeacon)
      throw ArgumentError('$_type is not a valid beacon type.');

    if (_type == BeaconId.typeEddystoneUid) {
      _uuid = null;
      _major = 0;
      _minor = 0;
      _length = BeaconId.eddystoneUidLength;
    } else {
      _hexId = null;
      _namespace = null;
      _instance = null;
      _length = BeaconId.iBeaconIdLength;
    }

    return BeaconId._builder(this);
  }
}

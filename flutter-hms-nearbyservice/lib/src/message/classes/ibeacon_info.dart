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

class IBeaconInfo {
  final String? uuid;
  final int? major;
  final int? minor;
  final bool _isIncludeMajor;
  final bool _isIncludeMinor;

  IBeaconInfo({
    required this.uuid,
    this.major,
    this.minor,
  })  : _isIncludeMajor = major != null ? true : false,
        _isIncludeMinor = minor != null ? true : false;

  bool equals(dynamic object) {
    return identical(this, object) ||
        object is IBeaconInfo &&
            uuid == object.uuid &&
            minor == object.minor &&
            major == object.major &&
            _isIncludeMinor == object._isIncludeMinor &&
            _isIncludeMajor == object._isIncludeMajor;
  }

  factory IBeaconInfo.fromMap(Map<String, dynamic> map) {
    return IBeaconInfo(
      uuid: map['uuid'],
      major: map['major'],
      minor: map['minor'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'major': major,
      'minor': minor,
      'isIncludeMajor': _isIncludeMajor,
      'isIncludeMinor': _isIncludeMinor,
    };
  }

  @override
  String toString() {
    return 'uuid=$uuid, major=$major, minor=$minor';
  }
}

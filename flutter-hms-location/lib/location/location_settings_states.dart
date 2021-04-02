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

import 'dart:convert';
import 'dart:ui';

class LocationSettingsStates {
  bool blePresent;
  bool bleUsable;
  bool gpsPresent;
  bool gpsUsable;
  bool locationPresent;
  bool locationUsable;
  bool networkLocationPresent;
  bool networkLocationUsable;
  bool hmsLocationPresent;
  bool hmsLocationUsable;
  bool gnssPresent;
  bool gnssUsable;

  LocationSettingsStates(
      {this.blePresent,
      this.bleUsable,
      this.gpsPresent,
      this.gpsUsable,
      this.locationPresent,
      this.locationUsable,
      this.networkLocationPresent,
      this.networkLocationUsable,
      this.hmsLocationPresent,
      this.hmsLocationUsable,
      this.gnssPresent,
      this.gnssUsable});

  Map<String, dynamic> toMap() {
    return {
      'blePresent': blePresent,
      'bleUsable': bleUsable,
      'gpsPresent': gpsPresent,
      'gpsUsable': gpsUsable,
      'locationPresent': locationPresent,
      'locationUsable': locationUsable,
      'networkLocationPresent': networkLocationPresent,
      'networkLocationUsable': networkLocationUsable,
      'hmsLocationPresent': hmsLocationPresent,
      'hmsLocationUsable': hmsLocationUsable,
      'gnssPresent': gnssPresent,
      'gnssUsable': gnssUsable,
    };
  }

  factory LocationSettingsStates.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return LocationSettingsStates(
      blePresent: map['blePresent'],
      bleUsable: map['bleUsable'],
      gpsPresent: map['gpsPresent'],
      gpsUsable: map['gpsUsable'],
      locationPresent: map['locationPresent'],
      locationUsable: map['locationUsable'],
      networkLocationPresent: map['networkLocationPresent'],
      networkLocationUsable: map['networkLocationUsable'],
      hmsLocationPresent: map['hmsLocationPresent'],
      hmsLocationUsable: map['hmsLocationUsable'],
      gnssPresent: map['gnssPresent'],
      gnssUsable: map['gnssUsable'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationSettingsStates.fromJson(String source) =>
      LocationSettingsStates.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocationSettingsStates(blePresent: $blePresent, bleUsable: '
        '$bleUsable, gpsPresent: $gpsPresent, gpsUsable: $gpsUsable, '
        'locationPresent: $locationPresent, locationUsable: $locationUsable, '
        'networkLocationPresent: $networkLocationPresent, '
        'networkLocationUsable: $networkLocationUsable, hmsLocationPresent: '
        '$hmsLocationPresent, hmsLocationUsable: $hmsLocationUsable, '
        'gnssPresent: $gnssPresent, gnssUsable: $gnssUsable)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LocationSettingsStates &&
        o.blePresent == blePresent &&
        o.bleUsable == bleUsable &&
        o.gpsPresent == gpsPresent &&
        o.gpsUsable == gpsUsable &&
        o.locationPresent == locationPresent &&
        o.locationUsable == locationUsable &&
        o.networkLocationPresent == networkLocationPresent &&
        o.networkLocationUsable == networkLocationUsable &&
        o.hmsLocationPresent == hmsLocationPresent &&
        o.hmsLocationUsable == hmsLocationUsable &&
        o.gnssPresent == gnssPresent &&
        o.gnssUsable == gnssUsable;
  }

  @override
  int get hashCode {
    return hashList([
      blePresent,
      bleUsable,
      gpsPresent,
      gpsUsable,
      locationPresent,
      locationUsable,
      networkLocationPresent,
      networkLocationUsable,
      hmsLocationPresent,
      hmsLocationUsable,
      gnssPresent,
      gnssUsable,
    ]);
  }
}

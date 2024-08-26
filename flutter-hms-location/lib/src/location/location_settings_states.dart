/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

part of '../../huawei_location.dart';

class LocationSettingsStates {
  /// Indicates whether the BLE is available on the device.
  bool blePresent;

  /// Indicates whether the BLE is enabled and can be used by the app.
  bool bleUsable;

  /// Indicates whether the GPS provider is available on the device.
  ///
  /// **Deprecated.**
  bool gpsPresent;

  /// Indicates whether the GPS provider is enabled and can be used by the app.
  ///
  /// **Deprecated.**
  bool gpsUsable;

  /// Indicates whether the location provider is available on the device.
  bool locationPresent;

  /// Indicates whether the location provider is enabled and can be used by
  /// the app.
  bool locationUsable;

  /// Indicates whether the network location provider is available
  /// on the device.
  bool networkLocationPresent;

  /// Indicates whether the network location provider is enabled and can be
  /// used by the app.
  bool networkLocationUsable;

  /// Indicates whether HMS Core (APK) is available for location.
  bool hmsLocationPresent;

  /// Indicates whether the location function is enabled for HMS Core (APK).
  bool hmsLocationUsable;

  /// `True` if the GNSS service is available on the device; `false`
  /// otherwise.
  bool gnssPresent;

  /// `True` if the GNSS function is enabled on the device; `false`
  /// otherwise.
  bool gnssUsable;

  LocationSettingsStates({
    required this.blePresent,
    required this.bleUsable,
    required this.gpsPresent,
    required this.gpsUsable,
    required this.locationPresent,
    required this.locationUsable,
    required this.networkLocationPresent,
    required this.networkLocationUsable,
    required this.hmsLocationPresent,
    required this.hmsLocationUsable,
    required this.gnssPresent,
    required this.gnssUsable,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
    return 'LocationSettingsStates('
        'blePresent: $blePresent, '
        'bleUsable: $bleUsable, '
        'gpsPresent: $gpsPresent, '
        'gpsUsable: $gpsUsable, '
        'locationPresent: $locationPresent, '
        'locationUsable: $locationUsable, '
        'networkLocationPresent: $networkLocationPresent, '
        'networkLocationUsable: $networkLocationUsable, '
        'hmsLocationPresent: $hmsLocationPresent, '
        'hmsLocationUsable: $hmsLocationUsable, '
        'gnssPresent: $gnssPresent, '
        'gnssUsable: $gnssUsable)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is LocationSettingsStates &&
        other.blePresent == blePresent &&
        other.bleUsable == bleUsable &&
        other.gpsPresent == gpsPresent &&
        other.gpsUsable == gpsUsable &&
        other.locationPresent == locationPresent &&
        other.locationUsable == locationUsable &&
        other.networkLocationPresent == networkLocationPresent &&
        other.networkLocationUsable == networkLocationUsable &&
        other.hmsLocationPresent == hmsLocationPresent &&
        other.hmsLocationUsable == hmsLocationUsable &&
        other.gnssPresent == gnssPresent &&
        other.gnssUsable == gnssUsable;
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
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
      ],
    );
  }
}

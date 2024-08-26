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

class LocationSettingsRequest {
  /// Collection of [LocationRequest] objects.
  List<LocationRequest?>? requests;

  /// Indicates whether BLE scanning needs to be enabled.
  ///
  /// The options are `true` (yes) and `false` (no).
  bool alwaysShow;

  /// Indicates whether a location is required for the app to continue.
  ///
  /// The options are `true` (yes) and `false` (no).
  bool needBle;

  LocationSettingsRequest({
    this.requests = const <LocationRequest>[],
    this.alwaysShow = false,
    this.needBle = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requests': requests?.map((LocationRequest? x) => x?.toMap()).toList(),
      'alwaysShow': alwaysShow,
      'needBle': needBle,
    };
  }

  factory LocationSettingsRequest.fromMap(Map<dynamic, dynamic> map) {
    return LocationSettingsRequest(
      requests: List<LocationRequest>.from(
        map['requests']?.map(
          (dynamic x) => LocationRequest.fromMap(x),
        ),
      ),
      alwaysShow: map['alwaysShow'],
      needBle: map['needBle'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationSettingsRequest.fromJson(String source) =>
      LocationSettingsRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocationSettingsRequest('
        'requests: $requests, '
        'alwaysShow: $alwaysShow, '
        'needBle: $needBle)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is LocationSettingsRequest &&
        listEquals(other.requests, requests) &&
        other.alwaysShow == alwaysShow &&
        other.needBle == needBle;
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        requests,
        alwaysShow,
        needBle,
      ],
    );
  }
}

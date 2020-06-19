/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'location_request.dart';

class LocationSettingsRequest {
  List<LocationRequest> requests;
  bool alwaysShow;
  bool needBle;

  LocationSettingsRequest({
    this.requests = const <LocationRequest>[],
    this.alwaysShow = false,
    this.needBle = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'requests': requests?.map((x) => x?.toMap())?.toList(),
      'alwaysShow': alwaysShow,
      'needBle': needBle,
    };
  }

  factory LocationSettingsRequest.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return LocationSettingsRequest(
      requests: List<LocationRequest>.from(
          map['requests']?.map((x) => LocationRequest.fromMap(x))),
      alwaysShow: map['alwaysShow'],
      needBle: map['needBle'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationSettingsRequest.fromJson(String source) =>
      LocationSettingsRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'LocationSettingsRequest(requests: $requests, alwaysShow: $alwaysShow, needBle: $needBle)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LocationSettingsRequest &&
        listEquals(o.requests, requests) &&
        o.alwaysShow == alwaysShow &&
        o.needBle == needBle;
  }

  @override
  int get hashCode {
    return hashList([
      requests,
      alwaysShow,
      needBle,
    ]);
  }
}

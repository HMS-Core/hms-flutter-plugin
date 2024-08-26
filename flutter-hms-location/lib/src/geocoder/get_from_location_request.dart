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

class GetFromLocationRequest {
  double latitude;
  double longitude;
  int maxResults;

  GetFromLocationRequest({
    required this.latitude,
    required this.longitude,
    required this.maxResults,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'maxResults': maxResults,
    };
  }

  factory GetFromLocationRequest.fromMap(Map<dynamic, dynamic> map) {
    return GetFromLocationRequest(
      latitude: map['latitude'],
      longitude: map['longitude'],
      maxResults: map['maxResults'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GetFromLocationRequest.fromJson(String source) =>
      GetFromLocationRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GetFromLocationRequest('
        'latitude: $latitude, '
        'longitude: $longitude, '
        'maxResults: $maxResults)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is GetFromLocationRequest &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.maxResults == maxResults;
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        latitude,
        longitude,
        maxResults,
      ],
    );
  }
}

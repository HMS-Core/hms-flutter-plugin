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

class GetFromLocationNameRequest {
  String locationName;
  int maxResults;
  double? lowerLeftLatitude;
  double? lowerLeftLongitude;
  double? upperRightLatitude;
  double? upperRightLongitude;

  GetFromLocationNameRequest({
    required this.locationName,
    required this.maxResults,
    this.lowerLeftLatitude,
    this.lowerLeftLongitude,
    this.upperRightLatitude,
    this.upperRightLongitude,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'locationName': locationName,
      'maxResults': maxResults,
      'lowerLeftLatitude': lowerLeftLatitude,
      'lowerLeftLongitude': lowerLeftLongitude,
      'upperRightLatitude': upperRightLatitude,
      'upperRightLongitude': upperRightLongitude,
    };
  }

  factory GetFromLocationNameRequest.fromMap(Map<dynamic, dynamic> map) {
    return GetFromLocationNameRequest(
      locationName: map['locationName'],
      maxResults: map['maxResults'],
      lowerLeftLatitude: map['lowerLeftLatitude'],
      lowerLeftLongitude: map['lowerLeftLongitude'],
      upperRightLatitude: map['upperRightLatitude'],
      upperRightLongitude: map['upperRightLongitude'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GetFromLocationNameRequest.fromJson(String source) =>
      GetFromLocationNameRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GetFromLocationNameRequest('
        'locationName: $locationName, '
        'maxResults: $maxResults, '
        'lowerLeftLatitude: $lowerLeftLatitude, '
        'lowerLeftLongitude: $lowerLeftLongitude, '
        'upperRightLatitude: $upperRightLatitude, '
        'upperRightLongitude: $upperRightLongitude)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is GetFromLocationNameRequest &&
        other.locationName == locationName &&
        other.maxResults == maxResults &&
        other.lowerLeftLatitude == lowerLeftLatitude &&
        other.lowerLeftLongitude == lowerLeftLongitude &&
        other.upperRightLatitude == upperRightLatitude &&
        other.upperRightLongitude == upperRightLongitude;
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        locationName,
        maxResults,
        lowerLeftLatitude,
        lowerLeftLongitude,
        upperRightLatitude,
        upperRightLongitude,
      ],
    );
  }
}

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

class ActivityIdentificationData {
  /// The device is in a vehicle, such as a car.
  static const int VEHICLE = 100;

  /// The device is on a bicycle.
  static const int BIKE = 101;

  /// The device user is walking or running.
  static const int FOOT = 102;

  /// The device is still.
  static const int STILL = 103;

  /// The current activity cannot be identified.
  static const int OTHERS = 104;

  /// The device has an obvious tilt change.
  static const int TILTING = 105;

  /// The device user is walking. This is a sub activity of the [FOOT] activity.
  static const int WALKING = 107;

  /// The device user is running. This is a sub activity of the [FOOT] activity.
  static const int RUNNING = 108;

  static const List<int> _validTypes = <int>[
    VEHICLE,
    BIKE,
    FOOT,
    STILL,
    OTHERS,
    TILTING,
    WALKING,
    RUNNING
  ];

  /// Type of the detected activity.
  int? identificationActivity;

  /// Confidence for the user to execute the activity.
  ///
  /// The confidence ranges from `0` to `100`.  A larger value indicates
  /// more reliable activity authenticity.
  int? possibility;

  ActivityIdentificationData({
    this.identificationActivity,
    this.possibility,
  });

  static bool isValidType(int type) {
    return _validTypes.contains(type) ? true : false;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'identificationActivity': identificationActivity,
      'possibility': possibility,
    };
  }

  factory ActivityIdentificationData.fromMap(Map<dynamic, dynamic> map) {
    return ActivityIdentificationData(
      identificationActivity: map['identificationActivity'],
      possibility: map['possibility'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityIdentificationData.fromJson(String source) =>
      ActivityIdentificationData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ActivityIdentificationData('
        'identificationActivity: $identificationActivity, '
        'possibility: $possibility)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is ActivityIdentificationData &&
        other.identificationActivity == identificationActivity &&
        other.possibility == possibility;
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        identificationActivity,
        possibility,
      ],
    );
  }
}

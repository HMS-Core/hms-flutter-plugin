/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_health;

class DeviceInfo {
  /// Mobile phones.
  static const int TYPE_PHONE = 1;

  /// Smart scale.
  static const int TYPE_SCALES = 2;

  /// Smart watch.
  static const int TYPE_SMART_WATCH = 3;

  /// Smart band.
  static const int TYPE_SMART_BAND = 4;

  /// Smart earphones.
  static const int TYPE_SMART_EARPHONE = 5;

  /// Blood glucose monitor.
  static const int TYPE_BLOOD_GLUCOSE_MONITOR = 6;

  /// Blood pressure monitor.
  static const int TYPE_BLOOD_PRESSURE_MONITOR = 7;

  /// Heart rate monitor.
  static const int TYPE_HEART_RATE_MONITOR = 8;

  /// ECG equipment.
  static const int TYPE_ECG_EQUIPMENT = 9;

  /// Thermometer.
  static const int TYPE_THERMOMETERS = 10;

  /// Oximeter.
  static const int TYPE_OXIMETER = 11;

  /// Treadmill.
  static const int TYPE_TREADMILL = 12;

  /// Elliptical machine.
  static const int TYPE_ELLIPTICAL_MACHINE = 13;

  /// Spinning bike.
  static const int TYPE_EXERCISE_BIKE = 14;

  /// Elliptical machine.
  static const int TYPE_ROWING_MACHINE = 15;

  /// Walking machine.
  static const int TYPE_WALKING_MACHINE = 16;

  /// Jump rope.
  static const int TYPE_ROPE_SKIPPING = 17;

  /// Third-party watch.
  static const int TYPE_THIRD_WATCH = 18;

  /// Unknown device.
  static const int TYPE_UNKNOWN = 0;

  /// Default platform.
  static const int PLATFORM_DEFAULT = 0;

  /// Platform other than the default one.
  static const int PLATFORM_OTHER = 2;

  /// Presentation of the phone as a string.
  static const String STR_TYPE_PHONE = 'Phone';

  /// Presentation of the smart scale as a string.
  static const String STR_TYPE_SCALES = 'Scales';

  /// Presentation of the smart watch as a string.
  static const String STR_TYPE_SMART_WATCH = 'Smart watch';

  /// Presentation of the smart band as a string.
  static const String STR_TYPE_SMART_BAND = 'Smart band';

  /// Presentation of the smart earphones as a string.
  static const String STR_TYPE_SMART_EARPHONE = 'Smart earphone';

  /// Presentation of the blood glucose monitor as a string.
  static const String STR_TYPE_BLOOD_GLUCOSE_MONITOR = 'Blood glucose monitor';

  /// Presentation of the blood pressure monitor as a string.
  static const String STR_TYPE_BLOOD_PRESSURE_MONITOR =
      'Blood pressure monitor';

  /// Presentation of the heart rate monitor as a string.
  static const String STR_TYPE_HEART_RATE_MONITOR = 'Heart rate monitor';

  /// ECG equipment represented as a string.
  static const String STR_TYPE_ECG_EQUIPMENT = 'Ecg equipment';

  /// Thermometer represented as a string.
  static const String STR_TYPE_THERMOMETERS = 'Thermometers';

  /// Treadmill represented as a string.
  static const String STR_TYPE_TREADMILL = 'Treadmill';

  /// Oximeter represented as a string.
  static const String STR_TYPE_OXIMETER = 'Oximeter';

  /// Elliptical machine represented as a string.
  static const String STR_TYPE_ELLIPTICAL_MACHINE = 'Elliptical machine';

  /// Spinning bike represented as a string.
  static const String STR_TYPE_EXERCISE_BIKE = 'Exercise bike';

  /// Rowing machine represented as a string.
  static const String STR_TYPE_ROWING_MACHINE = 'Rowing machine';

  /// Walking machine represented as a string.
  static const String STR_TYPE_WALKING_MACHINE = 'Walking machine';

  /// Jump rope represented as a string.
  static const String STR_TYPE_ROPE_SKIPPING = 'Rope skipping';

  /// Third-party watch represented as a string.
  static const String STR_TYPE_THIRD_WATCH = 'Third watch';

  /// Presentation of the unknown device as a string.
  static const String STR_TYPE_UNKNOWN = 'Unknown';

  String? uuid;
  String? deviceManufacturer;
  String? modelName;
  int? deviceType;
  int? platformType;
  bool? fromBleDevice;

  DeviceInfo({
    this.uuid,
    this.deviceManufacturer,
    this.modelName,
    this.deviceType,
    this.platformType,
    this.fromBleDevice,
  });

  factory DeviceInfo.fromMap(Map<dynamic, dynamic> map) {
    return DeviceInfo(
      uuid: map['uuid'],
      fromBleDevice: map['fromBleDevice'],
      deviceManufacturer: map['deviceManufacturer'],
      deviceType: map['deviceType'],
      modelName: map['modelName'],
      platformType: map['platformType'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'deviceManufacturer': deviceManufacturer,
      'modelName': modelName,
      'deviceType': deviceType,
      'platformType:': platformType,
      'fromBleDevice': fromBleDevice,
    }..removeWhere((String k, dynamic v) => v == null);
  }

  String getDeviceTypeById(int deviceType) {
    switch (deviceType) {
      case 0:
        return STR_TYPE_UNKNOWN;
      case 1:
        return STR_TYPE_PHONE;
      case 2:
        return STR_TYPE_SCALES;
      case 3:
        return STR_TYPE_SMART_WATCH;
      case 4:
        return STR_TYPE_SMART_BAND;
      case 5:
        return STR_TYPE_SMART_EARPHONE;
      case 6:
        return STR_TYPE_BLOOD_GLUCOSE_MONITOR;
      case 7:
        return STR_TYPE_BLOOD_PRESSURE_MONITOR;
      case 8:
        return STR_TYPE_HEART_RATE_MONITOR;
      case 9:
        return STR_TYPE_ECG_EQUIPMENT;
      case 10:
        return STR_TYPE_THERMOMETERS;
      case 11:
        return STR_TYPE_OXIMETER;
      case 12:
        return STR_TYPE_TREADMILL;
      case 13:
        return STR_TYPE_ELLIPTICAL_MACHINE;
      case 14:
        return STR_TYPE_EXERCISE_BIKE;
      case 15:
        return STR_TYPE_ROWING_MACHINE;
      case 16:
        return STR_TYPE_WALKING_MACHINE;
      case 17:
        return STR_TYPE_ROPE_SKIPPING;
      case 18:
        return STR_TYPE_THIRD_WATCH;
      default:
        return '';
    }
  }

  int getDeviceTypeByString(String deviceType) {
    switch (deviceType) {
      case STR_TYPE_UNKNOWN:
        return 1;
      case STR_TYPE_PHONE:
        return 2;
      case STR_TYPE_SCALES:
        return 3;
      case STR_TYPE_SMART_WATCH:
        return 4;
      case STR_TYPE_SMART_BAND:
        return 5;
      case STR_TYPE_SMART_EARPHONE:
        return 6;
      case STR_TYPE_BLOOD_GLUCOSE_MONITOR:
        return 7;
      case STR_TYPE_BLOOD_PRESSURE_MONITOR:
        return 8;
      case STR_TYPE_HEART_RATE_MONITOR:
        return 9;
      case STR_TYPE_ECG_EQUIPMENT:
        return 10;
      case STR_TYPE_THERMOMETERS:
        return 11;
      case STR_TYPE_OXIMETER:
        return 12;
      case STR_TYPE_TREADMILL:
        return 13;
      case STR_TYPE_ELLIPTICAL_MACHINE:
        return 14;
      case STR_TYPE_EXERCISE_BIKE:
        return 15;
      case STR_TYPE_ROWING_MACHINE:
        return 16;
      case STR_TYPE_WALKING_MACHINE:
        return 17;
      case STR_TYPE_ROPE_SKIPPING:
        return 17;
      case STR_TYPE_THIRD_WATCH:
        return 17;
      default:
        return 0;
    }
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  bool operator ==(Object other) {
    return other is DeviceInfo &&
        other.uuid == uuid &&
        other.deviceManufacturer == deviceManufacturer &&
        other.modelName == modelName &&
        other.deviceType == deviceType &&
        other.platformType == platformType &&
        other.fromBleDevice == fromBleDevice;
  }

  @override
  int get hashCode {
    return Object.hash(
      uuid,
      deviceManufacturer,
      modelName,
      deviceType,
      platformType,
      fromBleDevice,
    );
  }
}

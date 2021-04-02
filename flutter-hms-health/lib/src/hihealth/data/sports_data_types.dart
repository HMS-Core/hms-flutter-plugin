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

import 'data_type.dart';
import 'sport_fields.dart';

/// Feature value definition of the Fitness Machine Profile. Fields parsed by the
/// protocol can be obtained based on the fields under DataType.
class SportDataTypes {
  /// Exercise data of the treadmill, corresponding to Treadmill Data of the Bluetooth protocol.
  static const DataType TYPE_TREADMILL_DATA = DataType(
      'com.huawei.treadmill.data', READ_SCOPE_NAME_URL, WRITE_SCOPE_NAME_URL, [
    SportFields.FIELD_TREADMILL_INSTANTANEOUS_SPEED,
    SportFields.FIELD_TREADMILL_AVERAGE_SPEED,
    SportFields.FIELD_TREADMILL_TOTAL_DISTANCE,
    SportFields.FIELD_TREADMILL_INCLINATION,
    SportFields.FIELD_TREADMILL_RAMP_ANGLE_SETTING,
    SportFields.FIELD_TREADMILL_POSITIVE_ELEVATION_GAIN,
    SportFields.FIELD_TREADMILL_NEGATIVE_ELEVATION_GAIN,
    SportFields.FIELD_TREADMILL_INSTANTANEOUS_PACE,
    SportFields.FIELD_TREADMILL_AVERAGE_PACE,
    SportFields.FIELD_TREADMILL_TOTAL_ENERGY,
    SportFields.FIELD_TREADMILL_ENERGY_PER_HOUR,
    SportFields.FIELD_TREADMILL_ENERGY_PER_MINUTE,
    SportFields.FIELD_TREADMILL_METABOLIC_EQUIVALENT,
    SportFields.FIELD_TREADMILL_HEART_RATE,
    SportFields.FIELD_TREADMILL_ELAPSED_TIME,
    SportFields.FIELD_TREADMILL_REMAINING_TIME,
    SportFields.FIELD_TREADMILL_FORCE_ON_BELT,
    SportFields.FIELD_TREADMILL_POWER_OUTPUT
  ]);

  /// Exercise data of the treadmill as a crossfit trainer.
  static const DataType TYPE_CROSS_TRAINER_DATA = DataType(
      'com.huawei.cross.trainer.data',
      READ_SCOPE_NAME_URL,
      WRITE_SCOPE_NAME_URL, [
    SportFields.FIELD_CROSS_TRAINER_DATA_INSTANTANEOUS_SPEED,
    SportFields.FIELD_CROSS_TRAINER_DATA_AVERAGE_SPEED,
    SportFields.FIELD_CROSS_TRAINER_DATA_TOTAL_DISTANCE,
    SportFields.FIELD_CROSS_TRAINER_DATA_STEP_PER_MINUTE,
    SportFields.FIELD_CROSS_TRAINER_DATA_AVERAGE_STEP_RATE,
    SportFields.FIELD_CROSS_TRAINER_DATA_STRIDE_COUNT,
    SportFields.FIELD_CROSS_TRAINER_DATA_POSITIVE_ELEVATION_GAIN,
    SportFields.FIELD_CROSS_TRAINER_DATA_NEGATIVE_ELEVATION_GAIN,
    SportFields.FIELD_CROSS_TRAINER_DATA_INCLINATION,
    SportFields.FIELD_CROSS_TRAINER_DATA_RAMP_ANGLE_SETTING,
    SportFields.FIELD_CROSS_TRAINER_DATA_RESISTANCE_LEVEL,
    SportFields.FIELD_CROSS_TRAINER_DATA_INSTANTANEOUS_POWER,
    SportFields.FIELD_CROSS_TRAINER_DATA_AVERAGE_POWER,
    SportFields.FIELD_CROSS_TRAINER_DATA_TOTAL_ENERGY,
    SportFields.FIELD_CROSS_TRAINER_DATA_ENERGY_PER_HOUR,
    SportFields.FIELD_CROSS_TRAINER_DATA_ENERGY_PER_MINUTE,
    SportFields.FIELD_CROSS_TRAINER_DATA_HEART_RATE,
    SportFields.FIELD_CROSS_TRAINER_DATA_METABOLIC_EQUIVALENT,
    SportFields.FIELD_CROSS_TRAINER_DATA_ELAPSED_TIME,
    SportFields.FIELD_CROSS_TRAINER_DATA_REMAINING_TIME
  ]);

  /// Treadmill exercise status.
  static const DataType TYPE_TRAINING_STATUS_DATA = DataType(
      'com.huawei.training.status.data',
      READ_SCOPE_NAME_URL,
      WRITE_SCOPE_NAME_URL, [
    SportFields.FIELD_TRAINING_STATUS,
    SportFields.FIELD_TRAINING_STATUS_STRING
  ]);

  /// Speed range supported by the treadmill.
  static const DataType TYPE_SUPPORT_SPEED_RANGE = DataType(
      'com.huawei.support.speed.range',
      READ_SCOPE_NAME_URL,
      WRITE_SCOPE_NAME_URL, [
    SportFields.FIELD_SUPPORTED_MINIMUM_SPEED,
    SportFields.FIELD_SUPPORTED_MAXIMUM_SPEED,
    SportFields.FIELD_SUPPORTED_MINIMUM_INCREMENT
  ]);

  /// Tilt range supported by the treadmill.
  static const DataType TYPE_SUPPORT_INCLINATION_RANGE = DataType(
      'com.huawei.support.inclination.range',
      READ_SCOPE_NAME_URL,
      WRITE_SCOPE_NAME_URL, [
    SportFields.FIELD_SUPPORTED_INCLINATION_MIN_INCLINATION,
    SportFields.FIELD_SUPPORTED_INCLINATION_MAX_INCLINATION,
    SportFields.FIELD_SUPPORTED_INCLINATION_MIN_INCREMENT
  ]);

  /// Levels supported by treadmill.
  static const DataType TYPE_SUPPORT_LEVEL_RANGE = DataType(
      'com.huawei.support.level.range',
      READ_SCOPE_NAME_URL,
      WRITE_SCOPE_NAME_URL, [
    SportFields.FIELD_SUPPORTED_LEVEL_MIN_RESISTANCE_LEVEL,
    SportFields.FIELD_SUPPORTED_LEVEL_MAX_RESISTANCE_LEVEL,
    SportFields.FIELD_SUPPORTED_LEVEL_MIN_INCREMENT
  ]);

  /// Heart rate range supported by the treadmill.
  static const DataType TYPE_SUPPORT_HEART_RANGE = DataType(
      'com.huawei.support.heart.range',
      READ_SCOPE_NAME_URL,
      WRITE_SCOPE_NAME_URL, [
    SportFields.FIELD_SUPPORTED_HEART_MIN_HEART_RATE,
    SportFields.FIELD_SUPPORTED_HEART_MAX_HEART_RATE,
    SportFields.FIELD_SUPPORTED_HEART_MIN_INCREMENT
  ]);

  /// Power range supported by the treadmill.
  static const DataType TYPE_SUPPORT_POWER_RANGE = DataType(
      'com.huawei.support.power.range',
      READ_SCOPE_NAME_URL,
      WRITE_SCOPE_NAME_URL, [
    SportFields.FIELD_SUPPORTED_POWER_MIN_POWER,
    SportFields.FIELD_SUPPORTED_POWER_MAX_POWER,
    SportFields.FIELD_SUPPORTED_POWER_MIN_INCREMENT
  ]);

  /// Fitness machine function of the treadmill.
  static const DataType TYPE_FITNESS_MACHINE_FEATURE = DataType(
      'com.huawei.fitness.machine.feature',
      READ_SCOPE_NAME_URL,
      WRITE_SCOPE_NAME_URL, [
    SportFields.FIELD_FITNESS_MACHINE_FEATURE,
    SportFields.FIELD_FITNESS_TARGET_SETTING
  ]);

  /// Fitness machine status of the treadmill.
  static const DataType TYPE_FITNESS_MACHINE_STATUS = DataType(
      'com.huawei.fitness.machine.status',
      READ_SCOPE_NAME_URL,
      WRITE_SCOPE_NAME_URL, [
    SportFields.FIELD_MACHINE_STATUS_OP_CODE,
    SportFields.FIELD_MACHINE_STATUS_PARAMETER
  ]);

  /// Response to control commands of the treadmill.
  static const DataType TYPE_FITNESS_MACHINE_CONTROL_INDICATION = DataType(
      'com.huawei.fitness.machine.control.indication',
      READ_SCOPE_NAME_URL,
      WRITE_SCOPE_NAME_URL, [
    SportFields.FIELD_FITNESS_MACHINE_CONTROL_RESPONSE_OP_CODE,
    SportFields.FIELD_FITNESS_MACHINE_CONTROL_REQUEST_OP_CODE,
    SportFields.FIELD_FITNESS_MACHINE_CONTROL_RESULT_OP_CODE,
    SportFields.FIELD_FITNESS_MACHINE_CONTROL_PARAMETER
  ]);

  /// Control commands of the treadmill, used to start, pause, and resume the treadmill, as well as other related operations.
  static const DataType TYPE_FITNESS_MACHINE_CONTROL = DataType(
      'com.huawei.fitness.machine.control.point',
      READ_SCOPE_NAME_URL,
      WRITE_SCOPE_NAME_URL, [
    SportFields.FIELD_FITNESS_MACHINE_CONTROL_REQUEST_OP_CODE,
    SportFields.FIELD_FITNESS_MACHINE_CONTROL_PARAMETER
  ]);

  /// Extended fitness data of the treadmill.
  static const DataType TYPE_FITNESS_EXTENSION_DATA = DataType(
      'com.huawei.fitness.extension.data',
      READ_SCOPE_NAME_URL,
      WRITE_SCOPE_NAME_URL, [
    SportFields.FIELD_EXTENSION_DATA_UNLOCK_CODE,
    SportFields.FIELD_EXTENSION_DATA_HEART_RATE,
    SportFields.FIELD_EXTENSION_DATA_TOTAL_ENERGY,
    SportFields.FIELD_EXTENSION_DATA_DYNAMIC_ENERGY,
    SportFields.FIELD_EXTENSION_DATA_STEP_COUNT
  ]);

  /// Customized BLE command.
  static const DataType TYPE_CUSTOM_BLE_COMMAND = DataType(
      'com.huawei.fitness.custom.command',
      READ_SCOPE_NAME_URL,
      WRITE_SCOPE_NAME_URL, [
    SportFields.FIELD_CHARACTERISTIC_UUID,
    SportFields.FIELD_SERVICES_UUID,
    SportFields.FIELD_FITNESS_MACHINE_CONTROL_REQUEST_OP_CODE,
    SportFields.FIELD_FITNESS_MACHINE_CONTROL_PARAMETER,
    SportFields.FIELD_CUSTOM_COMMAND_CONTENT
  ]);

  // /// Fitness Machine Profile for the treadmill.
  static const DataType TYPE_FITNESS_MACHINE_PROFILE = DataType(
      'com.huawei.fitness.machine.profile',
      READ_SCOPE_NAME_URL,
      WRITE_SCOPE_NAME_URL, []);

  /// Name of the treadmill manufacturer.
  static const DataType TYPE_MANUFACTURER_NAME = DataType(
      'com.huawei.manufacturer.name',
      READ_SCOPE_NAME_URL,
      WRITE_SCOPE_NAME_URL,
      [SportFields.FIELD_DIS_MANUFACTURER_NAME]);

  /// Model of the treadmill.
  static const DataType TYPE_MODEL_NUMBER = DataType(
      'com.huawei.model.number',
      READ_SCOPE_NAME_URL,
      WRITE_SCOPE_NAME_URL,
      [SportFields.FIELD_DIS_MODEL_NUMBER]);

  // /// Serial number of the treadmill.
  static const DataType TYPE_SERIAL_NUMBER = DataType(
      'com.huawei.serial.number',
      READ_SCOPE_NAME_URL,
      WRITE_SCOPE_NAME_URL,
      [SportFields.FIELD_DIS_SERIAL_NUMBER]);

  /// Device version number of the treadmill.
  static const DataType TYPE_HARDWARE_REVISION = DataType(
      'com.huawei.hardware.revision',
      READ_SCOPE_NAME_URL,
      WRITE_SCOPE_NAME_URL,
      [SportFields.FIELD_DIS_HARDWARE_REVISION]);

  /// Firmware version number of the treadmill.
  static const DataType TYPE_FIRMWARE_REVISION = DataType(
      'com.huawei.firmware.revision',
      READ_SCOPE_NAME_URL,
      WRITE_SCOPE_NAME_URL,
      [SportFields.FIELD_DIS_FIRMWARE_REVISION]);

  // /// Software version number of the treadmill.
  static const DataType TYPE_SOFTWARE_REVISION = DataType(
      'com.huawei.software.revision',
      READ_SCOPE_NAME_URL,
      WRITE_SCOPE_NAME_URL,
      [SportFields.FIELD_DIS_SOFTWARE_REVISION]);

  /// System ID of the treadmill.
  static const DataType TYPE_SYSTEM_ID = DataType(
      'com.huawei.system.id',
      READ_SCOPE_NAME_URL,
      WRITE_SCOPE_NAME_URL,
      [SportFields.FIELD_DIS_SYSTEM_ID]);

  /// URL for data reading.
  static const String READ_SCOPE_NAME_URL = 'default';

  /// URL for data writing.
  static const String WRITE_SCOPE_NAME_URL = 'default';
}

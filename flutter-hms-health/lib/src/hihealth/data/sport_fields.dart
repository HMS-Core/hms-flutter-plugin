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

import 'field.dart';

class SportFields {
  static const Field FIELD_TREADMILL_INSTANTANEOUS_SPEED =
      Field.newIntField("treadmill_instantaneous_speed");
  static const Field FIELD_TREADMILL_AVERAGE_SPEED =
      Field.newIntField("treadmill_average_speed");
  static const Field FIELD_TREADMILL_TOTAL_DISTANCE =
      Field.newIntField("treadmill_total_distance");
  static const Field FIELD_TREADMILL_INCLINATION =
      Field.newIntField("treadmill_inclination");
  static const Field FIELD_TREADMILL_RAMP_ANGLE_SETTING =
      Field.newIntField("treadmill_ramp_angle_setting");
  static const Field FIELD_TREADMILL_POSITIVE_ELEVATION_GAIN =
      Field.newIntField("treadmill_positive_elevation_gain");
  static const Field FIELD_TREADMILL_NEGATIVE_ELEVATION_GAIN =
      Field.newIntField("treadmill_negative_elevation_gain");
  static const Field FIELD_TREADMILL_INSTANTANEOUS_PACE =
      Field.newIntField("treadmill_instantaneous_pace");
  static const Field FIELD_TREADMILL_AVERAGE_PACE =
      Field.newIntField("treadmill_average_pace");
  static const Field FIELD_TREADMILL_TOTAL_ENERGY =
      Field.newIntField("treadmill_total_energy");
  static const Field FIELD_TREADMILL_ENERGY_PER_HOUR =
      Field.newIntField("treadmill_energy_per_hour");
  static const Field FIELD_TREADMILL_ENERGY_PER_MINUTE =
      Field.newIntField("treadmill_energy_per_minute");
  static const Field FIELD_TREADMILL_METABOLIC_EQUIVALENT =
      Field.newIntField("treadmill_metabolic_equivalent");
  static const Field FIELD_TREADMILL_HEART_RATE =
      Field.newIntField("treadmill_heart_rate");
  static const Field FIELD_TREADMILL_ELAPSED_TIME =
      Field.newIntField("treadmill_elapsed_time");
  static const Field FIELD_TREADMILL_REMAINING_TIME =
      Field.newIntField("treadmill_remaining_time");
  static const Field FIELD_TREADMILL_FORCE_ON_BELT =
      Field.newIntField("treadmill_force_on_belt");
  static const Field FIELD_TREADMILL_POWER_OUTPUT =
      Field.newIntField("treadmill_power_output");
  static const Field FIELD_TRAINING_STATUS =
      Field.newIntField("training_status");
  static const Field FIELD_TRAINING_STATUS_STRING =
      Field.newStringField("training_status_string");
  static const Field FIELD_SUPPORTED_MINIMUM_SPEED =
      Field.newIntField("supported_minimum_speed");
  static const Field FIELD_SUPPORTED_MAXIMUM_SPEED =
      Field.newIntField("supported_maximum_speed");
  static const Field FIELD_SUPPORTED_MINIMUM_INCREMENT =
      Field.newIntField("supported_minimum_increment");
  static const Field FIELD_SUPPORTED_INCLINATION_MIN_INCLINATION =
      Field.newIntField("supported_inclination_minimum_inclination");
  static const Field FIELD_SUPPORTED_INCLINATION_MAX_INCLINATION =
      Field.newIntField("supported_inclination_maximum_inclination");
  static const Field FIELD_SUPPORTED_INCLINATION_MIN_INCREMENT =
      Field.newIntField("supported_inclination_minimum_increment");
  static const Field FIELD_SUPPORTED_LEVEL_MIN_RESISTANCE_LEVEL =
      Field.newIntField("supported_level_minimum_resistance_level");
  static const Field FIELD_SUPPORTED_LEVEL_MAX_RESISTANCE_LEVEL =
      Field.newIntField("supported_level_maximum_resistance_level");
  static const Field FIELD_SUPPORTED_LEVEL_MIN_INCREMENT =
      Field.newIntField("supported_level_minimum_increment");
  static const Field FIELD_SUPPORTED_HEART_MIN_HEART_RATE =
      Field.newIntField("supported_heart_minimum_heart_rate");
  static const Field FIELD_SUPPORTED_HEART_MAX_HEART_RATE =
      Field.newIntField("supported_heart_maximum_heart_rate");
  static const Field FIELD_SUPPORTED_HEART_MIN_INCREMENT =
      Field.newIntField("supported_heart_minimum_increment");
  static const Field FIELD_SUPPORTED_POWER_MIN_POWER =
      Field.newIntField("supported_power_minimum_power");
  static const Field FIELD_SUPPORTED_POWER_MAX_POWER =
      Field.newIntField("supported_power_maximum_power");
  static const Field FIELD_SUPPORTED_POWER_MIN_INCREMENT =
      Field.newIntField("supported_power_minimum_increment");
  static const Field FIELD_FITNESS_MACHINE_FEATURE =
      Field.newIntField("fitness_machine_feature");
  static const Field FIELD_FITNESS_TARGET_SETTING =
      Field.newIntField("fitness_target_setting");
  static const Field FIELD_FITNESS_MACHINE_CONTROL_RESPONSE_OP_CODE =
      Field.newIntField("fitness_machine_control_response_op_code");
  static const Field FIELD_FITNESS_MACHINE_CONTROL_REQUEST_OP_CODE =
      Field.newIntField("fitness_machine_control_request_op_code");
  static const Field FIELD_FITNESS_MACHINE_CONTROL_RESULT_OP_CODE =
      Field.newIntField("fitness_machine_control_result_op_code");
  static const Field FIELD_FITNESS_MACHINE_CONTROL_PARAMETER =
      Field.newIntField("fitness_machine_control_op_parameter");
  static const Field FIELD_CROSS_TRAINER_DATA_INSTANTANEOUS_SPEED =
      Field.newIntField("cross_trainer_instantaneous_speed");
  static const Field FIELD_CROSS_TRAINER_DATA_AVERAGE_SPEED =
      Field.newIntField("cross_trainer_average_speed");
  static const Field FIELD_CROSS_TRAINER_DATA_TOTAL_DISTANCE =
      Field.newIntField("cross_trainer_total_distance");
  static const Field FIELD_CROSS_TRAINER_DATA_STEP_PER_MINUTE =
      Field.newIntField("cross_trainer_step_per_minute");
  static const Field FIELD_CROSS_TRAINER_DATA_AVERAGE_STEP_RATE =
      Field.newIntField("cross_trainer_average_step_rate");
  static const Field FIELD_CROSS_TRAINER_DATA_STRIDE_COUNT =
      Field.newIntField("cross_trainer_stride_count");
  static const Field FIELD_CROSS_TRAINER_DATA_POSITIVE_ELEVATION_GAIN =
      Field.newIntField("cross_trainer_positive_elevation_gain");
  static const Field FIELD_CROSS_TRAINER_DATA_NEGATIVE_ELEVATION_GAIN =
      Field.newIntField("cross_trainer_negative_elevation_gain");
  static const Field FIELD_CROSS_TRAINER_DATA_INCLINATION =
      Field.newIntField("cross_trainer_inclination");
  static const Field FIELD_CROSS_TRAINER_DATA_RESISTANCE_LEVEL =
      Field.newIntField("cross_trainer_resistance_level");
  static const Field FIELD_CROSS_TRAINER_DATA_RAMP_ANGLE_SETTING =
      Field.newIntField("cross_trainer_ramp_angle_setting");
  static const Field FIELD_CROSS_TRAINER_DATA_INSTANTANEOUS_POWER =
      Field.newIntField("cross_trainer_instantaneous_power");
  static const Field FIELD_CROSS_TRAINER_DATA_AVERAGE_POWER =
      Field.newIntField("cross_trainer_average_power");
  static const Field FIELD_CROSS_TRAINER_DATA_TOTAL_ENERGY =
      Field.newIntField("cross_trainer_total_energy");
  static const Field FIELD_CROSS_TRAINER_DATA_ENERGY_PER_HOUR =
      Field.newIntField("cross_trainer_energy_per_hour");
  static const Field FIELD_CROSS_TRAINER_DATA_ENERGY_PER_MINUTE =
      Field.newIntField("cross_trainer_energy_per_minute");
  static const Field FIELD_CROSS_TRAINER_DATA_HEART_RATE =
      Field.newIntField("cross_trainer_heart_rate");
  static const Field FIELD_CROSS_TRAINER_DATA_METABOLIC_EQUIVALENT =
      Field.newIntField("cross_trainer_metabolic_equivalent");
  static const Field FIELD_CROSS_TRAINER_DATA_ELAPSED_TIME =
      Field.newIntField("cross_trainer_elapsed_time");
  static const Field FIELD_CROSS_TRAINER_DATA_REMAINING_TIME =
      Field.newIntField("cross_trainer_remaining_time");
  static const Field FIELD_MACHINE_STATUS_OP_CODE =
      Field.newIntField("machine_status_op_code");
  static const Field FIELD_EXTENSION_DATA_UNLOCK_CODE =
      Field.newStringField("extension_data_unlock_code");
  static const Field FIELD_EXTENSION_DATA_HEART_RATE =
      Field.newIntField("extension_data_heart_rate");
  static const Field FIELD_EXTENSION_DATA_TOTAL_ENERGY =
      Field.newIntField("extension_data_total_energy");
  static const Field FIELD_EXTENSION_DATA_DYNAMIC_ENERGY =
      Field.newIntField("extension_data_dynamic_energy");
  static const Field FIELD_EXTENSION_DATA_STEP_COUNT =
      Field.newIntField("extension_data_step_count");
  static const Field FIELD_MACHINE_STATUS_PARAMETER =
      Field.newIntField("machine_status_parameter");
  static const Field FIELD_CHARACTERISTIC_UUID =
      Field.newStringField("characteristics_uuid");
  static const Field FIELD_SERVICES_UUID =
      Field.newStringField("services_uuid");
  static const Field FIELD_CUSTOM_COMMAND_CONTENT =
      Field.newStringField("custom_command_content");
  static const Field FIELD_DIS_MANUFACTURER_NAME =
      Field.newStringField("manufacturer_name");
  static const Field FIELD_DIS_MODEL_NUMBER =
      Field.newStringField("model_number");
  static const Field FIELD_DIS_SERIAL_NUMBER =
      Field.newStringField("serial_number");
  static const Field FIELD_DIS_HARDWARE_REVISION =
      Field.newStringField("hardware_revision");
  static const Field FIELD_DIS_FIRMWARE_REVISION =
      Field.newStringField("firmware_revision");
  static const Field FIELD_DIS_SOFTWARE_REVISION =
      Field.newStringField("software_revision");
  static const Field FIELD_DIS_SYSTEM_ID = Field.newStringField("system_id");
}

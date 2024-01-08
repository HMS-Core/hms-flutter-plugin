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

abstract class HealthFields {
  static const Field FIELD_SYSTOLIC_PRESSURE = Field.newDoubleField(
    'systolic_pressure',
  );
  static const Field FIELD_SYSTOLIC_PRESSURE_AVG = Field.newDoubleField(
    'systolic_pressure_avg',
  );
  static const Field FIELD_SYSTOLIC_PRESSURE_MIN = Field.newDoubleField(
    'systolic_pressure_min',
  );
  static const Field FIELD_SYSTOLIC_PRESSURE_MAX = Field.newDoubleField(
    'systolic_pressure_max',
  );
  static const Field FIELD_DIASTOLIC_PRESSURE = Field.newDoubleField(
    'diastolic_pressure',
  );
  static const Field FIELD_DIASTOLIC_PRESSURE_AVG = Field.newDoubleField(
    'diastolic_pressure_avg',
  );
  static const Field FIELD_DIASTOLIC_PRESSURE_MIN = Field.newDoubleField(
    'diastolic_pressure_min',
  );
  static const Field FIELD_DIASTOLIC_PRESSURE_MAX = Field.newDoubleField(
    'diastolic_pressure_max',
  );
  static const Field FIELD_BODY_POSTURE = Field.newIntField(
    'body_posture',
  );
  static const int BODY_POSTURE_STANDING = 1;
  static const int BODY_POSTURE_SITTING = 2;
  static const int BODY_POSTURE_LYING_DOWN = 3;
  static const int BODY_POSTURE_SEMI_RECUMBENT = 4;
  static const Field FIELD_MEASURE_BODY_PART_OF_BLOOD_PRESSURE =
      Field.newIntField('measure_body_part_of_blood_pressure');
  static const int MEASURE_BODY_PART_OF_BLOOD_PRESSURE_LEFT_WRIST = 1;
  static const int MEASURE_BODY_PART_OF_BLOOD_PRESSURE_RIGHT_WRIST = 2;
  static const int MEASURE_BODY_PART_OF_BLOOD_PRESSURE_LEFT_UPPER_ARM = 3;
  static const int MEASURE_BODY_PART_OF_BLOOD_PRESSURE_RIGHT_UPPER_ARM = 4;
  static const Field FIELD_SPHYGMUS = Field.newDoubleField(
    'sphygmus',
  );
  static const Field FIELD_LEVEL = Field.newDoubleField(
    'level',
  );
  static const Field FIELD_MEASURE_TIME = Field.newIntField(
    'measure_time',
  );
  static const int MEASURE_TIME_RANDOM_TIME = 9;
  static const int MEASURE_TIME_BEFORE_BREAKFAST = 1;
  static const int MEASURE_TIME_AFTER_BREAKFAST = 2;
  static const int MEASURE_TIME_BEFORE_LUNCH = 3;
  static const int MEASURE_TIME_AFTER_LUNCH = 4;
  static const int MEASURE_TIME_BEFORE_DINNER = 5;
  static const int MEASURE_TIME_AFTER_DINNER = 6;
  static const int MEASURE_TIME_BEFORE_SLEEP = 7;
  static const int MEASURE_TIME_BEFORE_DAWN = 8;
  static const Field FIELD_CORRELATION_WITH_MEALTIME = Field.newIntField(
    'correlation_with_mealtime',
  );
  static const int FIELD_CORRELATION_WITH_MEALTIME_GENERAL = 1;
  static const int FIELD_CORRELATION_WITH_MEALTIME_FASTING = 2;
  static const int FIELD_CORRELATION_WITH_MEALTIME_BEFORE_MEAL = 3;
  static const int FIELD_CORRELATION_WITH_MEALTIME_AFTER_MEAL = 4;
  static const Field FIELD_CORRELATION_WITH_SLEEP_STATE = Field.newIntField(
    'correlation_with_sleep_state',
  );
  static const int CORRELATION_WITH_SLEEP_STATE_FULLY_AWAKE = 1;
  static const int CORRELATION_WITH_SLEEP_STATE_BEFORE_SLEEP = 2;
  static const int CORRELATION_WITH_SLEEP_STATE_ON_WAKING = 3;
  static const int CORRELATION_WITH_SLEEP_STATE_DURING_SLEEP = 4;
  static const Field FIELD_SAMPLE_SOURCE = Field.newIntField(
    'sample_source',
  );
  static const int SAMPLE_SOURCE_INTERSTITIAL_FLUID = 1;
  static const int SAMPLE_SOURCE_CAPILLARY_BLOOD = 2;
  static const int SAMPLE_SOURCE_PLASMA = 3;
  static const int SAMPLE_SOURCE_SERUM = 4;
  static const int SAMPLE_SOURCE_TEARS = 5;
  static const int SAMPLE_SOURCE_WHOLE_BLOOD = 6;
  static const Field FIELD_SATURATION = Field.newDoubleField(
    'saturation',
  );
  static const Field FIELD_SATURATION_AVG = Field.newDoubleField(
    'saturation_avg',
  );
  static const Field FIELD_SATURATION_MIN = Field.newDoubleField(
    'saturation_min',
  );
  static const Field FIELD_SATURATION_MAX = Field.newDoubleField(
    'saturation_max',
  );
  static const Field FIELD_OXYGEN_SUPPLY_FLOW_RATE = Field.newDoubleField(
    'oxygen_supply_flow_rate',
  );
  static const Field FIELD_OXYGEN_SUPPLY_FLOW_RATE_AVG = Field.newDoubleField(
    'oxygen_supply_flow_rate_avg',
  );
  static const Field FIELD_OXYGEN_SUPPLY_FLOW_RATE_MIN = Field.newDoubleField(
    'oxygen_supply_flow_rate_min',
  );
  static const Field FIELD_OXYGEN_SUPPLY_FLOW_RATE_MAX = Field.newDoubleField(
    'oxygen_supply_flow_rate_max',
  );
  static const Field FIELD_OXYGEN_THERAPY = Field.newIntField(
    'oxygen_therapy',
  );
  static const int OXYGEN_THERAPY_NASAL_CANULA = 1;
  static const Field FIELD_SPO2_MEASUREMENT_MECHANISM = Field.newIntField(
    'spo2_measurement_mechanism',
  );
  static const int SPO2_MEASUREMENT_MECHANISM_PERIPHERAL_CAPILLARY = 1;
  static const Field FIELD_SPO2_MEASUREMENT_APPROACH = Field.newIntField(
    'spo2_measurement_approach',
  );
  static const int SPO2_MEASUREMENT_APPROACH_PULSE_OXIMETRY = 1;
  static const Field FIELD_TEMPERATURE = Field.newDoubleField(
    'temperature',
  );
  static const Field FIELD_MEASURE_BODY_PART_OF_TEMPERATURE = Field.newIntField(
    'measure_body_part_of_temperature',
  );
  static const int MEASURE_BODY_PART_OF_TEMPERATURE_AXILLARY = 1;
  static const int MEASURE_BODY_PART_OF_TEMPERATURE_FINGER = 2;
  static const int MEASURE_BODY_PART_OF_TEMPERATURE_FOREHEAD = 3;
  static const int MEASURE_BODY_PART_OF_TEMPERATURE_ORAL = 4;
  static const int MEASURE_BODY_PART_OF_TEMPERATURE_RECTAL = 5;
  static const int MEASURE_BODY_PART_OF_TEMPERATURE_TEMPORAL_ARTERY = 6;
  static const int MEASURE_BODY_PART_OF_TEMPERATURE_TOE = 7;
  static const int MEASURE_BODY_PART_OF_TEMPERATURE_TYMPANIC = 8;
  static const int MEASURE_BODY_PART_OF_TEMPERATURE_WRIST = 9;
  static const int MEASURE_BODY_PART_OF_TEMPERATURE_VAGINAL = 10;
  static const Field FIELD_TEXTURE = Field.newIntField(
    'texture',
  );
  static const int TEXTURE_DRY = 1;
  static const int TEXTURE_STICKY = 2;
  static const int TEXTURE_CREAMY = 3;
  static const int TEXTURE_WATERY = 4;
  static const int TEXTURE_EGG_WHITE = 5;
  static const Field FIELD_AMOUNT = Field.newIntField(
    'amount',
  );
  static const int AMOUNT_LIGHT = 1;
  static const int AMOUNT_MEDIUM = 2;
  static const int AMOUNT_HEAVY = 3;
  static const Field FIELD_POSITION = Field.newIntField(
    'position',
  );
  static const int POSITION_LOW = 1;
  static const int POSITION_MEDIUM = 2;
  static const int POSITION_HIGH = 3;
  static const Field FIELD_DILATION_STATUS = Field.newIntField(
    'dilation_status',
  );
  static const int DILATION_STATUS_CLOSED = 1;
  static const int DILATION_STATUS_MEDIUM = 2;
  static const int DILATION_STATUS_OPEN = 3;
  static const Field FIELD_FIRMNESS_LEVEL = Field.newIntField(
    'firmness_level',
  );
  static const int FIRMNESS_LEVEL_SOFT = 1;
  static const int FIRMNESS_LEVEL_MEDIUM = 2;
  static const int FIRMNESS_LEVEL_FIRM = 3;
  static const Field FIELD_VOLUME = Field.newIntField(
    'volume',
  );
  static const int VOLUME_SPOTTING = 1;
  static const int VOLUME_LIGHT = 2;
  static const int VOLUME_MEDIUM = 3;
  static const int VOLUME_HEAVY = 4;
  static const Field FIELD_DETECTION_RESULT = Field.newIntField(
    'detection_result',
  );
  static const int DETECTION_RESULT_NEGATIVE = 1;
  static const int DETECTION_RESULT_POSITIVE = 2;
  static const Field FIELD_URIC_ACID = Field.newIntField(
    'uric_acid',
  );
  static const Field FIELD_NITRITE = Field.newIntField(
    'nitrite',
  );
  static const Field FIELD_UROBILINOGEN = Field.newIntField(
    'urobilinogen',
  );
  static const Field FIELD_BILIRUBIN = Field.newIntField(
    'bilirubin',
  );
  static const Field FIELD_GLUCOSE = Field.newIntField(
    'glucose',
  );
  static const Field FIELD_THRESHOLD = Field.newDoubleField(
    'threshold',
  );
  static const Field FIELD_AVG_HEART_RATE = Field.newDoubleField(
    'avg_heart_rate',
  );
  static const Field FIELD_MAX_HEART_RATE = Field.newDoubleField(
    'max_heart_rate',
  );
  static const Field FIELD_MIN_HEART_RATE = Field.newDoubleField(
    'min_heart_rate',
  );
  static const Field FIELD_MEASUREMENT_ANOMALY_FLAG = Field.newIntField(
    'measurement_anomaly_flag',
  );
  static const Field FIELD_BEFORE_MEASURE_ACTIVITY = Field.newIntField(
    'before_measure_activity',
  );
  static const Field FIELD_RECORD_DAY = Field.newIntField(
    'recordDay',
  );
  static const Field FIELD_STATUS = Field.newIntField(
    'status',
  );
  static const Field FIELD_SUB_STATUS = Field.newIntField(
    'subStatus',
  );
  static const Field FIELD_REMARKS = Field.newStringField(
    'remarks',
  );
  static const Field FIELD_TIME_ZONE = Field.newStringField(
    'timeZone',
  );
  static const Field FIELD_DYSMENORRHOEA_LEVEL = Field.newIntField(
    'level',
  );
  static const Field FIELD_PHYSICAL_SYMPTOMS = Field.newStringField(
    'physicalSymptoms',
  );
  static const Field FIELD_SPHYGMUS_AVG = Field.newDoubleField(
    'sphygmus_avg',
  );
  static const Field FIELD_SPHYGMUS_MIN = Field.newDoubleField(
    'sphygmus_min',
  );
  static const Field FIELD_SPHYGMUS_MAX = Field.newDoubleField(
    'sphygmus_max',
  );
  static const Field FIELD_SPHYGMUS_LAST = Field.newDoubleField(
    'sphygmus_last',
  );
  static const Field FIELD_SATURATION_LAST = Field.newDoubleField(
    'saturation_last',
  );

  static const Field SYS_MODE = Field.newIntField(
    'sysMode',
  );

  static const Field SYS_SESSION_DATE = Field.newLongField(
    'sysSessionDate',
  );

  static const Field EVENT_AHI = Field.newDoubleField(
    'eventAhi',
  );

  static const Field SYS_DURATION = Field.newIntField(
    'sysDuration',
  );

  static const Field LUMIS_TIDVOL_MEDIAN = Field.newDoubleField(
    'lumisTidvolMedian',
  );

  static const Field LUMIS_TIDVOL = Field.newDoubleField(
    'lumisTidvol95',
  );

  static const Field LUMIS_TIDVOL_MAX = Field.newDoubleField(
    'lumisTidvolMax',
  );

  static const Field CLINICAL_RESPRATE_MEDIAN = Field.newDoubleField(
    'clinicalRespRateMedian',
  );

  static const Field CLINICAL_RESP_RATE = Field.newDoubleField(
    'clinicalRespRate95',
  );

  static const Field CLINICAL_RESP_RATE_MAX = Field.newDoubleField(
    'clinicalRespRateMax',
  );

  static const Field LUMIS_IERATIO_MEDIAN = Field.newDoubleField(
    'lumisIeratioMedian',
  );

  static const Field LUMIS_IERATIO_QUANTILE = Field.newDoubleField(
    'lumisIeratioQuantile95',
  );

  static const Field LUMIS_IERATIO_MAX = Field.newDoubleField(
    'lumisIeratioMax',
  );

  static const Field MASK_OFF = Field.newIntField(
    'maskOff',
  );

  static const Field HYPOVENTILATION_INDEX = Field.newDoubleField(
    'hypoventilationIndex',
  );

  static const Field OBSTRUCTIVE_APNEA_INDEX = Field.newDoubleField(
    'obstructiveApneaIndex',
  );

  static const Field PRESSURE_BELOW = Field.newDoubleField(
    'pressureBelow95',
  );

  static const Field HYPOVENTILATION_EVENT_TIMES = Field.newIntField(
    'hypoventilationEventTimes',
  );

  static const Field SNORING_EVENT_TIMES = Field.newIntField(
    'snoringEventTimes',
  );

  static const Field CENTER_APNEA_EVENT_TIMES = Field.newIntField(
    'obstructiveApneaEventTimes',
  );

  static const Field OBSTRUCTIVE_APNEA_EVENT_TIMES = Field.newIntField(
    'centerApneaEventTimes',
  );

  static const Field AIR_FLOW_LIMIT_EVENT_TIMES = Field.newIntField(
    'airflowLimitEventTimes',
  );

  static const Field MASSIVE_LEAK_EVENT_TIMES = Field.newIntField(
    'massiveLeakEventTimes',
  );

  static const Field UNKNOW_EVENT_TIMES = Field.newIntField(
    'unknowEventTimes',
  );

  static const Field ALL_EVENT_TIMES = Field.newIntField(
    'allEventTimes',
  );
}

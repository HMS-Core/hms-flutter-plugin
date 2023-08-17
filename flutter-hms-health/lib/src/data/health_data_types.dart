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

abstract class HealthDataTypes {
  static const DataType DT_INSTANTANEOUS_BLOOD_PRESSURE = DataType(
    'com.huawei.instantaneous.blood_pressure',
    'https://www.huawei.com/healthkit/bloodpressure.read',
    'https://www.huawei.com/healthkit/bloodpressure.write',
    <Field>[
      HealthFields.FIELD_SYSTOLIC_PRESSURE,
      HealthFields.FIELD_DIASTOLIC_PRESSURE,
      HealthFields.FIELD_BODY_POSTURE,
      HealthFields.FIELD_MEASURE_BODY_PART_OF_BLOOD_PRESSURE,
      HealthFields.FIELD_SPHYGMUS,
      HealthFields.FIELD_MEASUREMENT_ANOMALY_FLAG,
      HealthFields.FIELD_BEFORE_MEASURE_ACTIVITY,
    ],
  );

  static const DataType DT_INSTANTANEOUS_BLOOD_GLUCOSE = DataType(
    'com.huawei.instantaneous.blood_glucose',
    'https://www.huawei.com/healthkit/bloodglucose.read',
    'https://www.huawei.com/healthkit/bloodglucose.write',
    <Field>[
      HealthFields.FIELD_LEVEL,
      HealthFields.FIELD_MEASURE_TIME,
      HealthFields.FIELD_SAMPLE_SOURCE,
    ],
  );

  static const DataType DT_INSTANTANEOUS_SPO2 = DataType(
    'com.huawei.instantaneous.spo2',
    'https://www.huawei.com/healthkit/oxygensaturation.read',
    'https://www.huawei.com/healthkit/oxygensaturation.write',
    <Field>[
      HealthFields.FIELD_SATURATION,
      HealthFields.FIELD_OXYGEN_SUPPLY_FLOW_RATE,
      HealthFields.FIELD_OXYGEN_THERAPY,
      HealthFields.FIELD_SPO2_MEASUREMENT_MECHANISM,
      HealthFields.FIELD_SPO2_MEASUREMENT_APPROACH,
    ],
  );

  static const DataType DT_INSTANTANEOUS_BODY_TEMPERATURE = DataType(
    'com.huawei.instantaneous.body.temperature',
    'https://www.huawei.com/healthkit/bodytemperature.read',
    'https://www.huawei.com/healthkit/bodytemperature.write',
    <Field>[
      HealthFields.FIELD_TEMPERATURE,
      HealthFields.FIELD_MEASURE_BODY_PART_OF_TEMPERATURE,
    ],
  );

  static const DataType DT_INSTANTANEOUS_SKIN_TEMPERATURE = DataType(
    'com.huawei.instantaneous.skin.temperature',
    'https://www.huawei.com/healthkit/bodytemperature.read',
    'https://www.huawei.com/healthkit/bodytemperature.write',
    <Field>[
      HealthFields.FIELD_TEMPERATURE,
      HealthFields.FIELD_MEASURE_BODY_PART_OF_TEMPERATURE,
    ],
  );

  static const DataType DT_INSTANTANEOUS_BODY_TEMPERATURE_REST = DataType(
    'com.huawei.instantaneous.body.temperature.rest',
    'https://www.huawei.com/healthkit/bodytemperature.read',
    'https://www.huawei.com/healthkit/bodytemperature.write',
    <Field>[
      HealthFields.FIELD_TEMPERATURE,
      HealthFields.FIELD_MEASURE_BODY_PART_OF_TEMPERATURE,
    ],
  );

  static const DataType DT_INSTANTANEOUS_CERVICAL_MUCUS = DataType(
    'com.huawei.instantaneous.cervical_mucus',
    'https://www.huawei.com/healthkit/reproductive.read',
    'https://www.huawei.com/healthkit/reproductive.write',
    <Field>[
      HealthFields.FIELD_TEXTURE,
      HealthFields.FIELD_AMOUNT,
    ],
  );

  static const DataType DT_INSTANTANEOUS_CERVICAL_STATUS = DataType(
    'com.huawei.instantaneous.cervical_status',
    'https://www.huawei.com/healthkit/reproductive.read',
    'https://www.huawei.com/healthkit/reproductive.write',
    <Field>[
      HealthFields.FIELD_POSITION,
      HealthFields.FIELD_DILATION_STATUS,
      HealthFields.FIELD_FIRMNESS_LEVEL,
    ],
  );

  static const DataType DT_CONTINUOUS_MENSTRUAL_FLOW = DataType(
    'com.huawei.continuous.menstrual_flow',
    'https://www.huawei.com/healthkit/reproductive.read',
    'https://www.huawei.com/healthkit/reproductive.write',
    <Field>[
      HealthFields.FIELD_VOLUME,
    ],
  );

  static const DataType DT_INSTANTANEOUS_OVULATION_DETECTION = DataType(
    'com.huawei.instantaneous.ovulation_detection',
    'https://www.huawei.com/healthkit/reproductive.read',
    'https://www.huawei.com/healthkit/reproductive.write',
    <Field>[
      HealthFields.FIELD_DETECTION_RESULT,
    ],
  );

  static const DataType DT_INSTANTANEOUS_VAGINAL_SPECKLE = DataType(
    'com.huawei.instantaneous.vaginal_speckle',
    'https://www.huawei.com/healthkit/reproductive.read',
    'https://www.huawei.com/healthkit/reproductive.write',
    <Field>[
      Field.FIELD_APPEARANCE,
    ],
  );

  static const DataType DT_INSTANTANEOUS_URIC_ACID = DataType(
    'com.huawei.instantaneous.uric_acid',
    'https://www.huawei.com/healthkit/uricacid.read',
    'https://www.huawei.com/healthkit/uricacid.write',
    <Field>[
      HealthFields.FIELD_URIC_ACID,
    ],
  );

  static const DataType DT_INSTANTANEOUS_URINE_ROUTINE_NITRITE = DataType(
    'com.huawei.instantaneous.urine_routine.nitrite',
    'https://www.huawei.com/healthkit/urineroutine.read',
    'https://www.huawei.com/healthkit/urineroutine.write',
    <Field>[
      HealthFields.FIELD_NITRITE,
    ],
  );

  static const DataType DT_INSTANTANEOUS_URINE_ROUTINE_UROBILINOGEN = DataType(
    'com.huawei.instantaneous.urine_routine.urobilinogen',
    'https://www.huawei.com/healthkit/urineroutine.read',
    'https://www.huawei.com/healthkit/urineroutine.write',
    <Field>[
      HealthFields.FIELD_UROBILINOGEN,
    ],
  );

  static const DataType DT_INSTANTANEOUS_URINE_ROUTINE_BILIRUBIN = DataType(
    'com.huawei.instantaneous.urine_routine.bilirubin',
    'https://www.huawei.com/healthkit/urineroutine.read',
    'https://www.huawei.com/healthkit/urineroutine.write',
    <Field>[
      HealthFields.FIELD_BILIRUBIN,
    ],
  );

  static const DataType DT_INSTANTANEOUS_URINE_ROUTINE_GLUCOSE = DataType(
    'com.huawei.instantaneous.urine_routine.glucose',
    'https://www.huawei.com/healthkit/urineroutine.read',
    'https://www.huawei.com/healthkit/urineroutine.write',
    <Field>[
      HealthFields.FIELD_GLUCOSE,
    ],
  );

  static const DataType DT_HEALTH_RECORD_TACHYCARDIA = DataType(
    'com.huawei.health.record.tachycardia',
    'https://www.huawei.com/healthkit/hearthealth.read',
    'https://www.huawei.com/healthkit/hearthealth.write',
    <Field>[
      HealthFields.FIELD_THRESHOLD,
      HealthFields.FIELD_AVG_HEART_RATE,
      HealthFields.FIELD_MAX_HEART_RATE,
      HealthFields.FIELD_MIN_HEART_RATE,
    ],
  );

  static const DataType DT_HEALTH_RECORD_BRADYCARDIA = DataType(
    'com.huawei.health.record.bradycardia',
    'https://www.huawei.com/healthkit/hearthealth.read',
    'https://www.huawei.com/healthkit/hearthealth.write',
    <Field>[
      HealthFields.FIELD_THRESHOLD,
      HealthFields.FIELD_AVG_HEART_RATE,
      HealthFields.FIELD_MAX_HEART_RATE,
      HealthFields.FIELD_MIN_HEART_RATE,
    ],
  );

  static const DataType DT_HEALTH_RECORD_SLEEP = DataType(
    'com.huawei.health.record.sleep',
    'https://www.huawei.com/healthkit/sleep.read',
    'https://www.huawei.com/healthkit/sleep.write',
    <Field>[
      Field.FALL_ASLEEP_TIME,
      Field.WAKE_UP_TIME,
      Field.LIGHT_SLEEP_TIME,
      Field.DEEP_SLEEP_TIME,
      Field.DREAM_TIME,
      Field.AWAKE_TIME,
      Field.ALL_SLEEP_TIME,
      Field.WAKE_UP_CNT,
      Field.DEEP_SLEEP_PART,
      Field.SLEEP_SCORE,
      Field.SLEEP_LATENCY,
      Field.SLEEP_EFFICIENCY,
      Field.GO_BED_TIME_NEW,
      Field.SLEEP_TYPE,
      Field.PREPARE_SLEEP_TIME,
      Field.OFF_BED_TIME,
    ],
  );

  static const DataType POLYMERIZE_CONTINUOUS_BODY_BLOOD_PRESSURE_STATISTICS =
      DataType(
    'com.huawei.continuous.body.blood_pressure.statistics',
    'https://www.huawei.com/healthkit/bloodpressure.read',
    'https://www.huawei.com/healthkit/bloodpressure.write',
    <Field>[
      HealthFields.FIELD_SYSTOLIC_PRESSURE_AVG,
      HealthFields.FIELD_SYSTOLIC_PRESSURE_MAX,
      HealthFields.FIELD_SYSTOLIC_PRESSURE_MIN,
      HealthFields.FIELD_DIASTOLIC_PRESSURE_AVG,
      HealthFields.FIELD_DIASTOLIC_PRESSURE_MAX,
      HealthFields.FIELD_DIASTOLIC_PRESSURE_MIN,
      HealthFields.FIELD_SPHYGMUS_AVG,
      HealthFields.FIELD_SPHYGMUS_MAX,
      HealthFields.FIELD_SPHYGMUS_MIN,
      HealthFields.FIELD_SPHYGMUS_LAST,
    ],
    isPolymerizedFlag: true,
  );

  static const DataType POLYMERIZE_CONTINUOUS_BODY_BLOOD_GLUCOSE_STATISTICS =
      DataType(
    'com.huawei.continuous.blood_glucose.statistics',
    'https://www.huawei.com/healthkit/bloodglucose.read',
    'https://www.huawei.com/healthkit/bloodglucose.write',
    <Field>[
      Field.FIELD_AVG,
      Field.FIELD_MAX,
      Field.FIELD_MIN,
      HealthFields.FIELD_CORRELATION_WITH_MEALTIME,
      Field.FIELD_MEAL,
      HealthFields.FIELD_CORRELATION_WITH_SLEEP_STATE,
      HealthFields.FIELD_SAMPLE_SOURCE,
    ],
    isPolymerizedFlag: true,
  );

  static const DataType POLYMERIZE_CONTINUOUS_SPO2_STATISTICS = DataType(
    'com.huawei.continuous.spo2.statistics',
    'https://www.huawei.com/healthkit/oxygensaturation.read',
    'https://www.huawei.com/healthkit/oxygensaturation.write',
    <Field>[
      HealthFields.FIELD_SATURATION_AVG,
      HealthFields.FIELD_SATURATION_MAX,
      HealthFields.FIELD_SATURATION_MIN,
      HealthFields.FIELD_SATURATION_LAST,
    ],
    isPolymerizedFlag: true,
  );

  static const DataType POLYMERIZE_CONTINUOUS_BODY_TEMPERATURE_STATISTICS =
      DataType(
    'com.huawei.continuous.body.temperature.statistics',
    'https://www.huawei.com/healthkit/bodytemperature.read',
    'https://www.huawei.com/healthkit/bodytemperature.write',
    <Field>[
      Field.FIELD_AVG,
      Field.FIELD_MAX,
      Field.FIELD_MIN,
    ],
    isPolymerizedFlag: true,
  );

  static const DataType POLYMERIZE_CONTINUOUS_SKIN_TEMPERATURE_STATISTICS =
      DataType(
    'com.huawei.continuous.skin.temperature.statistics',
    'https://www.huawei.com/healthkit/bodytemperature.read',
    'https://www.huawei.com/healthkit/bodytemperature.write',
    <Field>[
      Field.FIELD_AVG,
      Field.FIELD_MAX,
      Field.FIELD_MIN,
    ],
    isPolymerizedFlag: true,
  );

  static const DataType POLYMERIZE_CONTINUOUS_BODY_TEMPERATURE_REST_STATISTICS =
      DataType(
    'com.huawei.continuous.body.temperature.rest.statistics',
    'https://www.huawei.com/healthkit/bodytemperature.read',
    'https://www.huawei.com/healthkit/bodytemperature.write',
    <Field>[
      Field.FIELD_AVG,
      Field.FIELD_MAX,
      Field.FIELD_MIN,
    ],
    isPolymerizedFlag: true,
  );

  static const DataType POLYMERIZE_INSTANTANEOUS_CERVICAL_MUCUS = DataType(
    'com.huawei.instantaneous.cervical_mucus',
    'https://www.huawei.com/healthkit/reproductive.read',
    'https://www.huawei.com/healthkit/reproductive.write',
    <Field>[
      HealthFields.FIELD_TEXTURE,
      HealthFields.FIELD_AMOUNT,
    ],
    isPolymerizedFlag: true,
  );

  static const DataType POLYMERIZE_INSTANTANEOUS_CERVICAL_STATUS = DataType(
    'com.huawei.instantaneous.cervical_status',
    'https://www.huawei.com/healthkit/reproductive.read',
    'https://www.huawei.com/healthkit/reproductive.write',
    <Field>[
      HealthFields.FIELD_POSITION,
      HealthFields.FIELD_DILATION_STATUS,
      HealthFields.FIELD_FIRMNESS_LEVEL,
    ],
    isPolymerizedFlag: true,
  );

  static const DataType POLYMERIZE_CONTINUOUS_MENSTRUAL_FLOW = DataType(
    'com.huawei.continuous.menstrual_flow',
    'https://www.huawei.com/healthkit/reproductive.read',
    'https://www.huawei.com/healthkit/reproductive.write',
    <Field>[
      HealthFields.FIELD_VOLUME,
    ],
    isPolymerizedFlag: true,
  );

  static const DataType POLYMERIZE_INSTANTANEOUS_OVULATION_DETECTION = DataType(
    'com.huawei.instantaneous.ovulation_detection',
    'https://www.huawei.com/healthkit/reproductive.read',
    'https://www.huawei.com/healthkit/reproductive.write',
    <Field>[
      HealthFields.FIELD_DETECTION_RESULT,
    ],
    isPolymerizedFlag: true,
  );

  static const DataType POLYMERIZE_INSTANTANEOUS_VAGINAL_SPECKLE = DataType(
    'com.huawei.instantaneous.vaginal_speckle',
    'https://www.huawei.com/healthkit/reproductive.read',
    'https://www.huawei.com/healthkit/reproductive.write',
    <Field>[
      Field.FIELD_APPEARANCE,
    ],
    isPolymerizedFlag: true,
  );

  static const DataType DT_HEALTH_RECORD_MENSTRUAL_CYCLE = DataType(
    'com.huawei.health.record.menstrual_cycle',
    'https://www.huawei.com/healthkit/reproductive.read',
    'https://www.huawei.com/healthkit/reproductive.write',
    <Field>[
      HealthFields.FIELD_RECORD_DAY,
      HealthFields.FIELD_STATUS,
      HealthFields.FIELD_SUB_STATUS,
      HealthFields.FIELD_REMARKS,
      HealthFields.FIELD_TIME_ZONE,
    ],
    isPolymerizedFlag: true,
  );

  static const DataType FIELD_DYSMENORRHOEA = DataType(
    'com.huawei.dysmenorrhoea',
    'https://www.huawei.com/healthkit/reproductive.read',
    'https://www.huawei.com/healthkit/reproductive.write',
    <Field>[
      HealthFields.FIELD_DYSMENORRHOEA_LEVEL,
    ],
    isPolymerizedFlag: true,
  );

  static const DataType FIELD_PHYSICAL_SYMPTOMS = DataType(
    'com.huawei.physical_symptoms',
    'https://www.huawei.com/healthkit/reproductive.read',
    'https://www.huawei.com/healthkit/reproductive.write',
    <Field>[
      HealthFields.FIELD_PHYSICAL_SYMPTOMS,
    ],
    isPolymerizedFlag: true,
  );

  static const DataType DT_SLEEP_RESPIRATORY_DETAIL = DataType(
    'com.huawei.sleep_respiratory_detail',
    'https://www.huawei.com/healthkit/pulmonary.read',
    'https://www.huawei.com/healthkit/pulmonary.write',
    <Field>[
      Field.SLEEP_RESPIRATORY_TYPE,
      Field.SLEEP_RESPIRATORY_VALUE,
    ],
    isPolymerizedFlag: true,
  );

  static const DataType DT_SLEEP_RESPIRATORY_EVENT = DataType(
    'com.huawei.sleep_respiratory_event',
    'https://www.huawei.com/healthkit/pulmonary.read',
    'https://www.huawei.com/healthkit/pulmonary.write',
    <Field>[
      Field.EVENT_NAME,
    ],
    isPolymerizedFlag: true,
  );

  static const DataType DT_HEALTH_RECORD_VENTILATOR = DataType(
    'com.huawei.health.record.ventilator',
    'https://www.huawei.com/healthkit/pulmonary.read',
    'https://www.huawei.com/healthkit/pulmonary.write',
    <Field>[
      HealthFields.SYS_MODE,
      HealthFields.SYS_SESSION_DATE,
      HealthFields.EVENT_AHI,
      HealthFields.SYS_DURATION,
      HealthFields.LUMIS_TIDVOL_MEDIAN,
      HealthFields.LUMIS_TIDVOL,
      HealthFields.LUMIS_TIDVOL_MAX,
      HealthFields.CLINICAL_RESPRATE_MEDIAN,
      HealthFields.CLINICAL_RESP_RATE,
      HealthFields.CLINICAL_RESP_RATE_MAX,
      HealthFields.LUMIS_IERATIO_MEDIAN,
      HealthFields.LUMIS_IERATIO_QUANTILE,
      HealthFields.LUMIS_IERATIO_MAX,
      HealthFields.MASK_OFF,
      HealthFields.HYPOVENTILATION_INDEX,
      HealthFields.OBSTRUCTIVE_APNEA_INDEX,
      HealthFields.PRESSURE_BELOW,
      HealthFields.HYPOVENTILATION_EVENT_TIMES,
      HealthFields.SNORING_EVENT_TIMES,
      HealthFields.CENTER_APNEA_EVENT_TIMES,
      HealthFields.OBSTRUCTIVE_APNEA_EVENT_TIMES,
      HealthFields.AIR_FLOW_LIMIT_EVENT_TIMES,
      HealthFields.MASSIVE_LEAK_EVENT_TIMES,
      HealthFields.UNKNOW_EVENT_TIMES,
      HealthFields.ALL_EVENT_TIMES,
    ],
    isPolymerizedFlag: true,
  );

  static const DataType DT_CGM_BLOOD_GLUCOSE = DataType(
    'com.huawei.cgm_blood_glucose',
    'https://www.huawei.com/healthkit/bloodglucose.read',
    'https://www.huawei.com/healthkit/bloodglucose.write',
    <Field>[
      HealthFields.FIELD_LEVEL,
    ],
    isPolymerizedFlag: true,
  );

  static const DataType POLYMERIZE_CGM_BLOOD_GLUCOSE_STATISTICS = DataType(
    'com.huawei.cgm_blood_glucose.statistics',
    'https://www.huawei.com/healthkit/bloodglucose.read',
    'https://www.huawei.com/healthkit/bloodglucose.write',
    <Field>[
      Field.AVG,
      Field.MAX,
      Field.MIN,
      Field.LAST,
    ],
    isPolymerizedFlag: true,
  );
}

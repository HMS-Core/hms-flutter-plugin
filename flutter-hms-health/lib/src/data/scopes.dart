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

/// Scope constant class, which is used to apply for scopes to access Health Kit data from users.
class Scope {
  final String scopeStr;

  const Scope._(this.scopeStr);

  static List<Scope> get getAllScopes {
    return <Scope>[
      HEALTHKIT_ACTIVITY_READ,
      HEALTHKIT_ACTIVITY_WRITE,
      HEALTHKIT_BLOODGLUCOSE_READ,
      HEALTHKIT_BLOODGLUCOSE_WRITE,
      HEALTHKIT_CALORIES_READ,
      HEALTHKIT_CALORIES_WRITE,
      HEALTHKIT_DISTANCE_READ,
      HEALTHKIT_DISTANCE_WRITE,
      HEALTHKIT_HEARTRATE_READ,
      HEALTHKIT_HEARTRATE_WRITE,
      HEALTHKIT_HEIGHTWEIGHT_READ,
      HEALTHKIT_HEIGHTWEIGHT_WRITE,
      HEALTHKIT_LOCATION_READ,
      HEALTHKIT_LOCATION_WRITE,
      HEALTHKIT_PULMONARY_READ,
      HEALTHKIT_PULMONARY_WRITE,
      HEALTHKIT_SLEEP_READ,
      HEALTHKIT_SLEEP_WRITE,
      HEALTHKIT_SPEED_READ,
      HEALTHKIT_SPEED_WRITE,
      HEALTHKIT_STEP_READ,
      HEALTHKIT_STEP_WRITE,
      HEALTHKIT_STRENGTH_READ,
      HEALTHKIT_STRENGTH_WRITE,
      HEALTHKIT_BODYFAT_READ,
      HEALTHKIT_BODYFAT_WRITE,
      HEALTHKIT_NUTRITION_READ,
      HEALTHKIT_NUTRITION_WRITE,
      HEALTHKIT_BLOODPRESSURE_READ,
      HEALTHKIT_BLOODPRESSURE_WRITE,
      HEALTHKIT_BODYTEMPERATURE_READ,
      HEALTHKIT_BODYTEMPERATURE_WRITE,
      HEALTHKIT_OXYGENSTATURATION_READ,
      HEALTHKIT_OXYGENSTATURATION_WRITE,
      HEALTHKIT_REPRODUCTIVE_READ,
      HEALTHKIT_REPRODUCTIVE_WRITE,
      HEALTHKIT_ACTIVITY_RECORD_READ,
      HEALTHKIT_ACTIVITY_RECORD_WRITE,
      HEALTHKIT_HEARTRATE_REALTIME,
      HEALTHKIT_STEP_REALTIME,
      HEALTHKIT_HEARTHEALTH_WRITE,
      HEALTHKIT_HEARTHEALTH_READ,
      HEALTHKIT_STRESS_WRITE,
      HEALTHKIT_STRESS_READ,
      HEALTHKIT_OXYGEN_SATURATION_WRITE,
      HEALTHKIT_OXYGEN_SATURATION_READ,
      HEALTHKIT_HISTORYDATA_OPEN_WEEK,
      HEALTHKIT_HISTORYDATA_OPEN_MONTH,
      HEALTHKIT_HISTORYDATA_OPEN_YEAR,
    ];
  }

  /// Views the activity data (such as activity points, workout, strength,
  /// running posture, cycling, and activity duration) in HUAWEI Health Kit.
  static const Scope HEALTHKIT_ACTIVITY_READ = Scope._(
    'https://www.huawei.com/healthkit/activity.read',
  );

  /// Stores the activity data (such as activity points, workout, strength,
  /// running posture, cycling, and activity duration) in HUAWEI Health Kit.
  static const Scope HEALTHKIT_ACTIVITY_WRITE = Scope._(
    'https://www.huawei.com/healthkit/activity.write',
  );

  /// Views the blood glucose data in HUAWEI Health Kit.
  static const Scope HEALTHKIT_BLOODGLUCOSE_READ = Scope._(
    'https://www.huawei.com/healthkit/bloodglucose.read',
  );

  /// Stores the blood glucose data in HUAWEI Health Kit.
  static const Scope HEALTHKIT_BLOODGLUCOSE_WRITE = Scope._(
    'https://www.huawei.com/healthkit/bloodglucose.write',
  );

  /// Views the calories (including the BMR) in HUAWEI Health Kit.
  static const Scope HEALTHKIT_CALORIES_READ = Scope._(
    'https://www.huawei.com/healthkit/calories.read',
  );

  /// Stores calories (including the BMR) in HUAWEI Health Kit.
  static const Scope HEALTHKIT_CALORIES_WRITE = Scope._(
    'https://www.huawei.com/healthkit/calories.write',
  );

  /// Views the distance and climbing height in HUAWEI Health Kit.
  static const Scope HEALTHKIT_DISTANCE_READ = Scope._(
    'https://www.huawei.com/healthkit/distance.read',
  );

  /// Stores the distance and climbing height in HUAWEI Health Kit.
  static const Scope HEALTHKIT_DISTANCE_WRITE = Scope._(
    'https://www.huawei.com/healthkit/distance.write',
  );

  /// Views the heart rate data in HUAWEI Health Kit.
  static const Scope HEALTHKIT_HEARTRATE_READ = Scope._(
    'https://www.huawei.com/healthkit/heartrate.read',
  );

  /// Stores the heart rate data in HUAWEI Health Kit.
  static const Scope HEALTHKIT_HEARTRATE_WRITE = Scope._(
    'https://www.huawei.com/healthkit/heartrate.write',
  );

  /// Views the height and weight in HUAWEI Health Kit.
  static const Scope HEALTHKIT_HEIGHTWEIGHT_READ = Scope._(
    'https://www.huawei.com/healthkit/heightweight.read',
  );

  /// Stores the height and weight in HUAWEI Health Kit.
  static const Scope HEALTHKIT_HEIGHTWEIGHT_WRITE = Scope._(
    'https://www.huawei.com/healthkit/heightweight.write',
  );

  /// Views the location data (including the trajectory) in HUAWEI Health Kit.
  static const Scope HEALTHKIT_LOCATION_READ = Scope._(
    'https://www.huawei.com/healthkit/location.read',
  );

  /// Stores the location data (including the trajectory) in HUAWEI Health Kit.
  static const Scope HEALTHKIT_LOCATION_WRITE = Scope._(
    'https://www.huawei.com/healthkit/location.write',
  );

  /// Views the pulmonary function data (e.g. VO2 Max) in HUAWEI Health Kit.
  static const Scope HEALTHKIT_PULMONARY_READ = Scope._(
    'https://www.huawei.com/healthkit/pulmonary.read',
  );

  /// Stores the pulmonary function data (e.g. VO2 Max) in HUAWEI Health Kit.
  static const Scope HEALTHKIT_PULMONARY_WRITE = Scope._(
    'https://www.huawei.com/healthkit/pulmonary.write',
  );

  /// Views the sleep data in HUAWEI Health Kit.
  static const Scope HEALTHKIT_SLEEP_READ = Scope._(
    'https://www.huawei.com/healthkit/sleep.read',
  );

  /// Stores the sleep data in HUAWEI Health Kit.
  static const Scope HEALTHKIT_SLEEP_WRITE = Scope._(
    'https://www.huawei.com/healthkit/sleep.write',
  );

  /// Views the speed in HUAWEI Health Kit.
  static const Scope HEALTHKIT_SPEED_READ = Scope._(
    'https://www.huawei.com/healthkit/speed.read',
  );

  /// Stores the speed in HUAWEI Health Kit.
  static const Scope HEALTHKIT_SPEED_WRITE = Scope._(
    'https://www.huawei.com/healthkit/speed.write',
  );

  /// Views the step count in HUAWEI Health Kit.
  static const Scope HEALTHKIT_STEP_READ = Scope._(
    'https://www.huawei.com/healthkit/step.read',
  );

  /// Stores the step count in HUAWEI Health Kit.
  static const Scope HEALTHKIT_STEP_WRITE = Scope._(
    'https://www.huawei.com/healthkit/step.write',
  );

  /// Views medium- and high-intensity data in HUAWEI Health Kit.
  static const Scope HEALTHKIT_STRENGTH_READ = Scope._(
    'https://www.huawei.com/healthkit/strength.read',
  );

  /// Stores medium- and high-intensity data in HUAWEI Health Kit.
  static const Scope HEALTHKIT_STRENGTH_WRITE = Scope._(
    'https://www.huawei.com/healthkit/strength.write',
  );

  /// Views the body fat data (such as body fat rate, BMI, muscle mass,
  /// moisture rate, visceral fat, bone salt, protein ratio, and skeletal muscle mass)
  /// in HUAWEI Health Kit.
  static const Scope HEALTHKIT_BODYFAT_READ = Scope._(
    'https://www.huawei.com/healthkit/bodyfat.read',
  );

  /// Stores the body fat data (such as body fat rate, BMI, muscle mass,
  /// moisture rate, visceral fat, bone salt, protein ratio, and skeletal muscle mass)
  /// in HUAWEI Health Kit.
  static const Scope HEALTHKIT_BODYFAT_WRITE = Scope._(
    'https://www.huawei.com/healthkit/bodyfat.write',
  );

  /// Views the nutrition data in HUAWEI Health Kit.
  static const Scope HEALTHKIT_NUTRITION_READ = Scope._(
    'https://www.huawei.com/healthkit/nutrition.read',
  );

  /// Stores the nutrition data in HUAWEI Health Kit.
  static const Scope HEALTHKIT_NUTRITION_WRITE = Scope._(
    'https://www.huawei.com/healthkit/nutrition.write',
  );

  /// Views the blood pressure data in HUAWEI Health Kit.
  static const Scope HEALTHKIT_BLOODPRESSURE_READ = Scope._(
    'https://www.huawei.com/healthkit/bloodpressure.read',
  );

  /// Stores the blood pressure data in HUAWEI Health Kit.
  static const Scope HEALTHKIT_BLOODPRESSURE_WRITE = Scope._(
    'https://www.huawei.com/healthkit/bloodpressure.write',
  );

  /// Views the body temperature data in HUAWEI Health Kit.
  static const Scope HEALTHKIT_BODYTEMPERATURE_READ = Scope._(
    'https://www.huawei.com/healthkit/bodytemperature.read',
  );

  /// Stores the body temperature data in HUAWEI Health Kit.
  static const Scope HEALTHKIT_BODYTEMPERATURE_WRITE = Scope._(
    'https://www.huawei.com/healthkit/bodytemperature.write',
  );

  /// Views the blood oxygen data in HUAWEI Health Kit.
  static const Scope HEALTHKIT_OXYGENSTATURATION_READ = Scope._(
    'https://www.huawei.com/healthkit/oxygensaturation.read',
  );

  /// Stores the blood oxygen data in HUAWEI Health Kit.
  static const Scope HEALTHKIT_OXYGENSTATURATION_WRITE = Scope._(
    'https://www.huawei.com/healthkit/oxygensaturation.write',
  );

  /// Views the reproductive data in HUAWEI Health Kit.
  static const Scope HEALTHKIT_REPRODUCTIVE_READ = Scope._(
    'https://www.huawei.com/healthkit/reproductive.read',
  );

  /// Stores the reproductive data in HUAWEI Health Kit.
  static const Scope HEALTHKIT_REPRODUCTIVE_WRITE = Scope._(
    'https://www.huawei.com/healthkit/reproductive.write',
  );

  /// Views the activity data (such as activity points, workout, strength,
  /// running posture, cycling, and activity duration) in HUAWEI Health Kit.
  static const Scope HEALTHKIT_ACTIVITY_RECORD_READ = Scope._(
    'https://www.huawei.com/healthkit/activityrecord.read',
  );

  /// Stores the activity data (such as activity points, workout, strength,
  /// running posture, cycling, and activity duration) in HUAWEI Health Kit.
  static const Scope HEALTHKIT_ACTIVITY_RECORD_WRITE = Scope._(
    'https://www.huawei.com/healthkit/activityrecord.write',
  );

  /// Subscribes to real-time heart data in HUAWEI Health Kit.
  static const Scope HEALTHKIT_HEARTRATE_REALTIME = Scope._(
    'https://www.huawei.com/healthkit/heartrate.realtime',
  );

  /// Subscribes to real-time total step count data in HUAWEI Health Kit.
  static const Scope HEALTHKIT_STEP_REALTIME = Scope._(
    'https://www.huawei.com/healthkit/step.realtime',
  );

  /// Views the SpO2 data from Health Kit.
  static const Scope HEALTHKIT_OXYGEN_SATURATION_READ = Scope._(
    'https://www.huawei.com/healthkit/oxygensaturation.read',
  );

  /// Stores the SpO2 data to Health Kit.
  static const Scope HEALTHKIT_OXYGEN_SATURATION_WRITE = Scope._(
    'https://www.huawei.com/healthkit/oxygensaturation.write',
  );

  /// Views the stress data from Health Kit.
  static const Scope HEALTHKIT_STRESS_READ = Scope._(
    'https://www.huawei.com/healthkit/stress.read',
  );

  /// Stores the stress data to Health Kit.
  static const Scope HEALTHKIT_STRESS_WRITE = Scope._(
    'https://www.huawei.com/healthkit/stress.write',
  );

  /// Views the heart health data (such as heart rate variability and ECG)
  /// from Health Kit.
  static const Scope HEALTHKIT_HEARTHEALTH_READ = Scope._(
    'https://www.huawei.com/healthkit/hearthealth.read',
  );

  /// Stores the heart health data (such as heart rate variability and
  /// electrocardiogram) to Health Kit.
  static const Scope HEALTHKIT_HEARTHEALTH_WRITE = Scope._(
    'https://www.huawei.com/healthkit/hearthealth.write',
  );

  /// Views data of the previous week from Health Kit.
  static const Scope HEALTHKIT_HISTORYDATA_OPEN_WEEK = Scope._(
    'https://www.huawei.com/healthkit/historydata.open.week',
  );

  /// Views data of the previous month from Health Kit.
  static const Scope HEALTHKIT_HISTORYDATA_OPEN_MONTH = Scope._(
    'https://www.huawei.com/healthkit/historydata.open.month',
  );

  /// Views data of the previous year from Health Kit.
  static const Scope HEALTHKIT_HISTORYDATA_OPEN_YEAR = Scope._(
    'https://www.huawei.com/healthkit/historydata.open.year',
  );
}

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

/// Fields for common data types.
class Field {
  /// Field that contains integer values.
  static const int FORMAT_INT32 = 1;

  @Deprecated('This constant has been deprecated.')
  /// Field that contains float values.
  static const int FORMAT_FLOAT = 2;

  /// Field that contains Double values.
  static const int FORMAT_DOUBLE = 2;

  /// Field that contains string values.
  static const int FORMAT_STRING = 3;

  /// Field that contains mapped values.
  static const int FORMAT_MAP = 4;

  /// Field that contains long integer values.
  static const int FORMAT_LONG = 5;

  /// Meal types.
  static const int MEAL_UNKNOWN = 0;
  static const int MEAL_BREAKFAST = 1;
  static const int MEAL_LUNCH = 2;
  static const int MEAL_DINNER = 3;
  static const int MEAL_SNACK = 4;

  /// Types of objects for resistance during an exercise.
  static const int TYPE_OF_RESISTANCE_UNKNOWN = 0;
  static const int TYPE_OF_RESISTANCE_BARBELL = 1;
  static const int TYPE_OF_RESISTANCE_CABLE = 2;
  static const int TYPE_OF_RESISTANCE_DUMBBELL = 3;
  static const int TYPE_OF_RESISTANCE_KETTLEBELL = 4;
  static const int TYPE_OF_RESISTANCE_MACHINE = 5;
  static const int TYPE_OF_RESISTANCE_BODY = 6;

  /// Calories (kcal).
  static const String NUTRIENTS_FACTS_CALORIES = 'calories';

  /// Total fat (g).
  static const String NUTRIENTS_FACTS_TOTAL_FAT = 'fat.total';

  /// Saturated fat (g).
  static const String NUTRIENTS_FACTS_SATURATED_FAT = 'fat.saturated';

  /// Unsaturated fat (g).
  static const String NUTRIENTS_FACTS_UNSATURATED_FAT = 'fat.unsaturated';

  /// Polyunsaturated fat (g).
  static const String NUTRIENTS_FACTS_POLYUNSATURATED_FAT =
      'fat.polyunsaturated';

  /// Monounsaturated fat (g).
  static const String NUTRIENTS_FACTS_MONOUNSATURATED_FAT =
      'fat.monounsaturated';

  /// Trans fat (g).
  static const String NUTRIENTS_FACTS_TRANS_FAT = 'fat.trans';

  /// Cholesterol (mg).
  static const String NUTRIENTS_FACTS_CHOLESTEROL = 'cholesterol';

  /// Sodium (mg).
  static const String NUTRIENTS_FACTS_SODIUM = 'sodium';

  /// Potassium (mg).
  static const String NUTRIENTS_FACTS_POTASSIUM = 'potassium';

  /// Total carbohydrates (g).
  static const String NUTRIENTS_FACTS_TOTAL_CARBS = 'carbs.total';

  /// Dietary fiber (g).
  static const String NUTRIENTS_FACTS_DIETARY_FIBER = 'dietary_fiber';

  /// Sugar amount (g).
  static const String NUTRIENTS_FACTS_SUGAR = 'sugar';

  /// Protein amount (g).
  static const String NUTRIENTS_FACTS_PROTEIN = 'protein';

  /// Vitamin A amount in international unit (IU).
  static const String NUTRIENTS_FACTS_VITAMIN_A = 'vitamin_a';

  /// Vitamin C amount (mg).
  static const String NUTRIENTS_FACTS_VITAMIN_C = 'vitamin_c';

  /// Calcium amount (mg).
  static const String NUTRIENTS_FACTS_CALCIUM = 'calcium';

  /// Iron amount (mg).
  static const String NUTRIENTS_FACTS_IRON = 'iron';

  static const Field EXERCISE_TYPE = Field.newIntField(
    'exercise_type',
  );

  static const Field INTENSITY_MAP = Field.newMapField(
    'intensity_map',
  );

  static const Field VDOT = Field.newIntField(
    'vdot',
  );

  static const Field TRAINING_INDEX = Field.newDoubleField(
    'index',
  );

  static const Field FATIGUE_INDEX = Field.newDoubleField(
    'index',
  );

  static const Field PHYSICAL_FITNESS_INDEX = Field.newDoubleField(
    'index',
  );

  static const Field STATE_INDEX = Field.newDoubleField(
    'index',
  );

  static const Field FIELD_LAST = Field.newDoubleField(
    'last',
  );

  static const Field FIELD_JUMP_HEIGHT = Field.newDoubleField(
    'jump_height',
  );

  static const Field FIELD_PASSAGE_DURATION = Field.newIntField(
    'passage_duration',
  );

  static const Field FIELD_JUMP_TIMES = Field.newIntField(
    'jump_times',
  );

  static const Field FIELD_MIN_JUMP_HEIGHT = Field.newDoubleField(
    'min_jump_height',
  );

  static const Field FIELD_AVG_JUMP_HEIGHT = Field.newDoubleField(
    'avg_jump_height',
  );

  static const Field FIELD_MAX_JUMP_HEIGHT = Field.newDoubleField(
    'max_jump_height',
  );

  static const Field FIELD_MIN_PASSAGE_DURATION = Field.newIntField(
    'min_passage_duration',
  );

  static const Field FIELD_AVG_PASSAGE_DURATION = Field.newIntField(
    'avg_passage_duration',
  );

  static const Field FIELD_MAX_PASSAGE_DURATION = Field.newIntField(
    'max_passage_duration',
  );

  static const Field ALTITUDE = Field.newDoubleField(
    'altitude',
  );

  static const Field SKIP_SPEED = Field.newIntField(
    'skip_speed',
  );

  static const Field AVG = Field.newIntField(
    'avg',
  );

  static const Field MAX = Field.newIntField(
    'max',
  );

  static const Field MIN = Field.newIntField(
    'min',
  );

  static const Field GROUND_CONTACT_TIME = Field.newIntField(
    'ground_contact_time',
  );
  static const Field GROUND_IMPACT_ACCELERATION = Field.newIntField(
    'ground_impact_acceleration',
  );
  static const Field SWING_ANGLE = Field.newIntField(
    'swing_angle',
  );
  static const Field EVERSION_EXCURSION = Field.newIntField(
    'eversion_excursion',
  );
  static const Field HANG_TIME = Field.newIntField(
    'hang_time',
  );
  static const Field GROUND_HANG_TIME_RATE = Field.newDoubleField(
    'ground_hang_time_rate',
  );
  static const Field FORE_FOOT_STRIKE_PATTERN = Field.newIntField(
    'fore_foot_strike_pattern',
  );
  static const Field HIND_FOOT_STRIKE_PATTERN = Field.newIntField(
    'hind_foot_strike_pattern',
  );
  static const Field WHOLE_FOOT_STRIKE_PATTERN = Field.newIntField(
    'whole_foot_strike_pattern',
  );

  static const Field AVG_GROUND_CONTACT_TIME = Field.newIntField(
    'avg_ground_contact_time',
  );
  static const Field AVG_GROUND_IMPACT_ACCELERATION = Field.newIntField(
    'avg_ground_impact_acceleration',
  );
  static const Field AVG_SWING_ANGLE = Field.newIntField(
    'avg_swing_angle',
  );
  static const Field AVG_EVERSION_EXCURSION = Field.newIntField(
    'avg_eversion_excursion',
  );
  static const Field AVG_HANG_TIME = Field.newIntField(
    'avg_hang_time',
  );
  static const Field AVG_GROUND_HANG_TIME_RATE = Field.newDoubleField(
    'avg_ground_hang_time_rate',
  );

  static const Field ASCENT_RATE = Field.newDoubleField(
    'ascentRate',
  );

  static const Field DESCENT_RATE = Field.newDoubleField(
    'descentRate',
  );

  static const Field SKIP_NUM = Field.newIntField(
    'skip_num',
  );
  static const Field STUMBLING_ROPE = Field.newIntField(
    'stumbling_rope',
  );
  static const Field MAX_SKIPPING_TIMES = Field.newIntField(
    'max_skipping_times',
  );
  static const Field DOUBLE_SHAKE = Field.newIntField(
    'double_shake',
  );
  static const Field TRIPLE_SHAKE = Field.newIntField(
    'triple_shake',
  );

  static const Field OVERALL_SCORE = Field.newIntField(
    'overall_score',
  );
  static const Field BURST_SCORE = Field.newIntField(
    'burst_score',
  );
  static const Field JUMP_SCORE = Field.newIntField(
    'jump_score',
  );
  static const Field RUN_SCORE = Field.newIntField(
    'run_score',
  );
  static const Field BREAKTHROUGH_SCORE = Field.newIntField(
    'breakthrough_score',
  );
  static const Field SPORT_INTENSITY_SCORE = Field.newIntField(
    'sport_intensity_score',
  );

  static const Field DIVING_DURATION = Field.newDoubleField(
    'divingDuration',
  );
  static const Field FLYING_AFTER_DIVING_TIME = Field.newDoubleField(
    'flyingAfterDivingTime',
  );
  static const Field SURFACE_INTERVAL_TIME = Field.newDoubleField(
    'surfaceIntervalTime',
  );
  static const Field WATER_SURFACE_TEMPERATURE = Field.newDoubleField(
    'waterSurfaceTemperature',
  );
  static const Field UNDERWATER_TEMPERATURE = Field.newDoubleField(
    'underwaterTemperature',
  );
  static const Field DIVE_DEPTH = Field.newDoubleField(
    'diveDepth',
  );
  static const Field ENTERING_WATER_LATITUDE = Field.newDoubleField(
    'enteringWaterLatitude',
  );
  static const Field ENTERING_WATER_LONGITUDE = Field.newDoubleField(
    'enteringWaterLongitude',
  );

  static const Field FIELD_COORDINATE = Field.newIntField(
    'coordinate',
  );

  static const Field EXITING_WATER_LATITUDE = Field.newDoubleField(
    'exitingWaterLatitude',
  );
  static const Field EXITING_WATER_LONGITUDE = Field.newDoubleField(
    'exitingWaterLongitude',
  );

  static const Field FIELD_DURATION = Field.newIntField(
    'duration',
  );

  static const Field FIELD_ASCENT_TOTAL = Field.newDoubleField(
    'ascent_total',
  );

  static const Field FIELD_DESCENT_TOTAL = Field.newDoubleField(
    'descent_total',
  );

  /// Precision.
  static const Field FIELD_PRECISION = Field.newDoubleField(
    'precision',
  );

  /// Altitude.
  static const Field FIELD_ALTITUDE = Field.newDoubleField(
    'altitude',
  );

  /// Activity type.
  static const Field FIELD_TYPE_OF_ACTIVITY = Field.newIntField(
    'type_of_activity',
  );

  /// Activity type confidence.
  static const Field FIELD_POSSIBILITY_OF_ACTIVITY = Field.newDoubleField(
    'possibility_of_activity',
  );

  /// Heart rate.
  static const Field FIELD_BPM = Field.newDoubleField(
    'bpm',
  );

  /// Confidence, with a value ranging from `0.0` to `100.0`.
  static const Field FIELD_POSSIBILITY = Field.newDoubleField(
    'possibility',
  );

  /// Duration.
  static const Field FIELD_SPAN = Field.newIntField(
    'span',
  );

  /// Distance (m).
  static const Field FIELD_DISTANCE = Field.newDoubleField(
    'distance',
  );

  /// Distance covered since the last reading.
  static const Field FIELD_DISTANCE_DELTA = Field.newDoubleField(
    'distance_delta',
  );

  /// Height (m).
  static const Field FIELD_HEIGHT = Field.newDoubleField(
    'height',
  );

  /// Steps taken since the last reading.
  static const Field FIELD_STEPS_DELTA = Field.newIntField(
    'steps_delta',
  );

  /// Step count.
  static const Field FIELD_STEPS = Field.newIntField(
    'steps',
  );

  /// Step length (m)
  static const Field FIELD_STEP_LENGTH = Field.newDoubleField(
    'step_length',
  );

  /// Latitude (degree).
  static const Field FIELD_LATITUDE = Field.newDoubleField(
    'latitude',
  );

  /// Longitude (degree).
  static const Field FIELD_LONGITUDE = Field.newDoubleField(
    'longitude',
  );

  /// Weight (kg).
  static const Field FIELD_BODY_WEIGHT = Field.newDoubleField(
    'body_weight',
  );

  /// Body mass index, which is calculated via dividing the weight kilograms by
  /// the square meter of height (kg/m2).
  static const Field FIELD_BMI = Field.newDoubleField(
    'bmi',
  );

  /// Body fat (kg), accurate to the first decimal place.
  static const Field FIELD_BODY_FAT = Field.newDoubleField(
    'body_fat',
  );

  /// Body fat rate (percentage), with a value ranging from 0 to 100.
  static const Field FIELD_BODY_FAT_RATE = Field.newDoubleField(
    'body_fat_rate',
  );

  /// Muscle mass (kg).
  static const Field FIELD_MUSCLE_MASS = Field.newDoubleField(
    'muscle_mass',
  );

  /// Basic metabolism (kcal/day).
  static const Field FIELD_BASAL_METABOLISM = Field.newDoubleField(
    'basal_metabolism',
  );

  /// Water weight (kg).
  static const Field FIELD_MOISTURE = Field.newDoubleField(
    'moisture',
  );

  /// Water rate (percentage).
  static const Field FIELD_MOISTURE_RATE = Field.newDoubleField(
    'moisture_rate',
  );

  /// Visceral fat (level).
  static const Field FIELD_VISCERAL_FAT_LEVEL = Field.newDoubleField(
    'visceral_fat_level',
  );

  /// Bone salt amount (kg).
  static const Field FIELD_BONE_SALT = Field.newDoubleField(
    'bone_salt',
  );

  /// Protein ratio (percentage).
  static const Field FIELD_PROTEIN_RATE = Field.newDoubleField(
    'protein_rate',
  );

  /// Body age.
  static const Field FIELD_BODY_AGE = Field.newIntField(
    'body_age',
  );

  /// Body score (score).
  static const Field FIELD_BODY_SCORE = Field.newDoubleField(
    'body_score',
  );

  /// Skeletal muscle (kg).
  static const Field FIELD_SKELETAL_MUSCLE_MASS = Field.newDoubleField(
    'skeletal_musclel_mass',
  );

  /// Impedance (ohm).
  static const Field FIELD_IMPEDANCE = Field.newDoubleField(
    'impedance',
  );

  /// Circumference of a body part (such as the hip, chest, and waist) in centimeters.
  static const Field FIELD_CIRCUMFERENCE = Field.newDoubleField(
    'circumference',
  );

  /// Speed (m/s).
  static const Field FIELD_SPEED = Field.newDoubleField(
    'speed',
  );

  /// Rotations per minute or rate per minute.
  static const Field FIELD_RPM = Field.newDoubleField(
    'rpm',
  );

  /// Step frequency.
  static const Field FIELD_STEP_RATE = Field.newDoubleField(
    'step_rate',
  );

  /// Rotations.
  static const Field FIELD_ROTATION = Field.newIntField(
    'rotation',
  );

  /// Calories (kcal).
  static const Field FIELD_CALORIES = Field.newDoubleField(
    'calories',
  );

  /// Calories (kcal).
  static const Field FIELD_CALORIES_TOTAL = Field.newDoubleField(
    'calories_total',
  );

  /// Power (Watt).
  static const Field FIELD_POWER = Field.newDoubleField(
    'power',
  );

  /// Volume (liter).
  static const Field FIELD_HYDRATE = Field.newDoubleField(
    'hydrate',
  );

  /// Meal type.
  static const Field FIELD_MEAL = Field.newIntField(
    'meal',
  );

  /// Food type.
  static const Field FIELD_FOOD = Field.newStringField(
    'food',
  );

  /// Nutrients.
  static const Field FIELD_NUTRIENTS = Field.newMapField(
    'nutrients',
  );

  /// Nutrition facts.
  static const Field FIELD_NUTRIENTS_FACTS = Field.newMapField(
    'nutrients_facts',
  );

  /// Fragments.
  static const Field FIELD_FRAGMENTS = Field.newIntField(
    'fragments',
  );

  /// Average value.
  static const Field FIELD_AVG = Field.newDoubleField(
    'avg',
  );

  /// Maximum value.
  static const Field FIELD_MAX = Field.newDoubleField(
    'max',
  );

  /// Minimum value.
  static const Field FIELD_MIN = Field.newDoubleField(
    'min',
  );

  /// Low latitude (degree).
  static const Field FIELD_MIN_LATITUDE = Field.newDoubleField(
    'min_latitude',
  );

  /// Low longitude (degree).
  static const Field FIELD_MIN_LONGITUDE = Field.newDoubleField(
    'min_longitude',
  );

  /// High latitude (degree).
  static const Field FIELD_MAX_LATITUDE = Field.newDoubleField(
    'max_latitude',
  );

  /// High longitude (degree).
  static const Field FIELD_MAX_LONGITUDE = Field.newDoubleField(
    'max_longitude',
  );

  /// Number of occurrences within a period of time.
  static const Field FIELD_APPEARANCE = Field.newIntField(
    'appearance',
  );

  /// Workout intensity.
  static const Field FIELD_INTENSITY = Field.newDoubleField(
    'intensity',
  );

  /// Time when the user falls asleep, expressed as a Unix timestamp.
  static const Field FALL_ASLEEP_TIME = Field.newLongField(
    'fall_asleep_time',
  );

  /// Time when the user wakes up, expressed as a Unix timestamp.
  static const Field WAKE_UP_TIME = Field.newLongField(
    'wakeup_time',
  );

  /// Sleep score.
  static const Field SLEEP_SCORE = Field.newIntField(
    'sleep_score',
  );

  /// Sleep latency.
  static const Field SLEEP_LATENCY = Field.newIntField(
    'sleep_latency',
  );

  /// Time when the user goes to bed.
  static const Field GO_BED_TIME = Field.newLongField(
    'go_bedTime',
  );

  static const Field GO_BED_TIME_NEW = Field.newLongField(
    'go_bed_time',
  );

  /// Sleep efficiency (percentage).
  static const Field SLEEP_EFFICIENCY = Field.newIntField(
    'sleep_efficiency',
  );

  /// Light sleep duration.
  static const Field LIGHT_SLEEP_TIME = Field.newIntField(
    'light_sleep_time',
  );

  /// Deep sleep duration.
  static const Field DEEP_SLEEP_TIME = Field.newIntField(
    'deep_sleep_time',
  );

  /// REM sleep duration.
  static const Field DREAM_TIME = Field.newIntField(
    'dream_time',
  );

  /// Duration when staying awake.
  static const Field AWAKE_TIME = Field.newIntField(
    'awake_time',
  );

  /// Total sleep duration.
  static const Field ALL_SLEEP_TIME = Field.newIntField(
    'all_sleep_time',
  );

  /// Number of times the user is awake.
  static const Field WAKE_UP_CNT = Field.newIntField(
    'wakeup_count',
  );

  /// Number of deep sleep segments.
  static const Field DEEP_SLEEP_PART = Field.newIntField(
    'deep_sleep_part',
  );

  /// Sleep state. Value range: `[1,4]`
  static const Field SLEEP_STATE = Field.newIntField(
    'sleep_state',
  );

  /// Stress score. Value range: `[1, 99]`.
  static const Field SCORE = Field.newIntField(
    'score',
  );

  /// Stress grade. Value range: `[1, 4]`.
  static const Field GRADE = Field.newIntField(
    'grade',
  );

  /// Stress measurement flag: active or passive. Value range: `[1, 2]`.
  static const Field MEASURE_TYPE = Field.newIntField(
    'measure_type',
  );

  /// Average stress score. Value range: `[1, 99]`.
  static const Field STRESS_AVG = Field.newIntField(
    'avg',
  );

  /// Highest stress score. Value range: `[1, 99]`.
  static const Field STRESS_MAX = Field.newIntField(
    'max',
  );

  /// Lowest stress score. Value range: `[1, 99]`.
  static const Field STRESS_MIN = Field.newIntField(
    'min',
  );

  /// Latest stress score. Value range: `[1, 99]`.
  static const Field STRESS_LAST = Field.newIntField(
    'last',
  );

  /// Number of stress measurement times. Value range: `[1, 2147483647]`.
  static const Field MEASURE_COUNT = Field.newIntField(
    'measure_count',
  );

  /// Maximum resistance level supported by the device.
  static const Field MAX_RES = Field.newIntField(
    'maxRes',
  );

  /// Minimum resistance level supported by the device.
  static const Field MIN_RES = Field.newIntField(
    'minRes',
  );

  /// Resistance level.
  static const Field RESISTANCE_LEVEL = Field.newIntField(
    'resistanceLevel',
  );

  /// Lower limit of resistance level 1.
  static const Field RESISTANCE_LEVEL_ONE_LOWER_LIMIT = Field.newIntField(
    'resistanceLevelOneLowerLimit',
  );

  /// Lower limit of resistance level 2.
  static const Field RESISTANCE_LEVEL_TWO_LOWER_LIMIT = Field.newIntField(
    'resistanceLevelTwoLowerLimit',
  );

  /// Lower limit of resistance level 3.
  static const Field RESISTANCE_LEVEL_THREE_LOWER_LIMIT = Field.newIntField(
    'resistanceLevelThreeLowerLimit',
  );

  /// Lower limit of resistance level 3.
  static const Field RESISTANCE_LEVEL_FOUR_LOWER_LIMIT = Field.newIntField(
    'resistanceLevelFourLowerLimit',
  );

  /// Lower limit of resistance level 5.
  static const Field RESISTANCE_LEVEL_FIVE_LOWER_LIMIT = Field.newIntField(
    'resistanceLevelFiveLowerLimit',
  );

  /// Upper limit of resistance level 5.
  static const Field RESISTANCE_LEVEL_FIVE_UPPER_LIMIT = Field.newIntField(
    'resistanceLevelFiveUpperLimit',
  );

  /// Activity duration at resistance level 1.
  static const Field RESISTANCE_LEVEL_ONE_TIME = Field.newIntField(
    'resistanceLevelOneTime',
  );

  /// Activity duration at resistance level 2.
  static const Field RESISTANCE_LEVEL_TWO_TIME = Field.newIntField(
    'resistanceLevelTwoTime',
  );

  /// Activity duration at resistance level 3.
  static const Field RESISTANCE_LEVEL_THREE_TIME = Field.newIntField(
    'resistanceLevelThreeTime',
  );

  /// Activity duration at resistance level 4.
  static const Field RESISTANCE_LEVEL_FOUR_TIME = Field.newIntField(
    'resistanceLevelFourTime',
  );

  /// Activity duration at resistance level 5.
  static const Field RESISTANCE_LEVEL_FIVE_TIME = Field.newIntField(
    'resistanceLevelFiveTime',
  );

  /// Rowing stroke rate.
  static const Field SPM = Field.newDoubleField(
    'spm',
  );

  /// SWOLF.
  static const Field SWOLF = Field.newDoubleField(
    'swolf',
  );

  /// Sleep type.
  static const Field SLEEP_TYPE = Field.newIntField(
    'sleep_type',
  );

  /// Time when the user prepares for sleep.
  static const Field PREPARE_SLEEP_TIME = Field.newLongField(
    'prepare_sleep_time',
  );

  /// Time when the user is out of bed for the last time.
  static const Field OFF_BED_TIME = Field.newLongField(
    'off_bed_time',
  );

  /// Maximum oxygen uptake.
  static const Field VO2MAX = Field.newIntField(
    'vo2max',
  );

  /// Latest value.
  static const Field LAST = Field.newIntField(
    'last',
  );

  /// Breathing duration.
  static const Field BREATH_TIME = Field.newIntField(
    'breathTime',
  );

  /// Breath holding time.
  static const Field BREATH_HOLDING_TIME = Field.newIntField(
    'breathHoldingTime',
  );

  /// Number of training sessions.
  static const Field BREATH_HOLDING_TRAIN_RHYTHM = Field.newIntField(
    'breathHoldingTrainRhythm',
  );

  /// Diaphragm contraction.
  static const Field DIAPHRAGM_TIME = Field.newIntField(
    'diaphragmTime',
  );

  /// Active peak.
  static const Field IMPACT_PEAK = Field.newDoubleField(
    'impact_peak',
  );

  /// Vertical amplitude.
  static const Field VERTICAL_OSCILLATION = Field.newDoubleField(
    'vertical_oscillation',
  );

  /// Vertical stride ratio.
  static const Field VERTICAL_RATIO = Field.newDoubleField(
    'vertical_ratio',
  );

  /// Left and right ground contact balance.
  static const Field GC_TIME_BALANCE = Field.newDoubleField(
    'gc_time_balance',
  );

  /// Average active peak.
  static const Field AVG_IMPACT_PEAK = Field.newDoubleField(
    'avg_impact_peak',
  );

  /// Average left and right ground contact balance.
  static const Field AVG_GC_TIME_BALANCE = Field.newDoubleField(
    'avg_gc_time_balance',
  );

  /// Average vertical oscillation.
  static const Field AVG_VERTICAL_OSCILLATION = Field.newDoubleField(
    'avg_vertical_oscillation',
  );

  /// Average vertical stride ratio.
  static const Field AVG_VERTICAL_RATIO = Field.newDoubleField(
    'avg_vertical_ratio',
  );

  /// Average impact loading rate.
  static const Field AVG_VERTICAL_IMPACT_RATE = Field.newDoubleField(
    'avg_vertical_impact_rate',
  );

  /// Underwater time.
  static const Field DIVING_TIME = Field.newIntField(
    'divingTime',
  );

  /// Number of dives.
  static const Field DIVING_COUNT = Field.newIntField(
    'divingCount',
  );

  /// Maximum depth of diving.
  static const Field MAX_DEPTH = Field.newDoubleField(
    'maxDepth',
  );

  /// Average depth of diving.
  static const Field AVG_DEPTH = Field.newDoubleField(
    'avgDepth',
  );

  /// Maximum duration of a single dive.
  static const Field MAX_UNDERWATER_TIME = Field.newIntField(
    'maxUnderwaterTime',
  );

  /// No-fly time.
  static const Field NO_FLY_TIME = Field.newIntField(
    'noFlyTime',
  );

  /// Water type.
  static const Field WATER_TYPE = Field.newIntField(
    'waterType',
  );

  /// Surface interval.
  static const Field SURFACE_TIME = Field.newIntField(
    'surfaceTime',
  );

  /// Number of trips.
  static const Field TRIP_TIMES = Field.newIntField(
    'trip_times',
  );

  /// Maximum slope (in percentages).
  static const Field MAX_SLOPE_PERCENT = Field.newDoubleField(
    'max_slope_percent',
  );

  /// Maximum slope angle.
  static const Field MAX_SLOPE_DEGREE = Field.newDoubleField(
    'max_slope_degree',
  );

  /// Ski duration.
  static const Field SKIING_TOTAL_TIME = Field.newLongField(
    'total_time',
  );

  /// Ski distance.
  static const Field SKIING_TOTAL_DISTANCE = Field.newIntField(
    'total_distance',
  );

  /// Average body fat percentage.
  static const Field FIELD_AVG_BODY_FAT_RATE = Field.newDoubleField(
    'avg_body_fat_rate',
  );

  /// Maximum body fat percentage
  static const Field FIELD_MAX_BODY_FAT_RATE = Field.newDoubleField(
    'max_body_fat_rate',
  );

  /// Minimum body fat percentage.
  static const Field FIELD_MIN_BODY_FAT_RATE = Field.newDoubleField(
    'min_body_fat_rate',
  );

  /// Average skeletal muscle mass.
  static const Field FIELD_AVG_SKELETAL_MUSCLEL_MASS = Field.newDoubleField(
    'avg_skeletal_musclel_mass',
  );

  /// Maximum skeletal muscle mass.
  static const Field FIELD_MAX_SKELETAL_MUSCLEL_MASS = Field.newDoubleField(
    'max_skeletal_musclel_mass',
  );

  /// Minimum skeletal muscle mass.
  static const Field FIELD_MIN_SKELETAL_MUSCLEL_MASS = Field.newDoubleField(
    'min_skeletal_musclel_mass',
  );

  /// Stroke count.
  static const Field PULL_TIMES = Field.newIntField(
    'pull_times',
  );

  /// Main stroke.
  static const Field SWIMMING_STROKE = Field.newIntField(
    'swimming_stroke',
  );

  /// Swimming pool length.
  static const Field POOL_LENGTH = Field.newIntField(
    'pool_length',
  );

  /// Total swings.
  static const Field GOLF_SWING_COUNT = Field.newIntField(
    'golf_swing_count',
  );

  /// Average swing speed.
  static const Field GOLF_SWING_SPEED = Field.newIntField(
    'golf_swing_speed',
  );

  /// Maximum swing speed.
  static const Field GOLF_MAX_SWING_SPEED = Field.newIntField(
    'golf_max_swing_speed',
  );

  /// Average swing tempo (average backswing time/average downswing time).
  static const Field GOLF_SWING_TEMPO = Field.newDoubleField(
    'golf_swing_tempo',
  );

  /// Average downswing time.
  static const Field GOLF_DOWN_SWING_TIME = Field.newIntField(
    'golf_down_swing_time',
  );

  /// Average backswing time.
  static const Field GOLF_BACK_SWING_TIME = Field.newIntField(
    'golf_back_swing_time',
  );

  static const Field SLEEP_RESPIRATORY_TYPE = Field.newIntField(
    'type',
  );

  static const Field SLEEP_RESPIRATORY_VALUE = Field.newDoubleField(
    'value',
  );

  static const Field EVENT_NAME = Field.newIntField(
    'eventName',
  );

   static const Field TEMPERATURE = Field.newDoubleField(
    'temperature',
  );

   static const Field DEPTH = Field.newDoubleField(
    'depth',
  );

  /// Attribute type.
  final int format;

  /// Field Name.
  final String name;

  /// Indicates whether it is optional.
  final bool isOptional;

  const Field(
    this.name,
    this.format, {
    this.isOptional = false,
  });

  @Deprecated('This method has been deprecated.')
  /// Creates an attribute that contains float values.
  const Field.newFloatField(this.name)
      : format = FORMAT_FLOAT,
        isOptional = false;

  /// Creates an attribute that contains Double values.
  const Field.newDoubleField(this.name)
      : format = FORMAT_DOUBLE,
        isOptional = false;

  /// Creates an attribute that contains integer values.
  const Field.newIntField(this.name)
      : format = FORMAT_INT32,
        isOptional = false;

  /// Creates an attribute that contains mapped values.
  const Field.newMapField(this.name)
      : format = FORMAT_MAP,
        isOptional = false;

  /// Creates an attribute that contains string values.
  const Field.newStringField(this.name)
      : format = FORMAT_STRING,
        isOptional = false;

  /// Creates an attribute that contains long values.
  ///
  /// (Note: this type matches with `long` on Java which can contain 64 bits.
  /// Dart's integer values are already 64 bits instead of Java's 32 bits.)
  const Field.newLongField(this.name)
      : format = FORMAT_LONG,
        isOptional = false;

  factory Field.fromMap(Map<dynamic, dynamic> map) {
    return Field(
      map['name'],
      map['format'],
      isOptional: map['isOptional'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'format': format,
      'isOptional': isOptional,
    }..removeWhere((String k, dynamic v) => v == null);
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  bool operator ==(Object other) {
    return other is Field &&
        other.name == name &&
        other.format == format &&
        other.isOptional == isOptional;
  }

  @override
  int get hashCode {
    return Object.hash(
      name,
      format,
      isOptional,
    );
  }
}

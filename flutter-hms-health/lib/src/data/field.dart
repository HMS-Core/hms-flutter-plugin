/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

  /// Field that contains float values.
  static const int FORMAT_FLOAT = 2;

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

  static const Field TRAINING_INDEX = Field.newFloatField(
    'index',
  );

  static const Field FATIGUE_INDEX = Field.newFloatField(
    'index',
  );

  static const Field PHYSICAL_FITNESS_INDEX = Field.newFloatField(
    'index',
  );

  static const Field STATE_INDEX = Field.newFloatField(
    'index',
  );

  static const Field FIELD_LAST = Field.newFloatField(
    'last',
  );

  static const Field FIELD_JUMP_HEIGHT = Field.newFloatField(
    'jump_height',
  );

  static const Field FIELD_PASSAGE_DURATION = Field.newIntField(
    'passage_duration',
  );

  static const Field FIELD_JUMP_TIMES = Field.newIntField(
    'jump_times',
  );

  static const Field FIELD_MIN_JUMP_HEIGHT = Field.newFloatField(
    'min_jump_height',
  );

  static const Field FIELD_AVG_JUMP_HEIGHT = Field.newFloatField(
    'avg_jump_height',
  );

  static const Field FIELD_MAX_JUMP_HEIGHT = Field.newFloatField(
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

  static const Field ALTITUDE = Field.newFloatField(
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
  static const Field GROUND_HANG_TIME_RATE = Field.newFloatField(
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
  static const Field AVG_GROUND_HANG_TIME_RATE = Field.newFloatField(
    'avg_ground_hang_time_rate',
  );

  static const Field ASCENT_RATE = Field.newFloatField(
    'ascentRate',
  );

  static const Field DESCENT_RATE = Field.newFloatField(
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

  static const Field DIVING_DURATION = Field.newFloatField(
    'divingDuration',
  );
  static const Field FLYING_AFTER_DIVING_TIME = Field.newFloatField(
    'flyingAfterDivingTime',
  );
  static const Field SURFACE_INTERVAL_TIME = Field.newFloatField(
    'surfaceIntervalTime',
  );
  static const Field WATER_SURFACE_TEMPERATURE = Field.newFloatField(
    'waterSurfaceTemperature',
  );
  static const Field UNDERWATER_TEMPERATURE = Field.newFloatField(
    'underwaterTemperature',
  );
  static const Field DIVE_DEPTH = Field.newFloatField(
    'diveDepth',
  );
  static const Field ENTERING_WATER_LATITUDE = Field.newFloatField(
    'enteringWaterLatitude',
  );
  static const Field ENTERING_WATER_LONGITUDE = Field.newFloatField(
    'enteringWaterLongitude',
  );

  static const Field FIELD_COORDINATE = Field.newIntField(
    'coordinate',
  );

  static const Field EXITING_WATER_LATITUDE = Field.newFloatField(
    'exitingWaterLatitude',
  );
  static const Field EXITING_WATER_LONGITUDE = Field.newFloatField(
    'exitingWaterLongitude',
  );

  static const Field FIELD_DURATION = Field.newIntField(
    'duration',
  );

  static const Field FIELD_ASCENT_TOTAL = Field.newFloatField(
    'ascent_total',
  );

  static const Field FIELD_DESCENT_TOTAL = Field.newFloatField(
    'descent_total',
  );

  /// Precision.
  static const Field FIELD_PRECISION = Field.newFloatField(
    'precision',
  );

  /// Altitude.
  static const Field FIELD_ALTITUDE = Field.newFloatField(
    'altitude',
  );

  /// Activity type.
  static const Field FIELD_TYPE_OF_ACTIVITY = Field.newIntField(
    'type_of_activity',
  );

  /// Activity type confidence.
  static const Field FIELD_POSSIBILITY_OF_ACTIVITY = Field.newFloatField(
    'possibility_of_activity',
  );

  /// Heart rate.
  static const Field FIELD_BPM = Field.newFloatField(
    'bpm',
  );

  /// Confidence, with a value ranging from `0.0` to `100.0`.
  static const Field FIELD_POSSIBILITY = Field.newFloatField(
    'possibility',
  );

  /// Duration.
  static const Field FIELD_SPAN = Field.newIntField(
    'span',
  );

  /// Distance (m).
  static const Field FIELD_DISTANCE = Field.newFloatField(
    'distance',
  );

  /// Distance covered since the last reading.
  static const Field FIELD_DISTANCE_DELTA = Field.newFloatField(
    'distance_delta',
  );

  /// Height (m).
  static const Field FIELD_HEIGHT = Field.newFloatField(
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
  static const Field FIELD_STEP_LENGTH = Field.newFloatField(
    'step_length',
  );

  /// Latitude (degree).
  static const Field FIELD_LATITUDE = Field.newFloatField(
    'latitude',
  );

  /// Longitude (degree).
  static const Field FIELD_LONGITUDE = Field.newFloatField(
    'longitude',
  );

  /// Weight (kg).
  static const Field FIELD_BODY_WEIGHT = Field.newFloatField(
    'body_weight',
  );

  /// Body mass index, which is calculated via dividing the weight kilograms by
  /// the square meter of height (kg/m2).
  static const Field FIELD_BMI = Field.newFloatField(
    'bmi',
  );

  /// Body fat (kg), accurate to the first decimal place.
  static const Field FIELD_BODY_FAT = Field.newFloatField(
    'body_fat',
  );

  /// Body fat rate (percentage), with a value ranging from 0 to 100.
  static const Field FIELD_BODY_FAT_RATE = Field.newFloatField(
    'body_fat_rate',
  );

  /// Muscle mass (kg).
  static const Field FIELD_MUSCLE_MASS = Field.newFloatField(
    'muscle_mass',
  );

  /// Basic metabolism (kcal/day).
  static const Field FIELD_BASAL_METABOLISM = Field.newFloatField(
    'basal_metabolism',
  );

  /// Water weight (kg).
  static const Field FIELD_MOISTURE = Field.newFloatField(
    'moisture',
  );

  /// Water rate (percentage).
  static const Field FIELD_MOISTURE_RATE = Field.newFloatField(
    'moisture_rate',
  );

  /// Visceral fat (level).
  static const Field FIELD_VISCERAL_FAT_LEVEL = Field.newFloatField(
    'visceral_fat_level',
  );

  /// Bone salt amount (kg).
  static const Field FIELD_BONE_SALT = Field.newFloatField(
    'bone_salt',
  );

  /// Protein ratio (percentage).
  static const Field FIELD_PROTEIN_RATE = Field.newFloatField(
    'protein_rate',
  );

  /// Body age.
  static const Field FIELD_BODY_AGE = Field.newIntField(
    'body_age',
  );

  /// Body score (score).
  static const Field FIELD_BODY_SCORE = Field.newFloatField(
    'body_score',
  );

  /// Skeletal muscle (kg).
  static const Field FIELD_SKELETAL_MUSCLE_MASS = Field.newFloatField(
    'skeletal_musclel_mass',
  );

  /// Impedance (ohm).
  static const Field FIELD_IMPEDANCE = Field.newFloatField(
    'impedance',
  );

  /// Circumference of a body part (such as the hip, chest, and waist) in centimeters.
  static const Field FIELD_CIRCUMFERENCE = Field.newFloatField(
    'circumference',
  );

  /// Speed (m/s).
  static const Field FIELD_SPEED = Field.newFloatField(
    'speed',
  );

  /// Rotations per minute or rate per minute.
  static const Field FIELD_RPM = Field.newFloatField(
    'rpm',
  );

  /// Step frequency.
  static const Field FIELD_STEP_RATE = Field.newFloatField(
    'step_rate',
  );

  /// Rotations.
  static const Field FIELD_ROTATION = Field.newIntField(
    'rotation',
  );

  /// Calories (kcal).
  static const Field FIELD_CALORIES = Field.newFloatField(
    'calories',
  );

  /// Calories (kcal).
  static const Field FIELD_CALORIES_TOTAL = Field.newFloatField(
    'calories_total',
  );

  /// Power (Watt).
  static const Field FIELD_POWER = Field.newFloatField(
    'power',
  );

  /// Volume (liter).
  static const Field FIELD_HYDRATE = Field.newFloatField(
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
  static const Field FIELD_AVG = Field.newFloatField(
    'avg',
  );

  /// Maximum value.
  static const Field FIELD_MAX = Field.newFloatField(
    'max',
  );

  /// Minimum value.
  static const Field FIELD_MIN = Field.newFloatField(
    'min',
  );

  /// Low latitude (degree).
  static const Field FIELD_MIN_LATITUDE = Field.newFloatField(
    'min_latitude',
  );

  /// Low longitude (degree).
  static const Field FIELD_MIN_LONGITUDE = Field.newFloatField(
    'min_longitude',
  );

  /// High latitude (degree).
  static const Field FIELD_MAX_LATITUDE = Field.newFloatField(
    'max_latitude',
  );

  /// High longitude (degree).
  static const Field FIELD_MAX_LONGITUDE = Field.newFloatField(
    'max_longitude',
  );

  /// Number of occurrences within a period of time.
  static const Field FIELD_APPEARANCE = Field.newIntField(
    'appearance',
  );

  /// Workout intensity.
  static const Field FIELD_INTENSITY = Field.newFloatField(
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

  /// Creates an attribute that contains float values.
  const Field.newFloatField(this.name)
      : format = FORMAT_FLOAT,
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
    return hashValues(
      name,
      format,
      isOptional,
    );
  }
}

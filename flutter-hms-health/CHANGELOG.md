## 6.8.0+300

- Updated the value ranges of some fields of the Weight, Body Temperature, Blood Pressure, and Blood Glucose data types.
- Added the Free Diving activity record data type, added data type constants related to Free Diving to DataType, and added constants related to Free Diving to Field.
- Added the dataTypeName to DataCollector to allow for setting data types to character strings.
- Added the dataType to SamplePoint to create SamplePoint for statistical data types and feature data types.
- Added fields total_time and total_distance to the sport feature statistical data of Skiing, and added constants SKIING_TOTAL_TIME and SKIING_TOTAL_DISTANCE to Field.
- Deprecated the isDeleteSubData(bool deleteSubData) method in the ActivityRecordDeleteOptions class, which is no longer recommended to use.
- Added the maximum oxygen uptake data type; added constants related to the maximum oxygen uptake to DataType; added the attribute name VO2MAX to Field.
- Added Apnea Training in Diving and Apnea Testing in Diving activity types to HiHealthActivities; added data type constants related to Apnea Training in Diving and Apnea Testing in Diving to DataType; added constants related to Apnea Training in Diving and Apnea Testing in Diving to Field.
- Added open fields prepare_sleep_time and off_bed_time to Sleep Records; added two constants to Field: PREPARE_SLEEP_TIME indicating the time when one prepares for sleep, and OFF_BED_TIME indicating the time when one gets out of the bed for the last time.
- Expanded fields of the Running Form sampling data, and added constants related to Running Form to Field.
- Changed activityTypeId from optional to mandatory for creating activity records.
- Added the Menstrual Cycle data type; added constants related to menstrual cycle to HealthFields.
- Added Menstrual Volume, Period Pain Level, and Physical Symptom data types.
- Added beginActivityRecord and continueActivityRecord to ActivityRecordsController for creating activity records that can run in the background.
- Added Stroke Rate (Rowing), Power, Stroke Rate (Swimming), and SWOLF data types, as well as constants related to these data types to DataType and Field.
- Added the following activity record data types: swimming, climbing, skiing, elliptical machine, strength training, badminton, calisthenics, HIIT, yoga, table tennis, physical training, core training, functional training, tennis, Tai chi, hula hoop, boxing, pilates, stepper, and golf.
- Added cancelAuthorization(bool deleteData) to ConsentsController, allowing users to delete their data when they cancel all scopes granted to your app.
- Deprecated MIME-related constants and APIs.
- Added the sleep_type field to Sleep Records.
- Extended statistical data type fields for Heart Rate, Weight, SpO2, and Blood Pressure.
- Deprecated revoke(String appId) in ConsentsController.
- Deprecated revokeWithScopes(String appId, List<Scope> scopes) in ConsentsController. You are advised to use cancelAuthorizationWithScopes(String appId, List<Scope> scopes) instead.
- Added the Resistance data type and added constants related to resistance to DataType and Field.
- Added two fields to HealthFields: FIELD_MEASUREMENT_ANOMALY_FLAG indicating measurement exception events and FIELD_BEFORE_MEASURE_ACTIVITY indicating activities before measurement.
- Added two fields to the blood pressure data type: one indicating measurement exception events and the other indicating activities before measurement; supported querying the blood pressure statistics of the current day and of every day.

## 6.3.0+302

- If HMS Core (APK) 4.0.2.300 or later is not installed on the mobile phone that uses the Health Kit, an error will be thrown when an API is called.

## 6.3.0+301

> **This release has BREAKING CHANGES.**

- Migrated to **null-safety**.
- Since the file structure of the package has changed, just use the following import.

  ```dart
  import 'package:huawei_health/huawei_health.dart';
  ```

- Added AppInfo API.
- Added readLatestData API to the DataController class.
- Added HealthRecord API.
- Added requestAuthorizationIntent API to SettingController for integrating Huawei ID.
- Added parseHealthKitAuthResultFromIntent API to parse the auth result of HealthKitAuthResult.
- Added jumping, heart rate, ECG and ECG details data types.
- Added jumping, heart rate, body temperature statistical data types.
- Added skin temperature, altitude, rope jumping speed data types.
- Added resting body temperature, altitude, skin temperature, rope jumping speed statistical data types.
- Added health record data type.
- Added activity feature data type.
- Added HealthRecordController with following APIs:
  - addHealthRecord
  - deleteHealthRecord
  - getHealthRecord
  - updateHealthRecord
- Added HealthRecordInsertOptions with following API:
  - getInsertHealthRecord
- Added HealthRecordReadOptions with following APIs:
  - getDataCollector
  - getDataType
  - getEndTime
  - getRemoveApplicationsList
  - getStartTime
  - getSubDataTypeList
  - isAllAppsSelected
- Added HealthRecordUpdateOptions with following APIs:
  - getUpdateHealthRecord
  - getUpdateHealthRecordId
- Added running form data types (Steps).
- Added sleep records data types.
- Added 4 result codes to HiHealthStatusCodes (DataType, Field, HealthDataTypes)
- Added QUERY_TIME_EXCEED_LIMIT error code.
- Added SamplePoint.addMetadata for Android (can only be tested in China - ask for support)
- Added deleteActivityRecord API to ActivityRecordsController.
- Added ActivityRecordDeleteOptions class.
- Added deleteHealthRecord API to HealthRecordController.
- Added HealthRecordDeleteOptions class.
- Added getDeviceInfo API to ActivityRecord.
- Added setDeviceInfo API to ActivityRecord.Builder.
- Added devices to the list of supported devices in DeviceInfo class.
- Added duration field to step count statistics data type.
- Added ascent_total and decent_total altitude statics data type.
- Added FIELD_DURATION, FIELD_ASCENT_TOTAL and FIELD_DESCENT_TOTAL fields to Field.
- Added FIELD_SPHYGMUS to HealthFields.
- Added SCOPE_HEALTHKIT_HEARTHEALTH_READ and SCOPE_HEALTHKIT_HEARTHEALTH_WRITE to HuaweiHiHealth.
- Added HEALTHKIT_HEARTHEALTH_READ and HEALTHKIT_HEARTHEALTH_WRITE to Scopes.
- Deprecated BleController API and it should not be used.
- Deprecated BleDeviceInfo API.
- Deprecated SportDataTypes API.
- Deprecated SportFields API.
- Deprecated ActivityRecordResult API.
- Deprecated ActivityRecordStopResult API.
- Deprecated BleDeviceInfosResult API.
- Deprecated DailyStatisticsResult API.
- Deprecated DataCollectorsResult API.
- Deprecated DataTypeResult API.
- Deprecated ReadDetailResult API.
- Deprecated ActivityRecord.ACTION_ACTIVITY_RECORD_START.
- Deprecated ActivityRecord.ACTION_ACTIVITY_RECORD_END.
- Deprecated BleCommandOptions API.
- Deprecated BleScanCallback API.
- Deprecated StartBleScanOptions API.
- Deprecated SleepFragmentCategory API.
- Deprecated SleepState API.
- Deprecated
  - getActivityRecordsController (context)
  - getAutoRecorderController (context)
  - getConsentsController (context)
  - getDataController (context)
  - getHealthRecordController (context)
  - getSettingController (context).
- Deprecated setSportHealthPaceMap in PaceSummary class.
- Removed STR_TYPE_ERR field from DeviceInfo.

## 5.0.5+301

- Updated HMSLogger.
- Fixed the bug that crashes the application while disabling the Health Service.

## 5.0.5+300

- Initial release.

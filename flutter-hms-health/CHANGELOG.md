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

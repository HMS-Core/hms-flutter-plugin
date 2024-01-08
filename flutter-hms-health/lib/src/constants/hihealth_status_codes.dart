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

/// Defines the HiHealth result codes.
abstract class HiHealthStatusCodes {
  /// Status codes map of the Health Kit SDK.
  static const Map<String, String> _codes = <String, String>{
    /// [Solution:] Make sure that the device is connected to the Internet.
    '7': 'Network error.',

    /// [Solution:] An internal error such as a database exception has occurred.
    /// Please try again.
    '8': 'Internal error.',

    /// [Solution:] Make sure to add a data collector before using it.
    '-50000': 'No data available from the data collector.',

    /// [Solution:] Check whether the record is correct.
    '-50001': 'The record already exists.',

    /// [Solution:] Check whether the device information is correct.
    '-50002': 'Saved device not found.',

    /// [Solution:] Check whether the listener has been registered.
    '-50003': 'Listener not registered.',

    /// [Solution:] Check whether the user has authorized the permissions.
    ///
    /// Request user authorization whenever needed.
    '50000': 'User authorization required.',

    /// [Solution:] The name of the data type to be inserted already exists.
    ///
    /// Check whether the data type name is correct.
    '50001': 'Conflicting data type detected during data insertion.',

    /// [Solution:] The prefix of the data type name must be the same as the
    /// package name of the app.
    '50002': 'Name of the inserted data type not matching the app package name',

    /// [Solution:] No corresponding data type is found based on the name.
    ///
    /// Check the data type name.
    '50003': 'Data type not exist',

    /// [Solution:] Make sure that the information of the app that attempts to
    /// insert data is the same as that of the app you have registered.
    '50004': 'App mismatch detected during data insertion.',

    /// [Solution:] The corresponding authorization needs to be granted on the
    /// device for the requested operation.
    '50005': 'Unknown authentication error.',

    /// [Solution:] Check whether the Bluetooth permission has been granted.
    '50006': 'Bluetooth permission not yet granted.',

    /// [Solution:] Check whether the device supports this platform.
    '50007': 'Platform not supported.',

    /// [Solution:] Please try again.
    '50008': 'A transient error occurred. Please try again.',

    /// [Solution:] Make sure that the activity to be started is correct.
    '50009': 'The same activity has ended and cannot be started again.',

    /// [Solution:] Make sure that the app authorizations are correct.
    '50010': 'An unauthorized app request.',

    /// [Solution:] Check whether there is any parameter error in the called API.
    '50011': 'API call error.',

    /// [Solution:] Only the following data types support aggregation:
    /// * DataType.DT_CONTINUOUS_CALORIES_BURNT: Calories burnt within a period of time (unit: kcal).
    /// * DataType.DT_CONTINUOUS_DISTANCE_DELTA: Distance covered since the last reading (unit: meter).
    /// * DataType.DT_INSTANTANEOUS_HEART_RATE: Heart rate (unit: heartbeats per minute).
    /// * DataType.DT_CONTINUOUS_STEPS_DELTA: Steps taken since the last reading.
    /// * DataType.DT_INSTANTANEOUS_BODY_WEIGHT: Weight (unit: kg).
    /// * Datatype.DT_CONTINUOUS_SLEEP: Sleep details
    /// * DataType.DT_INSTANTANEOUS_STRESS: Stress
    '50012': 'Aggregation not supported by the data type.',

    /// [Solution:] Check whether the account is supported.
    '50013': 'Account not supported.',

    /// [Solution:] Make sure that Bluetooth is enabled.
    '50014': 'Bluetooth disabled.',

    /// [Solution:] Make sure that the package names are the same.
    '50015':
        'Inconsistent app package name detected when inserting a data collector.',

    /// [Solution:] Make sure that the data collector is connected.
    '50018': 'No available data collector found.',

    /// [Solution:] The time for the data update request is inconsistent with the
    /// time of the data in the update request. Check whether the time is correct.
    '50019':
        'Timestamp of the sampling dataset inconsistent with the update time range.',

    /// [Solution:] Check whether the timestamp is correct.
    '50020': 'Incorrect timestamp when adding an activity record.',

    /// [Solution:] Check whether the sampling point data is correct.
    ///
    /// If this result code is returned, troubleshoot as follows:
    /// * Scenario 1: Check whether the value range of the field corresponding to
    /// the sampling point data is correct. For details, please refer to Public
    /// Atomic Data Types on the Huawei Developer Website.
    /// * Scenario 2: Ensure that the end time of the sampling point data is later
    /// than the UNIX timestamp of January 1, 2014.
    '50021': 'Invalid sampling point data.',

    /// [Solution:] The start time must not be later than the end time.
    /// Check whether the time is correct.
    '50022': 'Incorrect timestamp input for query.',

    /// [Solution:] This result code applies to the following scenarios:
    /// * Scenario 1: The data types in the request or in DataCollector of the
    /// request must be any of the following:
    ///    - DT_INSTANTANEOUS_CALORIES_BMR: Basic metabolic rate per day (unit: kcal).
    ///    - DT_INSTANTANEOUS_BODY_FAT_RATE: Body fat rate.
    ///    - DT_INSTANTANEOUS_HEIGHT: Height (unit: meter).
    ///    - DT_INSTANTANEOUS_HYDRATE: Water taken over a single drink (unit: liter).
    ///    - DT_INSTANTANEOUS_NUTRITION_FACTS: Nutrient intake over a meal.
    ///    - DT_INSTANTANEOUS_BODY_WEIGHT: Weight (unit: kg).
    /// * Scenario 2: Currently, automatic data recording is supported only for
    ///    - DT_CONTINUOUS_STEPS_DELTA. This result code will be returned if automatic
    /// data recording is started for any other data types.
    /// * Scenario 3: Currently, real-time data query is supported only for:
    ///    - Step count: DT_CONTINUOUS_STEPS_TOTAL
    '50023':
        'Record update or automatic data recording not supported by the data type.',

    /// [Solution:] Check whether the app is in the trustlist.
    '50024':
        'Before using this data type, ensure that the app is in the trustlist.',

    /// [Solution:] Adjust the query time range to reduce the data volume to be queried.
    '50025':
        'The amount of data to be queried exceeds the maximum serialization size.',

    /// [Solution:] The system version must be EMUI 8.1 or later.
    '50026': 'Not supported by the system version.',

    /// [Solution:] For grouped data types (which are the ones that start with "POLYMERIZE_"),
    /// for example, POLYMERIZE_CONTINUOUS_HEART_RATE_STATISTICS, raw data is not allowed
    /// to be directly inserted.
    '50027': 'Raw data cannot be directly inserted into grouped data types.',

    /// [Solution:] Each data type contains multiple fields, which are either mandatory
    /// or optional. For details, see the data types section in the Development Guide.
    /// This result code will be returned when calling a Health Kit API to insert data,
    /// if any mandatory field is not specified.
    '50028':
        'There are mandatory fields that are not specified in the sampling point.',

    /// [Solution:] When calling the related API to add or query customized data types
    /// in the Setting module, if an internal error occurs, this result code will be returned.
    '50029':
        'Unused customized data types in the Setting module are not allowed to be used.',

    /// [Solution:] Make sure that the device is connected to the Internet.
    '50030': 'No Internet connection.',

    /// [Solution:] Check whether the input parameters for calling the API are correct.
    '50031': 'Parameter loss during API calling.',

    /// [Solution:] Please stay tuned for future updates.
    '50032': 'API function not yet supported.',

    /// [Solution:] Install the latest version of the HUAWEI Health app, grant
    /// authorizations, and try again.
    '50033': 'Dependent HUAWEI Health app not installed.',

    /// [Solution:] Install the latest version of HUAWEI Health and try again.
    '50034': 'Version mismatch of dependent HUAWEI Health app.',

    /// [Solution:] Currently, each third-party app can only call the real-time
    /// data query API once at any given time. This exception occurs if the API
    /// is called repeatedly. You can call the API for ending real-time data query
    /// and then try again.
    '50035':
        'Dependent listener already exists when calling the real-time data query API.',

    /// [Solution:] To call the API for ending real-time data query, make sure
    /// that the real-time data query API has been called. Otherwise, this result
    /// code will be returned.
    '50036':
        'Dependent listener does not exist when calling the API for ending real-time data query.',

    /// [Solution:] This exception will be thrown if the user has not authorized
    /// the HUAWEI Health app to open data to HUAWEI Health Kit. To authorize,
    /// the user needs to open HUAWEI Health app, and go to
    /// *Me > Settings > Data sharing > Health Kit > LINK*.
    '50037':
        'The user has not authorized the HUAWEI Health app to open data to HUAWEI Health Kit',

    /// [Solution:] The user has to be a HUAWEI Health app user.
    '50038': 'The user is not a HUAWEI Health app user.',
    '50039': 'Invalid package name and appid not found.',
    '50040':
        'The country/region in which your account was registered is not on the list of supported locations.',
    '50041': 'The app package name is incorrect.',
    '50042': 'The Physical activity permission is not enabled.',
    '50043':
        'Data migration is in progress. Operations related to data points are temporarily prohibited.',
    '50044': 'The data type is not supported',
    '50045': 'The Huawei account is not logged in.',
    '50046': 'The function does not have the required permission.',
    '50047': '',
    '50048': 'The user of the beta application exceed the range.',
    '50049':
        'Invalid context. Currently, the service context cannot be transferred to trigger forcible upgrade. Please use the activity context.',
    '50050':
        'Invalid healthRecordId. Enter an existing healthRecordId and try again.',
    '50051':
        'Invalid DataType. The current version supports tachycardia, bradycardia, health.record.sleep and their associated data types. please check.',
    '50052':
        'An error occurs when the data dictionary is parsed. Please contact Huawei technical support.',
    '50053':
        'The device hardware may not support the step sensor. please try another device.',
    '50054':
        'invalid activityType filled in, may not support ActivityRecordsController API, please check.',
    '50055': 'JS Api exception, please retry later.',
    '50056': 'JS Api param error, please check the input params.',
    '50057': 'Activity summary not support this dataType',
    '50058': 'This interface is not supported in this region.',
    '50059':
        'The query time in this api exceed the limit 30 days, please check it',
    '50060': 'API calling not supported on the device.',
    '50061': 'Data reading or writing disabled when the screen is locked.',
    '50062': 'The app that calls the API currently is not a frontend app.',
    '50063': 'HMS Core (APK) version not supported.',

    /// [Solution:] Start the Huawei Health app manually.
    '50064':
        'The Huawei Health app has been installed but has never been started.',

    /// [Solution:] Make sure that the start time in the query parameters is
    /// not earlier than the time of the earliest available historical data.
    '50065':
        'The start time in the query parameters is earlier than the time of the earliest available historical data.',
    '50300': 'Activity record running in the background.',
    '50301': 'Failed to call the renewal API.',
    '50302': 'Mandatory data types missing for activity or health records.',
    '50303': 'Data type not supported in activity or health records.',
    '51000': 'Activity record canceled in the background.',
    '51001':
        'Current activity record canceled in the background due to a new record started by another third-party app.'
  };

  /// Returns the error description according to the result code.
  static String getStatusCodeMessage(String statusCode) {
    return _codes[statusCode] ?? 'UNKNOWN_ERROR';
  }
}

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

class HealthRecordReadOptions {
  String packageName;
  DateTime? _startTime;
  DateTime? _endTime;
  TimeUnit _timeUnit = TimeUnit.MILLISECONDS;
  bool _readFromAllApps = false;
  DataCollector? _dataCollector;
  DataType? _dataType;
  String? _appToRemove;
  final List<Map<String, dynamic>> _subDataTypeList = <Map<String, dynamic>>[];

  HealthRecordReadOptions({
    required this.packageName,
  });

  void setPackageName(String packageName) {
    this.packageName = packageName;
  }

  void setTimeInterval(
    DateTime startTime,
    DateTime endTime,
    TimeUnit timeUnit,
  ) {
    _startTime = startTime;
    _endTime = endTime;
    _timeUnit = timeUnit;
  }

  void readByDataCollector(DataCollector dataCollector) {
    _dataCollector = dataCollector;
  }

  void readByDataType(DataType dataType) {
    _dataType = dataType;
  }

  void readHealthRecordsFromAllApps() {
    _readFromAllApps = true;
  }

  void removeApplication(String appName) {
    _appToRemove = appName;
  }

  void setSubDataTypeList(List<DataType> list) {
    for (DataType dataType in list) {
      if (!_subDataTypeList.contains(dataType.toMap())) {
        _subDataTypeList.add(dataType.toMap());
      }
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'packageName': packageName,
      'startTime': _startTime?.millisecondsSinceEpoch,
      'endTime': _endTime?.millisecondsSinceEpoch,
      'timeUnit': describeEnum(_timeUnit),
      'readFromAllApps': _readFromAllApps,
      'dataCollector': _dataCollector?.toMap(),
      'dataType': _dataType?.toMap(),
      'appToRemove': _appToRemove,
      'subDataTypeList': _subDataTypeList,
    }..removeWhere((String k, dynamic v) => v == null);
  }
}

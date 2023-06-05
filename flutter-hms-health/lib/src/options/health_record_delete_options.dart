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

class HealthRecordDeleteOptions {
  String? packageName;
  DateTime startTime;
  DateTime endTime;
  TimeUnit timeUnit;
  final List<String> _healthRecordIds = <String>[];
  final List<Map<String, dynamic>> _subDataTypeList = <Map<String, dynamic>>[];
  DataType? _dataType;
  bool deleteSubData;

  HealthRecordDeleteOptions({
    required this.startTime,
    required this.endTime,
    this.packageName,
    this.timeUnit = TimeUnit.MILLISECONDS,
    this.deleteSubData = false,
  });

  void setPackageName(String packageName) {
    this.packageName = packageName;
  }

  void setTimeInterval(
    DateTime startTime,
    DateTime endTime,
    TimeUnit timeUnit,
  ) {
    this.startTime = startTime;
    this.endTime = endTime;
    this.timeUnit = timeUnit;
  }

  void setHealthRecordIds(List<String> list) {
    _healthRecordIds.clear();
    _healthRecordIds.addAll(list);
  }

  void setSubDataTypeList(List<DataType> subDataTypeList) {
    for (DataType dataType in subDataTypeList) {
      if (!_subDataTypeList.contains(dataType.toMap())) {
        _subDataTypeList.add(dataType.toMap());
      }
    }
  }

  void setDataType(DataType dataType) {
    _dataType = dataType;
  }

  void isDeleteSubData(bool deleteSubData) {
    this.deleteSubData = deleteSubData;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'packageName': packageName,
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
      'timeUnit': describeEnum(timeUnit),
      'hrIDs': _healthRecordIds,
      'subDataTypeList': _subDataTypeList,
      'dataType': _dataType?.toMap(),
      'deleteSubData': deleteSubData,
    }..removeWhere((String k, dynamic v) => v == null);
  }
}

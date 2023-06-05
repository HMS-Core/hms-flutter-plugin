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

class ActivityRecordDeleteOptions {
  String? _packageName;
  DateTime? _startTime;
  DateTime? _endTime;
  TimeUnit _timeUnit = TimeUnit.MILLISECONDS;
  final List<String> _activityRecordIDs = <String>[];
  final List<Map<String, dynamic>> _subDataTypeList = <Map<String, dynamic>>[];
  bool _isDeleteSubData = false;

  void setPackageName(String packageName) {
    _packageName = packageName;
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

  void setActivityRecordIDs(List<String> ids) {
    _activityRecordIDs.clear();
    _activityRecordIDs.addAll(ids);
  }

  void setSubDataTypeList(List<DataType> types) {
    for (DataType type in types) {
      if (!_subDataTypeList.contains(type.toMap())) {
        _subDataTypeList.add(type.toMap());
      }
    }
  }

  @Deprecated('No longer recommended to use.')
  void isDeleteSubData(bool deleteSubData) {
    _isDeleteSubData = deleteSubData;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'packageName': _packageName,
      'startTime': _startTime?.millisecondsSinceEpoch,
      'endTime': _endTime?.millisecondsSinceEpoch,
      'timeUnit': describeEnum(_timeUnit),
      'activityRecordIDs': _activityRecordIDs,
      'subDataTypes': _subDataTypeList,
      'deleteSubData': _isDeleteSubData,
    }..removeWhere((String k, dynamic v) => v == null);
  }
}

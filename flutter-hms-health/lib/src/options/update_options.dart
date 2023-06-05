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

/// Request parameter class for updating data for a specified period of time to
/// the HUAWEI Health platform.
class UpdateOptions {
  DateTime startTime;
  DateTime endTime;
  SampleSet sampleSet;
  TimeUnit timeUnit;

  UpdateOptions({
    required this.startTime,
    required this.endTime,
    required this.sampleSet,
    this.timeUnit = TimeUnit.MILLISECONDS,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
      'sampleSet': sampleSet.toMap(),
      'timeUnit': describeEnum(timeUnit),
    }..removeWhere((String k, dynamic v) => v == null);
  }
}

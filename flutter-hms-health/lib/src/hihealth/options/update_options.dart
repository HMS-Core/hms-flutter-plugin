/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:huawei_health/huawei_health.dart';

/// Request parameter class for updating data for a specified period of time to
/// the HUAWEI Health platform.
class UpdateOptions {
  DateTime startTime;
  DateTime endTime;
  TimeUnit timeUnit;
  SampleSet sampleSet;

  UpdateOptions(
      {this.startTime,
      this.endTime,
      this.timeUnit = TimeUnit.MILLISECONDS,
      this.sampleSet});

  Map<String, dynamic> toMap() {
    return {
      "startTime": startTime?.millisecondsSinceEpoch,
      "endTime": endTime?.millisecondsSinceEpoch,
      "timeUnit": timeUnit.toString(),
      "sampleSet": sampleSet.toMap()
    }..removeWhere((k, v) => v == null);
  }
}

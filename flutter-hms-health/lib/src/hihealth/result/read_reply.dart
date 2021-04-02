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

import 'package:huawei_health/src/hihealth/data/group.dart';

import '../../../huawei_health.dart';

/// Data reading response class that defines the Read results of the
/// [DataController.read] method.
class ReadReply {
  final List<Group> groups;
  final List<SampleSet> sampleSets;

  ReadReply._({this.groups, this.sampleSets});

  factory ReadReply.fromMap(Map<String, dynamic> resultMap) {
    if (resultMap == null) return null;
    return ReadReply._(
        groups: resultMap['groups'] != null
            ? List.from(resultMap['groups']
                .map((e) => Group.fromMap(Map<String, dynamic>.from(e))))
            : null,
        sampleSets: resultMap['sampleSets'] != null
            ? List.from(resultMap['sampleSets']
                .map((e) => SampleSet.fromMap(Map<String, dynamic>.from(e))))
            : null);
  }

  Map<String, dynamic> toMap() {
    return {
      "groups": List<Map<String, dynamic>>.from(groups?.map((e) => e.toMap())),
      "sampleSet":
          List<Map<String, dynamic>>.from(sampleSets?.map((e) => e.toMap()))
    }..removeWhere((k, v) => v == null);
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

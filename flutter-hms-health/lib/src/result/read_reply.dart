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

/// Data reading response class that defines the Read results of the
/// [DataController.read] method.
class ReadReply {
  final List<Group> groups;
  final List<SampleSet> sampleSets;

  ReadReply._({
    required this.groups,
    required this.sampleSets,
  });

  factory ReadReply.fromMap(Map<dynamic, dynamic> resultMap) {
    return ReadReply._(
      groups: resultMap['groups'] != null
          ? List<Group>.from(
              resultMap['groups'].map(
                (dynamic e) => Group.fromMap(e),
              ),
            )
          : <Group>[],
      sampleSets: resultMap['sampleSets'] != null
          ? List<SampleSet>.from(
              resultMap['sampleSets'].map(
                (dynamic e) {
                  return SampleSet.fromMap(e);
                },
              ),
            )
          : <SampleSet>[],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'groups': List<Map<String, dynamic>>.from(
        groups.map((Group e) => e.toMap()),
      ),
      'sampleSet': List<Map<String, dynamic>>.from(
        sampleSets.map((SampleSet e) => e.toMap()),
      ),
    }..removeWhere((String k, dynamic v) => v == null);
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

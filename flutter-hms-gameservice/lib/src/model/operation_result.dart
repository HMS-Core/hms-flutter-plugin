/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_gameservice;

/// Returns the final archive data or conflicting data in the case of
/// archive reading or conflict resolution.
class OperationResult {
  /// A [Difference] object that contains detailed conflicting data.
  /// The object needs to be obtained only when isDifference returns true.
  final Difference? difference;

  /// [Archive] data.
  final Archive? archive;

  /// Indicates whether there is a data conflict.
  ///
  /// The options are as follows:
  /// true: There is a data conflict. Use [difference] to obtain conflicting data.
  /// false: There is no data conflict. Use [archive] to obtain archive data.
  final bool? isDifference;

  const OperationResult._({
    this.difference,
    this.archive,
    this.isDifference,
  });

  factory OperationResult.fromMap(Map<dynamic, dynamic> map) {
    return OperationResult._(
      difference: map['difference'] != null
          ? Difference.fromMap(map['difference'])
          : null,
      archive: map['archive'] != null ? Archive.fromMap(map['archive']) : null,
      isDifference: map['isDifference'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'difference': difference?.toMap(),
      'archive': archive?.toMap(),
      'isDifference': isDifference,
    };
  }

  @override
  String toString() {
    return '$OperationResult('
        'difference: $difference, '
        'archive: $archive, '
        'isDifference: $isDifference)';
  }
}

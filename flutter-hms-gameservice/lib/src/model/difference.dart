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

/// Details about a conflict if it is present on the [difference] field
/// of an [OperationResult] object.
class Difference {
  /// The archive data on Huawei game server.
  final Archive? serverArchive;

  /// The ArchiveDetails object for an archive file to be modified when a conflict has occurred.
  final ArchiveDetails? emptyArchiveDetails;

  /// The Archive object to be modified when a conflict has occurred.
  final Archive? recentArchive;

  const Difference._({
    this.serverArchive,
    this.emptyArchiveDetails,
    this.recentArchive,
  });

  factory Difference.fromMap(Map<dynamic, dynamic> map) {
    return Difference._(
      serverArchive: map['serverArchive'] != null
          ? Archive.fromMap(map['serverArchive'])
          : null,
      emptyArchiveDetails: map['emptyArchiveDetails'] != null
          ? ArchiveDetails.fromUint8List(map['emptyArchiveDetails'])
          : null,
      recentArchive: map['recentArchive'] != null
          ? Archive.fromMap(map['recentArchive'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serverArchive': serverArchive?.toMap(),
      'emptyArchiveDetails': emptyArchiveDetails?.toMap(),
      'recentArchive': recentArchive?.toMap(),
    };
  }

  @override
  String toString() {
    return '$Difference('
        'serverArchive: $serverArchive, '
        'emptyArchiveDetails: $emptyArchiveDetails, '
        'recentArchive: $recentArchive)';
  }
}

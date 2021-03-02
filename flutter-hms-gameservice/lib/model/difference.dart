/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:huawei_gameservice/model/model_export.dart';

/// Details about a conflict if it is present on the [difference] field
/// of an [OperationResult] object.
class Difference {
  /// The archive data on Huawei game server.
  final Archive serverArchive;

  /// The ArchiveDetails object for an archive file to be modified when a conflict has occurred.
  final ArchiveDetails emptyArchiveDetails;

  /// The Archive object to be modified when a conflict has occurred.
  final Archive recentArchive;

  Difference._({
    this.serverArchive,
    this.emptyArchiveDetails,
    this.recentArchive,
  });

  Map<String, dynamic> toMap() {
    return {
      'serverArchive': serverArchive?.toMap(),
      'emptyArchiveDetails': emptyArchiveDetails?.toMap(),
      'recentArchive': recentArchive?.toMap(),
    };
  }

  factory Difference.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

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

  @override
  String toString() =>
      'Difference(serverArchive: $serverArchive, emptyArchiveDetails: $emptyArchiveDetails, recentArchive: $recentArchive)';
}

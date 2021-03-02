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

import 'package:huawei_gameservice/model/archive_details.dart';
import 'package:huawei_gameservice/model/archive_summary.dart';

/// Returns the archive file and archive metadata of a saved game.
///
/// An object of the Archive type is returned in the case of archive reading or
/// data conflict resolution.
class Archive {
  /// An [ArchiveSummary] object that contains the archive metadata.
  final ArchiveSummary summary;

  /// An [ArchiveDetails] object that contains the content of the archive.
  final ArchiveDetails details;

  Archive._({
    this.summary,
    this.details,
  });

  Map<String, dynamic> toMap() {
    return {
      'summary': summary?.toMap(),
      'details': details?.toMap(),
    };
  }

  factory Archive.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Archive._(
      summary: map['summary'] != null
          ? ArchiveSummary.fromMap(Map<String, dynamic>.from(map['summary']))
          : null,
      details: map['details'] != null
          ? ArchiveDetails.fromUint8List(map['details'])
          : null,
    );
  }

  @override
  String toString() => 'Archive(summary: $summary, details: $details)';
}

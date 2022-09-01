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

/// Returns the archive file and archive metadata of a saved game.
///
/// An object of the Archive type is returned in the case of archive reading or
/// data conflict resolution.
class Archive {
  /// An [ArchiveSummary] object that contains the archive metadata.
  final ArchiveSummary? summary;

  /// An [ArchiveDetails] object that contains the content of the archive.
  final ArchiveDetails? details;

  const Archive._({
    this.summary,
    this.details,
  });

  factory Archive.fromMap(Map<dynamic, dynamic> map) {
    return Archive._(
      summary: map['summary'] != null
          ? ArchiveSummary.fromMap(map['summary'])
          : null,
      details: map['details'] != null
          ? ArchiveDetails.fromUint8List(map['details'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'summary': summary?.toMap(),
      'details': details?.toMap(),
    };
  }

  @override
  String toString() {
    return '$Archive('
        'summary: $summary, '
        'details: $details)';
  }
}

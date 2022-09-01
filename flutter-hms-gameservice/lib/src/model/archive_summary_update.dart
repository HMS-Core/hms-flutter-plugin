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

/// Saves changes to archive metadata in the case of
/// archive submission or data conflict resolution.
class ArchiveSummaryUpdate {
  /// The MIME type of the cover image of an archive.
  String? thumbnailMimeType;

  /// The cover image byte content of an archive.
  Uint8List? thumbnail;

  /// The description of an archive.
  String? descInfo;

  /// The progress value of an archive.
  int? currentProgress;

  /// The new played time of an archive.
  int? activeTime;

  ArchiveSummaryUpdate({
    this.thumbnailMimeType,
    this.thumbnail,
    this.descInfo,
    this.currentProgress,
    this.activeTime,
  });

  factory ArchiveSummaryUpdate.fromMap(Map<dynamic, dynamic> map) {
    return ArchiveSummaryUpdate(
      thumbnailMimeType: map['thumbnailMimeType'],
      thumbnail: map['thumbnail'] != null
          ? Uint8List.fromList(
              List<int>.from(map['thumbnail']),
            )
          : null,
      descInfo: map['description'],
      currentProgress: map['currentProgress'],
      activeTime: map['activeTime'],
    );
  }

  /// Obtains the archive summary update object from the archive summary description.
  factory ArchiveSummaryUpdate.fromSummary(ArchiveSummary summary) {
    return ArchiveSummaryUpdate(
      descInfo: summary.descInfo,
      currentProgress: summary.currentProgress,
      activeTime: summary.activeTime == -1 ? null : summary.activeTime,
    );
  }

  Map<String, dynamic> toMap() {
    return removeNulls(
      <String, dynamic>{
        'thumbnailMimeType': thumbnailMimeType,
        'thumbnail': thumbnail,
        'descInfo': descInfo,
        'currentProgress': currentProgress,
        'activeTime': activeTime,
      },
    );
  }

  @override
  String toString() {
    return '$ArchiveSummaryUpdate('
        'thumbnailMimeType: $thumbnailMimeType, '
        'thumbnail: $thumbnail, '
        'description: $descInfo, '
        'currentProgress: $currentProgress, '
        'activeTime: $activeTime)';
  }
}

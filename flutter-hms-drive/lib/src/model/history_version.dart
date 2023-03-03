/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'dart:convert';

import 'package:huawei_drive/huawei_drive.dart';

/// Metadata class for historical file versions.
class HistoryVersion with ExtraParameter {
  /// ID of a historical file version.
  String? id;

  /// Whether to permanently keep a historical version, even if it is not the
  /// latest version.
  bool? keepPermanent;

  /// Resource type.
  ///
  /// The value is always `drive#historyVersion`.
  String? category;

  /// Last user who modified a historical file version.
  DriveUser? lastEditor;

  /// SHA-256 value for verifying a historical file version.
  ///
  /// This parameter may not be set on the client. If it is set, the server will
  /// use the SHA-256 value for verifying the historical file version.
  String? sha256;

  /// MIME type of the file.
  String? mimeType;

  /// Time when a historical version is modified.
  DateTime? editedTime;

  ///	Original file name of a historical version.
  String? originalFilename;

  /// File size of a historical version, in bytes.
  int? size;

  HistoryVersion({
    this.id,
    this.keepPermanent,
    this.category,
    this.lastEditor,
    this.sha256,
    this.mimeType,
    this.editedTime,
    this.originalFilename,
    this.size,
  });

  factory HistoryVersion.fromMap(Map<String, dynamic> map) {
    return HistoryVersion(
      id: map['id'],
      keepPermanent: map['keepPermanent'],
      category: map['category'],
      lastEditor: map['lastEditor'] != null
          ? DriveUser.fromMap(map['lastEditor'])
          : null,
      sha256: map['sha256'],
      mimeType: map['mimeType'],
      editedTime:
          map['editedTime'] != null ? DateTime.parse(map['editedTime']) : null,
      originalFilename: map['originalFilename'],
      size: map['size'],
    );
  }

  factory HistoryVersion.fromJson(String source) =>
      HistoryVersion.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'keepPermanent': keepPermanent,
      'category': category,
      'lastEditor': lastEditor?.toMap(),
      'sha256': sha256,
      'mimeType': mimeType,
      'editedTime': editedTime?.toIso8601String(),
      'originalFilename': originalFilename,
      'size': size,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'HistoryVersion(id: $id, keepPermanent: $keepPermanent, category: $category, lastEditor: $lastEditor, sha256: $sha256, mimeType: $mimeType, editedTime: $editedTime, originalFilename: $originalFilename, size: $size)';
  }
}

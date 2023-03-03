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

import 'package:huawei_drive/src/model/drive_file.dart';

/// File or drive change class.
class Change {
  ///	Change type, which can be file or drive.
  String? changeType;

  /// Information about a changed file.
  ///
  /// The file field is available only when the changed file is not deleted and
  /// the value of changeType is file.
  DriveFile? file;

  /// ID of a changed file.
  String? fileId;

  /// Resource type.
  ///
  /// The value is always `drive#change`.
  String? category;

  /// Change time, in RFC 3339 date-time format.
  DateTime? time;

  /// Indicates whether a change is removed from the change list.
  ///
  /// true if a change is removed from the change list; false otherwise.
  bool? deleted;

  Change({
    this.changeType,
    this.file,
    this.fileId,
    this.category,
    this.time,
    this.deleted,
  });

  factory Change.fromMap(Map<String, dynamic> map) {
    return Change(
      changeType: map['changeType'],
      file: map['file'] != null ? DriveFile.fromMap(map['file']) : null,
      fileId: map['fileId'],
      category: map['category'],
      time: map['time'] != null ? DateTime.parse(map['time']) : null,
      deleted: map['deleted'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'changeType': changeType,
      'file': file?.toMap(),
      'fileId': fileId,
      'category': category,
      'time': time?.toIso8601String(),
      'deleted': deleted,
    };
  }

  String toJson() => json.encode(toMap());

  factory Change.fromJson(String source) => Change.fromMap(json.decode(source));

  @override
  String toString() {
    return '$Change('
        'changeType: $changeType,'
        'file: $file,'
        'fileId: $fileId,'
        'category: $category, '
        'time: $time, '
        'deleted: $deleted)';
  }
}

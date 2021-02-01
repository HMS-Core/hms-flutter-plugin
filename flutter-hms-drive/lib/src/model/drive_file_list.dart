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

import 'dart:convert';

import 'package:huawei_drive/huawei_drive.dart';

class DriveFileList {
  String category;
  List<DriveFile> files;
  String nextCursor;
  bool searchCompleted;

  DriveFileList({
    this.category,
    this.files,
    this.nextCursor,
    this.searchCompleted,
  });

  DriveFileList clone({
    String category,
    List<DriveFile> files,
    String nextCursor,
    bool searchCompleted,
  }) {
    return DriveFileList(
      category: category ?? this.category,
      files: files ?? this.files,
      nextCursor: nextCursor ?? this.nextCursor,
      searchCompleted: searchCompleted ?? this.searchCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'files': files?.map((x) => x?.toMap())?.toList(),
      'nextCursor': nextCursor,
      'searchCompleted': searchCompleted,
    };
  }

  factory DriveFileList.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DriveFileList(
      category: map['category'],
      files: map['files'] == null
          ? null
          : List<DriveFile>.from(
              map['files']?.map((x) => DriveFile.fromMap(x))),
      nextCursor: map['nextCursor'],
      searchCompleted: map['searchCompleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DriveFileList.fromJson(String source) =>
      DriveFileList.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FileList(category: $category, files: $files, nextCursor: $nextCursor, searchCompleted: $searchCompleted)';
  }
}

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
import 'dart:typed_data';

class DriveFileContent {
  String type;
  String path;
  Int8List byteArray;

  DriveFileContent({
    this.type,
    this.path,
    this.byteArray,
  });

  DriveFileContent clone({
    String type,
    String path,
    Int8List byteArray,
  }) {
    return DriveFileContent(
      type: type ?? this.type,
      path: path ?? this.path,
      byteArray: byteArray ?? this.byteArray,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'path': path,
      'byteArray': byteArray,
    };
  }

  factory DriveFileContent.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DriveFileContent(
      type: map['type'],
      path: map['path'],
      byteArray:
          map['byteArray'] == null ? null : Int8List.fromList(map['byteArray']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DriveFileContent.fromJson(String source) =>
      DriveFileContent.fromMap(json.decode(source));

  @override
  String toString() => 'FileContent(type: $type, path: $path, arr: $byteArray)';
}

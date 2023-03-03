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

import 'package:huawei_drive/src/model/drive_thumbnail.dart';

class ContentExtras {
  DriveThumbnail? thumbnail;

  ContentExtras({
    this.thumbnail,
  });

  factory ContentExtras.fromMap(Map<String, dynamic> map) {
    return ContentExtras(
      thumbnail: map['thumbnail'] == null
          ? null
          : DriveThumbnail.fromMap(map['thumbnail']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'thumbnail': thumbnail?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  factory ContentExtras.fromJson(String source) =>
      ContentExtras.fromMap(json.decode(source));

  @override
  String toString() => 'ContentExtras(thumbnail: $thumbnail)';
}

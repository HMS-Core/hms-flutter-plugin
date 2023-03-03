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

class DriveThumbnail {
  String? content;
  String? mimeType;
  bool? thumbnailPublic;

  DriveThumbnail({
    this.content,
    this.mimeType,
    this.thumbnailPublic,
  });

  factory DriveThumbnail.fromMap(Map<String, dynamic> map) {
    return DriveThumbnail(
      content: map['content'],
      mimeType: map['mimeType'],
      thumbnailPublic: map['thumbnailPublic'],
    );
  }

  factory DriveThumbnail.fromJson(String source) =>
      DriveThumbnail.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'mimeType': mimeType,
      'thumbnailPublic': thumbnailPublic,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'Thumbnail(content: $content, mimeType: $mimeType, thumbnailPublic: $thumbnailPublic)';
}

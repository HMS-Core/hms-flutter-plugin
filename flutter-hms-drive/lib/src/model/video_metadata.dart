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

class VideoMetadata {
  int durationTime;
  int height;
  int width;

  VideoMetadata({
    this.durationTime,
    this.height,
    this.width,
  });

  VideoMetadata clone({
    int durationTime,
    int height,
    int width,
  }) {
    return VideoMetadata(
      durationTime: durationTime ?? this.durationTime,
      height: height ?? this.height,
      width: width ?? this.width,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'durationTime': durationTime,
      'height': height,
      'width': width,
    };
  }

  factory VideoMetadata.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return VideoMetadata(
      durationTime: map['durationTime'],
      height: map['height'],
      width: map['width'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoMetadata.fromJson(String source) =>
      VideoMetadata.fromMap(json.decode(source));

  @override
  String toString() =>
      'VideoMetadata(durationTime: $durationTime, height: $height, width: $width)';
}

/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of '../../huawei_ml_body.dart';

class Rect {
  int bottom;
  int left;
  int right;
  int top;

  Rect({
    required this.bottom,
    required this.left,
    required this.right,
    required this.top,
  });

  factory Rect.fromJson(String str) {
    return Rect.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory Rect.fromMap(Map<String, dynamic> json) {
    return Rect(
      bottom: json['bottom'],
      left: json['left'],
      right: json['right'],
      top: json['top'],
    );
  }

  Map<dynamic, dynamic> toMap() {
    return <dynamic, dynamic>{
      'bottom': bottom,
      'left': left,
      'right': right,
      'top': top,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is Rect &&
        other.bottom == bottom &&
        other.left == left &&
        other.right == right &&
        other.top == top;
  }
}

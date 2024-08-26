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

class MLGesture {
  static const int one = 0;
  static const int second = 1;
  static const int three = 2;
  static const int four = 3;
  static const int five = 4;
  static const int six = 5;
  static const int seven = 6;
  static const int eight = 7;
  static const int nine = 8;
  static const int diss = 9;
  static const int fist = 10;
  static const int good = 11;
  static const int heart = 12;
  static const int ok = 13;
  static const int unknown = 14;

  final int? category;
  final double? score;
  final BodyBorder? border;

  const MLGesture._({
    this.border,
    this.category,
    this.score,
  });

  factory MLGesture.fromMap(Map<dynamic, dynamic> map) {
    return MLGesture._(
      category: map['category'],
      score: map['score'],
      border: map['rect'] != null ? BodyBorder.fromMap(map['rect']) : null,
    );
  }
}

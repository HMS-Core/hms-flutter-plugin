/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'ml_border.dart';

class MLHandKeypoints {
  List<MLHandKeypoint> handKeypoints;
  MLBorder rect;
  double score;

  MLHandKeypoints({this.handKeypoints, this.rect, this.score});

  MLHandKeypoints.fromJson(Map<String, dynamic> json) {
    if (json['handKeypoints'] != null) {
      handKeypoints = new List<MLHandKeypoint>();
      json['handKeypoints'].forEach((v) {
        handKeypoints.add(new MLHandKeypoint.fromJson(v));
      });
    }
    rect =
        json['border'] != null ? new MLBorder.fromJson(json['border']) : null;
    score = json['score'];
  }
}

class MLHandKeypoint {
  /// First joint of the index finger near the wrist.
  static const int TYPE_FOREFINGER_FIRST = 5;

  /// Second joint of the index finger near the wrist.
  static const int TYPE_FOREFINGER_SECOND = 6;

  /// Third joint of the index finger near the wrist.
  static const int TYPE_FOREFINGER_THIRD = 7;

  /// Index finger tip.
  static const int TYPE_FOREFINGER_FOURTH = 8;

  /// First joint of the little finger near the wrist.
  static const int TYPE_LITTLE_FINGER_FIRST = 17;

  /// Second joint of the little finger near the wrist.
  static const int TYPE_LITTLE_FINGER_SECOND = 18;

  /// Third joint of the little finger near the wrist.
  static const int TYPE_LITTLE_FINGER_THIRD = 19;

  /// Little finger tip.
  static const int TYPE_LITTLE_FINGER_FOURTH = 20;

  /// First joint of the middle finger near the wrist.
  static const int TYPE_MIDDLE_FINGER_FIRST = 9;

  /// Second joint of the middle finger near the wrist.
  static const int TYPE_MIDDLE_FINGER_SECOND = 10;

  /// Third joint of the middle finger near the wrist.
  static const int TYPE_MIDDLE_FINGER_THIRD = 11;

  /// Middle finger tip.
  static const int TYPE_MIDDLE_FINGER_FOURTH = 12;

  /// First joint of the ring finger near the wrist.
  static const int TYPE_RING_FINGER_FIRST = 13;

  /// Second joint of the ring finger near the wrist.
  static const int TYPE_RING_FINGER_SECOND = 14;

  /// Third joint of the ring finger near the wrist.
  static const int TYPE_RING_FINGER_THIRD = 15;

  /// Ring finger tip.
  static const int TYPE_RING_FINGER_FOURTH = 16;

  /// First joint of the thumb near the wrist.
  static const int TYPE_THUMB_FIRST = 1;

  /// Second joint of the thumb near the wrist.
  static const int TYPE_THUMB_SECOND = 2;

  /// Third joint of the thumb near the wrist.
  static const int TYPE_THUMB_THIRD = 3;

  /// Thumb tip.
  static const int TYPE_THUMB_FOURTH = 4;

  /// Wrist joint.
  static const int TYPE_WRIST = 0;

  dynamic pointX;
  dynamic pointY;
  double score;
  int type;

  MLHandKeypoint({this.pointX, this.pointY, this.score, this.type});

  MLHandKeypoint.fromJson(Map<String, dynamic> json) {
    pointX = json['pointX'];
    pointY = json['pointY'];
    score = json['score'];
    type = json['type'];
  }
}

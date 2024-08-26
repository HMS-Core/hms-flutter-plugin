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

class MLHandKeyPoints {
  final List<MLHandKeyPoint> handKeyPoints;
  final BodyBorder? rect;
  final double? score;

  const MLHandKeyPoints._({
    required this.handKeyPoints,
    required this.rect,
    required this.score,
  });

  factory MLHandKeyPoints.fromMap(Map<dynamic, dynamic> map) {
    final List<MLHandKeyPoint> points = <MLHandKeyPoint>[];

    if (map['handKeypoints'] != null) {
      map['handKeypoints'].forEach((dynamic v) {
        points.add(MLHandKeyPoint.fromMap(v));
      });
    }
    return MLHandKeyPoints._(
      handKeyPoints: points,
      score: map['score'],
      rect: map['border'] != null ? BodyBorder.fromMap(map['border']) : null,
    );
  }
}

class MLHandKeyPoint {
  /// First joint of the index finger near the wrist.
  static const int typeForefingerFirst = 5;

  /// Second joint of the index finger near the wrist.
  static const int typeForefingerSecond = 6;

  /// Third joint of the index finger near the wrist.
  static const int typeForefingerThird = 7;

  /// Index finger tip.
  static const int typeForefingerFourth = 8;

  /// First joint of the little finger near the wrist.
  static const int typeLittleFingerFirst = 17;

  /// Second joint of the little finger near the wrist.
  static const int typeLittleFingerSecond = 18;

  /// Third joint of the little finger near the wrist.
  static const int typeLittleFingerThird = 19;

  /// Little finger tip.
  static const int typeLittleFingerFourth = 20;

  /// First joint of the middle finger near the wrist.
  static const int typeMiddleFingerFirst = 9;

  /// Second joint of the middle finger near the wrist.
  static const int typeMiddleFingerSecond = 10;

  /// Third joint of the middle finger near the wrist.
  static const int typeMiddleFingerThird = 11;

  /// Middle finger tip.
  static const int typeMiddleFingerFourth = 12;

  /// First joint of the ring finger near the wrist.
  static const int typeRingFingerFirst = 13;

  /// Second joint of the ring finger near the wrist.
  static const int typeRingFingerSecond = 14;

  /// Third joint of the ring finger near the wrist.
  static const int typeRingFingerThird = 15;

  /// Ring finger tip.
  static const int typeRingFingerFourth = 16;

  /// First joint of the thumb near the wrist.
  static const int typeThumbFirst = 1;

  /// Second joint of the thumb near the wrist.
  static const int typeThumbSecond = 2;

  /// Third joint of the thumb near the wrist.
  static const int typeThumbThird = 3;

  /// Thumb tip.
  static const int typeThumbFourth = 4;

  /// Wrist joint.
  static const int typeWrist = 0;

  final double pointX;
  final double pointY;
  final double score;
  final int? type;

  const MLHandKeyPoint._({
    required this.pointX,
    required this.pointY,
    required this.score,
    required this.type,
  });

  factory MLHandKeyPoint.fromMap(Map<dynamic, dynamic> map) {
    return MLHandKeyPoint._(
      pointX: map['pointX'],
      pointY: map['pointY'],
      score: map['score'],
      type: map['type'],
    );
  }
}

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

class MLSkeleton {
  final List<MLJoint> joints;

  const MLSkeleton._({
    required this.joints,
  });

  factory MLSkeleton.fromMap(Map<dynamic, dynamic> json) {
    final List<MLJoint> joints = <MLJoint>[];

    if (json['joints'] != null) {
      json['joints'].forEach((dynamic v) {
        joints.add(MLJoint.fromMap(v));
      });
    }
    return MLSkeleton._(
      joints: joints,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'joints': joints.map((MLJoint v) => v.toJson()).toList(),
    };
  }
}

class MLJoint {
  /// Head point.
  static const int typeHeadTop = 113;

  /// Left ankle point.
  static const int typeLeftAnkle = 112;

  /// Left elbow point.
  static const int typeLeftElbow = 105;

  /// Left hip point.
  static const int typeLeftHip = 110;

  /// Left knee point.
  static const int typeLeftKnee = 111;

  /// Left shoulder point.
  static const int typeLeftShoulder = 104;

  /// Left wrist point.
  static const int typeLeftWrist = 106;

  /// Neck point.
  static const int typeNeck = 114;

  /// Right ankle point.
  static const int typeRightAnkle = 109;

  /// Right elbow point.
  static const int typeRightElbow = 102;

  /// Right hip point.
  static const int typeRightHip = 107;

  /// Right knee point.
  static const int typeRightKnee = 108;

  /// Right shoulder point.
  static const int typeRightShoulder = 101;

  /// Right wrist point.
  static const int typeRightWrist = 103;

  final int? type;
  final double pointX;
  final double pointY;
  final double score;

  const MLJoint._({
    required this.type,
    required this.pointX,
    required this.pointY,
    required this.score,
  });

  factory MLJoint.fromMap(Map<dynamic, dynamic> json) {
    return MLJoint._(
      type: json['type'],
      pointX: json['pointX'],
      pointY: json['pointY'],
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'pointX': pointX,
      'pointY': pointY,
      'type': type,
      'score': score,
    };
  }
}

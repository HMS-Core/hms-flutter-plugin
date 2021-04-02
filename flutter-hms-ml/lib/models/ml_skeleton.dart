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

class MLSkeleton {
  List<MLJoint> joints;

  MLSkeleton({this.joints});

  MLSkeleton.fromJson(Map<String, dynamic> json) {
    if (json['joints'] != null) {
      joints = new List<MLJoint>();
      json['joints'].forEach((v) {
        joints.add(new MLJoint.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.joints != null) {
      data['joints'] = this.joints.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MLJoint {
  /// Head point.
  static const int TYPE_HEAD_TOP = 113;

  /// Left ankle point.
  static const int TYPE_LEFT_ANKLE = 112;

  /// Left elbow point.
  static const int TYPE_LEFT_ELBOW = 105;

  /// Left hip point.
  static const int TYPE_LEFT_HIP = 110;

  /// Left knee point.
  static const int TYPE_LEFT_KNEE = 111;

  /// Left shoulder point.
  static const int TYPE_LEFT_SHOULDER = 104;

  /// Left wrist point.
  static const int TYPE_LEFT_WRIST = 106;

  /// Neck point.
  static const int TYPE_NECK = 114;

  /// Right ankle point.
  static const int TYPE_RIGHT_ANKLE = 109;

  /// Right elbow point.
  static const int TYPE_RIGHT_ELBOW = 102;

  /// Right hip point.
  static const int TYPE_RIGHT_HIP = 107;

  /// Right knee point.
  static const int TYPE_RIGHT_KNEE = 108;

  /// Right shoulder point.
  static const int TYPE_RIGHT_SHOULDER = 101;

  /// Right wrist point.
  static const int TYPE_RIGHT_WRIST = 103;

  dynamic pointX;
  dynamic pointY;
  int type;
  dynamic score;

  MLJoint({this.pointY, this.pointX, this.type, this.score});

  MLJoint.fromJson(Map<String, dynamic> json) {
    pointX = json['pointX'];
    pointY = json['pointY'];
    type = json['type'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pointX'] = this.pointX;
    data['pointY'] = this.pointY;
    data['type'] = this.type;
    data['score'] = this.score;
    return data;
  }
}

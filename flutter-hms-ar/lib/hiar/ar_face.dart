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

import 'dart:convert';

import 'ar_anchor.dart';
import 'ar_face_blend_shapes.dart';
import 'ar_pose.dart';
import 'ar_trackable_base.dart';

class ARFace implements ARTrackableBase {
  final List<ARAnchor> anchors;
  final TrackingState trackingState;
  final ARPose pose;
  final ARFaceBlendShapes faceBlendShapes;

  ARFace._({
    this.anchors,
    this.trackingState,
    this.pose,
    this.faceBlendShapes,
  });

  factory ARFace.fromMap(Map<String, dynamic> jsonMap) {
    return ARFace._(
        anchors: jsonMap['anchors'] != null
            ? List<ARAnchor>.from(
                jsonMap['anchors'].map((x) => ARAnchor.fromMap(x)))
            : null,
        faceBlendShapes: jsonMap['faceBlendShapes'] != null
            ? ARFaceBlendShapes.fromMap(jsonMap['faceBlendShapes'])
            : null,
        pose: jsonMap['pose'] != null ? ARPose.fromMap(jsonMap['pose']) : null,
        trackingState: jsonMap['trackingState'] != null
            ? TrackingState.values[jsonMap['trackingState']]
            : null);
  }

  factory ARFace.fromJSON(String json) {
    if (json == null) return null;
    return ARFace.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "trackingState": trackingState,
      "pose": pose?.toMap(),
      "anchors": anchors,
      "arFaceBlendingShapes": faceBlendShapes?.toMap(),
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

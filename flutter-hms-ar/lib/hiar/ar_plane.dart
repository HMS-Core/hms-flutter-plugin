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
import 'ar_pose.dart';
import 'ar_trackable_base.dart';

class ARPlane implements ARTrackableBase {
  final ARPose centerPose;

  final double extentX;
  final double extentZ;

  final List<double> planePolygon;
  final SemanticPlaneLabel label;
  final PlaneType type;

  final List<ARAnchor> anchors;
  final TrackingState trackingState;

  ARPlane._(
      {this.centerPose,
      this.extentX,
      this.extentZ,
      this.planePolygon,
      this.label,
      this.anchors,
      this.trackingState,
      this.type});

  factory ARPlane.fromMap(Map<String, dynamic> jsonMap) {
    if (jsonMap == null) return null;
    return ARPlane._(
        centerPose: jsonMap['centerPose'] != null
            ? ARPose.fromMap(jsonMap['centerPose'])
            : null,
        extentX:
            jsonMap['extentX'] != null ? jsonMap['extentX'].toDouble() : null,
        extentZ:
            jsonMap['extentZ'] != null ? jsonMap['extentZ'].toDouble() : null,
        planePolygon: jsonMap['planePolygon'] != null
            ? List<double>.from(
                jsonMap['planePolygon'].map((x) => x.toDouble()))
            : null,
        label: jsonMap['label'] != null
            ? SemanticPlaneLabel.values[jsonMap['label']]
            : null,
        trackingState: jsonMap['trackingState'] != null
            ? TrackingState.values[jsonMap['trackingState']]
            : null,
        anchors: jsonMap['anchors'] != null
            ? List<ARAnchor>.from(
                jsonMap['anchors'].map((x) => ARAnchor.fromMap(x)))
            : null,
        type:
            jsonMap['type'] != null ? PlaneType.values[jsonMap['type']] : null);
  }

  factory ARPlane.fromJSON(String json) {
    if (json == null) return null;
    return ARPlane.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> arPlaneMap = Map();
    arPlaneMap['centerPose'] = centerPose;
    arPlaneMap['extentX'] = extentX;
    arPlaneMap['extentZ'] = extentZ;
    arPlaneMap['planePolygon'] = planePolygon;
    arPlaneMap['label'] = label;
    arPlaneMap['trackingState'] = trackingState;
    arPlaneMap['anchors'] = anchors?.toString();
    arPlaneMap['type'] = type;
    return arPlaneMap;
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

/// Semantic types of the current plane.
enum SemanticPlaneLabel {
  /// Others.
  PLANE_OTHER,

  /// Wall.
  PLANE_WALL,

  /// Floor.
  PLANE_FLOOR,

  /// Seat.
  PLANE_SEAT,

  /// Table.
  PLANE_TABLE,

  /// Ceiling.
  PLANE_CEILING,
}

/// The plane type.
enum PlaneType {
  /// A horizontal plane facing up (such as the ground and desk platform).
  HORIZONTAL_UPWARD_FACING,

  /// A horizontal plane facing down (such as the ceiling).
  HORIZONTAL_DOWNWARD_FACING,

  /// A vertical plane.
  VERTICAL_FACING,

  /// Unsupported type.
  UNKNOWN_FACING,
}

/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_ar;

class ARPlane implements ARTrackableBase {
  final ARPose? centerPose;

  final double? extentX;
  final double? extentZ;

  final List<double> planePolygon;
  final SemanticPlaneLabel label;
  final PlaneType type;

  @override
  final List<ARAnchor>? anchors;
  @override
  final TrackingState? trackingState;

  ARPlane._({
    required this.type,
    required this.label,
    required this.planePolygon,
    this.centerPose,
    this.extentX,
    this.extentZ,
    this.anchors,
    this.trackingState,
  });

  factory ARPlane.fromMap(Map<String, dynamic> jsonMap) {
    return ARPlane._(
      centerPose: jsonMap['centerPose'] != null
          ? ARPose.fromMap(jsonMap['centerPose'])
          : null,
      extentX: jsonMap['extentX'],
      extentZ: jsonMap['extentZ'],
      planePolygon: List<double>.from(
        jsonMap['planePolygon'].map((dynamic x) => x.toDouble()),
      ),
      label: SemanticPlaneLabel.values[jsonMap['label']],
      trackingState: jsonMap['trackingState'] != null
          ? TrackingState.values[jsonMap['trackingState']]
          : null,
      anchors: jsonMap['anchors'] != null
          ? List<ARAnchor>.from(
              jsonMap['anchors'].map((dynamic x) => ARAnchor.fromMap(x)),
            )
          : null,
      type: PlaneType.values[jsonMap['type']],
    );
  }

  factory ARPlane.fromJSON(String json) {
    return ARPlane.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> arPlaneMap = <String, dynamic>{};
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

  /// Door.
  PLANE_DOOR,

  /// Window.
  PLANE_WINDOW,

  /// Bed.
  PLANE_BED,
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

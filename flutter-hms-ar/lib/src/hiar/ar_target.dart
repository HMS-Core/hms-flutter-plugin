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

class ARTarget implements ARTrackableBase {
  @override
  final List<ARAnchor>? anchors;
  @override
  final TrackingState? trackingState;

  final ARPose? centerPose;
  final List<double>? axisAlignBoundingBox;
  final double? radius;
  final TargetLabel targetLabel;
  final TargetShapeType targetShapeType;

  ARTarget._({
    required this.targetLabel,
    required this.targetShapeType,
    this.axisAlignBoundingBox,
    this.anchors,
    this.trackingState,
    this.centerPose,
    this.radius,
  });

  factory ARTarget.fromMap(Map<String, dynamic> jsonMap) {
    return ARTarget._(
      anchors: jsonMap['anchors'] != null
          ? List<ARAnchor>.from(
              jsonMap['anchors'].map((dynamic x) => ARAnchor.fromMap(x)),
            )
          : null,
      trackingState: jsonMap['trackingState'] != null
          ? TrackingState.values[jsonMap['trackingState']]
          : null,
      axisAlignBoundingBox: jsonMap['axisAlignBoundingBox'] != null
          ? List<double>.from(
              jsonMap['axisAlignBoundingBox'].map((dynamic x) => x.toDouble()),
            )
          : null,
      centerPose: jsonMap['centerPose'] != null
          ? ARPose.fromMap(jsonMap['centerPose'])
          : null,
      radius: jsonMap['radius'],
      targetLabel: TargetLabel.values[jsonMap['targetLabel'] + 1],
      targetShapeType: TargetShapeType.values[jsonMap['targetShapeType'] + 1],
    );
  }

  factory ARTarget.fromJSON(String json) {
    return ARTarget.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'anchors': anchors,
      'trackingState': trackingState,
      'axisAlignBoundingBox': axisAlignBoundingBox,
      'centerPose': centerPose,
      'radius': radius,
      'targetLabel': targetLabel,
      'targetShapeType': targetShapeType,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

/// Label of the recognized target object.
enum TargetLabel {
  /// The currently recognized label is invalid.
  TARGET_INVALID,

  /// The currently recognized label is valid as another type.
  TARGET_OTHER,

  /// The currently recognized label is a seat.
  TARGET_SEAT,

  /// The currently recognized label is a chair.
  TARGET_TABLE,
}

/// Shape of the recognized target object.
enum TargetShapeType {
  /// The currently recognized shape is invalid.
  TARGET_SHAPE_INVALID,

  /// The currently recognized shape is valid as another shape.
  TARGET_SHAPE_OTHER,

  /// The currently recognized shape is a cube.
  TARGET_SHAPE_CUBE,

  /// The currently recognized shape is a circle.
  TARGET_SHAPE_CIRCLE,

  /// The currently recognized shape is a rectangle.
  TARGET_SHAPE_RECT,
}

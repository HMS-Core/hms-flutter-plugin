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

class ARBody implements ARTrackableBase {
  final int bodyAction;

  @override
  final List<ARAnchor>? anchors;
  @override
  final TrackingState? trackingState;

  final List<ARBodySkeletonType> bodySkeletonTypes;
  final List<double> skeletonPoint2D;
  final List<double> skeletonPoint3D;
  final List<double> skeletonConfidence;
  final List<int> bodySkeletonConnection;
  final List<bool> skeletonPointIsExist2D;
  final List<bool> skeletonPointIsExist3D;
  final ARCoordinateSystemType coordinateSystemType;

  ARBody._({
    required this.coordinateSystemType,
    required this.bodySkeletonTypes,
    required this.skeletonPointIsExist2D,
    required this.skeletonPointIsExist3D,
    required this.bodyAction,
    required this.skeletonConfidence,
    required this.skeletonPoint2D,
    required this.skeletonPoint3D,
    required this.bodySkeletonConnection,
    this.anchors,
    this.trackingState,
  });

  factory ARBody.fromMap(Map<String, dynamic> jsonMap) {
    return ARBody._(
        bodyAction: jsonMap['bodyAction'],
        anchors: jsonMap['anchors'] != null
            ? List<ARAnchor>.from(
                jsonMap['anchors'].map((dynamic x) => ARAnchor.fromMap(x)),
              )
            : null,
        trackingState: jsonMap['trackingState'] != null
            ? TrackingState.values[jsonMap['trackingState']]
            : null,
        bodySkeletonTypes: List<ARBodySkeletonType>.from(
          jsonMap['bodySkeletonTypes']
              .map((dynamic x) => ARBodySkeletonType.values[x]),
        ),
        skeletonPoint2D: List<double>.from(
          jsonMap['skeletonPoint2D'].map((dynamic x) => x.toDouble()),
        ),
        skeletonPoint3D: List<double>.from(
          jsonMap['skeletonPoint3D'].map((dynamic x) => x.toDouble()),
        ),
        skeletonConfidence: List<double>.from(
          jsonMap['skeletonConfidence'].map((dynamic x) => x.toDouble()),
        ),
        bodySkeletonConnection: List<int>.from(
          jsonMap['bodySkeletonConnection'].map((dynamic x) => x),
        ),
        skeletonPointIsExist2D: List<bool>.from(
          jsonMap['skeletonPointIsExist2D']
              .map((dynamic x) => x == 1 ? true : false),
        ),
        skeletonPointIsExist3D: List<bool>.from(
          jsonMap['skeletonPointIsExist3D']
              .map((dynamic x) => x == 1 ? true : false),
        ),
        coordinateSystemType:
            ARCoordinateSystemType.values[jsonMap['coordinateSystemType'] + 1]);
  }

  factory ARBody.fromJSON(String json) {
    return ARBody.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bodyAction': bodyAction,
      'trackingState': trackingState,
      'anchors': anchors.toString(),
      'bodySkeletonTypes': bodySkeletonTypes,
      'skeletonPoint2D': skeletonPoint2D,
      'skeletonPoint3D': skeletonPoint3D,
      'skeletonConfidence': skeletonConfidence,
      'bodySkeletonConnection': bodySkeletonConnection,
      'skeletonPointIsExist2D': skeletonPointIsExist2D,
      'skeletonPointIsExist3D': skeletonPointIsExist3D,
      'coordinateSystemType': coordinateSystemType,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

/// The body skeleton type.
enum ARBodySkeletonType {
  /// Unknown
  BodySkeleton_Unknown,

  /// Head.
  BodySkeleton_Head,

  /// Neck.
  BodySkeleton_Neck,

  /// Right shoulder.
  BodySkeleton_r_Sho,

  /// Right elbow.
  BodySkeleton_r_Elbow,

  /// Right wrist.
  BodySkeleton_r_Wrist,

  /// Left shoulder.
  BodySkeleton_l_Sho,

  /// Left elbow.
  BodySkeleton_l_Elbow,

  /// Left wrist.
  BodySkeleton_l_Wrist,

  /// Right hip joint.
  BodySkeleton_r_Hip,

  /// Right knee.
  BodySkeleton_r_Knee,

  /// Right ankle.
  BodySkeleton_r_Ankle,

  /// Left hip joint.
  BodySkeleton_l_Hip,

  /// Left knee.
  BodySkeleton_l_Knee,

  /// Left ankle.
  BodySkeleton_l_Ankle,

  /// Center of hip joint.
  BodySkeleton_Hip_mid,

  /// Right ear.
  BodySkeleton_r_ear,

  /// Right eye.
  BodySkeleton_r_eye,

  /// Nose.
  BodySkeleton_nose,

  /// Left eye.
  BodySkeleton_l_eye,

  /// Left ear.
  BodySkeleton_l_ear,

  /// Spine.
  BodySkeleton_spine,

  /// Right toe.
  BodySkeleton_r_toe,

  /// Left toe.
  BodySkeleton_l_toe,

  /// Number of joints, instead of a joint point.
  BodySkeleton_Length,
}

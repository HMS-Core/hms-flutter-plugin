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

import '../constants/constants.dart';
import 'ar_anchor.dart';
import 'ar_trackable_base.dart';

class ARBody implements ARTrackableBase {
  final int bodyAction;

  final List<ARAnchor> anchors;
  final TrackingState trackingState;

  final List<ARBodySkeletonType> bodySkeletonTypes;
  final List<double> skeletonPoint2D;
  final List<double> skeletonPoint3D;
  final List<double> skeletonConfidence;
  final List<int> bodySkeletonConnection;
  final List<bool> skeletonPointIsExist2D;
  final List<bool> skeletonPointIsExist3D;
  final ARCoordinateSystemType coordinateSystemType;

  ARBody._({
    this.bodyAction,
    this.anchors,
    this.trackingState,
    this.bodySkeletonTypes,
    this.skeletonPoint2D,
    this.skeletonPoint3D,
    this.skeletonPointIsExist2D,
    this.skeletonPointIsExist3D,
    this.skeletonConfidence,
    this.bodySkeletonConnection,
    this.coordinateSystemType,
  });

  factory ARBody.fromMap(Map<String, dynamic> jsonMap) {
    if (jsonMap == null) return null;
    return ARBody._(
      bodyAction: jsonMap['bodyAction'] != null ? jsonMap['bodyAction'] : null,
      anchors: jsonMap['anchors'] != null
          ? List<ARAnchor>.from(
              jsonMap['anchors'].map((x) => ARAnchor.fromMap(x)))
          : null,
      trackingState: jsonMap['trackingState'] != null
          ? TrackingState.values[jsonMap['trackingState']]
          : null,
      bodySkeletonTypes: jsonMap['bodySkeletonTypes'] != null
          ? List<ARBodySkeletonType>.from(jsonMap['bodySkeletonTypes']
              .map((x) => ARBodySkeletonType.values[x]))
          : null,
      skeletonPoint2D: jsonMap['skeletonPoint2D'] != null
          ? List<double>.from(
              jsonMap['skeletonPoint2D'].map((x) => x.toDouble()))
          : null,
      skeletonPoint3D: jsonMap['skeletonPoint3D'] != null
          ? List<double>.from(
              jsonMap['skeletonPoint3D'].map((x) => x.toDouble()))
          : null,
      skeletonConfidence: jsonMap['skeletonConfidence'] != null
          ? List<double>.from(
              jsonMap['skeletonConfidence'].map((x) => x.toDouble()))
          : null,
      bodySkeletonConnection: jsonMap['bodySkeletonConnection'] != null
          ? List<int>.from(jsonMap['bodySkeletonConnection'].map((x) => x))
          : null,
      skeletonPointIsExist2D: jsonMap['skeletonPointIsExist2D'] != null
          ? List<bool>.from(jsonMap['skeletonPointIsExist2D']
              .map((x) => x == 1 ? true : false))
          : null,
      skeletonPointIsExist3D: jsonMap['skeletonPointIsExist3D'] != null
          ? List<bool>.from(jsonMap['skeletonPointIsExist3D']
              .map((x) => x == 1 ? true : false))
          : null,
      coordinateSystemType: jsonMap['coordinateSystemType'] != null
          ? ARCoordinateSystemType.values[jsonMap['coordinateSystemType'] + 1]
          : null,
    );
  }

  factory ARBody.fromJSON(String json) {
    if (json == null) return null;
    return ARBody.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "bodyAction": bodyAction,
      "trackingState": trackingState,
      "anchors": anchors.toString(),
      "bodySkeletonTypes": bodySkeletonTypes,
      "skeletonPoint2D": skeletonPoint2D,
      "skeletonPoint3D": skeletonPoint3D,
      "skeletonConfidence": skeletonConfidence,
      "bodySkeletonConnection": bodySkeletonConnection,
      "skeletonPointIsExist2D": skeletonPointIsExist2D,
      "skeletonPointIsExist3D": skeletonPointIsExist3D,
      "coordinateSystemType": coordinateSystemType,
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

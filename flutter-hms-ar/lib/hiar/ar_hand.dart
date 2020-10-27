/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

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

class ARHand implements ARTrackableBase {
  final List<double> gestureHandBox;
  final List<double> gestureCenter;
  final List<double> handSkeletonArray;
  final List<int> handSkeletonConnection;
  final List<ARHandSkeletonType> handSkeletonTypes;
  final int gestureType;

  final ARHandType handType;
  final ARCoordinateSystemType gestureCoordinateSystem;
  final ARCoordinateSystemType skeletonCoordinateSystem;

  final List<ARAnchor> anchors;
  final TrackingState trackingState;

  ARHand._(
      {this.gestureType,
      this.handType,
      this.anchors,
      this.gestureCenter,
      this.gestureHandBox,
      this.handSkeletonArray,
      this.handSkeletonConnection,
      this.handSkeletonTypes,
      this.gestureCoordinateSystem,
      this.skeletonCoordinateSystem,
      this.trackingState});

  factory ARHand.fromMap(Map<String, dynamic> jsonMap) {
    if (jsonMap == null) return null;
    return ARHand._(
      gestureType:
          jsonMap['gestureType'] != null ? jsonMap['gestureType'] : null,
      handType: jsonMap['handType'] != null
          ? ARHandType.values[jsonMap['handType'] + 1]
          : null,
      anchors: jsonMap['anchors'] != null
          ? List<ARAnchor>.from(
              jsonMap['anchors'].map((x) => ARAnchor.fromMap(x)))
          : null,
      gestureHandBox: jsonMap['gestureHandBox'] != null
          ? List<double>.from(
              jsonMap['gestureHandBox'].map((x) => x.toDouble()))
          : null,
      gestureCenter: jsonMap['gestureCenter'] != null
          ? List<double>.from(jsonMap['gestureCenter'].map((x) => x.toDouble()))
          : null,
      handSkeletonArray: jsonMap['handSkeletonArray'] != null
          ? List<double>.from(
              jsonMap['handSkeletonArray'].map((x) => x.toDouble()))
          : null,
      handSkeletonConnection: jsonMap['handSkeletonConnection'] != null
          ? List<int>.from(jsonMap['handSkeletonConnection'].map((x) => x))
          : null,
      handSkeletonTypes: jsonMap['arHandSkeletonTypes'] != null
          ? List<ARHandSkeletonType>.from(jsonMap['arHandSkeletonTypes']
              .map((x) => ARHandSkeletonType.values[x + 1]))
          : null,
      gestureCoordinateSystem: jsonMap['gestureCoordinateSystem'] != null
          ? ARCoordinateSystemType
              .values[jsonMap['gestureCoordinateSystem'] + 1]
          : null,
      skeletonCoordinateSystem: jsonMap['skeletonCoordinateSystem'] != null
          ? ARCoordinateSystemType
              .values[jsonMap['skeletonCoordinateSystem'] + 1]
          : null,
      trackingState: jsonMap['trackingState'] != null
          ? TrackingState.values[jsonMap['trackingState']]
          : null,
    );
  }

  factory ARHand.fromJSON(String json) {
    if (json == null) return null;
    return ARHand.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> arHandMap = Map();
    arHandMap['gestureType'] = gestureType;
    arHandMap['arHandType'] = handType;
    arHandMap['anchors'] = anchors;
    arHandMap['gestureHandBox'] = gestureHandBox;
    arHandMap['gestureCenter'] = gestureCenter;
    arHandMap['handSkeletonArray'] = handSkeletonArray;
    arHandMap['handSkeletonConnection'] = handSkeletonConnection;
    arHandMap['handSkeletonTypes'] = handSkeletonTypes;
    arHandMap['gestureCoordinateSystem'] = gestureCoordinateSystem;
    arHandMap['skeletonCoordinateSystem'] = skeletonCoordinateSystem;
    arHandMap['trackingState'] = trackingState;
    return arHandMap;
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

/// The hand skeleton point.
enum ARHandSkeletonType {
  /// The root point of the hand bone, that is, the wrist.
  HANDSKELETON_ROOT,

  /// Pinky knuckle 1.
  HANDSKELETON_PINKY_1,

  /// Pinky knuckle 2.
  HANDSKELETON_PINKY_2,

  /// Pinky knuckle 3.
  HANDSKELETON_PINKY_3,

  /// Pinky knuckle tip.
  HANDSKELETON_PINKY_4,

  /// Ring finger knuckle 1.
  HANDSKELETON_RING_1,

  /// Ring finger knuckle 2.
  HANDSKELETON_RING_2,

  /// Ring finger knuckle 3.
  HANDSKELETON_RING_3,

  /// Ring finger tip.
  HANDSKELETON_RING_4,

  /// Middle finger knuckle 1.
  HANDSKELETON_MIDDLE_1,

  /// Middle finger knuckle 2.
  HANDSKELETON_MIDDLE_2,

  /// Middle finger knuckle 3.
  HANDSKELETON_MIDDLE_3,

  /// Middle finger tip.
  HANDSKELETON_MIDDLE_4,

  /// Index finger knuckle 1.
  HANDSKELETON_INDEX_1,

  /// Index finger knuckle 2.
  HANDSKELETON_INDEX_2,

  /// Index finger knuckle 3.
  HANDSKELETON_INDEX_3,

  /// Index finger tip.
  HANDSKELETON_INDEX_4,

  /// Thumb knuckle 1.
  HANDSKELETON_THUMB_1,

  /// Thumb knuckle 2.
  HANDSKELETON_THUMB_2,

  /// Thumb knuckle 3.
  HANDSKELETON_THUMB_3,

  /// Thumb tip.
  HANDSKELETON_THUMB_4,

  /// Number of knuckles.
  HANDSKELETON_LENGTH,
}

/// The type of hand, which can be left or right.
///
/// Index of this enum corresponds to the value+1 of the Native AREngine SDK.
enum ARHandType {
  AR_HAND_UNKNOWN,
  AR_HAND_RIGHT,
  AR_HAND_LEFT,
}

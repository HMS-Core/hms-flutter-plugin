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

import 'package:flutter/material.dart';

import 'ar_pose.dart';
import 'ar_trackable_base.dart';

/// Represents an anchor at a fixed location and a specified direction in an
/// actual environment. HUAWEI AR Engine continuously updates this value so that
/// the location and direction remains unchanged even when the environment changes,
/// for example, as the camera moves.
///
/// Before using methods in this class, call getTrackingState() to check the
/// anchor status. The data obtained through getPose() is valid only when the
/// anchor status is ARTrackable.TrackingState.TRACKING.
class ARAnchor {
  final ARPose arPose;
  final TrackingState trackingState;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final ARAnchor check = other;
    return other is ARAnchor &&
        check.arPose == arPose &&
        check.trackingState == trackingState;
  }

  ARAnchor._({this.trackingState, this.arPose});

  factory ARAnchor.fromMap(Map<String, dynamic> jsonMap) {
    if (jsonMap == null) return null;
    return ARAnchor._(
      arPose: jsonMap['arPose'] != null ? jsonMap['arPose'] : null,
      trackingState: jsonMap['trackingState'] != null
          ? TrackingState.values[jsonMap['trackingState']]
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "arPose": arPose.toString(),
      "trackingState": trackingState,
    };
  }

  @override
  int get hashCode => hashValues(arPose, trackingState);

  @override
  String toString() {
    return toMap().toString();
  }
}

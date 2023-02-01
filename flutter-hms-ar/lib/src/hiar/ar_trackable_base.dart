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

abstract class ARTrackableBase {
  final List<ARAnchor>? anchors;

  final TrackingState? trackingState;

  ARTrackableBase._({
    this.trackingState,
    this.anchors,
  });
}

/// The tracking status of the trackable object.
enum TrackingState {
  /// Unknown State
  UNKNOWN_STATE,

  /// Tracking status.
  TRACKING,

  /// Paused status.
  PAUSED,

  /// Stopped status.
  STOPPED,
}

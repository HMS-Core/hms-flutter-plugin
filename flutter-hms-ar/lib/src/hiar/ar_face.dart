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

class ARFace implements ARTrackableBase {
  @override
  final List<ARAnchor>? anchors;
  @override
  final TrackingState? trackingState;
  final ARPose? pose;
  final ARFaceBlendShapes? faceBlendShapes;
  final int? healthParameterCount;
  final Map<String, dynamic>? healthParameters;

  ARFace._({
    this.anchors,
    this.trackingState,
    this.pose,
    this.faceBlendShapes,
    this.healthParameterCount,
    this.healthParameters,
  });

  factory ARFace.fromMap(Map<String, dynamic> jsonMap) {
    return ARFace._(
      anchors: jsonMap['anchors'] != null
          ? List<ARAnchor>.from(
              jsonMap['anchors'].map((dynamic x) => ARAnchor.fromMap(x)),
            )
          : null,
      faceBlendShapes: jsonMap['faceBlendShapes'] != null
          ? ARFaceBlendShapes.fromMap(jsonMap['faceBlendShapes'])
          : null,
      pose: jsonMap['pose'] != null ? ARPose.fromMap(jsonMap['pose']) : null,
      trackingState: jsonMap['trackingState'] != null
          ? TrackingState.values[jsonMap['trackingState']]
          : null,
      healthParameterCount: jsonMap['healthParameterCount'],
      healthParameters: jsonMap['healthParameters'] != null
          ? Map<String, dynamic>.from(jsonMap['healthParameters'])
          : null,
    );
  }

  factory ARFace.fromJSON(String json) {
    return ARFace.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'trackingState': trackingState,
      'pose': pose?.toMap(),
      'anchors': anchors,
      'arFaceBlendingShapes': faceBlendShapes?.toMap(),
      'healthParameterCount': healthParameterCount,
      'healthParameters': healthParameters,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

/// The health check parameters.
enum HealthParameter {
  /// Unknown parameter type.
  UNKNOWN_TYPE,

  /// Invalid parameter type.
  PARAMETER_INVALID,

  /// Heart rate.
  PARAMETER_HEART_RATE,

  /// Heart rate signal-to-noise ratio (SNR).
  PARAMETER_HEART_RATE_SNR,

  /// Confidence level of the heart rate value (0–1).
  PARAMETER_HEART_RATE_CONFIDENCE,

  /// Breath rate.
  PARAMETER_BREATH_RATE,

  /// Breath rate signal SNR.
  PARAMETER_BREATH_RATE_SNR,

  /// Confidence level of the breath rate value (0–1).
  PARAMETER_BREATH_RATE_CONFIDENCE,

  /// Facial attribute: age.
  PARAMETER_FACE_AGE,

  /// Facial attribute: Weight of male (0–1).
  PARAMETER_GENDER_MALE_WEIGHT,

  /// Facial attribute: Weight of female (0–1).
  PARAMETER_GENDER_FEMALE_WEIGHT,

  /// Heart rate waveform signal.
  PARAMETER_HEART_WAVE,
}

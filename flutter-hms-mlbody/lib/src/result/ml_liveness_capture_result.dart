/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of '../../huawei_ml_body.dart';

class MLLivenessCaptureResult {
  final Uint8List? bitmap;
  final bool? isLive;
  final double? score;
  final double? pitch;
  final double? roll;
  final double? yaw;

  const MLLivenessCaptureResult._({
    this.score,
    this.bitmap,
    this.pitch,
    this.roll,
    this.yaw,
    this.isLive,
  });

  factory MLLivenessCaptureResult.fromJson(Map<dynamic, dynamic> json) {
    return MLLivenessCaptureResult._(
      bitmap: json['bitmap'],
      isLive: json['isLive'],
      score: json['score'],
      pitch: json['pitch'],
      roll: json['roll'],
      yaw: json['yaw'],
    );
  }
}

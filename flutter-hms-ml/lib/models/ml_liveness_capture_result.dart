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

class MLLivenessCaptureResult {
  String bitmap;
  bool isLive;
  double score;
  double pitch;
  double roll;
  double yaw;

  MLLivenessCaptureResult(
      {this.score, this.bitmap, this.pitch, this.roll, this.yaw, this.isLive});

  factory MLLivenessCaptureResult.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return MLLivenessCaptureResult(
        bitmap: map['bitmap'] ?? null,
        isLive: map['isLive'] ?? null,
        score: map['score'] ?? null,
        pitch: map['pitch'] ?? null,
        roll: map['roll'] ?? null,
        yaw: map['yaw'] ?? null);
  }
}

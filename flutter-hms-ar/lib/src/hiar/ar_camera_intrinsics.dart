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

class ARCameraIntrinsics {
  final List<double> distortions;
  final List<double> focalLength;
  final List<double> principalPoint;
  final List<int> imageDimensions;

  ARCameraIntrinsics._({
    required this.distortions,
    required this.focalLength,
    required this.principalPoint,
    required this.imageDimensions,
  });

  factory ARCameraIntrinsics.fromMap(Map<String, dynamic> jsonMap) {
    return ARCameraIntrinsics._(
      distortions: List<double>.from(
        jsonMap['distortions'].map((dynamic x) => x.toDouble()),
      ),
      focalLength: List<double>.from(
        jsonMap['focalLength'].map((dynamic x) => x.toDouble()),
      ),
      principalPoint: List<double>.from(
        jsonMap['principalPoint'].map((dynamic x) => x.toDouble()),
      ),
      imageDimensions: List<int>.from(
        jsonMap['imageDimensions'].map((dynamic x) => x),
      ),
    );
  }

  factory ARCameraIntrinsics.fromJSON(String json) {
    return ARCameraIntrinsics.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'distortions': distortions,
      'focalLength': focalLength,
      'imageDimensions': imageDimensions,
      'principalPoint': principalPoint,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

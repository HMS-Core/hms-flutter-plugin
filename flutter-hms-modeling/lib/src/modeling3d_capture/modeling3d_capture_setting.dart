/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of modeling3d_capture;

/// Configuration of real-time guide.
class Modeling3dCaptureSetting {
  /// The number of boxes at each layer of the bounding hemisphere.
  final int azimuthNum;

  /// The number of layers of the bounding hemisphere.
  final int latitudeNum;

  /// The radius of the bounding hemisphere.
  final double radius;

  const Modeling3dCaptureSetting({
    this.azimuthNum = 20,
    this.latitudeNum = 2,
    this.radius = 3.0,
  });

  Map<String, dynamic> _toMap() {
    return <String, dynamic>{
      'azimuthNum': azimuthNum,
      'latitudeNum': latitudeNum,
      'radius': radius,
    };
  }
}

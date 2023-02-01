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

class ARCameraConfig {
  final String imageDimensions;
  final String textureDimensions;

  ARCameraConfig._({
    required this.imageDimensions,
    required this.textureDimensions,
  });

  factory ARCameraConfig.fromMap(Map<String, dynamic> jsonMap) {
    return ARCameraConfig._(
      imageDimensions: jsonMap['imageDimensions'],
      textureDimensions: jsonMap['textureDimensions'],
    );
  }

  factory ARCameraConfig.fromJSON(String json) {
    return ARCameraConfig.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageDimensions': imageDimensions,
      'textureDimensions': textureDimensions,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

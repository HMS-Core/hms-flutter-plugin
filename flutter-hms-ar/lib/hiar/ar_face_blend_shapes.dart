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

class ARFaceBlendShapes {
  final Map<String, dynamic> blendShapeDataMap;
  final List<double> blendShapeData;
  final List<String> blendShapeType;
  final int blendShapeCount;

  ARFaceBlendShapes._(
      {this.blendShapeCount,
      this.blendShapeData,
      this.blendShapeType,
      this.blendShapeDataMap});

  factory ARFaceBlendShapes.fromMap(Map<String, dynamic> jsonMap) {
    if (jsonMap == null) return null;
    return ARFaceBlendShapes._(
        blendShapeDataMap: jsonMap['blendShapeDataMap'] != null
            ? Map<String, dynamic>.from(jsonMap['blendShapeDataMap'])
            : null,
        blendShapeData: jsonMap['blendShapeData'] != null
            ? List<double>.from(
                jsonMap['blendShapeData'].map((x) => x.toDouble()))
            : null,
        blendShapeType: jsonMap['blendShapeType'] != null
            ? List<String>.from(jsonMap['blendShapeType'].map((x) => x))
            : null,
        blendShapeCount: jsonMap['blendShapeCount'] != null
            ? jsonMap['blendShapeCount']
            : null);
  }

  factory ARFaceBlendShapes.fromJSON(String json) {
    if (json == null) return null;
    return ARFaceBlendShapes.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "blendShapeDataMap": blendShapeDataMap,
      "blendShapeData": blendShapeData,
      "blendShapeType": blendShapeType,
      "blendShapeCount": blendShapeCount,
    };
  }
}

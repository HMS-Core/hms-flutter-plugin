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

class ARSceneMesh {
  int sceneDepthHeight;
  int sceneDepthWidth;
  final List<double>? sceneDepth;
  final List<double> triangleIndices;
  final List<double> vertexNormals;
  final List<double> vertices;

  ARSceneMesh._({
    required this.sceneDepthHeight,
    required this.sceneDepthWidth,
    required this.triangleIndices,
    required this.vertexNormals,
    required this.vertices,
    this.sceneDepth,
  });

  factory ARSceneMesh.fromMap(Map<String, dynamic> jsonMap) {
    return ARSceneMesh._(
      sceneDepthHeight: jsonMap['sceneDepthHeight'],
      sceneDepthWidth: jsonMap['sceneDepthWidth'],
      triangleIndices: List<double>.from(
          jsonMap['triangleIndices'].map((dynamic x) => x.toDouble())),
      vertexNormals: List<double>.from(
          jsonMap['vertexNormals'].map((dynamic x) => x.toDouble())),
      vertices: List<double>.from(
          jsonMap['vertices'].map((dynamic x) => x.toDouble())),
      sceneDepth: jsonMap['sceneDepth'] != null
          ? List<double>.from(
              jsonMap['sceneDepth'].map((dynamic x) => x.toDouble()),
            )
          : null,
    );
  }

  factory ARSceneMesh.fromJSON(String json) {
    return ARSceneMesh.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sceneDepthHeight': sceneDepthHeight,
      'sceneDepthWidth': sceneDepthWidth,
      'triangleIndices': triangleIndices,
      'vertexNormals': vertexNormals,
      'vertices': vertices,
      'sceneDepth': sceneDepth,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

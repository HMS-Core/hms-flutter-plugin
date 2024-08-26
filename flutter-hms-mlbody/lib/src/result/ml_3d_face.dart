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

class ML3DFace {
  static const int landmarkFive = 0;

  final List<BodyPosition> allVertexes;
  final double eulerX;
  final double eulerY;
  final double eulerZ;

  const ML3DFace._({
    required this.allVertexes,
    required this.eulerX,
    required this.eulerY,
    required this.eulerZ,
  });

  factory ML3DFace.fromMap(Map<dynamic, dynamic> map) {
    final List<BodyPosition> points = <BodyPosition>[];

    if (map['allVertexes'] != null) {
      map['allVertexes'].forEach((dynamic v) {
        points.add(BodyPosition.fromMap(v));
      });
    }
    return ML3DFace._(
      eulerX: map['eulerX'],
      eulerY: map['eulerY'],
      eulerZ: map['eulerZ'],
      allVertexes: points,
    );
  }
}

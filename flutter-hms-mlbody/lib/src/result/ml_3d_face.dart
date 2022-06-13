/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:huawei_ml_body/src/result/body_position.dart';

class ML3DFace {
  static const int landmarkFive = 0;

  List<BodyPosition?> allVertexes;
  dynamic eulerX;
  dynamic eulerY;
  dynamic eulerZ;

  ML3DFace({required this.allVertexes, this.eulerX, this.eulerY, this.eulerZ});

  factory ML3DFace.fromMap(Map<dynamic, dynamic> map) {
    var points = List<BodyPosition>.empty(growable: true);

    if (map['allVertexes'] != null) {
      map['allVertexes'].forEach((v) {
        points.add(BodyPosition.fromMap(v));
      });
    }

    return ML3DFace(
        eulerX: map['eulerX'],
        eulerY: map['eulerY'],
        eulerZ: map['eulerZ'],
        allVertexes: points);
  }
}

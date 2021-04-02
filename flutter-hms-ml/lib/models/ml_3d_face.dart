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

import 'package:huawei_ml/models/ml_face.dart';

class ML3DFace {
  static const int LANDMARK_FIVE = 0;

  List<Points> allVertexes;
  dynamic eulerX;
  dynamic eulerY;
  dynamic eulerZ;

  ML3DFace({this.allVertexes, this.eulerX, this.eulerY, this.eulerZ});

  ML3DFace.fromJson(Map<String, dynamic> json) {
    if (json['allVertexes'] != null) {
      allVertexes = new List<Points>();
      json['allVertexes'].forEach((v) {
        allVertexes.add(new Points.fromJson(v));
      });
    }
    eulerX = json['eulerX'] ?? null;
    eulerY = json['eulerY'] ?? null;
    eulerZ = json['eulerZ'] ?? null;
  }
}

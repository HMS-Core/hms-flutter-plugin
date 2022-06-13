/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'dart:typed_data';

import 'package:huawei_map/constants/param.dart';

class Tile {
  int x;
  int y;
  int zoom;
  Uint8List imageData;

  Tile({
    required this.x,
    required this.y,
    required this.zoom,
    required this.imageData,
  });

  Map<String, dynamic> toJson() => {
        Param.x: x,
        Param.y: y,
        Param.zoom: zoom,
        Param.imageData: imageData,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is Tile &&
        this.x == other.x &&
        this.y == other.y &&
        this.zoom == other.zoom &&
        this.imageData == other.imageData;
  }

  @override
  int get hashCode =>
      x.hashCode ^ y.hashCode ^ zoom.hashCode ^ imageData.hashCode;
}

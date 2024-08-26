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

class BodyPosition {
  final double? x;
  final double? y;
  final double? z;

  const BodyPosition._({
    required this.x,
    required this.y,
    required this.z,
  });

  factory BodyPosition.fromMap(Map<dynamic, dynamic> map) {
    return BodyPosition._(
      x: map['x'],
      y: map['y'],
      z: map['z'],
    );
  }
}

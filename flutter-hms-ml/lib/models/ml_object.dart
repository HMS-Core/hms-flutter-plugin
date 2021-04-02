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

import 'ml_border.dart';

class MLObject {
  /// Object type 0: others
  static const int TYPE_OTHER = 0;

  /// Object type 1: goods
  static const int TYPE_GOODS = 1;

  /// Object type 2: food
  static const int TYPE_FOOD = 2;

  /// Object type 3: furniture
  static const int TYPE_FURNITURE = 3;

  /// Object type 4: plants
  static const int TYPE_PLANT = 4;

  /// Object type 5: places
  static const int TYPE_PLACE = 5;

  /// Object type 6: faces
  static const int TYPE_FACE = 6;

  MLBorder border;
  dynamic possibility;
  int type;
  int tracingIdentity;

  MLObject({this.border, this.possibility, this.type});

  MLObject.fromJson(Map<String, dynamic> json) {
    border =
        json['border'] != null ? new MLBorder.fromJson(json['border']) : null;
    possibility = json['possibility'];
    type = json['type'];
    tracingIdentity = json['tracingIdentity'];
  }
}

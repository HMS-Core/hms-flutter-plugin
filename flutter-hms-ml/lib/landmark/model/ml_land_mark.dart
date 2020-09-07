/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'package:huawei_ml/utils/ml_border.dart';

class MlLandmark {
  MlBorder border;
  String landmark;
  String landmarkIdentity;
  dynamic possibility;
  Position position;

  MlLandmark(
      {this.border,
      this.landmark,
      this.landmarkIdentity,
      this.possibility,
      this.position});

  MlLandmark.fromJson(Map<String, dynamic> json) {
    border =
        json['border'] != null ? new MlBorder.fromJson(json['border']) : null;
    landmark = json['landmark'] ?? null;
    landmarkIdentity = json['landmarkIdentity'] ?? null;
    possibility = json['possibility'] ?? null;
    position = json['position'] != null
        ? new Position.fromJson(json['position'])
        : null;
  }
}

class Position {
  dynamic lat;
  dynamic lng;

  Position({this.lat, this.lng});

  Position.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] ?? null;
    lng = json['lng'] ?? null;
  }
}

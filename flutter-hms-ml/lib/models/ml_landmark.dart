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

class MLLandmark {
  MLBorder border;
  String landmark;
  String landmarkId;
  List<PositionInfo> positionInfos;
  dynamic possibility;

  MLLandmark(
      {this.border,
      this.landmark,
      this.landmarkId,
      this.positionInfos,
      this.possibility});

  MLLandmark.fromJson(Map<String, dynamic> json) {
    border =
        json['border'] != null ? new MLBorder.fromJson(json['border']) : null;
    landmark = json['landmark'] ?? null;
    landmarkId = json['landmarkIdentity'] ?? null;
    if (json['positionInfos'] != null) {
      positionInfos = new List<PositionInfo>();
      json['positionInfos'].forEach((v) {
        positionInfos.add(new PositionInfo.fromJson(v));
      });
    }
    possibility = json['possibility'] ?? null;
  }
}

class PositionInfo {
  double lat;
  double lng;

  PositionInfo({this.lat, this.lng});

  PositionInfo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }
}

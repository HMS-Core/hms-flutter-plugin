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

import 'ml_border.dart';

class MLRemoteLandmark {
  List<MLCoordinate?> positionInfos;
  MLImageBorder? border;
  String? landmark;
  String? landmarkId;
  dynamic possibility;

  MLRemoteLandmark(
      {required this.positionInfos,
      this.border,
      this.landmark,
      this.landmarkId,
      this.possibility});

  factory MLRemoteLandmark.fromMap(Map<dynamic, dynamic> map) {
    var positions = List<MLCoordinate>.empty(growable: true);

    if (map['positionInfos'] != null) {
      map['positionInfos'].forEach((v) {
        positions.add(MLCoordinate.fromMap(v));
      });
    }

    return MLRemoteLandmark(
      border: map['border'] != null
          ? new MLImageBorder.fromMap(map['border'])
          : null,
      landmark: map['landmark'] ?? null,
      landmarkId: map['landmarkIdentity'] ?? null,
      possibility: map['possibility'] ?? null,
      positionInfos: positions,
    );
  }
}

class MLCoordinate {
  double? lat;
  double? lng;

  MLCoordinate({this.lat, this.lng});

  factory MLCoordinate.fromMap(Map<dynamic, dynamic> map) {
    return MLCoordinate(lat: map['lat'] ?? null, lng: map['lng'] ?? null);
  }
}

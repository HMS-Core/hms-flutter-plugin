/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_ml_image;

class MLRemoteLandmark {
  final List<MLCoordinate> positionInfos;
  final MLImageBorder? border;
  final String? landmark;
  final String? landmarkId;
  final dynamic possibility;

  const MLRemoteLandmark._({
    required this.positionInfos,
    this.border,
    this.landmark,
    this.landmarkId,
    this.possibility,
  });

  factory MLRemoteLandmark.fromMap(Map<dynamic, dynamic> map) {
    final List<MLCoordinate> positions = <MLCoordinate>[];

    if (map['positionInfos'] != null) {
      map['positionInfos'].forEach((dynamic v) {
        positions.add(MLCoordinate.fromMap(v));
      });
    }
    return MLRemoteLandmark._(
      border:
          map['border'] != null ? MLImageBorder.fromMap(map['border']) : null,
      landmark: map['landmark'],
      landmarkId: map['landmarkIdentity'],
      possibility: map['possibility'],
      positionInfos: positions,
    );
  }
}

class MLCoordinate {
  final double? lat;
  final double? lng;

  const MLCoordinate._({
    this.lat,
    this.lng,
  });

  factory MLCoordinate.fromMap(Map<dynamic, dynamic> map) {
    return MLCoordinate._(
      lat: map['lat'],
      lng: map['lng'],
    );
  }
}

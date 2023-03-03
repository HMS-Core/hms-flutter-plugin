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

import 'dart:convert';

import 'package:huawei_drive/src/model/metadata_location.dart';

class PictureMetadata {
  double? aperture;
  String? cameraMake;
  String? cameraModel;
  String? colorSpace;
  double? exposureBias;
  String? exposureMode;
  double? exposureTime;
  bool? flashUsed;
  double? focalLenght;
  int? height;
  int? isoSpeed;
  String? lens;
  MetadataLocation? location;
  double? maxApertureValue;
  String? meteringMode;
  String? sensor;
  int? subjectDistance;
  String? exifTime;
  String? whiteBalance;
  int? width;

  PictureMetadata({
    this.aperture,
    this.cameraMake,
    this.cameraModel,
    this.colorSpace,
    this.exposureBias,
    this.exposureMode,
    this.exposureTime,
    this.flashUsed,
    this.focalLenght,
    this.height,
    this.isoSpeed,
    this.lens,
    this.location,
    this.maxApertureValue,
    this.meteringMode,
    this.sensor,
    this.subjectDistance,
    this.exifTime,
    this.whiteBalance,
    this.width,
  });

  factory PictureMetadata.fromMap(Map<String, dynamic> map) {
    return PictureMetadata(
      aperture: map['aperture'],
      cameraMake: map['cameraMake'],
      cameraModel: map['cameraModel'],
      colorSpace: map['colorSpace'],
      exposureBias: map['exposureBias'],
      exposureMode: map['exposureMode'],
      exposureTime: map['exposureTime'],
      flashUsed: map['flashUsed'],
      focalLenght: map['focalLenght'],
      height: map['height'],
      isoSpeed: map['isoSpeed'],
      lens: map['lens'],
      location: map['location'] == null
          ? null
          : MetadataLocation.fromMap(map['location']),
      maxApertureValue: map['maxApertureValue'],
      meteringMode: map['meteringMode'],
      sensor: map['sensor'],
      subjectDistance: map['subjectDistance'],
      exifTime: map['exifTime'],
      whiteBalance: map['whiteBalance'],
      width: map['width'],
    );
  }

  factory PictureMetadata.fromJson(String source) =>
      PictureMetadata.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'aperture': aperture,
      'cameraMake': cameraMake,
      'cameraModel': cameraModel,
      'colorSpace': colorSpace,
      'exposureBias': exposureBias,
      'exposureMode': exposureMode,
      'exposureTime': exposureTime,
      'flashUsed': flashUsed,
      'focalLenght': focalLenght,
      'height': height,
      'isoSpeed': isoSpeed,
      'lens': lens,
      'location': location?.toMap(),
      'maxApertureValue': maxApertureValue,
      'meteringMode': meteringMode,
      'sensor': sensor,
      'subjectDistance': subjectDistance,
      'exifTime': exifTime,
      'whiteBalance': whiteBalance,
      'width': width,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'PictureMetadata(aperture: $aperture, cameraMake: $cameraMake, cameraModel: $cameraModel, colorSpace: $colorSpace, exposureBias: $exposureBias, exposureMode: $exposureMode, exposureTime: $exposureTime, flashUsed: $flashUsed, focalLenght: $focalLenght, height: $height, isoSpeed: $isoSpeed, lens: $lens, location: $location, maxApertureValue: $maxApertureValue, meteringMode: $meteringMode, sensor: $sensor, subjectDistance: $subjectDistance, exifTime: $exifTime, whiteBalance: $whiteBalance, width: $width)';
  }
}

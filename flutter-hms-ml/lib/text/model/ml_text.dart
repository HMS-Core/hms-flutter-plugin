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
import 'package:huawei_ml/utils/ml_coordinate_points.dart';

class MlText {
  String stringValue;
  MlTextBlock blocks;

  MlText({this.blocks, this.stringValue});

  MlText.fromJson(Map<String, dynamic> json) {
    stringValue = json['stringValue'] ?? null;
    blocks = json['blocks'] != null
        ? new MlTextBlock.fromJson(json['blocks'])
        : null;
  }
}

class MlTextBlock {
  MlTextContents contents;
  MlBorder border;
  MlCoordinatePoints vertexes;
  String stringValue;
  dynamic possibility;
  String language;
  List<dynamic> languageList;

  MlTextBlock(
      {this.vertexes,
      this.stringValue,
      this.language,
      this.border,
      this.contents,
      this.languageList,
      this.possibility});

  MlTextBlock.fromJson(Map<String, dynamic> json) {
    contents = json['contents'] != null
        ? new MlTextContents.fromJson(json['contents'])
        : null;
    border =
        json['border'] != null ? new MlBorder.fromJson(json['border']) : null;
    vertexes = json['vertexes'] != null
        ? new MlCoordinatePoints.fromJson(json['vertexes'])
        : null;
    stringValue = json['stringValue'] ?? null;
    possibility = json['possibility'] ?? null;
    language = json['language'] ?? null;
    languageList = json['languageList'] ?? null;
  }
}

class MlTextContents {
  MlBorder border;
  MlCoordinatePoints vertexes;
  Contents contents;
  String stringValue;
  dynamic rotationDegree;
  bool isVertical;
  String language;
  dynamic possibility;
  List<dynamic> languageList;

  MlTextContents(
      {this.stringValue,
      this.rotationDegree,
      this.isVertical,
      this.language,
      this.border,
      this.possibility,
      this.languageList,
      this.vertexes,
      this.contents});

  MlTextContents.fromJson(Map<String, dynamic> json) {
    border =
        json['border'] != null ? new MlBorder.fromJson(json['border']) : null;
    vertexes = json['vertexes'] != null
        ? new MlCoordinatePoints.fromJson(json['vertexes'])
        : null;
    contents = json['contents'] != null
        ? new Contents.fromJson(json['contents'])
        : null;
    stringValue = json['stringValue'] ?? null;
    rotationDegree = json['rotationDegree'].toDouble() ?? null;
    isVertical = json['isVertical'] ?? null;
    possibility = json['possibility'] ?? null;
    language = json['language'] ?? null;
    languageList = json['languageList'] ?? null;
  }
}

class Contents {
  MlBorder border;
  MlCoordinatePoints vertexes;
  String stringValue;
  String language;
  dynamic possibility;
  List<dynamic> languageList;

  Contents(
      {this.stringValue,
      this.border,
      this.language,
      this.possibility,
      this.languageList,
      this.vertexes});

  Contents.fromJson(Map<String, dynamic> json) {
    border =
        json['border'] != null ? new MlBorder.fromJson(json['border']) : null;
    vertexes = json['vertexes'] != null
        ? new MlCoordinatePoints.fromJson(json['vertexes'])
        : null;
    stringValue = json['stringValue'] ?? null;
    possibility = json['possibility'] ?? null;
    languageList = json['languageList'] ?? null;
    language = json['language'] ?? null;
  }
}

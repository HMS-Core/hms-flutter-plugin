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

class MlDocument {
  String stringValue;
  MlDocumentBlocks blocks;

  MlDocument({this.stringValue, this.blocks});

  MlDocument.fromJson(Map<String, dynamic> json) {
    stringValue = json['stringValue'] ?? null;
    blocks = json['blocks'] != null
        ? new MlDocumentBlocks.fromJson(json['blocks'])
        : null;
  }
}

class MlDocumentBlocks {
  String stringValue;
  dynamic possibility;
  MlBorder border;
  MlDocumentSections sections;
  MlDocumentInterval interval;

  MlDocumentBlocks(
      {this.stringValue,
      this.possibility,
      this.border,
      this.sections,
      this.interval});

  MlDocumentBlocks.fromJson(Map<String, dynamic> json) {
    stringValue = json['stringValue'] ?? null;
    possibility = json['possibility'] ?? null;
    border =
        json['border'] != null ? new MlBorder.fromJson(json['border']) : null;
    sections = json['sections'] != null
        ? new MlDocumentSections.fromJson(json['sections'])
        : null;
    interval = json['interval'] != null
        ? new MlDocumentInterval.fromJson(json['interval'])
        : null;
  }
}

class MlDocumentSections {
  String stringValue;
  MlBorder border;
  dynamic possibility;
  List<dynamic> languageList;
  MlDocumentLineList lineList;
  MlDocumentWordList wordList;
  MlDocumentInterval interval;

  MlDocumentSections(
      {this.stringValue,
      this.border,
      this.possibility,
      this.languageList,
      this.lineList,
      this.wordList,
      this.interval});

  MlDocumentSections.fromJson(Map<String, dynamic> json) {
    stringValue = json['stringValue'] ?? null;
    border =
        json['border'] != null ? new MlBorder.fromJson(json['border']) : null;
    possibility = json['possibility'];
    languageList = json['languageList'];
    lineList = json['lineList'] != null
        ? new MlDocumentLineList.fromJson(json['lineList'])
        : null;
    wordList = json['wordList'] != null
        ? new MlDocumentWordList.fromJson(json['wordList'])
        : null;
    interval = json['interval'] != null
        ? new MlDocumentInterval.fromJson(json['interval'])
        : null;
  }
}

class MlDocumentLineList {
  String stringValue;
  MlBorder border;
  dynamic possibility;
  List<dynamic> languageList;
  MlDocumentWordList wordList;
  MlCoordinatePoints points;
  MlDocumentInterval interval;

  MlDocumentLineList(
      {this.stringValue,
      this.border,
      this.possibility,
      this.languageList,
      this.wordList,
      this.points,
      this.interval});

  MlDocumentLineList.fromJson(Map<String, dynamic> json) {
    stringValue = json['stringValue'] ?? null;
    border =
        json['border'] != null ? new MlBorder.fromJson(json['border']) : null;
    possibility = json['possibility'];
    languageList = json['languageList'];
    wordList = json['wordList'] != null
        ? new MlDocumentWordList.fromJson(json['wordList'])
        : null;
    points = json['points'] != null
        ? new MlCoordinatePoints.fromJson(json['points'])
        : null;
    interval = json['interval'] != null
        ? new MlDocumentInterval.fromJson(json['interval'])
        : null;
  }
}

class MlDocumentWordList {
  String stringValue;
  MlBorder border;
  dynamic possibility;
  List<dynamic> languageList;
  MlDocumentCharacterList characterList;
  MlDocumentInterval interval;

  MlDocumentWordList(
      {this.stringValue,
      this.border,
      this.possibility,
      this.languageList,
      this.characterList,
      this.interval});

  MlDocumentWordList.fromJson(Map<String, dynamic> json) {
    stringValue = json['stringValue'] ?? null;
    border =
        json['border'] != null ? new MlBorder.fromJson(json['border']) : null;
    possibility = json['possibility'];
    languageList = json['languageList'];
    characterList = json['characterList'] != null
        ? new MlDocumentCharacterList.fromJson(json['characterList'])
        : null;
    interval = json['interval'] != null
        ? new MlDocumentInterval.fromJson(json['interval'])
        : null;
  }
}

class MlDocumentCharacterList {
  String stringValue;
  dynamic possibility;
  MlBorder border;
  List<dynamic> languageList;
  MlDocumentInterval interval;

  MlDocumentCharacterList(
      {this.stringValue,
      this.possibility,
      this.border,
      this.languageList,
      this.interval});

  MlDocumentCharacterList.fromJson(Map<String, dynamic> json) {
    stringValue = json['stringValue'] ?? null;
    possibility = json['possibility'] ?? null;
    border =
        json['border'] != null ? new MlBorder.fromJson(json['border']) : null;
    languageList = json['languageList'];
    interval = json['interval'] != null
        ? new MlDocumentInterval.fromJson(json['interval'])
        : null;
  }
}

class MlDocumentInterval {
  dynamic intervalType;
  bool isTextFollowed;

  MlDocumentInterval({this.intervalType, this.isTextFollowed});

  MlDocumentInterval.fromJson(Map<String, dynamic> json) {
    intervalType = json['intervalType'] ?? null;
    isTextFollowed = json['isTextFollowed'] ?? null;
  }
}

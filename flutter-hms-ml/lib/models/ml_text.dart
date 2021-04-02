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

import 'package:huawei_ml/models/ml_text_language.dart';

import 'ml_border.dart';
import 'ml_point.dart';

class MLText {
  String stringValue;
  List<Blocks> blocks;

  MLText({this.stringValue, this.blocks});

  MLText.fromJson(Map<String, dynamic> json) {
    stringValue = json['stringValue'];
    if (json['blocks'] != null) {
      blocks = new List<Blocks>();
      json['blocks'].forEach((v) {
        blocks.add(new Blocks.fromJson(v));
      });
    }
  }
}

class Blocks {
  MLBorder border;
  String stringValue;
  List<TextLines> textLines;
  List<MLPoint> vertexes;
  String language;
  List<MLTextLanguage> languageList;
  dynamic possibility;

  Blocks(
      {this.border,
      this.stringValue,
      this.textLines,
      this.vertexes,
      this.language,
      this.languageList,
      this.possibility});

  Blocks.fromJson(Map<String, dynamic> json) {
    border =
        json['border'] != null ? new MLBorder.fromJson(json['border']) : null;
    stringValue = json['stringValue'];
    if (json['textLines'] != null) {
      textLines = new List<TextLines>();
      json['textLines'].forEach((v) {
        textLines.add(new TextLines.fromJson(v));
      });
    }
    if (json['vertexes'] != null) {
      vertexes = new List<MLPoint>();
      json['vertexes'].forEach((v) {
        vertexes.add(new MLPoint.fromJson(v));
      });
    }
    language = json['language'];
    if (json['languageList'] != null) {
      languageList = new List<MLTextLanguage>();
      json['languageList'].forEach((v) {
        languageList.add(new MLTextLanguage.fromJson(v));
      });
    }
    possibility = json['possibility'];
  }
}

class TextLines {
  MLBorder border;
  String stringValue;
  bool isVertical;
  dynamic rotationDegree;
  List<Words> words;
  List<MLPoint> vertexes;
  String language;
  List<MLTextLanguage> languageList;
  dynamic possibility;

  TextLines(
      {this.border,
      this.stringValue,
      this.isVertical,
      this.rotationDegree,
      this.words,
      this.vertexes,
      this.language,
      this.languageList,
      this.possibility});

  TextLines.fromJson(Map<String, dynamic> json) {
    border =
        json['border'] != null ? new MLBorder.fromJson(json['border']) : null;
    stringValue = json['stringValue'];
    isVertical = json['isVertical'];
    rotationDegree = json['rotationDegree'];
    if (json['words'] != null) {
      words = new List<Words>();
      json['words'].forEach((v) {
        words.add(new Words.fromJson(v));
      });
    }
    if (json['vertexes'] != null) {
      vertexes = new List<MLPoint>();
      json['vertexes'].forEach((v) {
        vertexes.add(new MLPoint.fromJson(v));
      });
    }
    language = json['language'];
    if (json['languageList'] != null) {
      languageList = new List<MLTextLanguage>();
      json['languageList'].forEach((v) {
        languageList.add(new MLTextLanguage.fromJson(v));
      });
    }
    possibility = json['possibility'];
  }
}

class Words {
  MLBorder border;
  String stringValue;
  List<MLPoint> vertexes;
  String language;
  List<MLTextLanguage> languageList;
  dynamic possibility;

  Words(
      {this.border,
      this.stringValue,
      this.vertexes,
      this.language,
      this.languageList,
      this.possibility});

  Words.fromJson(Map<String, dynamic> json) {
    border =
        json['border'] != null ? new MLBorder.fromJson(json['border']) : null;
    stringValue = json['stringValue'];
    if (json['vertexes'] != null) {
      vertexes = new List<MLPoint>();
      json['vertexes'].forEach((v) {
        vertexes.add(new MLPoint.fromJson(v));
      });
    }
    language = json['language'];
    if (json['languageList'] != null) {
      languageList = new List<MLTextLanguage>();
      json['languageList'].forEach((v) {
        languageList.add(new MLTextLanguage.fromJson(v));
      });
    }
    possibility = json['possibility'];
  }
}

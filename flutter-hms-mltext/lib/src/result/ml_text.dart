/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:huawei_ml_text/src/result/text_border.dart';

import 'ml_point.dart';
import 'ml_text_language.dart';

class MLText {
  String? stringValue;
  List<TextBlock?> blocks;

  MLText({this.stringValue, required this.blocks});

  factory MLText.fromMap(Map<dynamic, dynamic> map) {
    var blockList = List<TextBlock>.empty(growable: true);
    if (map['blocks'] != null) {
      map['blocks'].forEach((v) {
        blockList.add(TextBlock.fromMap(v));
      });
    }

    return MLText(stringValue: map['stringValue'], blocks: blockList);
  }
}

class TextBlock {
  TextBorder? border;
  String? stringValue;
  List<TextLine?> textLines;
  List<MLPoint?> vertexes;
  String? language;
  List<MLTextLanguage?> languageList;
  dynamic possibility;

  TextBlock(
      {this.border,
      this.stringValue,
      required this.textLines,
      required this.vertexes,
      required this.languageList,
      this.language,
      this.possibility});

  factory TextBlock.fromMap(Map<dynamic, dynamic> map) {
    var lines = List<TextLine>.empty(growable: true);
    var vertexes = List<MLPoint>.empty(growable: true);
    var languageList = List<MLTextLanguage>.empty(growable: true);

    if (map['textLines'] != null) {
      map['textLines'].forEach((v) {
        lines.add(TextLine.fromMap(v));
      });
    }

    if (map['vertexes'] != null) {
      map['vertexes'].forEach((v) {
        vertexes.add(MLPoint.fromJson(v));
      });
    }

    if (map['languageList'] != null) {
      map['languageList'].forEach((v) {
        languageList.add(MLTextLanguage.fromJson(v));
      });
    }

    return TextBlock(
        border:
            map['border'] != null ? TextBorder.fromMap(map['border']) : null,
        stringValue: map['stringValue'],
        textLines: lines,
        vertexes: vertexes,
        languageList: languageList,
        language: map['language'],
        possibility: map['possibility']);
  }
}

class TextLine {
  TextBorder? border;
  String? stringValue;
  bool? isVertical;
  dynamic rotationDegree;
  List<TextWord?> words;
  List<MLPoint?> vertexes;
  String? language;
  List<MLTextLanguage?> languageList;
  dynamic possibility;

  TextLine(
      {this.border,
      this.stringValue,
      this.isVertical,
      this.rotationDegree,
      required this.words,
      required this.vertexes,
      required this.languageList,
      this.language,
      this.possibility});

  factory TextLine.fromMap(Map<dynamic, dynamic> map) {
    var words = List<TextWord>.empty(growable: true);
    var vertexes = List<MLPoint>.empty(growable: true);
    var languages = List<MLTextLanguage>.empty(growable: true);

    if (map['words'] != null) {
      map['words'].forEach((v) {
        words.add(TextWord.fromMap(v));
      });
    }

    if (map['vertexes'] != null) {
      map['vertexes'].forEach((v) {
        vertexes.add(MLPoint.fromJson(v));
      });
    }

    if (map['languageList'] != null) {
      map['languageList'].forEach((v) {
        languages.add(MLTextLanguage.fromJson(v));
      });
    }

    return TextLine(
        border:
            map['border'] != null ? TextBorder.fromMap(map['border']) : null,
        stringValue: map['stringValue'],
        isVertical: map['isVertical'],
        rotationDegree: map['rotationDegree'],
        words: words,
        vertexes: vertexes,
        languageList: languages,
        language: map['language'],
        possibility: map['possibility']);
  }
}

class TextWord {
  TextBorder? border;
  String? stringValue;
  List<MLPoint?> vertexes;
  String? language;
  List<MLTextLanguage?> languageList;
  dynamic possibility;

  TextWord(
      {this.border,
      this.stringValue,
      required this.vertexes,
      required this.languageList,
      this.language,
      this.possibility});

  factory TextWord.fromMap(Map<dynamic, dynamic> map) {
    var vertexes = List<MLPoint>.empty(growable: true);
    var languages = List<MLTextLanguage>.empty(growable: true);

    if (map['vertexes'] != null) {
      map['vertexes'].forEach((v) {
        vertexes.add(MLPoint.fromJson(v));
      });
    }

    if (map['languageList'] != null) {
      map['languageList'].forEach((v) {
        languages.add(MLTextLanguage.fromJson(v));
      });
    }

    return TextWord(
        border:
            map['border'] != null ? TextBorder.fromMap(map['border']) : null,
        stringValue: map['stringValue'],
        vertexes: vertexes,
        languageList: languages,
        language: map['language'],
        possibility: map['possibility']);
  }
}

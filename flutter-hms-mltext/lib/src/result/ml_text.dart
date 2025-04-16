/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of '../../huawei_ml_text.dart';

class MLText {
  List<TextBlock?> blocks;
  String? stringValue;

  MLText({
    required this.blocks,
    this.stringValue,
  });

  factory MLText.fromMap(Map<dynamic, dynamic> map) {
    final List<TextBlock> blockList = <TextBlock>[];

    if (map['blocks'] != null) {
      map['blocks'].forEach((dynamic v) {
        blockList.add(TextBlock.fromMap(v));
      });
    }
    return MLText(
      stringValue: map['stringValue'],
      blocks: blockList,
    );
  }
}

class TextBlock {
  List<TextLine?> textLines;
  List<MLPoint?> vertexes;
  List<MLTextLanguage?> languageList;
  TextBorder? border;
  String? stringValue;
  String? language;
  dynamic possibility;

  TextBlock({
    required this.textLines,
    required this.vertexes,
    required this.languageList,
    this.border,
    this.stringValue,
    this.language,
    this.possibility,
  });

  factory TextBlock.fromMap(Map<dynamic, dynamic> map) {
    final List<TextLine> lines = <TextLine>[];
    final List<MLPoint> vertexes = <MLPoint>[];
    final List<MLTextLanguage> languageList = <MLTextLanguage>[];

    if (map['textLines'] != null) {
      map['textLines'].forEach((dynamic v) {
        lines.add(TextLine.fromMap(v));
      });
    }
    if (map['vertexes'] != null) {
      map['vertexes'].forEach((dynamic v) {
        vertexes.add(MLPoint.fromJson(v));
      });
    }
    if (map['languageList'] != null) {
      map['languageList'].forEach((dynamic v) {
        languageList.add(MLTextLanguage.fromJson(v));
      });
    }
    return TextBlock(
      border: map['border'] != null ? TextBorder.fromMap(map['border']) : null,
      stringValue: map['stringValue'],
      textLines: lines,
      vertexes: vertexes,
      languageList: languageList,
      language: map['language'],
      possibility: map['possibility'],
    );
  }
}

class TextLine {
  List<TextWord?> words;
  List<MLPoint?> vertexes;
  List<MLTextLanguage?> languageList;
  TextBorder? border;
  String? stringValue;
  bool? isVertical;
  dynamic rotationDegree;
  String? language;
  dynamic possibility;

  TextLine({
    required this.words,
    required this.vertexes,
    required this.languageList,
    this.border,
    this.stringValue,
    this.isVertical,
    this.rotationDegree,
    this.language,
    this.possibility,
  });

  factory TextLine.fromMap(Map<dynamic, dynamic> map) {
    final List<TextWord> words = <TextWord>[];
    final List<MLPoint> vertexes = <MLPoint>[];
    final List<MLTextLanguage> languages = <MLTextLanguage>[];

    if (map['words'] != null) {
      map['words'].forEach((dynamic v) {
        words.add(TextWord.fromMap(v));
      });
    }
    if (map['vertexes'] != null) {
      map['vertexes'].forEach((dynamic v) {
        vertexes.add(MLPoint.fromJson(v));
      });
    }
    if (map['languageList'] != null) {
      map['languageList'].forEach((dynamic v) {
        languages.add(MLTextLanguage.fromJson(v));
      });
    }
    return TextLine(
      border: map['border'] != null ? TextBorder.fromMap(map['border']) : null,
      stringValue: map['stringValue'],
      isVertical: map['isVertical'],
      rotationDegree: map['rotationDegree'],
      words: words,
      vertexes: vertexes,
      languageList: languages,
      language: map['language'],
      possibility: map['possibility'],
    );
  }
}

class TextWord {
  List<MLPoint?> vertexes;
  List<MLTextLanguage?> languageList;
  TextBorder? border;
  String? stringValue;
  String? language;
  dynamic possibility;

  TextWord({
    required this.vertexes,
    required this.languageList,
    this.border,
    this.stringValue,
    this.language,
    this.possibility,
  });

  factory TextWord.fromMap(Map<dynamic, dynamic> map) {
    final List<MLPoint> vertexes = <MLPoint>[];
    final List<MLTextLanguage> languages = <MLTextLanguage>[];

    if (map['vertexes'] != null) {
      map['vertexes'].forEach((dynamic v) {
        vertexes.add(MLPoint.fromJson(v));
      });
    }
    if (map['languageList'] != null) {
      map['languageList'].forEach((dynamic v) {
        languages.add(MLTextLanguage.fromJson(v));
      });
    }
    return TextWord(
      border: map['border'] != null ? TextBorder.fromMap(map['border']) : null,
      stringValue: map['stringValue'],
      vertexes: vertexes,
      languageList: languages,
      language: map['language'],
      possibility: map['possibility'],
    );
  }
}

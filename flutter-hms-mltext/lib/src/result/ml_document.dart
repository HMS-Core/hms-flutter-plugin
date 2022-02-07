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

class MLDocument {
  String? stringValue;
  List<DocumentBlock?> blocks;

  MLDocument({this.stringValue, required this.blocks});

  factory MLDocument.fromMap(Map<dynamic, dynamic> map) {
    var blocks = List<DocumentBlock>.empty(growable: true);

    if (map['blocks'] != null) {
      map['blocks'].forEach((v) {
        blocks.add(DocumentBlock.fromMap(v));
      });
    }

    return MLDocument(blocks: blocks, stringValue: map['stringValue']);
  }
}

class DocumentBlock {
  TextBorder? border;
  String? stringValue;
  Interval? interval;
  List<MLTextLanguage?> languageList;
  dynamic possibility;
  List<DocumentSection?> sections;

  DocumentBlock(
      {this.border,
      this.stringValue,
      this.interval,
      required this.languageList,
      this.possibility,
      required this.sections});

  factory DocumentBlock.fromMap(Map<dynamic, dynamic> map) {
    var languages = List<MLTextLanguage>.empty(growable: true);
    var sections = List<DocumentSection>.empty(growable: true);

    if (map['languageList'] != null) {
      map['languageList'].forEach((v) {
        languages.add(MLTextLanguage.fromJson(v));
      });
    }

    if (map['sections'] != null) {
      map['sections'].forEach((v) {
        sections.add(DocumentSection.fromMap(v));
      });
    }

    return DocumentBlock(
        border:
            map['border'] != null ? TextBorder.fromMap(map['border']) : null,
        stringValue: map['stringValue'],
        interval:
            map['interval'] != null ? Interval.fromMap(map['interval']) : null,
        languageList: languages,
        possibility: map['possibility'],
        sections: sections);
  }
}

class Interval {
  static const int other = 5;
  static const int space = 6;
  static const int wideSpace = 7;
  static const int newLineCharacter = 8;
  static const int endOfLineHyphen = 9;
  static const int sessionInterval = 10;

  bool? isTextFollowed;
  int? type;

  Interval({this.isTextFollowed, this.type});

  factory Interval.fromMap(Map<dynamic, dynamic> map) {
    return Interval(isTextFollowed: map['isTextFollowed'], type: map['type']);
  }
}

class DocumentSection {
  TextBorder? border;
  String? stringValue;
  List<DocumentWord?> wordList;
  List<DocumentLine?> lineList;
  Interval? interval;
  List<MLTextLanguage?> languageList;
  dynamic possibility;

  DocumentSection(
      {this.border,
      this.stringValue,
      required this.wordList,
      required this.lineList,
      required this.languageList,
      this.interval,
      this.possibility});

  factory DocumentSection.fromMap(Map<dynamic, dynamic> map) {
    var words = List<DocumentWord>.empty(growable: true);
    var lines = List<DocumentLine>.empty(growable: true);
    var languages = List<MLTextLanguage>.empty(growable: true);

    if (map['wordList'] != null) {
      map['wordList'].forEach((v) {
        words.add(DocumentWord.fromMap(v));
      });
    }

    if (map['lineList'] != null) {
      map['lineList'].forEach((v) {
        lines.add(DocumentLine.fromMap(v));
      });
    }

    if (map['languageList'] != null) {
      map['languageList'].forEach((v) {
        languages.add(MLTextLanguage.fromJson(v));
      });
    }

    return DocumentSection(
        border:
            map['border'] != null ? TextBorder.fromMap(map['border']) : null,
        stringValue: map['stringValue'],
        wordList: words,
        lineList: lines,
        interval:
            map['interval'] != null ? Interval.fromMap(map['interval']) : null,
        languageList: languages,
        possibility: map['possibility']);
  }
}

class DocumentWord {
  TextBorder? border;
  String? stringValue;
  Interval? interval;
  List<MLTextLanguage?> languageList;
  List<DocumentCharacter?> characterList;
  dynamic possibility;

  DocumentWord(
      {this.border,
      this.stringValue,
      this.interval,
      required this.languageList,
      required this.characterList,
      this.possibility});

  factory DocumentWord.fromMap(Map<dynamic, dynamic> map) {
    var languages = List<MLTextLanguage>.empty(growable: true);
    var chars = List<DocumentCharacter>.empty(growable: true);

    if (map['languageList'] != null) {
      map['languageList'].forEach((v) {
        languages.add(MLTextLanguage.fromJson(v));
      });
    }

    if (map['characterList'] != null) {
      map['characterList'].forEach((v) {
        chars.add(DocumentCharacter.fromMap(v));
      });
    }

    return DocumentWord(
        border:
            map['border'] != null ? TextBorder.fromMap(map['border']) : null,
        stringValue: map['stringValue'],
        interval:
            map['interval'] != null ? Interval.fromMap(map['interval']) : null,
        languageList: languages,
        characterList: chars,
        possibility: map['possibility']);
  }
}

class DocumentCharacter {
  TextBorder? border;
  String? stringValue;
  List<MLTextLanguage?> languageList;
  dynamic possibility;
  Interval? interval;

  DocumentCharacter(
      {this.border,
      this.stringValue,
      required this.languageList,
      this.possibility,
      this.interval});

  factory DocumentCharacter.fromMap(Map<dynamic, dynamic> map) {
    var languages = List<MLTextLanguage>.empty(growable: true);

    if (map['languageList'] != null) {
      map['languageList'].forEach((v) {
        languages.add(MLTextLanguage.fromJson(v));
      });
    }

    return DocumentCharacter(
        border:
            map['border'] != null ? TextBorder.fromMap(map['border']) : null,
        stringValue: map['stringValue'],
        languageList: languages,
        interval:
            map['interval'] != null ? Interval.fromMap(map['interval']) : null,
        possibility: map['possibility']);
  }
}

class DocumentLine {
  TextBorder? border;
  String? stringValue;
  List<DocumentWord?> wordList;
  Interval? interval;
  List<MLTextLanguage?> languageList;
  dynamic possibility;
  List<MLPoint?> points;

  DocumentLine({
    this.border,
    this.stringValue,
    required this.wordList,
    required this.languageList,
    required this.points,
    this.interval,
    this.possibility,
  });

  factory DocumentLine.fromMap(Map<dynamic, dynamic> map) {
    var words = List<DocumentWord>.empty(growable: true);
    var languages = List<MLTextLanguage>.empty(growable: true);
    var points = List<MLPoint>.empty(growable: true);

    if (map['wordList'] != null) {
      map['wordList'].forEach((v) {
        words.add(DocumentWord.fromMap(v));
      });
    }

    if (map['languageList'] != null) {
      map['languageList'].forEach((v) {
        languages.add(MLTextLanguage.fromJson(v));
      });
    }

    if (map['points'] != null) {
      map['points'].forEach((v) {
        points.add(MLPoint.fromJson(v));
      });
    }

    return DocumentLine(
        border:
            map['border'] != null ? TextBorder.fromMap(map['border']) : null,
        stringValue: map['stringValue'],
        wordList: words,
        interval:
            map['interval'] != null ? Interval.fromMap(map['interval']) : null,
        languageList: languages,
        possibility: map['possibility'],
        points: points);
  }
}

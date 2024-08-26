/*
 * Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

part of '../../huawei_ml_text.dart';

class MLDocument {
  List<DocumentBlock?> blocks;
  String? stringValue;

  MLDocument({
    required this.blocks,
    this.stringValue,
  });

  factory MLDocument.fromMap(Map<dynamic, dynamic> map) {
    final List<DocumentBlock> blocks = <DocumentBlock>[];
    if (map['blocks'] != null) {
      map['blocks'].forEach((dynamic v) {
        blocks.add(DocumentBlock.fromMap(v));
      });
    }
    return MLDocument(
      blocks: blocks,
      stringValue: map['stringValue'],
    );
  }
}

class DocumentBlock {
  List<MLTextLanguage?> languageList;
  List<DocumentSection?> sections;
  TextBorder? border;
  String? stringValue;
  Interval? interval;
  dynamic possibility;

  DocumentBlock({
    required this.languageList,
    required this.sections,
    this.border,
    this.stringValue,
    this.interval,
    this.possibility,
  });

  factory DocumentBlock.fromMap(Map<dynamic, dynamic> map) {
    final List<MLTextLanguage> languages = <MLTextLanguage>[];
    final List<DocumentSection> sections = <DocumentSection>[];

    if (map['languageList'] != null) {
      map['languageList'].forEach((dynamic v) {
        languages.add(MLTextLanguage.fromJson(v));
      });
    }
    if (map['sections'] != null) {
      map['sections'].forEach((dynamic v) {
        sections.add(DocumentSection.fromMap(v));
      });
    }
    return DocumentBlock(
      border: map['border'] != null ? TextBorder.fromMap(map['border']) : null,
      stringValue: map['stringValue'],
      interval:
          map['interval'] != null ? Interval.fromMap(map['interval']) : null,
      languageList: languages,
      possibility: map['possibility'],
      sections: sections,
    );
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

  Interval({
    this.isTextFollowed,
    this.type,
  });

  factory Interval.fromMap(Map<dynamic, dynamic> map) {
    return Interval(
      isTextFollowed: map['isTextFollowed'],
      type: map['type'],
    );
  }
}

class DocumentSection {
  List<DocumentWord?> wordList;
  List<DocumentLine?> lineList;
  List<MLTextLanguage?> languageList;
  TextBorder? border;
  String? stringValue;
  Interval? interval;
  dynamic possibility;

  DocumentSection({
    required this.wordList,
    required this.lineList,
    required this.languageList,
    this.border,
    this.stringValue,
    this.interval,
    this.possibility,
  });

  factory DocumentSection.fromMap(Map<dynamic, dynamic> map) {
    final List<DocumentWord> words = <DocumentWord>[];
    final List<DocumentLine> lines = <DocumentLine>[];
    final List<MLTextLanguage> languages = <MLTextLanguage>[];

    if (map['wordList'] != null) {
      map['wordList'].forEach((dynamic v) {
        words.add(DocumentWord.fromMap(v));
      });
    }
    if (map['lineList'] != null) {
      map['lineList'].forEach((dynamic v) {
        lines.add(DocumentLine.fromMap(v));
      });
    }
    if (map['languageList'] != null) {
      map['languageList'].forEach((dynamic v) {
        languages.add(MLTextLanguage.fromJson(v));
      });
    }
    return DocumentSection(
      border: map['border'] != null ? TextBorder.fromMap(map['border']) : null,
      stringValue: map['stringValue'],
      wordList: words,
      lineList: lines,
      interval:
          map['interval'] != null ? Interval.fromMap(map['interval']) : null,
      languageList: languages,
      possibility: map['possibility'],
    );
  }
}

class DocumentWord {
  List<MLTextLanguage?> languageList;
  List<DocumentCharacter?> characterList;
  TextBorder? border;
  String? stringValue;
  Interval? interval;
  dynamic possibility;

  DocumentWord({
    required this.languageList,
    required this.characterList,
    this.border,
    this.stringValue,
    this.interval,
    this.possibility,
  });

  factory DocumentWord.fromMap(Map<dynamic, dynamic> map) {
    final List<MLTextLanguage> languages = <MLTextLanguage>[];
    final List<DocumentCharacter> chars = <DocumentCharacter>[];

    if (map['languageList'] != null) {
      map['languageList'].forEach((dynamic v) {
        languages.add(MLTextLanguage.fromJson(v));
      });
    }
    if (map['characterList'] != null) {
      map['characterList'].forEach((dynamic v) {
        chars.add(DocumentCharacter.fromMap(v));
      });
    }
    return DocumentWord(
      border: map['border'] != null ? TextBorder.fromMap(map['border']) : null,
      stringValue: map['stringValue'],
      interval:
          map['interval'] != null ? Interval.fromMap(map['interval']) : null,
      languageList: languages,
      characterList: chars,
      possibility: map['possibility'],
    );
  }
}

class DocumentCharacter {
  List<MLTextLanguage?> languageList;
  TextBorder? border;
  String? stringValue;
  dynamic possibility;
  Interval? interval;

  DocumentCharacter({
    required this.languageList,
    this.border,
    this.stringValue,
    this.possibility,
    this.interval,
  });

  factory DocumentCharacter.fromMap(Map<dynamic, dynamic> map) {
    final List<MLTextLanguage> languages = <MLTextLanguage>[];
    if (map['languageList'] != null) {
      map['languageList'].forEach((dynamic v) {
        languages.add(MLTextLanguage.fromJson(v));
      });
    }
    return DocumentCharacter(
      border: map['border'] != null ? TextBorder.fromMap(map['border']) : null,
      stringValue: map['stringValue'],
      languageList: languages,
      interval:
          map['interval'] != null ? Interval.fromMap(map['interval']) : null,
      possibility: map['possibility'],
    );
  }
}

class DocumentLine {
  List<DocumentWord?> wordList;
  List<MLTextLanguage?> languageList;
  List<MLPoint?> points;
  TextBorder? border;
  String? stringValue;
  Interval? interval;
  dynamic possibility;

  DocumentLine({
    required this.wordList,
    required this.languageList,
    required this.points,
    this.border,
    this.stringValue,
    this.interval,
    this.possibility,
  });

  factory DocumentLine.fromMap(Map<dynamic, dynamic> map) {
    final List<DocumentWord> words = <DocumentWord>[];
    final List<MLTextLanguage> languages = <MLTextLanguage>[];
    final List<MLPoint> points = <MLPoint>[];

    if (map['wordList'] != null) {
      map['wordList'].forEach((dynamic v) {
        words.add(DocumentWord.fromMap(v));
      });
    }
    if (map['languageList'] != null) {
      map['languageList'].forEach((dynamic v) {
        languages.add(MLTextLanguage.fromJson(v));
      });
    }
    if (map['points'] != null) {
      map['points'].forEach((dynamic v) {
        points.add(MLPoint.fromJson(v));
      });
    }
    return DocumentLine(
      border: map['border'] != null ? TextBorder.fromMap(map['border']) : null,
      stringValue: map['stringValue'],
      wordList: words,
      interval:
          map['interval'] != null ? Interval.fromMap(map['interval']) : null,
      languageList: languages,
      possibility: map['possibility'],
      points: points,
    );
  }
}

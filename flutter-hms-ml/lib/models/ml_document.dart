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

import 'package:huawei_ml/models/ml_point.dart';

import 'ml_border.dart';
import 'ml_text_language.dart';

class MLDocument {
  String stringValue;
  List<MLDocumentBlocks> blocks;

  MLDocument({this.stringValue, this.blocks});

  MLDocument.fromJson(Map<String, dynamic> json) {
    stringValue = json['stringValue'];
    if (json['blocks'] != null) {
      blocks = new List<MLDocumentBlocks>();
      json['blocks'].forEach((v) {
        blocks.add(new MLDocumentBlocks.fromJson(v));
      });
    }
  }
}

class MLDocumentBlocks {
  MLBorder border;
  String stringValue;
  Interval interval;
  List<MLTextLanguage> languageList;
  dynamic possibility;
  List<Sections> sections;

  MLDocumentBlocks(
      {this.border,
      this.stringValue,
      this.interval,
      this.languageList,
      this.possibility,
      this.sections});

  MLDocumentBlocks.fromJson(Map<String, dynamic> json) {
    border =
        json['border'] != null ? new MLBorder.fromJson(json['border']) : null;
    stringValue = json['stringValue'];
    interval = json['interval'] != null
        ? new Interval.fromJson(json['interval'])
        : null;
    if (json['languageList'] != null) {
      languageList = new List<MLTextLanguage>();
      json['languageList'].forEach((v) {
        languageList.add(new MLTextLanguage.fromJson(v));
      });
    }
    possibility = json['possibility'];
    if (json['sections'] != null) {
      sections = new List<Sections>();
      json['sections'].forEach((v) {
        sections.add(new Sections.fromJson(v));
      });
    }
  }
}

class Interval {
  static const int OTHER = 5;
  static const int SPACE = 6;
  static const int WIDE_SPACE = 7;
  static const int NEW_LINE_CHARACTER = 8;
  static const int END_OF_LINE_HYPHEN = 9;
  static const int SESSION_INTERVAL = 10;

  bool isTextFollowed;
  int type;

  Interval({this.isTextFollowed, this.type});

  Interval.fromJson(Map<String, dynamic> json) {
    isTextFollowed = json['isTextFollowed'];
    type = json['type'];
  }
}

class Sections {
  MLBorder border;
  String stringValue;
  List<WordList> wordList;
  List<LineList> lineList;
  Interval interval;
  List<MLTextLanguage> languageList;
  dynamic possibility;

  Sections(
      {this.border,
      this.stringValue,
      this.wordList,
      this.lineList,
      this.interval,
      this.languageList,
      this.possibility});

  Sections.fromJson(Map<String, dynamic> json) {
    border =
        json['border'] != null ? new MLBorder.fromJson(json['border']) : null;
    stringValue = json['stringValue'];
    if (json['wordList'] != null) {
      wordList = new List<WordList>();
      json['wordList'].forEach((v) {
        wordList.add(new WordList.fromJson(v));
      });
    }
    if (json['lineList'] != null) {
      lineList = new List<LineList>();
      json['lineList'].forEach((v) {
        lineList.add(new LineList.fromJson(v));
      });
    }
    interval = json['interval'] != null
        ? new Interval.fromJson(json['interval'])
        : null;
    if (json['languageList'] != null) {
      languageList = new List<MLTextLanguage>();
      json['languageList'].forEach((v) {
        languageList.add(new MLTextLanguage.fromJson(v));
      });
    }
    possibility = json['possibility'];
  }
}

class WordList {
  MLBorder border;
  String stringValue;
  Interval interval;
  List<MLTextLanguage> languageList;
  List<CharacterList> characterList;
  dynamic possibility;

  WordList(
      {this.border,
      this.stringValue,
      this.interval,
      this.languageList,
      this.characterList,
      this.possibility});

  WordList.fromJson(Map<String, dynamic> json) {
    border =
        json['border'] != null ? new MLBorder.fromJson(json['border']) : null;
    stringValue = json['stringValue'];
    interval = json['interval'] != null
        ? new Interval.fromJson(json['interval'])
        : null;
    if (json['languageList'] != null) {
      languageList = new List<MLTextLanguage>();
      json['languageList'].forEach((v) {
        languageList.add(new MLTextLanguage.fromJson(v));
      });
    }
    if (json['characterList'] != null) {
      characterList = new List<CharacterList>();
      json['characterList'].forEach((v) {
        characterList.add(new CharacterList.fromJson(v));
      });
    }
    possibility = json['possibility'];
  }
}

class CharacterList {
  MLBorder border;
  String stringValue;
  List<MLTextLanguage> languageList;
  dynamic possibility;
  Interval interval;

  CharacterList(
      {this.border,
      this.stringValue,
      this.languageList,
      this.possibility,
      this.interval});

  CharacterList.fromJson(Map<String, dynamic> json) {
    border =
        json['border'] != null ? new MLBorder.fromJson(json['border']) : null;
    stringValue = json['stringValue'];
    if (json['languageList'] != null) {
      languageList = new List<MLTextLanguage>();
      json['languageList'].forEach((v) {
        languageList.add(new MLTextLanguage.fromJson(v));
      });
    }
    possibility = json['possibility'];
    interval = json['interval'] != null
        ? new Interval.fromJson(json['interval'])
        : null;
  }
}

class LineList {
  MLBorder border;
  String stringValue;
  List<WordList> wordList;
  Interval interval;
  List<MLTextLanguage> languageList;
  dynamic possibility;
  List<MLPoint> points;

  LineList(
      {this.border,
      this.stringValue,
      this.wordList,
      this.interval,
      this.languageList,
      this.possibility,
      this.points});

  LineList.fromJson(Map<String, dynamic> json) {
    border =
        json['border'] != null ? new MLBorder.fromJson(json['border']) : null;
    stringValue = json['stringValue'];
    if (json['wordList'] != null) {
      wordList = new List<WordList>();
      json['wordList'].forEach((v) {
        wordList.add(new WordList.fromJson(v));
      });
    }
    interval = json['interval'] != null
        ? new Interval.fromJson(json['interval'])
        : null;
    if (json['languageList'] != null) {
      languageList = new List<MLTextLanguage>();
      json['languageList'].forEach((v) {
        languageList.add(new MLTextLanguage.fromJson(v));
      });
    }
    possibility = json['possibility'];
    if (json['points'] != null) {
      points = new List<MLPoint>();
      json['points'].forEach((v) {
        points.add(new MLPoint.fromJson(v));
      });
    }
  }
}

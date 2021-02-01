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

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'word.dart';

class AutoCompletePrediction {
  String description;
  List<Word> matchedKeywords;
  List<Word> matchedWords;

  AutoCompletePrediction({
    this.description,
    this.matchedKeywords,
    this.matchedWords,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'matchedKeywords': matchedKeywords?.map((x) => x?.toMap())?.toList(),
      'matchedWords': matchedWords?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory AutoCompletePrediction.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AutoCompletePrediction(
      description: map['description'],
      matchedKeywords: map["matchedKeywords"] == null
          ? null
          : List<Word>.from(
              map["matchedKeywords"].map((x) => Word.fromMap(x)),
            ),
      matchedWords: map["matchedWords"] == null
          ? null
          : List<Word>.from(
              map["matchedWords"].map((x) => Word.fromMap(x)),
            ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AutoCompletePrediction.fromJson(String source) =>
      AutoCompletePrediction.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AutoCompletePrediction(description: $description, matchedKeywords: $matchedKeywords, matchedWords: $matchedWords)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AutoCompletePrediction &&
        o.description == description &&
        listEquals(o.matchedKeywords, matchedKeywords) &&
        listEquals(o.matchedWords, matchedWords);
  }

  @override
  int get hashCode {
    return description.hashCode ^
        matchedKeywords.hashCode ^
        matchedWords.hashCode;
  }
}

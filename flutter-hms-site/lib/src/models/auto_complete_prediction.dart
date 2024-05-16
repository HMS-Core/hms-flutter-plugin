/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_site;

class AutoCompletePrediction {
  String? description;
  List<Word>? matchedKeywords;
  List<Word>? matchedWords;

  AutoCompletePrediction({
    this.description,
    this.matchedKeywords,
    this.matchedWords,
  });

  factory AutoCompletePrediction.fromMap(Map<dynamic, dynamic> map) {
    return AutoCompletePrediction(
      description: map['description'],
      matchedKeywords: map['matchedKeywords'] != null
          ? List<Word>.from(
              map['matchedKeywords'].map(
                (dynamic x) => Word.fromMap(x),
              ),
            )
          : null,
      matchedWords: map['matchedWords'] != null
          ? List<Word>.from(
              map['matchedWords'].map(
                (dynamic x) => Word.fromMap(x),
              ),
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'matchedKeywords': matchedKeywords?.map((Word x) => x.toMap()).toList(),
      'matchedWords': matchedWords?.map((Word x) => x.toMap()).toList(),
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory AutoCompletePrediction.fromJson(String source) {
    return AutoCompletePrediction.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$AutoCompletePrediction('
        'description: $description, '
        'matchedKeywords: $matchedKeywords, '
        'matchedWords: $matchedWords)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AutoCompletePrediction &&
        other.description == description &&
        listEquals(other.matchedKeywords, matchedKeywords) &&
        listEquals(other.matchedWords, matchedWords);
  }

  @override
  int get hashCode {
    return description.hashCode ^
        matchedKeywords.hashCode ^
        matchedWords.hashCode;
  }
}

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

class OpeningHours {
  List<String>? texts;
  List<Period>? periods;

  OpeningHours({
    this.texts,
    this.periods,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'texts': texts,
      'periods': periods?.map((Period x) => x.toMap()).toList(),
    };
  }

  factory OpeningHours.fromMap(Map<dynamic, dynamic> map) {
    return OpeningHours(
      periods: map['periods'] != null
          ? List<Period>.from(
              map['periods'].map(
                (dynamic x) => Period.fromMap(x),
              ),
            )
          : null,
      texts: map['texts'] != null
          ? List<String>.from(
              map['texts'].map(
                (dynamic x) => x,
              ),
            )
          : null,
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory OpeningHours.fromJson(String source) {
    return OpeningHours.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$OpeningHours('
        'texts: $texts, '
        'periods: $periods)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OpeningHours &&
        listEquals(other.texts, texts) &&
        listEquals(other.periods, periods);
  }

  @override
  int get hashCode {
    return texts.hashCode ^ periods.hashCode;
  }
}

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

import 'period.dart';

class OpeningHours {
  List<String> texts;
  List<Period> periods;

  OpeningHours({
    this.texts,
    this.periods,
  });

  Map<String, dynamic> toMap() {
    return {
      'texts': texts,
      'periods': periods?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory OpeningHours.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return OpeningHours(
      periods: map["periods"] == null
          ? null
          : List<Period>.from(map["periods"].map((x) => Period.fromMap(x))),
      texts: map["texts"] == null
          ? null
          : List<String>.from(map["texts"].map((x) => x)),
    );
  }

  String toJson() => json.encode(toMap());

  factory OpeningHours.fromJson(String source) =>
      OpeningHours.fromMap(json.decode(source));

  @override
  String toString() => 'OpeningHours(texts: $texts, periods: $periods)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is OpeningHours &&
        listEquals(o.texts, texts) &&
        listEquals(o.periods, periods);
  }

  @override
  int get hashCode => texts.hashCode ^ periods.hashCode;
}

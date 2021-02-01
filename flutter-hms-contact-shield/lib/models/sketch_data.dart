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

class SketchData {
  double maxScore;
  double scoreSum;
  double weightedDurationSum;

  SketchData({
    double maxScore,
    double scoreSum,
    double weightedDurationSum,
  })  : maxScore = maxScore ?? 0.0,
        scoreSum = scoreSum ?? 0.0,
        weightedDurationSum = weightedDurationSum ?? 0.0;

  factory SketchData.fromJson(String str) =>
      SketchData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SketchData.fromMap(Map<String, dynamic> json) => SketchData(
        maxScore: json["maxScore"] == null ? null : json["maxScore"],
        scoreSum: json["scoreSum"] == null ? null : json["scoreSum"],
        weightedDurationSum: json["weightedDurationSum"] == null
            ? null
            : json["weightedDurationSum"],
      );

  Map<String, dynamic> toMap() => {
        "maxScore": maxScore == null ? null : maxScore,
        "scoreSum": scoreSum == null ? null : scoreSum,
        "weightedDurationSum":
            weightedDurationSum == null ? null : weightedDurationSum,
      };

  @override
  String toString() {
    return 'SketchData(maxScore: $maxScore, scoreSum: $scoreSum, weightedDurationSum: $weightedDurationSum)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SketchData &&
        o.maxScore == maxScore &&
        o.scoreSum == scoreSum &&
        o.weightedDurationSum == weightedDurationSum;
  }

  @override
  int get hashCode {
    return maxScore.hashCode ^ scoreSum.hashCode ^ weightedDurationSum.hashCode;
  }
}

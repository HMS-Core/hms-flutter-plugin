/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_contactshield;

class DailySketchConfiguration {
  List<double?>? weightsOfReportType;
  List<double?>? weightsOfContagiousness;
  List<int>? thresholdOfAttenuationInDb;
  List<double>? weightsOfAttenuationBucket;
  int? thresholdOfDaysSinceHit;
  double? minWindowScore;

  DailySketchConfiguration()
      : weightsOfReportType = <double?>[null, null, null, null, null, null],
        weightsOfContagiousness = <double?>[null, null, null],
        thresholdOfAttenuationInDb = <int>[],
        weightsOfAttenuationBucket = <double>[],
        thresholdOfDaysSinceHit = 0,
        minWindowScore = 0.0;

  Map<int, double?> getWeightsOfReportType() {
    final Map<int, double?> map = <int, double?>{};
    for (int i = 0; i < weightsOfReportType!.length; i++) {
      if (i < 5 && i > 0) {
        map.putIfAbsent(i, () => weightsOfReportType![i]);
      }
    }
    return map;
  }

  Map<int, double?> getWeightsOfContagiousness() {
    final Map<int, double?> map = <int, double?>{};
    for (int i = 0; i < weightsOfContagiousness!.length; i++) {
      if (i != 0) {
        map.putIfAbsent(i, () => weightsOfContagiousness![i]);
      }
    }
    return map;
  }

  List<int> getThresholdOfAttenuationInDb() {
    return List<int>.from(thresholdOfAttenuationInDb!);
  }

  List<double> getWeightsOfAttenuationBucket() {
    return List<double>.from(weightsOfAttenuationBucket!);
  }

  int? getThresholdOfDaysSinceHit() {
    return thresholdOfDaysSinceHit;
  }

  double? getMinWindowScore() {
    return minWindowScore;
  }

  void setWeightOfReportType(int reportType, double weightOfReportType) {
    if (!(reportType >= 0 && reportType <= 5)) {
      throw ArgumentError('reportType must be in [0,5]');
    }
    if (!(weightOfReportType >= 0.0 && weightOfReportType <= 2.5)) {
      throw ArgumentError('weightOfReportType must be in [0.0,2.5]');
    }
    weightsOfReportType!.insert(reportType, weightOfReportType);
  }

  void setWeightOfContagiousness(int index, double weightOfContagiousness) {
    if (!(index >= 0 && index < 3)) {
      throw ArgumentError('index must be in [0,2]');
    }
    weightsOfContagiousness!.insert(index, weightOfContagiousness);
  }

  void setThresholdsOfAttenuationInDb(
    List<int> thresholdOfAttenuationInDb,
    List<double> weightsOfAttenuationBucket,
  ) {
    for (int i = 0; i < thresholdOfAttenuationInDb.length; i++) {
      if (!(thresholdOfAttenuationInDb[i] >= 0 &&
          thresholdOfAttenuationInDb[i] <= 255)) {
        throw ArgumentError('thresholdOfAttenuationInDb must be in [0,255]');
      }
      if (i != 0) {
        if (!(thresholdOfAttenuationInDb[i - 1] <=
            thresholdOfAttenuationInDb[i])) {
          throw ArgumentError(
            'thresholdOfAttenuationInDb[${i - 1}] must be smaller than thresholdOfAttenuationInDb[$i]',
          );
        }
      }
    }
    this.thresholdOfAttenuationInDb =
        List<int>.from(thresholdOfAttenuationInDb);
    this.weightsOfAttenuationBucket =
        List<double>.from(weightsOfAttenuationBucket);
  }

  void setThresholdOfDaysSinceHit(int thresholdOfDaysSinceHit) {
    if (!(thresholdOfDaysSinceHit >= 0)) {
      throw ArgumentError('thresholdOfDaysSinceHit must not be negative');
    }
    this.thresholdOfDaysSinceHit = thresholdOfDaysSinceHit;
  }

  void setMinWindowScore(double minWindowScore) {
    if (!(minWindowScore >= 0.0)) {
      throw ArgumentError('minWindowScore must not be negative');
    }
    this.minWindowScore = minWindowScore;
  }

  factory DailySketchConfiguration.fromJson(String str) {
    return DailySketchConfiguration.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory DailySketchConfiguration.fromMap(Map<String, dynamic> json) {
    final DailySketchConfiguration tempDailySketch = DailySketchConfiguration();
    tempDailySketch.weightsOfReportType = json['weightsOfReportType'] == null
        ? null
        : List<double>.from(
            json['weightsOfReportType'].map((dynamic x) => x),
          );
    tempDailySketch.weightsOfContagiousness =
        json['weightsOfContagiousness'] == null
            ? null
            : List<double>.from(
                json['weightsOfContagiousness'].map((dynamic x) => x),
              );
    tempDailySketch.thresholdOfAttenuationInDb =
        json['thresholdOfAttenuationInDb'] == null
            ? null
            : List<int>.from(
                json['thresholdOfAttenuationInDb'].map((dynamic x) => x),
              );
    tempDailySketch.weightsOfAttenuationBucket =
        json['weightsOfAttenuationBucket'] == null
            ? null
            : List<double>.from(
                json['weightsOfAttenuationBucket'].map((dynamic x) => x),
              );
    tempDailySketch.thresholdOfDaysSinceHit = json['thresholdOfDaysSinceHit'];
    tempDailySketch.minWindowScore = json['minWindowScore'];

    return tempDailySketch;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'weightsOfReportType': weightsOfReportType,
      'weightsOfContagiousness': weightsOfContagiousness,
      'thresholdOfAttenuationInDb': thresholdOfAttenuationInDb,
      'weightsOfAttenuationBucket': weightsOfAttenuationBucket,
      'thresholdOfDaysSinceHit': thresholdOfDaysSinceHit,
      'minWindowScore': minWindowScore,
    };
  }

  @override
  String toString() {
    return '$DailySketchConfiguration('
        'weightsOfReportType: $weightsOfReportType, '
        'weightsOfContagiousness: $weightsOfContagiousness, '
        'thresholdOfAttenuationInDb: $thresholdOfAttenuationInDb, '
        'weightsOfAttenuationBucket: $weightsOfAttenuationBucket, '
        'thresholdOfDaysSinceHit: $thresholdOfDaysSinceHit, '
        'minWindowScore: $minWindowScore)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is DailySketchConfiguration &&
        listEquals(other.weightsOfReportType, weightsOfReportType) &&
        listEquals(other.weightsOfContagiousness, weightsOfContagiousness) &&
        listEquals(
          other.thresholdOfAttenuationInDb,
          thresholdOfAttenuationInDb,
        ) &&
        listEquals(
          other.weightsOfAttenuationBucket,
          weightsOfAttenuationBucket,
        ) &&
        other.thresholdOfDaysSinceHit == thresholdOfDaysSinceHit &&
        other.minWindowScore == minWindowScore;
  }

  @override
  int get hashCode {
    return weightsOfReportType.hashCode ^
        weightsOfContagiousness.hashCode ^
        thresholdOfAttenuationInDb.hashCode ^
        weightsOfAttenuationBucket.hashCode ^
        thresholdOfDaysSinceHit.hashCode ^
        minWindowScore.hashCode;
  }
}

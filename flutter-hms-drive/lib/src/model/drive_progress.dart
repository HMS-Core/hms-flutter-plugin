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

import 'dart:convert';

class DriveProgress {
  String fileName;
  double progress;
  ProgressState state;
  int totalTimeElapsed;

  DriveProgress({
    this.fileName,
    this.progress,
    this.state,
    this.totalTimeElapsed,
  });

  DriveProgress clone({
    String fileName,
    double progress,
    ProgressState state,
    int totalTimeElapsed,
  }) {
    return DriveProgress(
      fileName: fileName ?? this.fileName,
      progress: progress ?? this.progress,
      state: state ?? this.state,
      totalTimeElapsed: totalTimeElapsed ?? this.totalTimeElapsed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fileName': fileName,
      'progress': progress,
      'state': state?.toString(),
      'totalTimeElapsed': totalTimeElapsed,
    };
  }

  //ProgressState.fromMap(map['state'])

  factory DriveProgress.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    T enumFromString<T>(Iterable<T> values, String value) {
      return values.firstWhere(
          (type) => type.toString().split(".").last == value,
          orElse: () => null);
    }

    return DriveProgress(
      fileName: map['fileName'],
      progress: map['progress'],
      state: map['state'] == null
          ? null
          : enumFromString(ProgressState.values, map["state"]),
      totalTimeElapsed: map['totalTimeElapsed'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DriveProgress.fromJson(String source) =>
      DriveProgress.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DriveProgress(fileName: $fileName, progress: $progress, state: $state, totalTimeElapsed: $totalTimeElapsed)';
  }
}

enum ProgressState {
  NOT_STARTED,
  INITIATION_STARTED,
  INITIATION_COMPLETE,
  MEDIA_IN_PROGRESS,
  MEDIA_COMPLETE,
}

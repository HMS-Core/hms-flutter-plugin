/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
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

part of '../../huawei_location.dart';

class LogConfig {
  int fileExpiredTime;
  int fileNum;
  int fileSize;
  String logPath;

  LogConfig({
    required this.fileExpiredTime,
    required this.fileNum,
    required this.fileSize,
    required this.logPath,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fileExpiredTime': fileExpiredTime,
      'fileNum': fileNum,
      'fileSize': fileSize,
      'logPath': logPath,
    };
  }

  factory LogConfig.fromMap(Map<dynamic, dynamic>? map) {
    return LogConfig(
      fileExpiredTime: map?['fileExpiredTime'],
      fileNum: map?['fileNum'],
      fileSize: map?['fileSize'],
      logPath: map?['logPath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LogConfig.fromJson(String source) =>
      LogConfig.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LogConfig('
        'fileExpiredTime: $fileExpiredTime, '
        'fileNum: $fileNum, '
        'fileSize: $fileSize, '
        'logPath: $logPath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is LogConfig &&
        other.fileExpiredTime == fileExpiredTime &&
        other.fileNum == fileNum &&
        other.fileSize == fileSize &&
        other.logPath == logPath;
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        fileExpiredTime,
        fileNum,
        fileSize,
        logPath,
      ],
    );
  }
}

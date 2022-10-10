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

part of huawei_safetydetect;

/// The malicious app entity class.
class MaliciousAppData {
  final int apkCategory;
  final String apkPackageName;
  final String apkSha256;

  MaliciousAppData._({
    required this.apkCategory,
    required this.apkPackageName,
    required this.apkSha256,
  });

  factory MaliciousAppData.fromMap(Map<String, dynamic> map) {
    return MaliciousAppData._(
      apkCategory: map['apkCategory'],
      apkPackageName: map['apkPackageName'],
      apkSha256: map['apkSha256'],
    );
  }

  /// Obtains the MaliciousAppType that corresponds to the detected apkCategory of
  /// the current MaliciousAppData instance.
  MaliciousAppType get getMaliciousAppType {
    if (apkCategory == 1) {
      return MaliciousAppType.virus_level_risk;
    } else if (apkCategory == 2) {
      return MaliciousAppType.virus_level_virus;
    } else {
      throw ('Unsupported Malicious App Type Value.');
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'apkCategory': apkCategory,
      'apkPackageName': apkPackageName,
      'apkSha256': apkSha256,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

/// Malicious app types that can be detected during an app check.
enum MaliciousAppType {
  /// Risk app.
  virus_level_risk,

  /// Virus app.
  virus_level_virus,
}

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

/// The entity class of URL threat types.
class UrlCheckThreat {
  final int _urlCheckResult;

  UrlCheckThreat._(this._urlCheckResult);

  factory UrlCheckThreat.fromInt(int urlThreatValue) {
    return UrlCheckThreat._(urlThreatValue);
  }

  /// Obtains the integer value of the URL check result's threat type.
  int get getUrlCheckResult => _urlCheckResult;

  /// Obtains the corresponding UrlThreatType of the urlCheckResult.
  UrlThreatType get getUrlThreatType {
    if (_urlCheckResult == 1) {
      return UrlThreatType.malware;
    } else if (_urlCheckResult == 3) {
      return UrlThreatType.phishing;
    } else {
      throw ('Unsupported urlCheckResult value');
    }
  }
}

/// Threat Types that can be detected during an url check.
enum UrlThreatType {
  malware,
  phishing,
}

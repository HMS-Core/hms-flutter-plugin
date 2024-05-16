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

part of huawei_adsprime;

class ReferrerDetails {
  static const String keyInstallReferrer = 'install_referrer';
  static const String keyReferrerClickTimeStamp =
      'referrer_click_timestamp_seconds';
  static const String keyInstallBeginTimeStamp =
      'install_begin_timestamp_seconds';

  late Bundle _bundle;

  ReferrerDetails(Bundle referrerBundle) {
    _bundle = referrerBundle;
  }

  String? get getInstallReferrer {
    return _bundle.getString(keyInstallReferrer);
  }

  int? get getReferrerClickTimestampMillisecond {
    return _bundle.getInt(keyReferrerClickTimeStamp);
  }

  int? get getReferrerBeginTimeStampMillisecond {
    return _bundle.getInt(keyInstallBeginTimeStamp);
  }
}

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

import 'package:huawei_push/src/constants/channel.dart';

/// A class provided by the aggregation capability package for setting basic attributes.
class ProxySettings {
  /// Sets a country/region code. This method is available only for Huawei-developed apps.
  static Future<void> setCountryCode(String countryCode) async {
    methodChannel.invokeMethod("setCountryCode", {"countryCode": countryCode});
  }
}

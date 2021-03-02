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

import 'package:huawei_gameservice/constants/constants.dart';

/// Provides APIs related to the game floating window.
class BuoyClient {
  static String _clientName = "BuoyClient.";

  /// Displays the floating window.
  static Future<void> showFloatWindow() async {
    return await channel.invokeMethod(_clientName + "showFloatWindow");
  }

  /// Hides the floating window.
  static Future<void> hideFloatWindow() async {
    return await channel.invokeMethod(_clientName + "hideFloatWindow");
  }
}

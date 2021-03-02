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

import 'package:huawei_gameservice/clients/utils.dart';
import 'package:huawei_gameservice/constants/constants.dart';

/// Provides APIs related to basic game functions, such as obtaining the app ID
/// and setting the position for displaying the game greeting pop-up on the screen.
class GamesClient {
  static String _clientName = "GamesClient.";

  /// Obtains the app ID of a game.
  static Future<String> getAppId() async {
    return await channel.invokeMethod(_clientName + "getAppId");
  }

  /// Sets the position for displaying the game greeting and achievement unlocking pop-ups on the screen.
  static Future<void> setPopupsPosition(int position) async {
    return await channel.invokeMethod(
        _clientName + "setPopupsPosition", removeNulls({"position": position}));
  }

  /// Revokes the authorization to HUAWEI Game Service.
  static Future<bool> cancelGameService() async {
    return await channel.invokeMethod(_clientName + "cancelGameService");
  }
}

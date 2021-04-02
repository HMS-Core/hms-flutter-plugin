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

import 'package:huawei_account/huawei_account.dart';
import 'package:huawei_gameservice/huawei_gameservice.dart';

String buildErrorMessage(String apiName, String errorCode) {
  return "Error on $apiName API, Error: $errorCode, Error Description: ${GameServiceResultCodes.getStatusCodeMessage(errorCode)}";
}

Future<HmsAuthHuaweiId> signIn() async {
  try {
    HmsAuthHuaweiId _id;
    HmsAuthParamHelper helper = new HmsAuthParamHelper()
      ..setIdToken()
      ..setAccessToken()
      ..setAuthorizationCode()
      ..setEmail()
      ..setScopeList([
        GameScopes.GAME,
        GameScopes.DRIVE_APP_DATA,
      ])
      ..setProfile();

    _id = await HmsAuthService.signIn(authParamHelper: helper);
    print("User: ${_id.displayName}");
    return _id;
  } on Exception catch (e) {
    print(e.toString());
    return null;
  }
}

String formatMilliseconds(int milliseconds) {
  int milliSeconds = (milliseconds / 10).truncate();
  int seconds = (milliSeconds / 100).truncate();
  int minutes = (seconds / 60).truncate();

  String minutesStr = (minutes % 60).toString().padLeft(2, '0');
  String secondsStr = (seconds % 60).toString().padLeft(2, '0');
  String milliSecondsStr = (milliSeconds % 100).toString().padLeft(2, '0');

  return "$minutesStr:$secondsStr.$milliSecondsStr";
}

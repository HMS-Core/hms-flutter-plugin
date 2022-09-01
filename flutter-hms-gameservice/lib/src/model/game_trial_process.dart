/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_gameservice;

/// Callback typedef for trial duration expiration.
typedef OnTrialTimeOut = void Function();

/// Callback typedef for identity verification result.
typedef OnCheckRealNameResult = void Function(bool hasRealName);

/// Handles trial duration expiration.
///
/// You need to implement this API to obtain the notification to be displayed when the trial duration
/// of a user who has not performed identity verification ends.
/// This object is passed when the [PlayersClient.setGameTrialProcess] method of [PlayersClient] is called.
class GameTrialProcess {
  /// Callback for trial duration expiration.
  OnTrialTimeOut onTrialTimeOut;

  /// Callback for identity verification result.
  ///
  /// Identity verification result of the player.
  /// `true`: The user has completed identity verification.
  /// `false`: The user has not completed identity verification.
  OnCheckRealNameResult onCheckRealNameResult;

  GameTrialProcess(this.onTrialTimeOut, this.onCheckRealNameResult);
}

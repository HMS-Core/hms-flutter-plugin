/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

part of huawei_wallet;

class PassStatus {
  /// Status of a wallet pass.
  ///
  /// Values are:
  ///   - WalletPassConstant.passStateCompleted;
  ///   - WalletPassConstant.passStateExpired;
  ///   - WalletPassConstant.passStateInactive;
  ///   - WalletPassConstant.passStateActive;
  final String state;

  /// Time when the wallet pass takes effect, in UTC format: yyyy-MM-ddTHH:mm:ss.SSSZ.
  final String effectTime;

  /// Time when the wallet pass expires, in UTC format: yyyy-MM-ddTHH:mm:ss.SSSZ.
  final String expireTime;

  const PassStatus({
    required this.state,
    required this.effectTime,
    required this.expireTime,
  });

  Map<String, dynamic> _toMap() {
    return <String, dynamic>{
      'state': state,
      'effectTime': effectTime,
      'expireTime': expireTime,
    };
  }

  @override
  String toString() {
    return '$PassStatus('
        'state: $state, '
        'effectTime: $effectTime, '
        'expireTime: $expireTime)';
  }
}

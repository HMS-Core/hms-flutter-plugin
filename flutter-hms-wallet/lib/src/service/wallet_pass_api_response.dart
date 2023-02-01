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

class WalletPassApiResponse {
  /// Result code.
  final String? returnCode;

  /// Result description.
  final String? returnRes;

  /// Token for interacting with the card.
  final String? accessToken;

  /// Temporary public key for communicating with the card.
  final String? tempAccessSec;

  /// Pass parameters in JSON format.
  final String? cardParams;

  /// List of WalletPassStatus.
  final List<WalletPassStatus> passStatusList;

  /// List of WalletCardInfo.
  final List<WalletCardInfo> cardInfoList;

  /// Temporary public key for communicating with TEE.
  final String? teeTempAccessSec;

  /// Temporary transaction ID for communicating with TEE.
  final String? teeTempTransId;

  /// Instance of WalletPassStatus.
  final WalletPassStatus? passStatus;

  /// Version number.
  final String? version;

  /// Card reading result.
  final String? readNFCResult;

  /// Unique ID of the device where the account is used.
  final String? passDeviceId;

  /// Transaction ID.
  final String? transactionId;

  /// Transaction ID signature.
  final String? transactionIdSign;

  /// APDU execution result for auth0 or auth1.
  final String? authResult;

  const WalletPassApiResponse._({
    required this.returnCode,
    required this.returnRes,
    required this.accessToken,
    required this.tempAccessSec,
    required this.cardParams,
    required this.passStatusList,
    required this.cardInfoList,
    required this.teeTempAccessSec,
    required this.teeTempTransId,
    required this.passStatus,
    required this.version,
    required this.readNFCResult,
    required this.passDeviceId,
    required this.transactionId,
    required this.transactionIdSign,
    required this.authResult,
  });

  factory WalletPassApiResponse._fromMap(Map<dynamic, dynamic> map) {
    return WalletPassApiResponse._(
      returnCode: map['returnCode'],
      returnRes: map['returnRes'],
      accessToken: map['accessToken'],
      tempAccessSec: map['tempAccessSec'],
      cardParams: map['cardParams'],
      passStatusList: List<WalletPassStatus>.from(
        ((map['passStatusList'] ?? <dynamic>[]) as List<dynamic>)
            .map((dynamic e) => WalletPassStatus._fromMap(e)),
      ),
      cardInfoList: List<WalletCardInfo>.from(
        ((map['cardInfoList'] ?? <dynamic>[]) as List<dynamic>)
            .map((dynamic e) => WalletCardInfo._fromMap(e)),
      ),
      teeTempAccessSec: map['teeTempAccessSec'],
      teeTempTransId: map['teeTempTransId'],
      passStatus: map['passStatus'] != null
          ? WalletPassStatus._fromMap(map['passStatus'])
          : null,
      version: map['version'],
      readNFCResult: map['readNFCResult'],
      passDeviceId: map['passDeviceId'],
      transactionId: map['transactionId'],
      transactionIdSign: map['transactionIdSign'],
      authResult: map['authResult'],
    );
  }

  @override
  String toString() {
    return '$WalletPassApiResponse('
        'returnCode: $returnCode, '
        'returnRes: $returnRes, '
        'accessToken: $accessToken, '
        'tempAccessSec: $tempAccessSec, '
        'cardParams: $cardParams, '
        'passStatusList: $passStatusList, '
        'cardInfoList: $cardInfoList, '
        'teeTempAccessSec: $teeTempAccessSec, '
        'teeTempTransId: $teeTempTransId, '
        'passStatus: $passStatus, '
        'version: $version, '
        'readNFCResult: $readNFCResult, '
        'passDeviceId: $passDeviceId, '
        'transactionId: $transactionId, '
        'transactionIdSign: $transactionIdSign, '
        'authResult: $authResult)';
  }
}

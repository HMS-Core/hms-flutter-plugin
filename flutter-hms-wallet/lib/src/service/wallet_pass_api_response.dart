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
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:huawei_wallet/src/service/wallet_pass_status.dart';

class WalletPassApiResponse {
  final String returnCode;
  final String returnRes;
  final String accessToken;
  final String tempAccessSec;
  final String cardParams;
  final List<WalletPassStatus> passStatuslist;
  final List<WalletPassStatus> cardInfolist;
  final String teeTempAccessSec;
  final String teeTempTransId;
  final WalletPassStatus passStatus;
  final String version;
  final String readNFCResult;
  final String passDeviceId;
  final String transactionId;
  final String transactionIdSign;
  final String authResult;
  WalletPassApiResponse({
    this.returnCode,
    this.returnRes,
    this.accessToken,
    this.tempAccessSec,
    this.cardParams,
    this.passStatuslist,
    this.cardInfolist,
    this.teeTempAccessSec,
    this.teeTempTransId,
    this.passStatus,
    this.version,
    this.readNFCResult,
    this.passDeviceId,
    this.transactionId,
    this.transactionIdSign,
    this.authResult,
  });

  WalletPassApiResponse copyWith({
    String returnCode,
    String returnRes,
    String accessToken,
    String tempAccessSec,
    String cardParams,
    List<WalletPassStatus> passStatuslist,
    List<WalletPassStatus> cardInfolist,
    String teeTempAccessSec,
    String teeTempTransId,
    WalletPassStatus passStatus,
    String version,
    String readNFCResult,
    String passDeviceId,
    String transactionId,
    String transactionIdSign,
    String authResult,
  }) {
    return WalletPassApiResponse(
      returnCode: returnCode ?? this.returnCode,
      returnRes: returnRes ?? this.returnRes,
      accessToken: accessToken ?? this.accessToken,
      tempAccessSec: tempAccessSec ?? this.tempAccessSec,
      cardParams: cardParams ?? this.cardParams,
      passStatuslist: passStatuslist ?? this.passStatuslist,
      cardInfolist: cardInfolist ?? this.cardInfolist,
      teeTempAccessSec: teeTempAccessSec ?? this.teeTempAccessSec,
      teeTempTransId: teeTempTransId ?? this.teeTempTransId,
      passStatus: passStatus ?? this.passStatus,
      version: version ?? this.version,
      readNFCResult: readNFCResult ?? this.readNFCResult,
      passDeviceId: passDeviceId ?? this.passDeviceId,
      transactionId: transactionId ?? this.transactionId,
      transactionIdSign: transactionIdSign ?? this.transactionIdSign,
      authResult: authResult ?? this.authResult,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'returnCode': returnCode,
      'returnRes': returnRes,
      'accessToken': accessToken,
      'tempAccessSec': tempAccessSec,
      'cardParams': cardParams,
      'passStatuslist': passStatuslist?.map((x) => x?.toMap())?.toList(),
      'cardInfolist': cardInfolist?.map((x) => x?.toMap())?.toList(),
      'teeTempAccessSec': teeTempAccessSec,
      'teeTempTransId': teeTempTransId,
      'passStatus': passStatus?.toMap(),
      'version': version,
      'readNFCResult': readNFCResult,
      'passDeviceId': passDeviceId,
      'transactionId': transactionId,
      'transactionIdSign': transactionIdSign,
      'authResult': authResult,
    };
  }

  factory WalletPassApiResponse.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return WalletPassApiResponse(
      returnCode: map['returnCode'],
      returnRes: map['returnRes'],
      accessToken: map['accessToken'],
      tempAccessSec: map['tempAccessSec'],
      cardParams: map['cardParams'],
      passStatuslist: List<WalletPassStatus>.from(
          map['passStatuslist']?.map((x) => WalletPassStatus.fromMap(x)) ?? []),
      cardInfolist: List<WalletPassStatus>.from(
          map['cardInfolist']?.map((x) => WalletPassStatus.fromMap(x)) ?? []),
      teeTempAccessSec: map['teeTempAccessSec'],
      teeTempTransId: map['teeTempTransId'],
      passStatus: WalletPassStatus.fromMap(map['passStatus']),
      version: map['version'],
      readNFCResult: map['readNFCResult'],
      passDeviceId: map['passDeviceId'],
      transactionId: map['transactionId'],
      transactionIdSign: map['transactionIdSign'],
      authResult: map['authResult'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletPassApiResponse.fromJson(String source) =>
      WalletPassApiResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WalletPassApiResponse(returnCode: $returnCode, returnRes: $returnRes, accessToken: $accessToken, tempAccessSec: $tempAccessSec, cardParams: $cardParams, passStatuslist: $passStatuslist, cardInfolist: $cardInfolist, teeTempAccessSec: $teeTempAccessSec, teeTempTransId: $teeTempTransId, passStatus: $passStatus, version: $version, readNFCResult: $readNFCResult, passDeviceId: $passDeviceId, transactionId: $transactionId, transactionIdSign: $transactionIdSign, authResult: $authResult)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is WalletPassApiResponse &&
        o.returnCode == returnCode &&
        o.returnRes == returnRes &&
        o.accessToken == accessToken &&
        o.tempAccessSec == tempAccessSec &&
        o.cardParams == cardParams &&
        listEquals(o.passStatuslist, passStatuslist) &&
        listEquals(o.cardInfolist, cardInfolist) &&
        o.teeTempAccessSec == teeTempAccessSec &&
        o.teeTempTransId == teeTempTransId &&
        o.passStatus == passStatus &&
        o.version == version &&
        o.readNFCResult == readNFCResult &&
        o.passDeviceId == passDeviceId &&
        o.transactionId == transactionId &&
        o.transactionIdSign == transactionIdSign &&
        o.authResult == authResult;
  }

  @override
  int get hashCode {
    return returnCode.hashCode ^
        returnRes.hashCode ^
        accessToken.hashCode ^
        tempAccessSec.hashCode ^
        cardParams.hashCode ^
        passStatuslist.hashCode ^
        cardInfolist.hashCode ^
        teeTempAccessSec.hashCode ^
        teeTempTransId.hashCode ^
        passStatus.hashCode ^
        version.hashCode ^
        readNFCResult.hashCode ^
        passDeviceId.hashCode ^
        transactionId.hashCode ^
        transactionIdSign.hashCode ^
        authResult.hashCode;
  }
}

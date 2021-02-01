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

class WalletCardInfo {
  final String passId;
  final String status;
  final String lockID;
  final String transactionTime;
  final String transactionResult;
  WalletCardInfo({
    this.passId,
    this.status,
    this.lockID,
    this.transactionTime,
    this.transactionResult,
  });

  WalletCardInfo copyWith({
    String passId,
    String status,
    String lockID,
    String transactionTime,
    String transactionResult,
  }) {
    return WalletCardInfo(
      passId: passId ?? this.passId,
      status: status ?? this.status,
      lockID: lockID ?? this.lockID,
      transactionTime: transactionTime ?? this.transactionTime,
      transactionResult: transactionResult ?? this.transactionResult,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'passId': passId,
      'status': status,
      'lockID': lockID,
      'transactionTime': transactionTime,
      'transactionResult': transactionResult,
    };
  }

  factory WalletCardInfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return WalletCardInfo(
      passId: map['passId'],
      status: map['status'],
      lockID: map['lockID'],
      transactionTime: map['transactionTime'],
      transactionResult: map['transactionResult'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletCardInfo.fromJson(String source) =>
      WalletCardInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WalletCardInfo(passId: $passId, status: $status, lockID: $lockID, transactionTime: $transactionTime, transactionResult: $transactionResult)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is WalletCardInfo &&
        o.passId == passId &&
        o.status == status &&
        o.lockID == lockID &&
        o.transactionTime == transactionTime &&
        o.transactionResult == transactionResult;
  }

  @override
  int get hashCode {
    return passId.hashCode ^
        status.hashCode ^
        lockID.hashCode ^
        transactionTime.hashCode ^
        transactionResult.hashCode;
  }
}

/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

part of '../../huawei_iap.dart';

/// Information returned when the isSandboxActivated API is successfully called.
class IsSandboxActivatedResult {
  /// Result code description.
  String? errMsg;

  /// Indicates whether the APK version meets the requirements of sandbox testing.
  bool? isSandboxApk;

  /// Indicates whether a sandbox testing account is used.
  bool? isSandboxUser;

  /// Result code.
  ///
  /// - `'0'`: Success.
  String? returnCode;

  /// Information about the app version that is last released on HUAWEI AppGallery.
  String? versionFrMarket;

  /// App version information.
  String? versionInApk;

  /// [Status] object that contains the task processing result.
  Status? status;

  /// Creates an [IsSandboxActivatedResult] object.
  IsSandboxActivatedResult({
    this.errMsg,
    this.isSandboxApk,
    this.isSandboxUser,
    this.returnCode,
    this.versionFrMarket,
    this.versionInApk,
    this.status,
  });

  /// Creates an [IsSandboxActivatedResult] object from a JSON string.
  factory IsSandboxActivatedResult.fromJson(String str) =>
      IsSandboxActivatedResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IsSandboxActivatedResult.fromMap(Map<dynamic, dynamic> json) =>
      IsSandboxActivatedResult(
        errMsg: json['errMsg'] == null ? null : json['errMsg'],
        isSandboxApk:
            json['isSandboxApk'] == null ? null : json['isSandboxApk'],
        isSandboxUser:
            json['isSandboxUser'] == null ? null : json['isSandboxUser'],
        returnCode:
            json['returnCode'] == null ? null : json['returnCode'].toString(),
        versionFrMarket:
            json['versionFrMarket'] == null ? null : json['versionFrMarket'],
        versionInApk:
            json['versionInApk'] == null ? null : json['versionInApk'],
        status: json['status'] == null ? null : Status.fromMap(json['status']),
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errMsg': errMsg,
      'isSandboxApk': isSandboxApk,
      'isSandboxUser': isSandboxUser,
      'returnCode': returnCode,
      'versionFrMarket': versionFrMarket,
      'versionInApk': versionInApk,
      'status': status == null ? null : status!.toMap(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is IsSandboxActivatedResult &&
        this.errMsg == other.errMsg &&
        this.isSandboxApk == other.isSandboxApk &&
        this.isSandboxUser == other.isSandboxUser &&
        this.returnCode == other.returnCode &&
        this.versionFrMarket == other.versionFrMarket &&
        this.versionInApk == other.versionInApk &&
        this.status == other.status;
  }

  @override
  int get hashCode => Object.hash(
        errMsg,
        isSandboxApk,
        isSandboxUser,
        returnCode,
        versionFrMarket,
        versionInApk,
        status,
      );
}

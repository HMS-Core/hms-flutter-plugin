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

/// Information returned when isEnvReady is successfully called.
class IsEnvReadyResult {
  /// Result code.
  ///
  /// - `'0'`: The country or region of the signed-in HUAWEI ID supports HUAWEI IAP.
  String? returnCode;

  /// [Status] object that contains the task processing result.
  Status? status;

  /// Carrier ID.
  ///
  /// This field returns the carrier ID for apps on AppTouch, while returning a null value for apps on AppGallery.
  String? carrierId;

  /// Code of the country or region where the currently signed-in account is located.
  ///
  /// This field returns the country or region code for apps on AppTouch, while returning a null value for apps on AppGallery.
  String? country;

  /// Creates an [IsEnvReadyResult] object.
  IsEnvReadyResult({
    this.returnCode,
    this.status,
    this.carrierId,
    this.country,
  });

  /// Creates an [IsEnvReadyResult] object from a JSON string.
  factory IsEnvReadyResult.fromJson(String str) =>
      IsEnvReadyResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IsEnvReadyResult.fromMap(Map<String, dynamic> json) =>
      IsEnvReadyResult(
        returnCode:
            json['returnCode'] == null ? null : json['returnCode'].toString(),
        status: json['status'] == null ? null : Status.fromMap(json['status']),
        carrierId: json['carrierId'] == null ? null : json['carrierId'],
        country: json['country'] == null ? null : json['country'],
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'returnCode': returnCode,
      'status': status == null ? null : status!.toMap(),
      'carrierId': carrierId,
      'country': country,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is IsEnvReadyResult &&
        this.returnCode == other.returnCode &&
        this.status == other.status &&
        this.carrierId == other.carrierId &&
        this.country == other.country;
  }

  @override
  int get hashCode => Object.hash(
        returnCode,
        status,
        carrierId,
        country,
      );
}

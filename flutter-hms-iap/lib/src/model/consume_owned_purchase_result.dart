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

/// Information returned when the consumeOwnedPurchase API is successfully called.
class ConsumeOwnedPurchaseResult {
  /// [ConsumePurchaseData] object that contains consumption result data.
  ConsumePurchaseData? consumePurchaseData;

  /// Signature string generated after consumption data is signed using a private payment key.
  ///
  /// The signature algorithm is SHA256withRSA.
  String? dataSignature;

  /// Error description in the result code.
  String? errMsg;

  /// Result code.
  String? returnCode;

  /// Status object that contains the task processing result.
  Status? status;

  /// Signature algorithm.
  String? signatureAlgorithm;

  /// Unparsed JSON string of response.
  String rawValue;

  /// Creates a [ConsumeOwnedPurchaseResult] object.
  ConsumeOwnedPurchaseResult({
    required this.rawValue,
    this.consumePurchaseData,
    this.dataSignature,
    this.errMsg,
    this.returnCode,
    this.status,
    this.signatureAlgorithm,
  });

  /// Creates a [ConsumeOwnedPurchaseResult] object from a JSON string.
  factory ConsumeOwnedPurchaseResult.fromJson(String source) =>
      ConsumeOwnedPurchaseResult.fromMap(source);

  String toJson() => json.encode(toMap());

  factory ConsumeOwnedPurchaseResult.fromMap(String source) {
    Map<String, dynamic> jsonMap = json.decode(source);
    return ConsumeOwnedPurchaseResult(
      consumePurchaseData: jsonMap['consumePurchaseData'] == null
          ? null
          : ConsumePurchaseData.fromJson(jsonMap['consumePurchaseData']),
      dataSignature:
          jsonMap['dataSignature'] == null ? null : jsonMap['dataSignature'],
      errMsg: jsonMap['errMsg'] == null ? null : jsonMap['errMsg'],
      returnCode: jsonMap['returnCode'] == null
          ? null
          : jsonMap['returnCode'].toString(),
      status:
          jsonMap['status'] == null ? null : Status.fromMap(jsonMap['status']),
      signatureAlgorithm: jsonMap['signatureAlgorithm'] == null
          ? null
          : jsonMap['signatureAlgorithm'],
      rawValue: source,
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'consumePurchaseData':
            consumePurchaseData == null ? null : consumePurchaseData!.toJson(),
        'dataSignature': dataSignature,
        'errMsg': errMsg,
        'returnCode': returnCode,
        'status': status == null ? null : status!.toMap(),
        'signatureAlgorithm': signatureAlgorithm,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is ConsumeOwnedPurchaseResult &&
        this.consumePurchaseData == other.consumePurchaseData &&
        this.dataSignature == other.dataSignature &&
        this.errMsg == other.errMsg &&
        this.returnCode == other.returnCode &&
        this.status == other.status &&
        this.signatureAlgorithm == other.signatureAlgorithm;
  }

  @override
  int get hashCode => Object.hash(
        consumePurchaseData,
        dataSignature,
        errMsg,
        returnCode,
        status,
        signatureAlgorithm,
      );
}

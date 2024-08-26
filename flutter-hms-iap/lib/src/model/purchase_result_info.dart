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

/// Payment result information.
class PurchaseResultInfo {
  /// Result code.
  ///
  /// - `'0'`: The payment is successful.
  /// - Other values: The payment fails.
  String? returnCode;

  /// [InAppPurchaseData] object that contains purchase order details.
  InAppPurchaseData? inAppPurchaseData;

  /// Signature string generated after purchase data is signed using a private payment key.
  ///
  /// The signature algorithm is SHA256withRSA. After the payment is successful, the app needs to perform signature verification on the string of inAppPurchaseData using the payment public key.
  String? inAppDataSignature;

  /// Result code description.
  String? errMsg;

  /// Signature algorithm.
  ///
  /// Once you passed a signature algorithm, call this parameter to get this algorithm and use it to verify consumption result data. If no signature algorithm was passed, use the default SHA256WithRSA algorithm for the verification.
  ///
  /// If you only get a null value after the call of signatureAlgorithm, SHA256WithRSA will be used for the verification by default.
  String? signatureAlgorithm;

  /// Unparsed JSON string of response.
  String rawValue;

  /// Creates a [PurchaseResultInfo] object.
  PurchaseResultInfo({
    required this.rawValue,
    this.inAppDataSignature,
    this.inAppPurchaseData,
    this.returnCode,
    this.errMsg,
    this.signatureAlgorithm,
  });

  /// Creates a [PurchaseResultInfo] object from a JSON string.
  factory PurchaseResultInfo.fromJson(String str) =>
      PurchaseResultInfo.fromMap(str);

  String toJson() => json.encode(toMap());

  factory PurchaseResultInfo.fromMap(String source) {
    Map<dynamic, dynamic> jsonMap = json.decode(source);
    return PurchaseResultInfo(
      returnCode: jsonMap['returnCode'] == null
          ? null
          : jsonMap['returnCode'].toString(),
      inAppPurchaseData: jsonMap['inAppPurchaseData'] == null
          ? null
          : InAppPurchaseData.fromJson(jsonMap['inAppPurchaseData']),
      inAppDataSignature: jsonMap['inAppDataSignature'] == null
          ? null
          : jsonMap['inAppDataSignature'],
      errMsg: jsonMap['errMsg'] == null ? null : jsonMap['errMsg'],
      signatureAlgorithm: jsonMap['signatureAlgorithm'] == null
          ? null
          : jsonMap['signatureAlgorithm'],
      rawValue: source,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'returnCode': returnCode,
      'inAppPurchaseData':
          inAppPurchaseData == null ? null : inAppPurchaseData!.toJson(),
      'inAppDataSignature': inAppDataSignature,
      'errMsg': errMsg,
      'signatureAlgorithm': signatureAlgorithm,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is PurchaseResultInfo &&
        this.returnCode == other.returnCode &&
        this.inAppPurchaseData == other.inAppPurchaseData &&
        this.inAppDataSignature == other.inAppDataSignature &&
        this.errMsg == other.errMsg &&
        this.signatureAlgorithm == other.signatureAlgorithm;
  }

  @override
  int get hashCode => Object.hash(
        returnCode,
        inAppPurchaseData,
        inAppDataSignature,
        errMsg,
        signatureAlgorithm,
      );
}

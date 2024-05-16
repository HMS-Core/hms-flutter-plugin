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

part of huawei_iap;

/// Information returned when the obtainOwnedPurchases or obtainOwnedPurchaseRecord API
/// is successfully called.
class OwnedPurchasesResult {
  String? continuationToken;
  String? errMsg;
  List<InAppPurchaseData>? inAppPurchaseDataList;
  List<String>? inAppSignature;
  List<String>? itemList;
  String? returnCode;
  Status? status;
  List<String>? placedInappPurchaseDataList;
  List<String>? placedInappSignatureList;
  String? signatureAlgorithm;
  String rawValue;

  OwnedPurchasesResult({
    required this.rawValue,
    this.continuationToken,
    this.errMsg,
    this.inAppPurchaseDataList,
    this.inAppSignature,
    this.itemList,
    this.returnCode,
    this.status,
    this.placedInappPurchaseDataList,
    this.placedInappSignatureList,
    this.signatureAlgorithm,
  });

  factory OwnedPurchasesResult.fromJson(String str) =>
      OwnedPurchasesResult.fromMap(str);

  String toJson() => json.encode(toMap());

  factory OwnedPurchasesResult.fromMap(String source) {
    Map<String, dynamic> jsonMap = json.decode(source);

    return OwnedPurchasesResult(
      continuationToken: jsonMap['continuationToken'] == null
          ? null
          : jsonMap['continuationToken'],
      errMsg: jsonMap['errMsg'] == null ? null : jsonMap['errMsg'],
      inAppPurchaseDataList: jsonMap['inAppPurchaseDataList'] == null
          ? null
          : List<InAppPurchaseData>.from(
              jsonMap['inAppPurchaseDataList']
                  .map((dynamic x) => InAppPurchaseData.fromJson(x)),
            ).toList(),
      inAppSignature: jsonMap['inAppSignature'] == null
          ? null
          : List<String>.from(jsonMap['inAppSignature'].map((dynamic x) => x)),
      itemList: jsonMap['itemList'] == null
          ? null
          : (jsonMap['itemList'] as List<dynamic>)
              .map((dynamic e) => e.toString())
              .toList(),
      returnCode: jsonMap['returnCode'] == null
          ? null
          : jsonMap['returnCode'].toString(),
      status:
          jsonMap['status'] == null ? null : Status.fromMap(jsonMap['status']),
      placedInappPurchaseDataList:
          jsonMap['placedInappPurchaseDataList'] == null
              ? null
              : List<String>.from(jsonMap['placedInappPurchaseDataList']),
      placedInappSignatureList: jsonMap['placedInappSignatureList'] == null
          ? null
          : List<String>.from(jsonMap['placedInappSignatureList']),
      signatureAlgorithm: jsonMap['signatureAlgorithm'] == null
          ? null
          : jsonMap['signatureAlgorithm'],
      rawValue: source,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'continuationToken': continuationToken == null ? null : continuationToken,
      'errMsg': errMsg == null ? null : errMsg,
      'inAppPurchaseDataList': inAppPurchaseDataList == null
          ? null
          : List<dynamic>.from(
              inAppPurchaseDataList!.map((InAppPurchaseData x) => x),
            ),
      'inAppSignature': inAppSignature == null
          ? null
          : List<dynamic>.from(inAppSignature!.map((String x) => x)),
      'itemList': itemList == null
          ? null
          : List<dynamic>.from(itemList!.map((String x) => x)),
      'returnCode': returnCode == null ? null : returnCode,
      'status': status == null ? null : status!.toMap(),
      'placedInappPurchaseDataList': placedInappPurchaseDataList == null
          ? null
          : List<String>.from(
              placedInappPurchaseDataList!.map((String x) => x),
            ),
      'placedInappSignatureList': placedInappSignatureList == null
          ? null
          : List<String>.from(placedInappSignatureList!.map((String x) => x)),
      'signatureAlgorithm':
          signatureAlgorithm == null ? null : signatureAlgorithm,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is OwnedPurchasesResult &&
        this.continuationToken == other.continuationToken &&
        this.errMsg == other.errMsg &&
        listEquals(this.inAppPurchaseDataList, other.inAppPurchaseDataList) &&
        listEquals(this.inAppSignature, other.inAppSignature) &&
        listEquals(this.itemList, other.itemList) &&
        this.returnCode == other.returnCode &&
        this.status == other.status &&
        listEquals(
          this.placedInappPurchaseDataList,
          other.placedInappPurchaseDataList,
        ) &&
        listEquals(
          this.placedInappSignatureList,
          other.placedInappSignatureList,
        ) &&
        this.signatureAlgorithm == other.signatureAlgorithm;
  }

  @override
  int get hashCode => Object.hash(
        continuationToken,
        errMsg,
        Object.hashAll(inAppPurchaseDataList ?? <Iterable<Object>>[]),
        Object.hashAll(inAppSignature ?? <Iterable<Object>>[]),
        Object.hashAll(itemList ?? <Iterable<Object>>[]),
        returnCode,
        status,
        Object.hashAll(placedInappPurchaseDataList ?? <Iterable<Object>>[]),
        Object.hashAll(placedInappSignatureList ?? <Iterable<Object>>[]),
        signatureAlgorithm,
      );
}

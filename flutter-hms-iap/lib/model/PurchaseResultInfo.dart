/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/
import 'dart:convert';

import 'InAppPurchaseData.dart';

class PurchaseResultInfo {
  int returnCode;
  InAppPurchaseData inAppPurchaseData;
  String inAppDataSignature;
  String errMsg;

  PurchaseResultInfo({
    this.inAppDataSignature,
    this.inAppPurchaseData,
    this.returnCode,
    this.errMsg,
  });

  factory PurchaseResultInfo.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;
    return PurchaseResultInfo(
        returnCode: map['a'] == null ? null : map['a'],
        inAppPurchaseData: InAppPurchaseData.fromJson(map['b']) == null
            ? null
            : InAppPurchaseData.fromJson(map['b']),
        inAppDataSignature: map['c'] == null ? null : map['c'],
        errMsg: map['d'] == null ? null : map['d']);
  }

  factory PurchaseResultInfo.fromJson(String source) =>
      PurchaseResultInfo.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['a'] = this.returnCode;
    data['b'] = this.inAppPurchaseData.toJson();
    data['c'] = this.inAppDataSignature;
    data['d'] = this.errMsg;
    return data;
  }

  String toJson() => json.encode(toMap());
}

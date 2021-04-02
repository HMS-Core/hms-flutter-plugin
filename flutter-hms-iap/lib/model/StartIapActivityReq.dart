/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'dart:convert' show json;
import 'package:flutter/foundation.dart' show required;

class StartIapActivityReq {
  static const int TYPE_SUBSCRIBE_MANAGER_ACTIVITY = 2;
  static const int TYPE_SUBSCRIBE_EDIT_ACTIVITY = 3;

  int type;
  String productId;

  StartIapActivityReq({
    @required this.type,
    this.productId,
  });

  factory StartIapActivityReq.fromJson(String str) =>
      StartIapActivityReq.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StartIapActivityReq.fromMap(Map<String, dynamic> json) =>
      StartIapActivityReq(
        type: json['type'] == null ? null : json['type'],
        productId: json['productId'] == null ? null : json['productId'],
      );

  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "productId": productId,
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final StartIapActivityReq check = o;
    return o is StartIapActivityReq &&
        check.type == type &&
        check.productId == productId;
  }

  @override
  int get hashCode => type.hashCode ^ productId.hashCode;
}

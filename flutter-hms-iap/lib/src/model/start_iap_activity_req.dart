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

/// Request information of the startIapActivity API.
class StartIapActivityReq {
  /// Redirects your app to the subscription management screen of HUAWEI IAP.
  static const int TYPE_SUBSCRIBE_MANAGER_ACTIVITY = 2;

  ///Redirects your app to the subscription editing screen of HUAWEI IAP.
  static const int TYPE_SUBSCRIBE_EDIT_ACTIVITY = 3;

  /// Type of the screen to be redirected to.
  ///
  /// - `2`: Subscription management screen.
  /// - `3`: Subscription editing screen.
  int type;

  /// ID of a subscription.
  String? productId;

  /// Creates a [StartIapActivityReq] object.
  StartIapActivityReq({
    required this.type,
    this.productId,
  });

  /// Creates a [StartIapActivityReq] object from a JSON string.
  factory StartIapActivityReq.fromJson(String str) =>
      StartIapActivityReq.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StartIapActivityReq.fromMap(Map<String, dynamic> json) =>
      StartIapActivityReq(
        type: json['type'],
        productId: json['productId'] == null ? null : json['productId'],
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'productId': productId,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is StartIapActivityReq &&
        this.type == other.type &&
        this.productId == other.productId;
  }

  @override
  int get hashCode => Object.hash(
        type,
        productId,
      );
}

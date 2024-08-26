/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of '../../huawei_adsprime.dart';

class BiddingInfo {
  /// Creative bid amount
  final double? price;

  /// Currency of the creative bid, for example, CNY and USD.
  final String? currency;

  /// Bidding success notification URL
  final String? nUrl;

  /// URL used to notify Huawei of its bidding failure and the success of another vendor
  final String? lUrl;

  BiddingInfo({
    this.price,
    this.currency,
    this.nUrl,
    this.lUrl,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'price': price,
      'currency': currency,
      'nUrl': nUrl,
      'lUrl': lUrl,
    };
  }

  static BiddingInfo fromJson(Map<String, dynamic> args) {
    return BiddingInfo(
      price: args['price'],
      currency: args['currency'],
      nUrl: args['nUrl'],
      lUrl: args['lUrl'],
    );
  }
}

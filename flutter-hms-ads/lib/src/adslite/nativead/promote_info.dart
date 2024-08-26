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

part of '../../../huawei_ads.dart';

class PromoteInfo {
  /// Promotion subtype.
  ///
  /// * `1`: Quick app.
  /// * `2`: WeChat mini-program.
  final int? promoteType;

  /// Name of the promoted entity.
  ///
  /// `NOTICE:`
  /// The value is URL-encoded. Your app needs to decode it before using it.
  final String? promoteName;

  PromoteInfo({this.promoteType, this.promoteName});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'promoteType': promoteType,
      'promoteName': promoteName,
    };
  }

  static PromoteInfo fromJson(Map<dynamic, dynamic> args) {
    return PromoteInfo(
      promoteType: args['promoteType'],
      promoteName: args['promoteName'],
    );
  }

  /// Converts [PromoteInfo] object into a String.
  @override
  String toString() {
    return 'PromoteInfo {promoteType: ${promoteType.toString()}, promoteName: $promoteName}';
  }
}

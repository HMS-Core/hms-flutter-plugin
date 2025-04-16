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

part of '../../../huawei_adsprime.dart';

class RewardVerifyConfig {
  /// User ID.
  ///
  /// `NOTE:`
  /// This is a user ID of a rewarded ad. This parameter can be combined with a URL and then the URL is encoded.
  /// In this case, the URL length cannot exceed 1024 bytes. Otherwise, the server-side verification is affected.
  String? userId;

  /// Custom data.
  ///
  /// `NOTE:`
  /// This is a custom parameter of a rewarded ad. This parameter can be combined with a URL and then the URL is encoded.
  /// In this case, the URL length cannot exceed 1024 bytes. Otherwise, the server-side verification is affected.
  String? data;

  RewardVerifyConfig({
    this.userId,
    this.data,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'data': data,
    };
  }
}

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

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:huawei_ml/bankcard/ml_bankcard_settings.dart';
import 'package:huawei_ml/models/ml_bankcard.dart';
import 'package:huawei_ml/utils/channels.dart';

class MLBankcardAnalyzer {
  final MethodChannel _channel = Channels.bankcardAnalyzerMethodChannel;

  Future<MLBankcard> analyzeBankcard(MlBankcardSettings settings) async {
    return new MLBankcard.fromJson(json.decode(
        await _channel.invokeMethod("analyzeBankcard", settings.toMap())));
  }

  Future<MLBankcard> captureBankcard({MlBankcardSettings settings}) async {
    return new MLBankcard.fromJson(json.decode(await _channel.invokeMethod(
        "captureBankcard",
        settings == null
            ? new MlBankcardSettings().toMap()
            : settings.toMap())));
  }

  Future<bool> stopBankcardAnalyzer() async {
    return await _channel.invokeMethod("stopBankcardAnalyzer");
  }
}

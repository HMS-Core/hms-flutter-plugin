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
import 'package:flutter/services.dart';
import 'package:huawei_ml/bankcard/ml_bankcard_settings.dart';
import 'package:huawei_ml/bankcard/model/ml_bankcard.dart';

class MlBankcardClient {
  static const MethodChannel _channel = const MethodChannel("bankcard");

  static _createBankcardFromResponse(String response) {
    Map<String, dynamic> cardObject = json.decode(response);
    final MlBankcard bankcard = new MlBankcard.fromJson(cardObject);
    return bankcard;
  }

  static Future<MlBankcard> analyzeBankcard(MlBankcardSettings settings) async {
    return _createBankcardFromResponse(
        await _channel.invokeMethod("analyzeBankcard", settings.toMap()));
  }

  static Future<MlBankcard> captureBankcard(MlBankcardSettings settings) async {
    return _createBankcardFromResponse(
        await _channel.invokeMethod("startCaptureActivity", settings.toMap()));
  }

  static Future<String> stopAnalyzer() async {
    return await _channel.invokeMethod("stopAnalyzer");
  }
}

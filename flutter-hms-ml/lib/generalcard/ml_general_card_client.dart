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
import 'package:huawei_ml/generalcard/ml_general_card_settings.dart';
import 'model/ml_general_card.dart';

class MlGeneralCardClient {
  static const MethodChannel _channel = const MethodChannel("general_card");

  static _createGeneralCardFromResponse(String response) {
    Map<String, dynamic> object = json.decode(response);
    final MlGeneralCard card = new MlGeneralCard.fromJson(object);
    return card;
  }

  static Future<MlGeneralCard> getResultWithCapturing(
      MlGeneralCardSettings settings) async {
    return _createGeneralCardFromResponse(
        await _channel.invokeMethod("startCaptureActivity", settings.toMap()));
  }

  static Future<MlGeneralCard> getResultWithTakingPicture(
      MlGeneralCardSettings settings) async {
    return _createGeneralCardFromResponse(await _channel.invokeMethod(
        "startPictureTakingActivity", settings.toMap()));
  }

  static Future<MlGeneralCard> getResultWithLocalImage(
      MlGeneralCardSettings settings) async {
    return _createGeneralCardFromResponse(
        await _channel.invokeMethod("localImage", settings.toMap()));
  }
}

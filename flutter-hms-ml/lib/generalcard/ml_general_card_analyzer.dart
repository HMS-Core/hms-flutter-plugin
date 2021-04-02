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
import 'package:huawei_ml/generalcard/ml_general_card_analyzer_setting.dart';
import 'package:huawei_ml/utils/channels.dart';
import '../models/ml_general_card.dart';

class MLGeneralCardAnalyzer {
  final MethodChannel _channel = Channels.generalCardMethodChannel;

  Future<MLGeneralCard> capturePreview(
      MLGeneralCardAnalyzerSetting setting) async {
    return new MLGeneralCard.fromJson(json.decode(
        await _channel.invokeMethod("capturePreview", setting.toMap())));
  }

  Future<MLGeneralCard> capturePhoto(
      MLGeneralCardAnalyzerSetting setting) async {
    return new MLGeneralCard.fromJson(json
        .decode(await _channel.invokeMethod("capturePhoto", setting.toMap())));
  }

  Future<MLGeneralCard> captureImage(
      MLGeneralCardAnalyzerSetting setting) async {
    return new MLGeneralCard.fromJson(json
        .decode(await _channel.invokeMethod("captureImage", setting.toMap())));
  }
}

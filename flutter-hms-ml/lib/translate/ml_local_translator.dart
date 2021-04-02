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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_ml/translate/ml_translate_setting.dart';
import 'package:huawei_ml/utils/channels.dart';

class MLLocalTranslator {
  final MethodChannel _channel = Channels.localTranslatorMethodChannel;

  Future<List<dynamic>> getLocalAllLanguages() async {
    return await _channel.invokeMethod("getLocalAllLanguages");
  }

  Future<List<dynamic>> syncGetLocalAllLanguages() async {
    return await _channel.invokeMethod("syncGetLocalAllLanguages");
  }

  Future<bool> prepareModel({@required MLTranslateSetting setting}) async {
    return await _channel.invokeMethod("prepareModel", setting.toMap());
  }

  Future<bool> deleteModel(String langCode) async {
    return await _channel
        .invokeMethod("deleteModel", <String, dynamic>{'langCode': langCode});
  }

  Future<String> asyncTranslate({@required String sourceText}) async {
    return await _channel.invokeMethod(
        "asyncTranslate", <String, dynamic>{'sourceText': sourceText});
  }

  Future<String> syncTranslate({@required String sourceText}) async {
    return await _channel.invokeMethod(
        "syncTranslate", <String, dynamic>{'sourceText': sourceText});
  }

  Future<bool> stopTranslate() async {
    return await _channel.invokeMethod("stop");
  }
}

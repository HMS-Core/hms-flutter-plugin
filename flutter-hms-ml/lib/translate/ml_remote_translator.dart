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

import 'package:flutter/services.dart';
import 'package:huawei_ml/translate/ml_translate_setting.dart';
import 'package:huawei_ml/utils/channels.dart';
import 'package:flutter/material.dart';

class MLRemoteTranslator {
  final MethodChannel _channel = Channels.remoteTranslatorMethodChannel;

  Future<List<dynamic>> getCloudAllLanguages() async {
    return await _channel.invokeMethod("getCloudAllLanguages");
  }

  Future<List<dynamic>> syncGetCloudAllLanguages() async {
    return await _channel.invokeMethod("syncGetCloudAllLanguages");
  }

  Future<String> asyncTranslate({@required MLTranslateSetting setting}) async {
    return await _channel.invokeMethod("asyncTranslate", setting.toMap());
  }

  Future<String> syncTranslate({@required MLTranslateSetting setting}) async {
    return await _channel.invokeMethod("syncTranslate", setting.toMap());
  }

  Future<bool> stopTranslate() async {
    return await _channel.invokeMethod("stop");
  }
}

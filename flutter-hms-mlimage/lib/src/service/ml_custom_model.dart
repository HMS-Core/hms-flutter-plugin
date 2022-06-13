/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ml_image/src/common/xport.dart';
import 'package:huawei_ml_image/src/request/xport.dart';

class MLCustomModel {
  late MethodChannel _channel;

  MLCustomModel() {
    _channel = MethodChannel("$baseChannel.custom_model");
  }

  Future<bool> createBitmap(String imagePath) async {
    return await _channel.invokeMethod(mCreateBitmap, {"path": imagePath});
  }

  Future<bool> downloadRemoteModel(
    String remoteModelName,
    String assetPath,
  ) async {
    return await _channel.invokeMethod(mDownloadRemoteModel, {
      "modelName": remoteModelName,
      "assetPath": assetPath,
    });
  }

  Future<bool> prepareExecutor(
    String modelName,
    String assetPath,
  ) async {
    return await _channel.invokeMethod(mPrepareExecutor, {
      "modelName": modelName,
      "assetPath": assetPath,
    });
  }

  Future<Map<dynamic, dynamic>> startExecutor(
    MLModelInputOutputSettings settings,
    String labelFileName,
  ) async {
    return await _channel.invokeMethod(mStartExecutor, {
      "settings": settings.toMap(),
      "labelFileName": labelFileName,
    });
  }

  Future<int> getOutputIndex(String name) async {
    return await _channel.invokeMethod(mGetOutputIndex, {'name': name});
  }

  Future<bool> stopExecutor() async {
    return await _channel.invokeMethod(mStopModelExecutor);
  }
}

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
import 'package:huawei_ml/document/ml_document_settings.dart';
import 'package:huawei_ml/document/model/ml_document.dart';

class MlDocumentClient {
  static const MethodChannel _channel =
      const MethodChannel("document_analyzer");

  static Future<MlDocument> getDocumentAnalyzeInformation(
      MlDocumentSettings settings) async {
    final String response =
        await _channel.invokeMethod("analyzeDocument", settings.toMap());
    Map<String, dynamic> documentObject = json.decode(response);
    final MlDocument mlDocument = new MlDocument.fromJson(documentObject);
    return mlDocument;
  }

  static Future<String> closeAnalyzer() async {
    final String response = await _channel.invokeMethod("closeAnalyzer");
    return response;
  }
}

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
import 'package:huawei_ml/productvisionsearch/model/ml_product_vision_search.dart';
import 'package:huawei_ml/productvisionsearch/ml_product_vision_search_settings.dart';

class MlProductVisionSearchClient {
  static const MethodChannel _channel =
      const MethodChannel("product_vision_search");

  static Future<MlProductVisionSearch> getProductVisionSearchResult(
      MlProductVisionSearchSettings settings) async {
    MlProductVisionSearch productVisionSearch;
    final String response =
        await _channel.invokeMethod("startAnalyze", settings.toMap());
    Map<String, dynamic> object = json.decode(response);
    if (object.isNotEmpty) {
      productVisionSearch = new MlProductVisionSearch.fromJson(object);
    }
    return productVisionSearch;
  }

  static Future<String> stopAnalyzer() async {
    final String response = await _channel.invokeMethod("stopAnalyzer");
    return response;
  }
}

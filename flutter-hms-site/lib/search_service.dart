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

import 'package:flutter/services.dart';

import 'model/detail_search_request.dart';
import 'model/detail_search_response.dart';
import 'model/nearby_search_request.dart';
import 'model/nearby_search_response.dart';
import 'model/query_suggestion_request.dart';
import 'model/query_suggestion_response.dart';
import 'model/text_search_request.dart';
import 'model/text_search_response.dart';

class SearchService {
  static SearchService _instance;
  final MethodChannel _methodChannel;

  SearchService._create(this._methodChannel);

  factory SearchService() {
    if (_instance == null) {
      final MethodChannel methodChannel =
          const MethodChannel('com.huawei.hms.flutter.site/method');
      _instance = SearchService._create(
        methodChannel,
      );
    }
    return _instance;
  }

  Future<TextSearchResponse> textSearch(TextSearchRequest request) async {
    return TextSearchResponse.fromJson(
        await _methodChannel.invokeMethod('textSearch', request.toMap()));
  }

  Future<NearbySearchResponse> nearbySearch(NearbySearchRequest request) async {
    return NearbySearchResponse.fromJson(
        await _methodChannel.invokeMethod('nearbySearch', request.toMap()));
  }

  Future<DetailSearchResponse> detailSearch(DetailSearchRequest request) async {
    return DetailSearchResponse.fromJson(
        await _methodChannel.invokeMethod('detailSearch', request.toMap()));
  }

  Future<QuerySuggestionResponse> querySuggestion(
      QuerySuggestionRequest request) async {
    return QuerySuggestionResponse.fromJson(
        await _methodChannel.invokeMethod('querySuggestion', request.toMap()));
  }
}

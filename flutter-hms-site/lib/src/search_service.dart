/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_site;

class SearchService {
  final MethodChannel _methodChannel;

  SearchService._create(this._methodChannel);

  /// Creates the SearchService instance.
  ///
  /// - `apiKey` parameter is required.
  /// - You can set the data routing location.
  /// The options for `routePolicy` are CN (China), DE (Germany), SG (Singapore), and RU (Russia).
  static Future<SearchService> create({
    required String apiKey,
    String? routePolicy,
  }) async {
    const MethodChannel methodChannel = MethodChannel(
      'com.huawei.hms.flutter.site/MethodChannel',
    );
    final SearchService instance = SearchService._create(methodChannel);
    await methodChannel.invokeMethod<void>('initService', {
      'apiKey': apiKey,
      'routePolicy': routePolicy,
    });
    return instance;
  }

  Future<TextSearchResponse> textSearch(
    TextSearchRequest request,
  ) async {
    return TextSearchResponse.fromJson(
      (await (_methodChannel.invokeMethod<String>(
        'textSearch',
        request.toJson(),
      )))!,
    );
  }

  Future<NearbySearchResponse> nearbySearch(
    NearbySearchRequest request,
  ) async {
    return NearbySearchResponse.fromJson(
      (await (_methodChannel.invokeMethod<String>(
        'nearbySearch',
        request.toJson(),
      )))!,
    );
  }

  Future<DetailSearchResponse> detailSearch(
    DetailSearchRequest request,
  ) async {
    return DetailSearchResponse.fromJson(
      (await (_methodChannel.invokeMethod<String>(
        'detailSearch',
        request.toJson(),
      )))!,
    );
  }

  Future<QuerySuggestionResponse> querySuggestion(
    QuerySuggestionRequest request,
  ) async {
    return QuerySuggestionResponse.fromJson(
      (await (_methodChannel.invokeMethod<String>(
        'querySuggestion',
        request.toJson(),
      )))!,
    );
  }

  Future<QueryAutocompleteResponse> queryAutocomplete(
    QueryAutocompleteRequest request,
  ) async {
    return QueryAutocompleteResponse.fromJson(
      (await (_methodChannel.invokeMethod<String>(
        'queryAutocomplete',
        request.toJson(),
      )))!,
    );
  }

  Future<Site> startSiteSearchActivity(
    SearchIntent searchIntent,
  ) async {
    return Site.fromJson(
      (await (_methodChannel.invokeMethod<String>(
        'startSiteSearchActivity',
        searchIntent.toMap(),
      )))!,
    );
  }

  Future<void> enableLogger() async {
    return await _methodChannel.invokeMethod<void>(
      'enableLogger',
    );
  }

  Future<void> disableLogger() async {
    return await _methodChannel.invokeMethod<void>(
      'disableLogger',
    );
  }
}

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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_site/huawei_site.dart';

import '../widgets/custom_button.dart';
import 'detail_search_screen.dart';
import 'nearby_search_screen.dart';
import 'querysuggestion_search_screen.dart';
import 'text_search_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  static const String apiKey = '<api_key>';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _showAlertDialog({String? title, String? message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title!),
          content: Text(message!),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _siteSearch() async {
    final SearchFilter searchFilter = SearchFilter(
      poiType: <LocationType>[LocationType.TOURIST_ATTRACTION],
    );
    final SearchIntent searchIntent = SearchIntent(
      HomeScreen.apiKey,
      searchFilter: searchFilter,
    );
    final SearchService searchService = await SearchService.create(
      apiKey: HomeScreen.apiKey,
      routePolicy: 'CN',
    );

    try {
      final Site site = await searchService.startSiteSearchActivity(
        searchIntent,
      );

      _showAlertDialog(
        title: site.name,
        message: site.toString(),
      );
    } on PlatformException catch (e) {
      _showAlertDialog(
        title: 'ERROR',
        message:
            '${e.message!}, result code returned to SearchStatus object. $e',
      );
    }
  }

  void _queryAutocomplete() async {
    final SearchService searchService = await SearchService.create(
      apiKey: HomeScreen.apiKey,
      routePolicy: 'CN',
    );
    final QueryAutocompleteRequest request = QueryAutocompleteRequest(
      query: 'Istanbul',
    );

    try {
      final QueryAutocompleteResponse response =
          await searchService.queryAutocomplete(request);

      _showAlertDialog(
        title: 'QueryAutocompleteRequest',
        message: response.toString(),
      );
    } on PlatformException catch (e) {
      _showAlertDialog(
        title: 'Error',
        message: e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HMS Site Kit Flutter Demo'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CustomButton(
                text: 'Text Search',
                onPressed: () {
                  Navigator.pushNamed(context, TextSearchScreen.id);
                },
              ),
              CustomButton(
                text: 'Nearby Search',
                onPressed: () {
                  Navigator.pushNamed(context, NearbySearchScreen.id);
                },
              ),
              CustomButton(
                text: 'Place Detail Search',
                onPressed: () {
                  Navigator.pushNamed(context, DetailSearchScreen.id);
                },
              ),
              CustomButton(
                text: 'Query Suggestion Search',
                onPressed: () {
                  Navigator.pushNamed(context, QuerySuggestionSearchScreen.id);
                },
              ),
              CustomButton(
                text: 'Query Autocomplete',
                onPressed: _queryAutocomplete,
              ),
              CustomButton(
                text: 'Site Search',
                onPressed: _siteSearch,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

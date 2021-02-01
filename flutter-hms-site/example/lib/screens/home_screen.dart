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
import 'package:huawei_site/model/location_type.dart';
import 'package:huawei_site/model/query_autocomplete_request.dart';
import 'package:huawei_site/model/query_autocomplete_response.dart';
import 'package:huawei_site/model/search_filter.dart';
import 'package:huawei_site/model/search_intent.dart';
import 'package:huawei_site/model/site.dart';
import 'package:huawei_site/search_service.dart';

import '../keys.dart';
import '../widgets/custom_button.dart';
import 'detail_search_screen.dart';
import 'nearby_search_screen.dart';
import 'querysuggestion_search_screen.dart';
import 'text_search_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  static const String API_KEY = '<api_key>';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _showAlertDialog({String title, String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            FlatButton(
              child: Text("Close"),
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
    final SearchFilter _searchFilter =
        SearchFilter(poiType: <LocationType>[LocationType.TOURIST_ATTRACTION]);

    final SearchIntent _searchIntent =
        SearchIntent(HomeScreen.API_KEY, searchFilter: _searchFilter);

    final SearchService _searchService =
        await SearchService.create(HomeScreen.API_KEY);

    try {
      final Site _site =
          await _searchService.startSiteSearchActivity(_searchIntent);

      _showAlertDialog(
        title: _site.name,
        message: _site.toString(),
      );
    } on PlatformException catch (e) {
      _showAlertDialog(
        title: "Error",
        message: e.toString(),
      );
    }
  }

  void _queryAutocomplete() async {
    final SearchService _searchService =
        await SearchService.create(HomeScreen.API_KEY);
    final QueryAutocompleteRequest request =
        QueryAutocompleteRequest(query: "Istanbul");

    try {
      final QueryAutocompleteResponse response =
          await _searchService.queryAutocomplete(request);

      _showAlertDialog(
        title: "QueryAutocompleteRequest",
        message: response.toString(),
      );
    } on PlatformException catch (e) {
      _showAlertDialog(
        title: "Error",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CustomButton(
              key: Key(Keys.SCREEN_TEXT),
              text: "Text Search",
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  TextSearchScreen.id,
                );
              },
            ),
            CustomButton(
              key: Key(Keys.SCREEN_NEARBY),
              text: "Nearby Search",
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  NearbySearchScreen.id,
                );
              },
            ),
            CustomButton(
              key: Key(Keys.SCREEN_DETAIL),
              text: "Place Detail Search",
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  DetailSearchScreen.id,
                );
              },
            ),
            CustomButton(
              key: Key(Keys.SCREEN_QUERY),
              text: "Query Suggestion Search",
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  QuerySuggestionSearchScreen.id,
                );
              },
            ),
            CustomButton(
              key: Key(Keys.QUERY_COMPLETE),
              text: "Query Autocomplete",
              onPressed: _queryAutocomplete,
            ),
            CustomButton(
              key: Key(Keys.SITE_SEARCH),
              text: "Site Search",
              onPressed: _siteSearch,
            ),
          ],
        ),
      ),
    );
  }
}

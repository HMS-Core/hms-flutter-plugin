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

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:huawei_site/huawei_site.dart';
import 'package:huawei_site_example/screens/home_screen.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_checkbox.dart';
import '../widgets/custom_text_form_field.dart';

class QuerySuggestionSearchScreen extends StatefulWidget {
  static const String id = 'query_suggestion_search_screen';

  const QuerySuggestionSearchScreen({Key? key}) : super(key: key);

  @override
  State<QuerySuggestionSearchScreen> createState() =>
      _QuerySuggestionSearchScreenState();
}

class _QuerySuggestionSearchScreenState
    extends State<QuerySuggestionSearchScreen> {
  final TextEditingController _queryTextController = TextEditingController(
    text: 'Paris',
  );
  final TextEditingController _languageTextController = TextEditingController(
    text: 'en',
  );
  final TextEditingController _countryTextController = TextEditingController(
    text: 'FR',
  );
  final TextEditingController _latTextController = TextEditingController(
    text: '48.893478',
  );
  final TextEditingController _lngTextController = TextEditingController(
    text: '2.334595',
  );
  final TextEditingController _radiusTextController = TextEditingController(
    text: '5000',
  );

  List<String> _selectedCheckbox = <String>['en', 'fr', 'cn', 'de', 'ko'];
  late QuerySuggestionRequest _request;
  late String _results;
  late SearchService _searchService;

  @override
  void initState() {
    super.initState();
    initService();
    _results = '';
  }

  void initService() async {
    _searchService = await SearchService.create(
      apiKey: HomeScreen.apiKey,
      routePolicy: 'CN',
    );
  }

  void runSearch() async {
    _request.location = Coordinate(
      lat: double.parse(_latTextController.text),
      lng: double.parse(_lngTextController.text),
    );
    _request.radius = int.parse(_radiusTextController.text);
    _request.countryCode = _countryTextController.text;
    _request.language = _languageTextController.text;
    _request.children = true;

    try {
      QuerySuggestionResponse response =
          await _searchService.querySuggestion(_request);
      setState(() {
        _results = response.toJson();
        log(_results);
      });
    } catch (e) {
      setState(() {
        _results = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _request = QuerySuggestionRequest(
      query: _queryTextController.text,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Query Suggestion Search'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CustomTextFormField(
                      labelText: 'Query Text',
                      controller: _queryTextController,
                    ),
                    CustomTextFormField(
                      labelText: 'Language',
                      controller: _languageTextController,
                    ),
                    CustomTextFormField(
                      labelText: 'Country Code',
                      controller: _countryTextController,
                    ),
                    CustomTextFormField(
                      labelText: 'Latitude',
                      controller: _latTextController,
                    ),
                    CustomTextFormField(
                      labelText: 'Longitude',
                      controller: _lngTextController,
                    ),
                    CustomTextFormField(
                      labelText: 'Radius',
                      controller: _radiusTextController,
                    ),
                    CustomCheckboxWithFormField(
                      context: context,
                      buttonText: 'Countries',
                      onSaved: (List<String>? countries) {
                        setState(() {
                          _selectedCheckbox = countries!;
                          _request.countries = _selectedCheckbox;
                        });
                      },
                      dialogItemList: _selectedCheckbox,
                      dialogTitleText: 'Select/Add Country Codes',
                      initialValue: _selectedCheckbox,
                    ),
                    CustomButton(
                      text: 'Search',
                      onPressed: runSearch,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: Text(
                _results,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

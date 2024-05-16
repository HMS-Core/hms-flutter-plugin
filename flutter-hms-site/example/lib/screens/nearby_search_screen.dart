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
import '../widgets/custom_text_form_field.dart';

class NearbySearchScreen extends StatefulWidget {
  static const String id = 'nearby_search_screen';

  const NearbySearchScreen({Key? key}) : super(key: key);

  @override
  State<NearbySearchScreen> createState() => _NearbySearchScreenState();
}

class _NearbySearchScreenState extends State<NearbySearchScreen> {
  final TextEditingController _queryTextController = TextEditingController(
    text: 'Eiffel Tower',
  );
  final TextEditingController _languageTextController = TextEditingController(
    text: 'en',
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
  final TextEditingController _pageIndexTextController = TextEditingController(
    text: '1',
  );
  final TextEditingController _pageSizeTextController = TextEditingController(
    text: '20',
  );

  late NearbySearchRequest _request;
  late String _results;
  late SearchService _searchService;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    _request = NearbySearchRequest(
      location: Coordinate(
        lat: double.parse(_latTextController.text),
        lng: double.parse(_lngTextController.text),
      ),
    );
    _request.query = _queryTextController.text;
    _request.language = _languageTextController.text;
    _request.pageIndex = int.parse(_pageIndexTextController.text);
    _request.pageSize = int.parse(_pageSizeTextController.text);
    _request.radius = int.parse(_radiusTextController.text);
    try {
      NearbySearchResponse response = await _searchService.nearbySearch(
        _request,
      );
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Search'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Form(
                  key: _formKey,
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
                      CustomTextFormField(
                        labelText: 'PageIndex',
                        controller: _pageIndexTextController,
                      ),
                      CustomTextFormField(
                        labelText: 'PageSize',
                        controller: _pageSizeTextController,
                      ),
                      CustomButton(
                        text: 'Search',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            runSearch();
                          }
                        },
                      ),
                    ],
                  ),
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

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

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:huawei_site/model/coordinate.dart';
import 'package:huawei_site/model/hwlocation_type.dart';
import 'package:huawei_site/model/location_type.dart';
import 'package:huawei_site/model/text_search_request.dart';
import 'package:huawei_site/model/text_search_response.dart';
import 'package:huawei_site/search_service.dart';
import 'package:huawei_site_example/screens/home_screen.dart';

import '../keys.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class TextSearchScreen extends StatefulWidget {
  static const String id = 'text_search_screen';

  @override
  _TextSearchScreenState createState() => _TextSearchScreenState();
}

class _TextSearchScreenState extends State<TextSearchScreen> {
  final TextEditingController _queryTextController =
      TextEditingController(text: "Eiffel Tower");
  final TextEditingController _languageTextController =
      TextEditingController(text: "en");
  final TextEditingController _countryTextController =
      TextEditingController(text: "FR");
  final TextEditingController _latTextController =
      TextEditingController(text: "48.893478");
  final TextEditingController _lngTextController =
      TextEditingController(text: "2.334595");
  final TextEditingController _radiusTextController =
      TextEditingController(text: "5000");
  final TextEditingController _pageIndexTextController =
      TextEditingController(text: "1");
  final TextEditingController _pageSizeTextController =
      TextEditingController(text: "20");

  final TextSearchRequest _request = TextSearchRequest();

  String _results;
  SearchService _searchService;

  @override
  void initState() {
    super.initState();
    initService();
    _results = "";
  }

  void initService() async {
    _searchService = await SearchService.create(HomeScreen.API_KEY);
  }

  void runSearch() async {
    _request.query = _queryTextController.text;
    _request.location = Coordinate(
      lat: double.parse(_latTextController.text),
      lng: double.parse(_lngTextController.text),
    );
    _request.language = _languageTextController.text;
    _request.countryCode = _countryTextController.text;
    _request.pageIndex = int.parse(_pageIndexTextController.text);
    _request.pageSize = int.parse(_pageSizeTextController.text);
    _request.radius = int.parse(_radiusTextController.text);
    _request.hwPoiType = HwLocationType.TOWER;
    _request.location =
        Coordinate(lat: 48.85757246679441, lng: 2.2924174770714916);
    _request.poiType = LocationType.TOURIST_ATTRACTION;

    try {
      TextSearchResponse response = await _searchService.textSearch(_request);
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
        title: const Text('Text Search'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CustomTextFormField(
                      labelText: "Query Text",
                      controller: _queryTextController,
                    ),
                    CustomTextFormField(
                      labelText: "Language",
                      controller: _languageTextController,
                    ),
                    CustomTextFormField(
                      labelText: "Country Code",
                      controller: _countryTextController,
                    ),
                    CustomTextFormField(
                      labelText: "Latitude",
                      controller: _latTextController,
                    ),
                    CustomTextFormField(
                      labelText: "Longitude",
                      controller: _lngTextController,
                    ),
                    CustomTextFormField(
                      labelText: "Radius",
                      controller: _radiusTextController,
                    ),
                    CustomTextFormField(
                      labelText: "PageIndex",
                      controller: _pageIndexTextController,
                    ),
                    CustomTextFormField(
                      labelText: "PageSize",
                      controller: _pageSizeTextController,
                    ),
                    CustomButton(
                      key: Key(Keys.SEARCH_TEXT),
                      text: "Search",
                      onPressed: () {
                        runSearch();
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Text(
                _results,
                key: Key(Keys.RESULT_TEXT),
                style: TextStyle(
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

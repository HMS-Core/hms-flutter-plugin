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

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:huawei_site/model/coordinate.dart';
import 'package:huawei_site/model/nearby_search_request.dart';
import 'package:huawei_site/model/nearby_search_response.dart';
import 'package:huawei_site/search_service.dart';

import '../keys.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class NearbySearchScreen extends StatefulWidget {
  static const String id = 'nearby_search_screen';

  @override
  _NearbySearchScreenState createState() => _NearbySearchScreenState();
}

class _NearbySearchScreenState extends State<NearbySearchScreen> {
  String results;

  final SearchService searchService = SearchService();
  final NearbySearchRequest request = NearbySearchRequest();

  final TextEditingController queryTextController =
      TextEditingController(text: "Eiffel Tower");
  final TextEditingController languageTextController =
      TextEditingController(text: "en");
  final TextEditingController latTextController =
      TextEditingController(text: "48.893478");
  final TextEditingController lngTextController =
      TextEditingController(text: "2.334595");
  final TextEditingController radiusTextController =
      TextEditingController(text: "5000");
  final TextEditingController pageIndexTextController =
      TextEditingController(text: "1");
  final TextEditingController pageSizeTextController =
      TextEditingController(text: "20");

  @override
  void initState() {
    super.initState();
    results = "";
  }

  void runSearch() async {
    request.query = queryTextController.text;
    request.location = Coordinate(
      lat: double.parse(latTextController.text),
      lng: double.parse(lngTextController.text),
    );
    request.language = languageTextController.text;
    request.pageIndex = int.parse(pageIndexTextController.text);
    request.pageSize = int.parse(pageSizeTextController.text);
    request.radius = int.parse(radiusTextController.text);

    try {
      NearbySearchResponse response = await searchService.nearbySearch(request);
      setState(() {
        results = response.toJson();
        log(results);
      });
    } catch (e) {
      setState(() {
        results = e.toString();
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
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CustomTextFormField(
                      labelText: "Query Text",
                      controller: queryTextController,
                    ),
                    CustomTextFormField(
                      labelText: "Language",
                      controller: languageTextController,
                    ),
                    CustomTextFormField(
                      labelText: "Latitude",
                      controller: latTextController,
                    ),
                    CustomTextFormField(
                      labelText: "Longitude",
                      controller: lngTextController,
                    ),
                    CustomTextFormField(
                      labelText: "Radius",
                      controller: radiusTextController,
                    ),
                    CustomTextFormField(
                      labelText: "PageIndex",
                      controller: pageIndexTextController,
                    ),
                    CustomTextFormField(
                      labelText: "PageSize",
                      controller: pageSizeTextController,
                    ),
                    CustomButton(
                      key: Key(Keys.SEARCH_NEARBY),
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
                results,
                key: Key(Keys.RESULT_NEARBY),
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

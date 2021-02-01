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
import 'package:huawei_site/model/detail_search_request.dart';
import 'package:huawei_site/model/detail_search_response.dart';
import 'package:huawei_site/search_service.dart';
import 'package:huawei_site_example/screens/home_screen.dart';

import '../keys.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class DetailSearchScreen extends StatefulWidget {
  static const String id = 'detail_search_screen';

  @override
  _DetailSearchScreenState createState() => _DetailSearchScreenState();
}

class _DetailSearchScreenState extends State<DetailSearchScreen> {
  final TextEditingController _siteIdTextController =
      TextEditingController(text: "977B75943A9F01D561FF2073AE1D9353");
  final TextEditingController _languageTextController =
      TextEditingController(text: "en");

  final DetailSearchRequest _request = DetailSearchRequest();

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
    _request.siteId = _siteIdTextController.text;
    _request.language = _languageTextController.text;

    try {
      DetailSearchResponse response =
          await _searchService.detailSearch(_request);
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
        title: const Text('Place Detail Search'),
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
                      labelText: "Site ID",
                      controller: _siteIdTextController,
                    ),
                    CustomTextFormField(
                      labelText: "Language",
                      controller: _languageTextController,
                    ),
                    CustomButton(
                      key: Key(Keys.SEARCH_DETAIL),
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
              child: new Text(
                _results,
                key: Key(Keys.RESULT_DETAIL),
                style: new TextStyle(
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

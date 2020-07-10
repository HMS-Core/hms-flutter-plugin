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
import 'package:huawei_site/model/detail_search_request.dart';
import 'package:huawei_site/model/detail_search_response.dart';
import 'package:huawei_site/search_service.dart';

import '../keys.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class DetailSearchScreen extends StatefulWidget {
  static const String id = 'detail_search_screen';

  @override
  _DetailSearchScreenState createState() => _DetailSearchScreenState();
}

class _DetailSearchScreenState extends State<DetailSearchScreen> {
  String results;

  final SearchService searchService = SearchService();
  final DetailSearchRequest request = DetailSearchRequest();

  final TextEditingController siteIdTextController =
      TextEditingController(text: "977B75943A9F01D561FF2073AE1D9353");
  final TextEditingController languageTextController =
      TextEditingController(text: "en");

  @override
  void initState() {
    super.initState();
    results = "";
  }

  void runSearch() async {
    request.siteId = siteIdTextController.text;
    request.language = languageTextController.text;

    try {
      DetailSearchResponse response = await searchService.detailSearch(request);
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
                      controller: siteIdTextController,
                    ),
                    CustomTextFormField(
                      labelText: "Language",
                      controller: languageTextController,
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
                results,
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

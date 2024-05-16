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

import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import 'home_screen.dart';

class DetailSearchScreen extends StatefulWidget {
  static const String id = 'detail_search_screen';

  const DetailSearchScreen({Key? key}) : super(key: key);

  @override
  State<DetailSearchScreen> createState() => _DetailSearchScreenState();
}

class _DetailSearchScreenState extends State<DetailSearchScreen> {
  final TextEditingController _siteIdTextController = TextEditingController(
    text: '977B75943A9F01D561FF2073AE1D9353',
  );
  final TextEditingController _languageTextController = TextEditingController(
    text: 'en',
  );

  late DetailSearchRequest _request;
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
    _request = DetailSearchRequest(
      siteId: _siteIdTextController.text,
    );
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
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CustomTextFormField(
                        labelText: 'Site ID',
                        controller: _siteIdTextController,
                      ),
                      CustomTextFormField(
                        labelText: 'Language',
                        controller: _languageTextController,
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

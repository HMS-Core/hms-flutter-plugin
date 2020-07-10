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

import 'package:flutter/material.dart';

import '../keys.dart';
import '../widgets/custom_button.dart';
import 'detail_search_screen.dart';
import 'nearby_search_screen.dart';
import 'querysuggestion_search_screen.dart';
import 'text_search_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';

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
          ],
        ),
      ),
    );
  }
}

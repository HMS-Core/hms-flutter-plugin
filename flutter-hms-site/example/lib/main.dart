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

import 'screens/detail_search_screen.dart';
import 'screens/home_screen.dart';
import 'screens/nearby_search_screen.dart';
import 'screens/querysuggestion_search_screen.dart';
import 'screens/text_search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomeScreen(),
      routes: <String, Widget Function(BuildContext)>{
        HomeScreen.id: (BuildContext context) {
          return const HomeScreen();
        },
        TextSearchScreen.id: (BuildContext context) {
          return const TextSearchScreen();
        },
        NearbySearchScreen.id: (BuildContext context) {
          return const NearbySearchScreen();
        },
        DetailSearchScreen.id: (BuildContext context) {
          return const DetailSearchScreen();
        },
        QuerySuggestionSearchScreen.id: (BuildContext context) {
          return const QuerySuggestionSearchScreen();
        },
      },
    );
  }
}

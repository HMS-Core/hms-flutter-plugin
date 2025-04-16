/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ml_text_example/screens/bcr_example.dart';
import 'package:huawei_ml_text_example/screens/document_example.dart';
import 'package:huawei_ml_text_example/screens/form_example.dart';
import 'package:huawei_ml_text_example/screens/gcr_example.dart';
import 'package:huawei_ml_text_example/screens/icr_example.dart';
import 'package:huawei_ml_text_example/screens/lens_example.dart';
import 'package:huawei_ml_text_example/screens/text_embedding_example.dart';
import 'package:huawei_ml_text_example/screens/text_example.dart';
import 'package:huawei_ml_text_example/utils/constants.dart';
import 'package:huawei_ml_text_example/utils/utils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: demoAppBar(homeAppbarText),
      body: SafeArea(
        child: Padding(
          padding: smallPadding(context),
          child: Material(
            child: _columnItems(context),
          ),
        ),
      ),
    );
  }

  Widget _columnItems(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _paddingRow(
          context,
          _homePageRowItems(
            name: <String>['Text', 'Document', 'Bankcard'],
            imagePath: <String>['text', 'doc', 'bcr'],
            page: <Widget>[
              const TextExample(),
              const DocumentExample(),
              const BcrExample(),
            ],
          ),
        ),
        _paddingRow(
          context,
          _homePageRowItems(
            name: <String>['Embed', 'Lens', 'Form'],
            imagePath: <String>['textembed', 'textlens', 'text'],
            page: <Widget>[
              const TextEmbeddingExample(),
              const LensExample(),
              const FormExample(),
            ],
          ),
        ),
        Padding(
          padding: smallAllPadding(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              CustomGridElement(
                name: 'General\nCard',
                imagePath: 'gcr',
                page: GcrExample(),
              ),
              CustomGridElement(
                name: 'ID\nCard',
                imagePath: 'icr',
                page: IcrExample(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _paddingRow(
    BuildContext context,
    List<Widget> child,
  ) {
    return Padding(
      padding: smallAllPadding(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: child,
      ),
    );
  }

  List<Widget> _homePageRowItems({
    required List<String> name,
    required List<String> imagePath,
    required List<Widget> page,
  }) {
    return <Widget>[
      CustomGridElement(
        name: name.first,
        imagePath: imagePath.first,
        page: page.first,
      ),
      CustomGridElement(
        name: name.elementAt(1),
        imagePath: imagePath.elementAt(1),
        page: page.elementAt(1),
      ),
      CustomGridElement(
        name: name.elementAt(2),
        imagePath: imagePath.elementAt(2),
        page: page.elementAt(2),
      ),
    ];
  }
}

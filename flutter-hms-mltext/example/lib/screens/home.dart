/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ml_text_example/screens/lens_example.dart';
import 'package:huawei_ml_text_example/utils/constants.dart';
import 'bcr_example.dart';
import 'document_example.dart';
import 'form_example.dart';
import 'gcr_example.dart';
import 'icr_example.dart';
import 'text_embedding_example.dart';
import 'text_example.dart';
import '../utils/utils.dart';

import 'package:huawei_ml_text/huawei_ml_text.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    _setApiKey();
    _handlePermissions();
    super.initState();
  }

  _setApiKey() {
    MLTextApplication().setApiKey(homeApiKey);
  }

  _handlePermissions() async {
    await MLTextPermissions().requestPermission(
        [TextPermission.camera, TextPermission.storage]).then((granted) {
      if (!granted) {
        _handlePermissions();
      }
    });
  }

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
      children: [
        _paddingRow(
            context,
            _homePageRowItems(
                name: ["Text", "Document", "Bankcard"],
                imagePath: ["text", "doc", "bcr"],
                page: [TextExample(), DocumentExample(), BcrExample()])),
        _paddingRow(
            context,
            _homePageRowItems(
                name: ["Embed", "Lens", "Form"],
                imagePath: ["textembed", "textlens", "text"],
                page: [TextEmbeddingExample(), LensExample(), FormExample()])),
        Padding(
          padding: smallAllPadding(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomGridElement(
                  name: "General\nCard", imagePath: "gcr", page: GcrExample()),
              CustomGridElement(
                  name: "ID\nCard", imagePath: "icr", page: IcrExample()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _paddingRow(BuildContext context, List<Widget> child) {
    return Padding(
      padding: smallAllPadding(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: child,
      ),
    );
  }

  List<Widget> _homePageRowItems(
      {required List<String> name,
      required List<String> imagePath,
      required List<Widget> page}) {
    return [
      CustomGridElement(
          name: name.first, imagePath: imagePath.first, page: page.first),
      CustomGridElement(
          name: name.elementAt(1),
          imagePath: imagePath.elementAt(1),
          page: page.elementAt(1)),
      CustomGridElement(
          name: name.elementAt(2),
          imagePath: imagePath.elementAt(2),
          page: page.elementAt(2)),
    ];
  }
}

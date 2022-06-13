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
import 'package:huawei_ml_image/huawei_ml_image.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';

class ObjectExample extends StatefulWidget {
  @override
  _ObjectExampleState createState() => _ObjectExampleState();
}

class _ObjectExampleState extends State<ObjectExample> with DemoMixin {
  final _key = GlobalKey<ScaffoldState>();

  late MLObjectAnalyzer _analyzer;

  List _types = [];
  List _possibilities = [];

  @override
  void initState() {
    _analyzer = MLObjectAnalyzer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: demoAppBar("Object Detection Demo"),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            resultBox(objectTypes, _types, context),
            Container(
              color: kGrayColor,
              margin: context.paddingLow,
              width: context.highValue,
              height: context.highValue,
              child: Image.asset(objectImage),
            ),
            resultBox(possibility, _possibilities, context),
            containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: () => pickerDialog(_key, context, analyseFrame),
                  child: Text(startObjectDetection),
                )),
            containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: () =>
                      pickerDialog(_key, context, asyncAnalyseFrame),
                  child: Text(startAsyncObjectDetection),
                )),
            containerElevatedButton(
                context,
                ElevatedButton(
                  style: dangerbuttonStyle,
                  onPressed: stop,
                  child: Text(stopText),
                )),
          ],
        ),
      ),
    );
  }

  @override
  void analyseFrame(String? path) async {
    String? pickedImagePath = await getImage(ImageSource.gallery);

    if (pickedImagePath != null) {
      final setting = MLObjectAnalyzerSetting.create(path: pickedImagePath);
      try {
        List<MLObject> list = await _analyzer.analyseFrame(setting);
        list.forEach((element) {
          setState(() {
            _types.add(element.type);
            _possibilities.add(element.possibility);
          });
        });
      } on Exception catch (e) {
        exceptionDialog(context, e.toString());
      }
    }
  }

  @override
  void asyncAnalyseFrame(String? path) async {
    String? pickedImagePath = await getImage(ImageSource.gallery);

    if (pickedImagePath != null) {
      final setting = MLObjectAnalyzerSetting.create(path: pickedImagePath);
      try {
        List<MLObject> list = await _analyzer.asyncAnalyseFrame(setting);
        list.forEach((element) {
          setState(() {
            _types.add(element.type);
            _possibilities.add(element.possibility);
          });
        });
      } on Exception catch (e) {
        exceptionDialog(context, e.toString());
      }
    }
  }

  @override
  void stop() async {
    try {
      await _analyzer.stop();
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }
}

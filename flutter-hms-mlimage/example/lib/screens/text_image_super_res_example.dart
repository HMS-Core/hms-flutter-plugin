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

class TextImageSuperResolutionExample extends StatefulWidget {
  @override
  _TextImageSuperResolutionExampleState createState() =>
      _TextImageSuperResolutionExampleState();
}

class _TextImageSuperResolutionExampleState
    extends State<TextImageSuperResolutionExample> with DemoMixin {
  final _key = GlobalKey<ScaffoldState>();

  late MLTextImageSuperResolutionAnalyzer _analyzer;

  Image? _image;

  @override
  void initState() {
    _analyzer = MLTextImageSuperResolutionAnalyzer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: demoAppBar("Text Image Super Res. Demo"),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: kGrayColor,
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: _image != null
                ? _image
                : Image.asset(
                    textImage,
                    fit: BoxFit.scaleDown,
                  ),
          ),
          containerElevatedButton(
              context,
              ElevatedButton(
                style: buttonStyle,
                onPressed: () => pickerDialog(_key, context, analyseFrame),
                child: Text(startImageResolution),
              )),
          containerElevatedButton(
              context,
              ElevatedButton(
                style: buttonStyle,
                onPressed: () => pickerDialog(_key, context, asyncAnalyseFrame),
                child: Text(startAsyncImageResolution),
              )),
          containerElevatedButton(
              context,
              ElevatedButton(
                style: dangerbuttonStyle,
                onPressed: stop,
                child: Text(stopText),
              )),
        ],
      )),
    );
  }

  @override
  void analyseFrame(String? path) async {
    String? pickedImagePath = await getImage(ImageSource.gallery);

    if (pickedImagePath != null) {
      try {
        List<MLTextImageSuperResolution> list =
            await _analyzer.analyseFrame(pickedImagePath);
        list.forEach((element) {
          setState(() {
            _image = Image.memory(element.bytes!);
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
      try {
        MLTextImageSuperResolution result =
            await _analyzer.asyncAnalyseFrame(pickedImagePath);
        setState(() => _image = Image.memory(result.bytes!, fit: BoxFit.cover));
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

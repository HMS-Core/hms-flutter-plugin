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

class SegmentationExample extends StatefulWidget {
  @override
  _SegmentationExampleState createState() => _SegmentationExampleState();
}

class _SegmentationExampleState extends State<SegmentationExample>
    with DemoMixin {
  final _key = GlobalKey<ScaffoldState>();
  late MLImageSegmentationAnalyzer _analyzer;

  Image? _image;

  @override
  void initState() {
    _analyzer = MLImageSegmentationAnalyzer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: demoAppBar("Segmentation Demo"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: kGrayColor,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                width: context.width,
                height: context.width,
                child: _image != null
                    ? _image
                    : Image.asset(
                        selectImage,
                      ),
              ),
              containerElevatedButton(
                  context,
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: () => pickerDialog(_key, context, analyseFrame),
                    child: Text(startSegmentationText),
                  )),
              containerElevatedButton(
                  context,
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: () =>
                        pickerDialog(_key, context, asyncAnalyseFrame),
                    child: Text(startAsyncSegmentationText),
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
      ),
    );
  }

  @override
  void analyseFrame(String? path) async {
    String? pickedImagePath = await getImage(ImageSource.gallery);

    if (pickedImagePath != null) {
      final setting = MLImageSegmentationAnalyzerSetting.create(
          path: pickedImagePath,
          analyzerType: MLImageSegmentationAnalyzerSetting.BODY_SEG);

      try {
        List<MLImageSegmentation> list = await _analyzer.analyseFrame(setting);
        list.forEach((element) {
          setState(() {
            _image = Image.memory(element.foreground!);
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
      final setting = MLImageSegmentationAnalyzerSetting.create(
          path: pickedImagePath,
          analyzerType: MLImageSegmentationAnalyzerSetting.BODY_SEG);

      try {
        MLImageSegmentation segmentation =
            await _analyzer.asyncAnalyseFrame(setting);
        setState(() {
          _image = Image.memory(segmentation.foreground!, fit: BoxFit.cover);
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

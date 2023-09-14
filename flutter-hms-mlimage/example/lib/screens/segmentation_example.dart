/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ml_image_example/utils/constants.dart';
import 'package:huawei_ml_image_example/utils/utils.dart';

class SegmentationExample extends StatefulWidget {
  const SegmentationExample({Key? key}) : super(key: key);

  @override
  State<SegmentationExample> createState() => _SegmentationExampleState();
}

class _SegmentationExampleState extends State<SegmentationExample>
    with DemoMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final MLImageSegmentationAnalyzer _analyzer = MLImageSegmentationAnalyzer();
  Image? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: demoAppBar('Segmentation Demo'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                color: kGrayColor,
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                width: context.width,
                height: context.width,
                child: _image ??
                    Image.asset(
                      selectImage,
                    ),
              ),
              containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    pickerDialog(_key, context, analyseFrame);
                  },
                  child: const Text(startSegmentationText),
                ),
              ),
              containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    pickerDialog(_key, context, asyncAnalyseFrame);
                  },
                  child: const Text(startAsyncSegmentationText),
                ),
              ),
              containerElevatedButton(
                context,
                ElevatedButton(
                  style: dangerbuttonStyle,
                  onPressed: stop,
                  child: const Text(stopText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Future<void> analyseFrame(String? path) async {
    try {
      if (path != null) {
        final MLImageSegmentationAnalyzerSetting setting =
            MLImageSegmentationAnalyzerSetting.create(
          path: path,
          analyzerType: MLImageSegmentationAnalyzerSetting.BODY_SEG,
        );
        final List<MLImageSegmentation> list =
            await _analyzer.analyseFrame(setting);
        for (MLImageSegmentation element in list) {
          setState(() {
            _image = Image.memory(element.foreground!);
          });
        }
      }
    } catch (e) {
      exceptionDialog(context, '$e');
    }
  }

  @override
  Future<void> asyncAnalyseFrame(String? path) async {
    try {
      if (path != null) {
        final MLImageSegmentationAnalyzerSetting setting =
            MLImageSegmentationAnalyzerSetting.create(
          path: path,
          analyzerType: MLImageSegmentationAnalyzerSetting.BODY_SEG,
        );
        final MLImageSegmentation segmentation =
            await _analyzer.asyncAnalyseFrame(setting);
        setState(() {
          _image = Image.memory(
            segmentation.foreground!,
            fit: BoxFit.cover,
          );
        });
      }
    } catch (e) {
      exceptionDialog(context, '$e');
    }
  }

  @override
  Future<void> stop() async {
    try {
      await _analyzer.stop();
    } catch (e) {
      exceptionDialog(context, '$e');
    }
  }
}

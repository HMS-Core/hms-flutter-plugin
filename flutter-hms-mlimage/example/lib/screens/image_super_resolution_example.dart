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

class ImageSuperResolutionExample extends StatefulWidget {
  const ImageSuperResolutionExample({Key? key}) : super(key: key);

  @override
  State<ImageSuperResolutionExample> createState() =>
      _ImageSuperResolutionExampleState();
}

class _ImageSuperResolutionExampleState
    extends State<ImageSuperResolutionExample> with DemoMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final MLImageSuperResolutionAnalyzer _analyzer =
      MLImageSuperResolutionAnalyzer();
  Image? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: demoAppBar('Image Super Resolution Demo'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: kGrayColor,
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: _image ?? Image.asset(superImage),
            ),
            containerElevatedButton(
              context,
              ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  pickerDialog(
                    _key,
                    context,
                    analyseFrame,
                  );
                },
                child: const Text(startClassificationText),
              ),
            ),
            containerElevatedButton(
              context,
              ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  pickerDialog(
                    _key,
                    context,
                    asyncAnalyseFrame,
                  );
                },
                child: const Text(startAsyncClassificationText),
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
    );
  }

  @override
  Future<void> analyseFrame(String? path) async {
    if (path != null) {
      try {
        final MLImageSuperResolutionAnalyzerSetting setting =
            MLImageSuperResolutionAnalyzerSetting.create(
          path: path,
        );
        final List<MLImageSuperResolutionResult> list =
            await _analyzer.analyseFrame(setting);
        for (MLImageSuperResolutionResult element in list) {
          setState(() {
            _image = Image.memory(element.bytes!);
          });
        }
      } catch (e) {
        exceptionDialog(context, '$e');
      }
    }
  }

  @override
  Future<void> asyncAnalyseFrame(String? path) async {
    if (path != null) {
      try {
        final MLImageSuperResolutionAnalyzerSetting setting =
            MLImageSuperResolutionAnalyzerSetting.create(
          path: path,
        );
        final MLImageSuperResolutionResult result =
            await _analyzer.asyncAnalyseFrame(setting);
        setState(() {
          _image = Image.memory(result.bytes!);
        });
      } catch (e) {
        exceptionDialog(context, '$e');
      }
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

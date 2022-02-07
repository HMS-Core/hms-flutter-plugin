/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

class ProductExample extends StatefulWidget {
  @override
  _ProductExampleState createState() => _ProductExampleState();
}

class _ProductExampleState extends State<ProductExample> {
  late MLProductVisionSearchAnalyzer _analyzer;

  dynamic _length;

  @override
  void initState() {
    _analyzer = MLProductVisionSearchAnalyzer();
    _setApiKey();
    super.initState();
  }

  _setApiKey() {
    MLImageApplication().setApiKey(apiKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: demoAppBar("Product Search Demo"),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: kGrayColor,
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              width: context.width * 0.4,
              height: context.width * 0.4,
              child: Image.asset(
                productImage,
              ),
            ),
            resultBox(productDetection, _length, context),
            containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: _detectWithLocalImage,
                  child: Text(detectWithLocalImage),
                )),
            containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: _detectWithCapturing,
                  child: Text(detectWithCapturing),
                )),
            containerElevatedButton(
                context,
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: _stopRecognition,
                  child: Text(stopText),
                )),
          ],
        ),
      ),
    );
  }

  _detectWithLocalImage() async {
    String? pickedImagePath = await getImage(ImageSource.gallery);

    if (pickedImagePath != null) {
      try {
        final setting = MLProductVisionSearchAnalyzerSetting.local(
            path: pickedImagePath, productSetId: phone);
        List<MlProductVisualSearch?> list =
            await _analyzer.searchProduct(setting);

        if (list.isNotEmpty) {
          setState(() => _length = list.length);
        } else {
          setState(() => _length = listIsEmpty);
        }
      } on Exception catch (e) {
        exceptionDialog(context, e.toString());
      }
    }
  }

  _detectWithCapturing() async {
    final setting =
        MLProductVisionSearchAnalyzerSetting.plugin(productSetId: bags);

    try {
      List<MLProductCaptureResult?> list =
          await _analyzer.searchProductWithPlugin(setting);

      if (list.isNotEmpty) {
        setState(() => _length = list.length);
      } else {
        setState(() => _length = listIsEmpty);
      }
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  _stopRecognition() async {
    try {
      await _analyzer.stopProductAnalyzer();
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }
}

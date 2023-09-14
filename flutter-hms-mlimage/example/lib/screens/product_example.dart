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
import 'package:image_picker/image_picker.dart';

class ProductExample extends StatefulWidget {
  const ProductExample({Key? key}) : super(key: key);

  @override
  State<ProductExample> createState() => _ProductExampleState();
}

class _ProductExampleState extends State<ProductExample> {
  final MLProductVisionSearchAnalyzer _analyzer =
      MLProductVisionSearchAnalyzer();
  String? _length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: demoAppBar('Product Search Demo'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: kGrayColor,
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              width: context.width * 0.4,
              height: context.width * 0.4,
              child: Image.asset(
                productImage,
              ),
            ),
            resultBox(
              productDetection,
              _length,
              context,
            ),
            containerElevatedButton(
              context,
              ElevatedButton(
                style: buttonStyle,
                onPressed: _detectWithLocalImage,
                child: const Text(detectWithLocalImage),
              ),
            ),
            containerElevatedButton(
              context,
              ElevatedButton(
                style: buttonStyle,
                onPressed: _detectWithCapturing,
                child: const Text(detectWithCapturing),
              ),
            ),
            containerElevatedButton(
              context,
              ElevatedButton(
                style: buttonStyle,
                onPressed: _stopRecognition,
                child: const Text(stopText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _detectWithLocalImage() async {
    try {
      final String? pickedImagePath = await getImage(ImageSource.gallery);

      if (pickedImagePath != null) {
        final MLProductVisionSearchAnalyzerSetting setting =
            MLProductVisionSearchAnalyzerSetting.local(
          path: pickedImagePath,
          productSetId: phone,
        );
        final List<MlProductVisualSearch?> list =
            await _analyzer.searchProduct(setting);
        setState(() {
          _length = list.isNotEmpty ? '${list.length}' : listIsEmpty;
        });
      }
    } catch (e) {
      exceptionDialog(context, '$e');
    }
  }

  void _detectWithCapturing() async {
    try {
      final MLProductVisionSearchAnalyzerSetting setting =
          MLProductVisionSearchAnalyzerSetting.plugin(
        productSetId: bags,
      );
      final List<MLProductCaptureResult?> list =
          await _analyzer.searchProductWithPlugin(setting);
      setState(() {
        _length = list.isNotEmpty ? '${list.length}' : listIsEmpty;
      });
    } catch (e) {
      exceptionDialog(context, '$e');
    }
  }

  void _stopRecognition() async {
    try {
      await _analyzer.stopProductAnalyzer();
    } catch (e) {
      exceptionDialog(context, '$e');
    }
  }
}

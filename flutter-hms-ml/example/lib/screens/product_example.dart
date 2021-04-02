/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ml/huawei_ml.dart';
import 'package:huawei_ml_example/services/image_path_provider.dart';
import 'package:huawei_ml_example/widgets/detection_button.dart';
import 'package:huawei_ml_example/widgets/detection_result_box.dart';
import 'package:image_picker/image_picker.dart';

class ProductExample extends StatefulWidget {
  @override
  _ProductExampleState createState() => _ProductExampleState();
}

class _ProductExampleState extends State<ProductExample> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MLProductVisionSearchAnalyzer analyzer;
  MLProductVisionSearchAnalyzerSetting setting;

  String _type = "Type";
  String _productId = "Product Id";
  dynamic _possibility = 0;
  dynamic _bottomCorner = 0;
  dynamic _topCorner = 0;
  dynamic _leftCorner = 0;
  dynamic _rightCorner = 0;

  @override
  void initState() {
    analyzer = new MLProductVisionSearchAnalyzer();
    setting = new MLProductVisionSearchAnalyzerSetting();
    _checkPermissions();
    _setApiKey();
    super.initState();
  }

  _checkPermissions() async {
    await MLPermissionClient()
        .requestPermission([MLPermission.camera]).then((v) {
      if (!v) {
        _checkPermissions();
      }
    });
  }

  _setApiKey() async {
    await MLApplication().setApiKey(apiKey: "<your_api_key>");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text("Product Vision Search"),
          titleSpacing: 0,
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            detectionResultBox("TYPE", _type),
            detectionResultBox("BOTTOM CORNER", _bottomCorner),
            detectionResultBox("TOP CORNER", _topCorner),
            detectionResultBox("LEFT CORNER", _leftCorner),
            detectionResultBox("RIGHT CORNER", _rightCorner),
            detectionResultBox("PRODUCT ID", _productId),
            detectionResultBox("POSSIBILITY", _possibility),
            SizedBox(height: 20),
            detectionButton(
                onPressed: _showImagePickingOptions, label: "START ANALYZING")
          ],
        )),
      ),
    );
  }

  _startRecognition(String path) async {
    setting.path = path;
    setting.largestNumberOfReturns = 10;
    // take picture of a smart phone
    setting.productSetId = "phone";
    setting.region = MLProductVisionSearchAnalyzerSetting.REGION_DR_CHINA;
    try {
      final List<MlProductVisualSearch> visionSearch =
          await analyzer.searchProduct(setting);
      if (visionSearch.length > 0) {
        setState(() {
          _type = visionSearch.first.type;
          _bottomCorner = visionSearch.first.border.bottom;
          _topCorner = visionSearch.first.border.top;
          _leftCorner = visionSearch.first.border.left;
          _rightCorner = visionSearch.first.border.right;
          _possibility = visionSearch.first.productList.first.possibility;
          _productId = visionSearch.first.productList.first.productId;
        });
      } else {
        print("No product found");
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _showImagePickingOptions() async {
    scaffoldKey.currentState.showBottomSheet((context) => Container(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      child: Text("USE CAMERA"),
                      onPressed: () async {
                        final String path = await getImage(ImageSource.camera);
                        _startRecognition(path);
                      })),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      child: Text("PICK FROM GALLERY"),
                      onPressed: () async {
                        final String path = await getImage(ImageSource.gallery);
                        _startRecognition(path);
                      })),
            ],
          ),
        ));
  }
}

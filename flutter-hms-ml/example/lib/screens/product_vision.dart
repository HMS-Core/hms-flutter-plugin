/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'package:flutter/material.dart';
import 'package:huawei_ml/permissions/permission_client.dart';
import 'package:huawei_ml/productvisionsearch/ml_product_vision_search_client.dart';
import 'package:huawei_ml/productvisionsearch/model/ml_product_vision_search.dart';
import 'package:huawei_ml/productvisionsearch/ml_product_vision_search_settings.dart';
import 'package:huawei_ml_example/services/image_path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:huawei_ml/helpers/product_vision_helpers.dart';

class ProductVisionSearchPage extends StatefulWidget {
  @override
  _ProductVisionSearchPageState createState() =>
      _ProductVisionSearchPageState();
}

class _ProductVisionSearchPageState extends State<ProductVisionSearchPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MlProductVisionSearchSettings settings;

  String _type = "Type";
  String _productId = "Product Id";
  dynamic _possibility = 0;
  dynamic _bottomCorner = 0;
  dynamic _topCorner = 0;
  dynamic _leftCorner = 0;
  dynamic _rightCorner = 0;

  @override
  void initState() {
    settings = new MlProductVisionSearchSettings();
    _checkPermissions();
    super.initState();
  }

  _checkPermissions() async {
    if (await MlPermissionClient.checkCameraPermission()) {
      print("Permissions are granted");
    } else {
      await MlPermissionClient.requestCameraPermission();
    }
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
          body: Stack(
            children: [
              Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    child: SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        _visionBox("TYPE", _type),
                        _visionBox("BOTTOM CORNER", _bottomCorner),
                        _visionBox("TOP CORNER", _topCorner),
                        _visionBox("LEFT CORNER", _leftCorner),
                        _visionBox("RIGHT CORNER", _rightCorner),
                        _visionBox("PRODUCT ID", _productId),
                        _visionBox("POSSIBILITY", _possibility),
                      ],
                    )),
                  )),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: RaisedButton(
                      color: Colors.lightBlue,
                      textColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("Start Analyze"),
                      onPressed: _showImagePickingOptions,
                    )),
              )
            ],
          )),
    );
  }

  _startRecognition() async {
    try {
      settings.largestNumberOfReturns = 5;
      settings.region = ProductVisionRegion.REGION_DR_EUROPE;
      final MlProductVisionSearch visionSearch =
          await MlProductVisionSearchClient.getProductVisionSearchResult(
              settings);
      if (visionSearch != null) {
        setState(() {
          _type = visionSearch.type;
          _bottomCorner = visionSearch.border.bottom;
          _topCorner = visionSearch.border.top;
          _leftCorner = visionSearch.border.left;
          _rightCorner = visionSearch.border.right;
          _possibility = visionSearch.productList.possibility;
          _productId = visionSearch.productList.productId;
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
                        settings.path = path;
                        _startRecognition();
                      })),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      child: Text("PICK FROM GALLERY"),
                      onPressed: () async {
                        final String path = await getImage(ImageSource.gallery);
                        settings.path = path;
                        _startRecognition();
                      })),
            ],
          ),
        ));
  }

  Widget _visionBox(String name, dynamic value) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(name.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ))),
      Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                width: .5,
                color: Colors.black.withOpacity(.5),
                style: BorderStyle.solid)),
        child: Text(value.toString()),
      )
    ]);
  }
}

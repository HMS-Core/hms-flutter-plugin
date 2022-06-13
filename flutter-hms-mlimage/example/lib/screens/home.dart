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

import '../screens/classification_example.dart';
import '../screens/document_correction_example.dart';
import '../screens/image_super_resolution_example.dart';
import '../screens/landmark_example.dart';
import '../screens/lens_example.dart';
import '../screens/object_example.dart';
import '../screens/product_example.dart';
import '../screens/scene_example.dart';
import '../screens/segmentation_example.dart';
import '../screens/text_image_super_res_example.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    _handlePermissions();
    super.initState();
  }

  _handlePermissions() async {
    await MLImagePermissions().requestPermission(
        [ImagePermission.camera, ImagePermission.storage]).then((granted) {
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: context.paddingLow,
                  child: Image.asset(
                    bannerImage,
                    fit: BoxFit.cover,
                  )),
              Container(
                child: Material(
                  child: _columnItems(context),
                ),
              ),
            ],
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
            _homePageRowItems(name: [
              "Classification",
              "Object Detection",
              "Landmark"
            ], imagePath: [
              "classification",
              "object",
              "landmark"
            ], page: [
              ClassificationExample(),
              ObjectExample(),
              LandmarkExample()
            ])),
        _paddingRow(
            context,
            _homePageRowItems(name: [
              "Segmentation",
              "Product",
              "Image\nResolution"
            ], imagePath: [
              "segmentation",
              "productsegment",
              "imageresolution"
            ], page: [
              SegmentationExample(),
              ProductExample(),
              ImageSuperResolutionExample()
            ])),
        _paddingRow(
            context,
            _homePageRowItems(name: [
              "Document\nCorrection",
              "Scene\nDetection",
              "Text\nResolution"
            ], imagePath: [
              "document",
              "scene",
              "tisr"
            ], page: [
              DocumentCorrectionExample(),
              SceneExample(),
              TextImageSuperResolutionExample()
            ])),
        Padding(
          padding: smallAllPadding(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomGridElement(
                  name: "Lens", imagePath: "tisr", page: LensExample()),
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

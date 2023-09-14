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
import 'package:huawei_ml_image_example/screens/classification_example.dart';
import 'package:huawei_ml_image_example/screens/document_correction_example.dart';
import 'package:huawei_ml_image_example/screens/image_super_resolution_example.dart';
import 'package:huawei_ml_image_example/screens/landmark_example.dart';
import 'package:huawei_ml_image_example/screens/lens_example.dart';
import 'package:huawei_ml_image_example/screens/object_example.dart';
import 'package:huawei_ml_image_example/screens/product_example.dart';
import 'package:huawei_ml_image_example/screens/scene_example.dart';
import 'package:huawei_ml_image_example/screens/segmentation_example.dart';
import 'package:huawei_ml_image_example/screens/text_image_super_res_example.dart';
import 'package:huawei_ml_image_example/utils/constants.dart';
import 'package:huawei_ml_image_example/utils/utils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: demoAppBar(homeAppbarText),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: context.paddingLow,
                child: Image.asset(
                  bannerImage,
                  fit: BoxFit.cover,
                ),
              ),
              Material(
                child: _columnItems(context),
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
      children: <Widget>[
        _paddingRow(
          context,
          _homePageRowItems(
            name: <String>[
              'Classification',
              'Object Detection',
              'Landmark',
            ],
            imagePath: <String>[
              'classification',
              'object',
              'landmark',
            ],
            page: <Widget>[
              const ClassificationExample(),
              const ObjectExample(),
              const LandmarkExample(),
            ],
          ),
        ),
        _paddingRow(
          context,
          _homePageRowItems(
            name: <String>[
              'Segmentation',
              'Product',
              'Image\nResolution',
            ],
            imagePath: <String>[
              'segmentation',
              'productsegment',
              'imageresolution',
            ],
            page: <Widget>[
              const SegmentationExample(),
              const ProductExample(),
              const ImageSuperResolutionExample(),
            ],
          ),
        ),
        _paddingRow(
          context,
          _homePageRowItems(
            name: <String>[
              'Document\nCorrection',
              'Scene\nDetection',
              'Text\nResolution',
            ],
            imagePath: <String>[
              'document',
              'scene',
              'tisr',
            ],
            page: <Widget>[
              const DocumentCorrectionExample(),
              const SceneExample(),
              const TextImageSuperResolutionExample(),
            ],
          ),
        ),
        Padding(
          padding: smallAllPadding(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              CustomGridElement(
                name: 'Lens',
                imagePath: 'tisr',
                page: LensExample(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _paddingRow(
    BuildContext context,
    List<Widget> child,
  ) {
    return Padding(
      padding: smallAllPadding(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: child,
      ),
    );
  }

  List<Widget> _homePageRowItems({
    required List<String> name,
    required List<String> imagePath,
    required List<Widget> page,
  }) {
    return <Widget>[
      CustomGridElement(
        name: name.first,
        imagePath: imagePath.first,
        page: page.first,
      ),
      CustomGridElement(
        name: name.elementAt(1),
        imagePath: imagePath.elementAt(1),
        page: page.elementAt(1),
      ),
      CustomGridElement(
        name: name.elementAt(2),
        imagePath: imagePath.elementAt(2),
        page: page.elementAt(2),
      ),
    ];
  }
}

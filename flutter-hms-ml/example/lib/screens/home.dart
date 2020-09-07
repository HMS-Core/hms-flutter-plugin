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
import 'package:huawei_ml_example/screens/aft.dart';
import 'package:huawei_ml_example/screens/asr.dart';
import 'package:huawei_ml_example/screens/bankcard.dart';
import 'package:huawei_ml_example/screens/document.dart';
import 'package:huawei_ml_example/screens/face.dart';
import 'package:huawei_ml_example/screens/general_card.dart';
import 'package:huawei_ml_example/screens/landmark.dart';
import 'package:huawei_ml_example/screens/language_detection.dart';
import 'package:huawei_ml_example/screens/product_vision.dart';
import 'package:huawei_ml_example/screens/segmentation.dart';
import 'package:huawei_ml_example/screens/text.dart';
import 'package:huawei_ml_example/screens/translate.dart';
import 'package:huawei_ml_example/screens/tts.dart';
import 'package:huawei_ml_example/widgets/custom_grid_element.dart';
import 'classification.dart';
import 'object.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("FLUTTER HMS ML Kit Demo",
            style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/ml.png",
                  height: 100,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text("ML Text/Doc/Speech",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomGridElement(
                      name: "Text", imagePath: "text", page: TextRecognition()),
                  CustomGridElement(
                      name: "Document",
                      imagePath: "doc",
                      page: DocumentRecognitionPage()),
                  CustomGridElement(
                      name: "TTS",
                      imagePath: "tts",
                      page: TextToSpeechRecognitionPage()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomGridElement(
                      name: "AFT", imagePath: "asr", page: AftPage()),
                  CustomGridElement(
                      name: "ASR", imagePath: "asr", page: AsrPage()),
                  CustomGridElement(
                      name: "Language\nDetection",
                      imagePath: "langdetect",
                      page: LanguageDetectionPage()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomGridElement(
                      name: "Translate",
                      imagePath: "trans",
                      page: TranslatePage()),
                  CustomGridElement(
                      name: "Bankcard",
                      imagePath: "bcr",
                      page: BankcardRecognitionPage()),
                  CustomGridElement(
                      name: "General\nCard",
                      imagePath: "gcr",
                      page: GeneralCardRecognitionPage()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text("ML Vision",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomGridElement(
                      name: "ImgSeg",
                      imagePath: "segmentation",
                      page: SegmentationPage()),
                  CustomGridElement(
                      name: "Face",
                      imagePath: "face",
                      page: FaceRecognitionPage()),
                  CustomGridElement(
                      name: "Object",
                      imagePath: "object",
                      page: ObjectRecognitionPage()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomGridElement(
                      name: "Classify",
                      imagePath: "class",
                      page: ClassificationPage()),
                  CustomGridElement(
                      name: "Landmark",
                      imagePath: "landmark",
                      page: LandmarkRecognitionPage()),
                  CustomGridElement(
                      name: "Product\nVision",
                      imagePath: "productsegment",
                      page: ProductVisionSearchPage()),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

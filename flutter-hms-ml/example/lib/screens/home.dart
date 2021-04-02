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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'custom_model_example.dart';
import 'form_example.dart';
import 'lensview_example.dart';
import 'object_example.dart';
import 'product_example.dart';
import 'scene_example.dart';
import 'skeleton_example.dart';
import 'bcr_example.dart';
import 'document_example.dart';
import 'gcr_example.dart';
import 'text_embedding_example.dart';
import 'text_example.dart';
import 'face_3d_example.dart';
import 'face_example.dart';
import 'hand_example.dart';
import 'liveness_example.dart';
import 'translate_example.dart';
import 'lang_detection_example.dart';
import 'sound_detection_example.dart';
import 'classification_example.dart';
import 'segmentation_example.dart';
import 'landmark_example.dart';
import 'isr_example.dart';
import 'document_correction_example.dart';
import 'text_resolution_example.dart';
import 'asr_example.dart';
import 'aft_example.dart';
import 'rtt_example.dart';
import 'tts_example.dart';
import '../widgets/custom_grid_element.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xfff1f6f9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              "assets/ml.png",
              height: 40,
            ),
            SizedBox(width: 10),
            Text("HUAWEI ML PLUGIN DEMO",
                style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text("TEXT RELATED SERVICES",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomGridElement(
                      name: "Text", imagePath: "text", page: TextExample()),
                  CustomGridElement(
                      name: "Document",
                      imagePath: "doc",
                      page: DocumentExample()),
                  CustomGridElement(
                      name: "Bankcard", imagePath: "bcr", page: BcrExample()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomGridElement(
                      name: "Form", imagePath: "text", page: FormExample()),
                  CustomGridElement(
                      name: "General\nCard",
                      imagePath: "gcr",
                      page: GcrExample()),
                  Container(
                      width: MediaQuery.of(context).size.width / 4, height: 50)
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text("BODY RELATED SERVICES",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomGridElement(
                      name: "Face", imagePath: "face", page: FaceExample()),
                  CustomGridElement(
                      name: "Face3D", imagePath: "face", page: Face3DExample()),
                  CustomGridElement(
                      name: "Skeleton",
                      imagePath: "skeleton",
                      page: SkeletonExample()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomGridElement(
                      name: "Hand\nKeypoint",
                      imagePath: "handkey",
                      page: HandExample()),
                  CustomGridElement(
                      name: "Liveness",
                      imagePath: "liveness",
                      page: LivenessExample()),
                  Container(
                      width: MediaQuery.of(context).size.width / 4, height: 50)
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text("VOICE/LANGUAGE RELATED SERVICES",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomGridElement(
                      name: "Translate",
                      imagePath: "trans",
                      page: TranslateExample()),
                  CustomGridElement(
                      name: "Lang\nDetection",
                      imagePath: "langdetect",
                      page: LangDetectionExample()),
                  CustomGridElement(
                      name: "Sound\nDetection",
                      imagePath: "sounddetect",
                      page: SoundDetectionExample()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomGridElement(
                      name: "ASR", imagePath: "asr", page: AsrExample()),
                  CustomGridElement(
                      name: "AFT", imagePath: "asr", page: AftExample()),
                  CustomGridElement(
                      name: "RTT", imagePath: "rtt", page: RttExample()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomGridElement(
                      name: "TTS", imagePath: "tts", page: TtsExample()),
                  Container(
                      width: MediaQuery.of(context).size.width / 4, height: 50),
                  Container(
                      width: MediaQuery.of(context).size.width / 4, height: 50)
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text("IMAGE RELATED SERVICES",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomGridElement(
                      name: "Classification",
                      imagePath: "class",
                      page: ClassificationExample()),
                  CustomGridElement(
                      name: "Segmentation",
                      imagePath: "segmentation",
                      page: SegmentationExample()),
                  CustomGridElement(
                      name: "Landmark",
                      imagePath: "landmark",
                      page: LandmarkExample()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomGridElement(
                      name: "ISR", imagePath: "class", page: IsrExample()),
                  CustomGridElement(
                      name: "TISR",
                      imagePath: "segmentation",
                      page: TextResolutionExample()),
                  CustomGridElement(
                      name: "DSC",
                      imagePath: "landmark",
                      page: DocumentCorrectionExample()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomGridElement(
                      name: "Object",
                      imagePath: "object",
                      page: ObjectExample()),
                  CustomGridElement(
                      name: "Scene", imagePath: "scene", page: SceneExample()),
                  CustomGridElement(
                      name: "Product",
                      imagePath: "productsegment",
                      page: ProductExample()),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text("NATURAL LANGUAGE PROCESSING SERVICES",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomGridElement(
                      name: "Text\nEmbedding",
                      imagePath: "textembed",
                      page: TextEmbeddingExample()),
                  Container(
                      width: MediaQuery.of(context).size.width / 4, height: 50),
                  Container(
                      width: MediaQuery.of(context).size.width / 4, height: 50)
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text("CUSTOM MODEL",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomGridElement(
                      name: "Custom\nModel",
                      imagePath: "model",
                      page: CustomModelExample()),
                  Container(
                      width: MediaQuery.of(context).size.width / 4, height: 50),
                  Container(
                      width: MediaQuery.of(context).size.width / 4, height: 50)
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text("LIVE DETECTIONS",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomGridElement(
                      name: "Lens\nEngine",
                      imagePath: "ml",
                      page: LensViewExample()),
                  Container(
                      width: MediaQuery.of(context).size.width / 4, height: 50),
                  Container(
                      width: MediaQuery.of(context).size.width / 4, height: 50)
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

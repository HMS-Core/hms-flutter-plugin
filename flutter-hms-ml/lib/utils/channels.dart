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

import 'package:flutter/services.dart';

class Channels {
  /// ML APPLICATION
  static const MethodChannel mlApplicationMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/application/method");

  /// FACE
  static const MethodChannel faceAnalyzerMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/face/method");
  static const EventChannel faceAnalyzerEventChannel =
      const EventChannel("com.huawei.hms.flutter.ml/face/event");

  /// FACE 3D
  static const MethodChannel face3dMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/face/3d/method");
  static const EventChannel face3dEventChannel =
      const EventChannel("com.huawei.hms.flutter.ml/face/3d/event");

  /// HAND
  static const MethodChannel handAnalyzerMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/hand/method");
  static const EventChannel handAnalyzerEventChannel =
      const EventChannel("com.huawei.hms.flutter.ml/hand/event");

  /// LIVENESS
  static const MethodChannel livenessMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/liveness/method");

  /// SKELETON
  static const MethodChannel skeletonAnalyzerMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/skeleton/method");
  static const EventChannel skeletonAnalyzerEventChannel =
      const EventChannel("com.huawei.hms.flutter.ml/skeleton/event");

  /// PRODUCT
  static const MethodChannel productVisionMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/product/method");

  /// OBJECT
  static const MethodChannel objectAnalyzerMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/object/method");
  static const EventChannel objectAnalyzerEventChannel =
      const EventChannel("com.huawei.hms.flutter.ml/object/event");

  /// LANDMARK
  static const MethodChannel landmarkAnalyzerMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/landmark/method");

  /// SEGMENTATION
  static const MethodChannel segmentationMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/segmentation/method");

  /// CLASSIFICATION
  static const MethodChannel classificationMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/classification/method");
  static const EventChannel classificationEventChannel =
      const EventChannel("com.huawei.hms.flutter.ml/classification/event");

  /// IMAGE SUPER RESOLUTION
  static const MethodChannel imageResolutionMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/image_resolution/method");

  /// DOCUMENT CORRECTION
  static const MethodChannel documentCorrectionMethodChannel =
      const MethodChannel(
          "com.huawei.hms.flutter.ml/document_correction/method");

  /// TEXT RESOLUTION
  static const MethodChannel textResolutionMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/text_resolution/method");

  /// SCENE
  static const MethodChannel sceneDetectionMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/scene/method");
  static const EventChannel sceneDetectionEventChannel =
      const EventChannel("com.huawei.hms.flutter.ml/scene/event");

  /// TEXT
  static const MethodChannel textAnalyzerMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/text/method");
  static const EventChannel textAnalyzerEventChannel =
      const EventChannel("com.huawei.hms.flutter.ml/text/event");

  /// DOCUMENT
  static const MethodChannel documentAnalyzerMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/document/method");

  /// BANKCARD
  static const MethodChannel bankcardAnalyzerMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/bankcard/method");

  /// GENERAL CARD
  static const MethodChannel generalCardMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/gcr/method");

  /// FORM
  static const MethodChannel formAnalyzerMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/form/method");

  /// TRANSLATE
  static const MethodChannel localTranslatorMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/translate/local/method");
  static const MethodChannel remoteTranslatorMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/translate/remote/method");

  /// LANG DETECTION
  static const MethodChannel langDetectionMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/lang_detection/method");

  /// ASR
  static const MethodChannel asrMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/asr/method");
  static const EventChannel asrEventChannel =
      const EventChannel("com.huawei.hms.flutter.ml/asr/event");

  /// AFT
  static const MethodChannel aftMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/aft/method");
  static const EventChannel aftEventChannel =
      const EventChannel("com.huawei.hms.flutter.ml/aft/event");

  /// RTT
  static const MethodChannel rttMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/rtt/method");
  static const EventChannel rttEventChannel =
      const EventChannel("com.huawei.hms.flutter.ml/rtt/event");

  /// TTS
  static const MethodChannel ttsMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/tts/method");
  static const EventChannel ttsEventChannel =
      const EventChannel("com.huawei.hms.flutter.ml/tts/event");

  /// SOUND DETECTION
  static const MethodChannel soundDetectionMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/sound/method");

  /// FRAME
  static const MethodChannel frameMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/frame/method");

  /// LENS
  static const MethodChannel lensMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/lens/method");

  /// TEXT EMBEDDING
  static const MethodChannel textEmbeddingMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/text_embedding/method");

  /// CUSTOM MODEL
  static const MethodChannel customModelMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/custom_model/method");

  /// PERMISSIONS
  static const MethodChannel permissionMethodChannel =
      const MethodChannel("com.huawei.hms.flutter.ml/permission/method");
}

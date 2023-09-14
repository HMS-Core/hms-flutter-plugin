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

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

EdgeInsetsGeometry smallAllPadding(BuildContext context) {
  return EdgeInsets.all(getHeight(context) * 0.01);
}

EdgeInsetsGeometry smallPadding(BuildContext context) {
  return EdgeInsets.only(top: getHeight(context) * 0.15);
}

/// Strings
const String cameraText = 'USE CAMERA';
const String galleryText = 'PICK FROM GALLERY';
const String exceptionText = 'Exception';
const String startRecognitionText = 'Start Recognition';
const String startSegmentationText = 'Start Segmentation';
const String startAsyncSegmentationText = 'Start Async Segmentation';
const String startClassificationText = 'Start Classification';
const String startAsyncClassificationText = 'Start Async Classification';
const String stopText = 'Stop';
const String noneText = 'None';
const String unknownText = 'unknown';
const String phone = 'phone';
const String bags = 'bags';
const String possibility = 'Possibilities';
const String confidences = 'Confidences';
const String classificationNames = 'Classification Names';
const String landmarkNames = 'Landmark Names';
const String listIsEmpty = 'List is empty';
const String objectTypes = 'Object Types';
const String detectionResultCode = 'Detection Result Code';
const String sceneDetectionResults = 'Scene Detection Results';
const String startSceneDetection = 'Start Scene Detection';
const String startAsyncSceneDetection = 'Start Async Scene Detection';
const String startObjectDetection = 'Start Object Detection';
const String startDocumentDetection = 'Start Document Detection';
const String startAsyncDocumentDetection = 'Start Async Document Detection';
const String startDocumentCorrection = 'Start Document Correction';
const String startImageResolution = 'Start Image Resolution';
const String startAsyncImageResolution = 'Start Async Image Resolution';
const String startAsyncDocumentCorrection = 'Start Async Document Correction';
const String startAsyncObjectDetection = 'Start Async Object Detection';
const String productDetection = 'Detected product number';
const String detectWithLocalImage = 'Detect With Local Image';
const String detectWithCapturing = 'Detect With Capturing';
const String homeAppbarText = 'Hms ML Image Flutter Plugin';

/// String image path
const String userImage = 'assets/user.png';
const String addImage = 'assets/addimage.png';
const String objectImage = 'assets/object.png';
const String landmarkImage = 'assets/landmark.png';
const String selectImage = 'assets/selectimg.png';
const String textImage = 'assets/textimg.png';
const String tisImage = 'assets/tisr.png';
const String superImage = 'assets/imgsuper.png';
const String productImage = 'assets/product.png';
const String sceneImage = 'assets/scenedt.png';
const String bannerImage = 'assets/banner.jpg';

/// colors
const Color kPrimaryColor = Color.fromRGBO(109, 220, 207, 1);
const Color kGrayColor = Color.fromRGBO(219, 226, 239, 1);
const Color kBlackColor = Color.fromRGBO(0, 0, 0, 1);
const Color kBlueColor = Color.fromRGBO(144, 202, 249, 1);
const Color kGreenColor = Color.fromRGBO(134, 202, 256, 1);
const Color kDangerColor = Color.fromRGBO(236, 70, 70, 1);

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get width => mediaQuery.size.width;
  double get height => mediaQuery.size.height;

  double get lowValue => height * 0.01;
  double get normalValue => height * 0.02;
  double get mediumValue => height * 0.04;
  double get highValue => height * 0.1;
  double get highWidthValue => height * 0.8;
}

extension PaddingExtensionAll on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);
}

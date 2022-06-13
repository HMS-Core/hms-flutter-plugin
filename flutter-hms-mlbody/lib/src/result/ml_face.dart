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

import 'package:huawei_ml_body/src/result/body_border.dart';
import 'package:huawei_ml_body/src/result/body_position.dart';

class MLFace {
  /// Default value of facial expression and feature possibility, such as eye opening and age.
  static const double unanalyzedPossibility = 1.0;

  BodyBorder? border;
  MLFaceEmotion? emotions;
  MLFaceFeature? features;
  List<MLFaceShape?> faceShapeList;
  List<MLFaceKeyPoint?> keyPoints;
  List<BodyPosition?> allPoints;
  dynamic rotationAngleY;
  dynamic rotationAngleZ;
  dynamic rotationAngleX;
  dynamic opennessOfRightEye;
  dynamic possibilityOfSmiling;
  dynamic opennessOfLeftEye;
  int? tracingIdentity;
  dynamic width;
  dynamic height;

  MLFace(
      {required this.keyPoints,
      required this.allPoints,
      required this.faceShapeList,
      this.border,
      this.emotions,
      this.rotationAngleY,
      this.rotationAngleZ,
      this.rotationAngleX,
      this.tracingIdentity,
      this.opennessOfRightEye,
      this.features,
      this.width,
      this.possibilityOfSmiling,
      this.opennessOfLeftEye,
      this.height});

  factory MLFace.fromMap(Map<dynamic, dynamic> map) {
    var shapes = List<MLFaceShape>.empty(growable: true);
    var keyPoints = List<MLFaceKeyPoint>.empty(growable: true);
    var positions = List<BodyPosition>.empty(growable: true);

    if (map['faceShapeList'] != null) {
      map['faceShapeList'].forEach((v) {
        shapes.add(MLFaceShape.fromMap(v));
      });
    }

    if (map['keyPoints'] != null) {
      map['keyPoints'].forEach((v) {
        keyPoints.add(MLFaceKeyPoint.fromMap(v));
      });
    }

    if (map['allPoints'] != null) {
      map['allPoints'].forEach((v) {
        positions.add(BodyPosition.fromMap(v));
      });
    }

    return MLFace(
        border:
            map['border'] != null ? BodyBorder.fromMap(map['border']) : null,
        emotions: map['emotions'] != null
            ? MLFaceEmotion.fromMap(map['emotions'])
            : null,
        rotationAngleX: map['rotationAngleX'],
        rotationAngleY: map['rotationAngleY'],
        rotationAngleZ: map['rotationAngleZ'],
        tracingIdentity: map['tracingIdentity'],
        opennessOfRightEye: map['opennessOfRightEye'],
        features: map['features'] != null
            ? MLFaceFeature.fromMap(map['features'])
            : null,
        width: map['width'],
        height: map['height'],
        possibilityOfSmiling: map['possibilityOfSmiling'],
        opennessOfLeftEye: map['opennessOfLeftEye'],
        keyPoints: keyPoints,
        allPoints: positions,
        faceShapeList: shapes);
  }
}

class MLFaceEmotion {
  dynamic angryProbability;
  dynamic disgustProbability;
  dynamic surpriseProbability;
  dynamic sadProbability;
  dynamic neutralProbability;
  dynamic smilingProbability;
  dynamic fearProbability;

  MLFaceEmotion(
      {this.angryProbability,
      this.disgustProbability,
      this.surpriseProbability,
      this.sadProbability,
      this.neutralProbability,
      this.smilingProbability,
      this.fearProbability});

  factory MLFaceEmotion.fromMap(Map<dynamic, dynamic> map) {
    return MLFaceEmotion(
        angryProbability: map['angryProbability'],
        disgustProbability: map['disgustProbability'],
        surpriseProbability: map['surpriseProbability'],
        sadProbability: map['sadProbability'],
        neutralProbability: map['neutralProbability'],
        smilingProbability: map['smilingProbability'],
        fearProbability: map['fearProbability']);
  }
}

class MLFaceShape {
  static const int typeAll = 0;
  static const int typeFace = 1;
  static const int typeLeftEye = 2;
  static const int typeRightEye = 3;
  static const int typeBottomOfLeftEyebrow = 4;
  static const int typeBottomOfRightEyebrow = 5;
  static const int typeTopOfLeftEyebrow = 6;
  static const int typeTopOfRightEyebrow = 7;
  static const int typeBottomOfLowerLip = 8;
  static const int typeTopOfLowerLip = 9;
  static const int typeBottomOfUpperLip = 10;
  static const int typeTopOfUpperLip = 11;
  static const int typeBottomOfNose = 12;
  static const int typeBridgeOfNose = 13;

  int? faceShapeType;
  List<BodyPosition?> points;

  MLFaceShape({this.faceShapeType, required this.points});

  factory MLFaceShape.fromMap(Map<dynamic, dynamic> map) {
    var points = List<BodyPosition>.empty(growable: true);

    if (map['points'] != null) {
      map['points'].forEach((v) {
        points.add(BodyPosition.fromMap(v));
      });
    }

    return MLFaceShape(faceShapeType: map['faceShapeType'], points: points);
  }
}

class MLFaceFeature {
  int? age;
  dynamic moustacheProbability;
  dynamic hatProbability;
  dynamic sexProbability;
  dynamic leftEyeOpenProbability;
  dynamic sunGlassProbability;
  dynamic rightEyeOpenProbability;

  MLFaceFeature(
      {this.moustacheProbability,
      this.hatProbability,
      this.sexProbability,
      this.leftEyeOpenProbability,
      this.sunGlassProbability,
      this.age,
      this.rightEyeOpenProbability});

  factory MLFaceFeature.fromMap(Map<dynamic, dynamic> map) {
    return MLFaceFeature(
        moustacheProbability: map['moustacheProbability'],
        hatProbability: map['hatProbability'],
        sexProbability: map['sexProbability'],
        leftEyeOpenProbability: map['leftEyeOpenProbability'],
        sunGlassProbability: map['sunGlassProbability'],
        age: map['age'],
        rightEyeOpenProbability: map['rightEyeOpenProbability']);
  }
}

class MLFaceKeyPoint {
  static const int typeBottomOfMouth = 1;
  static const int typeLEftCheek = 2;
  static const int typeTipOfLeftEar = 4;
  static const int typeLEftEar = 3;
  static const int typeLeftEye = 5;
  static const int typeLeftSideOfMouth = 6;
  static const int typeTipOfNose = 7;
  static const int typeRightCheek = 8;
  static const int typeTipOfRightEar = 10;
  static const int typeRightEar = 9;
  static const int typeRightEye = 11;
  static const int typeRightSideOfMouth = 12;

  int? type;
  BodyPosition? point;

  MLFaceKeyPoint({this.type, this.point});

  factory MLFaceKeyPoint.fromMap(Map<dynamic, dynamic> map) {
    return MLFaceKeyPoint(
        type: map['type'],
        point:
            map['point'] != null ? BodyPosition.fromMap(map['point']) : null);
  }
}

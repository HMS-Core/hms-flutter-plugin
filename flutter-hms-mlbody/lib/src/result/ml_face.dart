/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of '../../huawei_ml_body.dart';

class MLFace {
  /// Default value of facial expression and feature possibility, such as eye opening and age.
  static const double unanalyzedPossibility = 1.0;

  final BodyBorder? border;
  final MLFaceEmotion? emotions;
  final MLFaceFeature? features;
  final List<MLFaceShape> faceShapeList;
  final List<MLFaceKeyPoint> keyPoints;
  final List<BodyPosition> allPoints;
  final double rotationAngleY;
  final double rotationAngleZ;
  final double rotationAngleX;
  final double opennessOfRightEye;
  final double possibilityOfSmiling;
  final double opennessOfLeftEye;
  final int tracingIdentity;
  final double width;
  final double height;

  const MLFace._({
    required this.keyPoints,
    required this.allPoints,
    required this.faceShapeList,
    this.border,
    this.emotions,
    this.features,
    required this.rotationAngleY,
    required this.rotationAngleZ,
    required this.rotationAngleX,
    required this.tracingIdentity,
    required this.opennessOfRightEye,
    required this.width,
    required this.possibilityOfSmiling,
    required this.opennessOfLeftEye,
    required this.height,
  });

  factory MLFace.fromMap(Map<dynamic, dynamic> map) {
    final List<MLFaceShape> shapes = <MLFaceShape>[];
    final List<MLFaceKeyPoint> keyPoints = <MLFaceKeyPoint>[];
    final List<BodyPosition> positions = <BodyPosition>[];

    if (map['faceShapeList'] != null) {
      map['faceShapeList'].forEach((dynamic v) {
        shapes.add(MLFaceShape.fromMap(v));
      });
    }
    if (map['keyPoints'] != null) {
      map['keyPoints'].forEach((dynamic v) {
        keyPoints.add(MLFaceKeyPoint.fromMap(v));
      });
    }
    if (map['allPoints'] != null) {
      map['allPoints'].forEach((dynamic v) {
        positions.add(BodyPosition.fromMap(v));
      });
    }
    return MLFace._(
      border: map['border'] != null ? BodyBorder.fromMap(map['border']) : null,
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
      faceShapeList: shapes,
    );
  }
}

class MLFaceEmotion {
  final double angryProbability;
  final double disgustProbability;
  final double surpriseProbability;
  final double sadProbability;
  final double neutralProbability;
  final double smilingProbability;
  final double fearProbability;

  const MLFaceEmotion._({
    required this.angryProbability,
    required this.disgustProbability,
    required this.surpriseProbability,
    required this.sadProbability,
    required this.neutralProbability,
    required this.smilingProbability,
    required this.fearProbability,
  });

  factory MLFaceEmotion.fromMap(Map<dynamic, dynamic> map) {
    return MLFaceEmotion._(
      angryProbability: map['angryProbability'],
      disgustProbability: map['disgustProbability'],
      surpriseProbability: map['surpriseProbability'],
      sadProbability: map['sadProbability'],
      neutralProbability: map['neutralProbability'],
      smilingProbability: map['smilingProbability'],
      fearProbability: map['fearProbability'],
    );
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

  final List<BodyPosition> points;
  final int? faceShapeType;

  const MLFaceShape._({
    required this.points,
    this.faceShapeType,
  });

  factory MLFaceShape.fromMap(Map<dynamic, dynamic> map) {
    final List<BodyPosition> points = <BodyPosition>[];

    if (map['points'] != null) {
      map['points'].forEach((dynamic v) {
        points.add(BodyPosition.fromMap(v));
      });
    }
    return MLFaceShape._(
      faceShapeType: map['faceShapeType'],
      points: points,
    );
  }
}

class MLFaceFeature {
  final int age;
  final double moustacheProbability;
  final double hatProbability;
  final double sexProbability;
  final double leftEyeOpenProbability;
  final double sunGlassProbability;
  final double rightEyeOpenProbability;

  const MLFaceFeature._({
    required this.age,
    required this.moustacheProbability,
    required this.hatProbability,
    required this.sexProbability,
    required this.leftEyeOpenProbability,
    required this.sunGlassProbability,
    required this.rightEyeOpenProbability,
  });

  factory MLFaceFeature.fromMap(Map<dynamic, dynamic> map) {
    return MLFaceFeature._(
      age: map['age'],
      moustacheProbability: map['moustacheProbability'],
      hatProbability: map['hatProbability'],
      sexProbability: map['sexProbability'],
      leftEyeOpenProbability: map['leftEyeOpenProbability'],
      sunGlassProbability: map['sunGlassProbability'],
      rightEyeOpenProbability: map['rightEyeOpenProbability'],
    );
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

  final int? type;
  final BodyPosition? point;

  const MLFaceKeyPoint._({
    this.type,
    this.point,
  });

  factory MLFaceKeyPoint.fromMap(Map<dynamic, dynamic> map) {
    return MLFaceKeyPoint._(
      type: map['type'],
      point: map['point'] != null ? BodyPosition.fromMap(map['point']) : null,
    );
  }
}

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

import 'ml_border.dart';
import 'ml_point.dart';

class MLFace {
  /// Default value of facial expression and feature possibility, such as eye opening and age.
  static const double UNANALYZED_POSSIBILITY = 1.0;

  MLBorder border;
  Emotions emotions;
  List<FaceShapeList> faceShapeList;
  dynamic rotationAngleY;
  dynamic rotationAngleZ;
  dynamic rotationAngleX;
  int tracingIdentity;
  dynamic opennessOfRightEye;
  Features features;
  List<KeyPoints> keyPoints;
  int width;
  List<Points> allPoints;
  dynamic possibilityOfSmiling;
  dynamic opennessOfLeftEye;
  int height;

  MLFace(
      {this.border,
      this.emotions,
      this.faceShapeList,
      this.rotationAngleY,
      this.rotationAngleZ,
      this.rotationAngleX,
      this.tracingIdentity,
      this.opennessOfRightEye,
      this.features,
      this.keyPoints,
      this.width,
      this.allPoints,
      this.possibilityOfSmiling,
      this.opennessOfLeftEye,
      this.height});

  MLFace.fromJson(Map<String, dynamic> json) {
    border =
        json['border'] != null ? new MLBorder.fromJson(json['border']) : null;
    emotions = json['emotions'] != null
        ? new Emotions.fromJson(json['emotions'])
        : null;
    if (json['faceShapeList'] != null) {
      faceShapeList = new List<FaceShapeList>();
      json['faceShapeList'].forEach((v) {
        faceShapeList.add(new FaceShapeList.fromJson(v));
      });
    }
    rotationAngleY = json['rotationAngleY'];
    rotationAngleZ = json['rotationAngleZ'];
    rotationAngleX = json['rotationAngleX'];
    tracingIdentity = json['tracingIdentity'];
    opennessOfRightEye = json['opennessOfRightEye'];
    features = json['features'] != null
        ? new Features.fromJson(json['features'])
        : null;
    if (json['keyPoints'] != null) {
      keyPoints = new List<KeyPoints>();
      json['keyPoints'].forEach((v) {
        keyPoints.add(new KeyPoints.fromJson(v));
      });
    }
    width = json['width'];
    if (json['allPoints'] != null) {
      allPoints = new List<Points>();
      json['allPoints'].forEach((v) {
        allPoints.add(new Points.fromJson(v));
      });
    }
    possibilityOfSmiling = json['possibilityOfSmiling'];
    opennessOfLeftEye = json['opennessOfLeftEye'];
    height = json['height'];
  }
}

class Emotions {
  dynamic angryProbability;
  dynamic disgustProbability;
  dynamic surpriseProbability;
  dynamic sadProbability;
  dynamic neutralProbability;
  dynamic smilingProbability;
  dynamic fearProbability;

  Emotions(
      {this.angryProbability,
      this.disgustProbability,
      this.surpriseProbability,
      this.sadProbability,
      this.neutralProbability,
      this.smilingProbability,
      this.fearProbability});

  Emotions.fromJson(Map<String, dynamic> json) {
    angryProbability = json['angryProbability'];
    disgustProbability = json['disgustProbability'];
    surpriseProbability = json['surpriseProbability'];
    sadProbability = json['sadProbability'];
    neutralProbability = json['neutralProbability'];
    smilingProbability = json['smilingProbability'];
    fearProbability = json['fearProbability'];
  }
}

class FaceShapeList {
  static const int TYPE_ALL = 0;
  static const int TYPE_FACE = 1;
  static const int TYPE_LEFT_EYE = 2;
  static const int TYPE_RIGHT_EYE = 3;
  static const int TYPE_BOTTOM_OF_LEFT_EYEBROW = 4;
  static const int TYPE_BOTTOM_OF_RIGHT_EYEBROW = 5;
  static const int TYPE_TOP_OF_LEFT_EYEBROW = 6;
  static const int TYPE_TOP_OF_RIGHT_EYEBROW = 7;
  static const int TYPE_BOTTOM_OF_LOWER_LIP = 8;
  static const int TYPE_TOP_OF_LOWER_LIP = 9;
  static const int TYPE_BOTTOM_OF_UPPER_LIP = 10;
  static const int TYPE_TOP_OF_UPPER_LIP = 11;
  static const int TYPE_BOTTOM_OF_NOSE = 12;
  static const int TYPE_BRIDGE_OF_NOSE = 13;

  int faceShapeType;
  List<MLPoint> coordinatePoints;
  List<Points> points;

  FaceShapeList({this.faceShapeType, this.coordinatePoints, this.points});

  FaceShapeList.fromJson(Map<String, dynamic> json) {
    faceShapeType = json['faceShapeType'];
    if (json['coordinatePoints'] != null) {
      coordinatePoints = new List<MLPoint>();
      json['coordinatePoints'].forEach((v) {
        coordinatePoints.add(new MLPoint.fromJson(v));
      });
    }
    if (json['points'] != null) {
      points = new List<Points>();
      json['points'].forEach((v) {
        points.add(new Points.fromJson(v));
      });
    }
  }
}

class Points {
  dynamic x;
  dynamic y;
  dynamic z;

  Points({this.x, this.y, this.z});

  Points.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
    z = json['z'];
  }
}

class Features {
  dynamic moustacheProbability;
  dynamic hatProbability;
  dynamic sexProbability;
  dynamic leftEyeOpenProbability;
  dynamic sunGlassProbability;
  int age;
  dynamic rightEyeOpenProbability;

  Features(
      {this.moustacheProbability,
      this.hatProbability,
      this.sexProbability,
      this.leftEyeOpenProbability,
      this.sunGlassProbability,
      this.age,
      this.rightEyeOpenProbability});

  Features.fromJson(Map<String, dynamic> json) {
    moustacheProbability = json['moustacheProbability'];
    hatProbability = json['hatProbability'];
    sexProbability = json['sexProbability'];
    leftEyeOpenProbability = json['leftEyeOpenProbability'];
    sunGlassProbability = json['sunGlassProbability'];
    age = json['age'];
    rightEyeOpenProbability = json['rightEyeOpenProbability'];
  }
}

class KeyPoints {
  static const int TYPE_BOTTOM_OF_MOUTH = 1;
  static const int TYPE_LEFT_CHEEK = 2;
  static const int TYPE_TIP_OF_LEFT_EAR = 4;
  static const int TYPE_LEFT_EAR = 3;
  static const int TYPE_LEFT_EYE = 5;
  static const int TYPE_LEFT_SIDE_OF_MOUTH = 6;
  static const int TYPE_TIP_OF_NOSE = 7;
  static const int TYPE_RIGHT_CHEEK = 8;
  static const int TYPE_TIP_OF_RIGHT_EAR = 10;
  static const int TYPE_RIGHT_EAR = 9;
  static const int TYPE_RIGHT_EYE = 11;
  static const int TYPE_RIGHT_SIDE_OF_MOUTH = 12;

  int type;
  MLPoint coordinatePoint;
  Points point;

  KeyPoints({this.type, this.coordinatePoint, this.point});

  KeyPoints.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinatePoint = json['coordinatePoint'] != null
        ? new MLPoint.fromJson(json['coordinatePoint'])
        : null;
    point = json['point'] != null ? new Points.fromJson(json['point']) : null;
  }
}

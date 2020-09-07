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

import 'package:huawei_ml/utils/ml_border.dart';
import 'package:huawei_ml/utils/ml_coordinate_points.dart';

class MlFace {
  dynamic opennessOfLeftEye;
  dynamic opennessOfRightEye;
  dynamic tracingIdentity;
  dynamic possibilityOfSmiling;
  dynamic rotationAngleX;
  dynamic rotationAngleY;
  dynamic rotationAngleZ;
  dynamic height;
  dynamic width;
  MlBorder border;
  AllPoints allPoints;
  KeyPoints keyPoints;
  FaceShapeList faceShapeList;
  Features features;
  Emotions emotions;

  MlFace(
      {this.opennessOfLeftEye,
      this.opennessOfRightEye,
      this.tracingIdentity,
      this.possibilityOfSmiling,
      this.rotationAngleX,
      this.rotationAngleY,
      this.rotationAngleZ,
      this.height,
      this.width,
      this.border,
      this.allPoints,
      this.keyPoints,
      this.faceShapeList,
      this.features,
      this.emotions});

  MlFace.fromJson(Map<String, dynamic> json) {
    opennessOfLeftEye = json['opennessOfLeftEye'] ?? null;
    opennessOfRightEye = json['opennessOfRightEye'] ?? null;
    tracingIdentity = json['tracingIdentity'] ?? null;
    possibilityOfSmiling = json['possibilityOfSmiling'] ?? null;
    rotationAngleX = json['rotationAngleX'] ?? null;
    rotationAngleY = json['rotationAngleY'] ?? null;
    rotationAngleZ = json['rotationAngleZ'] ?? null;
    height = json['height'] ?? null;
    width = json['width'] ?? null;
    border =
        json['border'] != null ? new MlBorder.fromJson(json['border']) : null;
    allPoints = json['allPoints'] != null
        ? new AllPoints.fromJson(json['allPoints'])
        : null;
    keyPoints = json['keyPoints'] != null
        ? new KeyPoints.fromJson(json['keyPoints'])
        : null;
    faceShapeList = json['faceShapeList'] != null
        ? new FaceShapeList.fromJson(json['faceShapeList'])
        : null;
    features = json['features'] != null
        ? new Features.fromJson(json['features'])
        : null;
    emotions = json['emotions'] != null
        ? new Emotions.fromJson(json['emotions'])
        : null;
  }
}

class AllPoints {
  dynamic x;
  dynamic y;

  AllPoints({this.x, this.y});

  AllPoints.fromJson(Map<String, dynamic> json) {
    x = json['X'];
    y = json['Y'];
  }
}

class KeyPoints {
  int type;
  Points points;
  MlCoordinatePoints coordinatePoint;

  KeyPoints({this.type, this.points, this.coordinatePoint});

  KeyPoints.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    points =
        json['points'] != null ? new Points.fromJson(json['points']) : null;
    coordinatePoint = json['coordinatePoint'] != null
        ? new MlCoordinatePoints.fromJson(json['coordinatePoint'])
        : null;
  }
}

class Points {
  dynamic x;
  dynamic y;
  dynamic z;

  Points({this.x, this.y, this.z});

  Points.fromJson(Map<String, dynamic> json) {
    x = json['X'];
    y = json['Y'];
    z = json['Z'];
  }
}

class FaceShapeList {
  int faceShapeType;
  Points points;

  FaceShapeList({this.faceShapeType, this.points});

  FaceShapeList.fromJson(Map<String, dynamic> json) {
    faceShapeType = json['faceShapeType'];
    points =
        json['points'] != null ? new Points.fromJson(json['points']) : null;
  }
}

class Features {
  dynamic sunGlassProbability;
  dynamic sexProbability;
  dynamic rightEyeOpenProbability;
  dynamic leftEyeOpenProbability;
  dynamic moustacheProbability;
  int age;
  dynamic hatProbability;

  Features(
      {this.sunGlassProbability,
      this.sexProbability,
      this.rightEyeOpenProbability,
      this.leftEyeOpenProbability,
      this.moustacheProbability,
      this.age,
      this.hatProbability});

  Features.fromJson(Map<String, dynamic> json) {
    sunGlassProbability = json['sunGlassProbability'];
    sexProbability = json['sexProbability'];
    rightEyeOpenProbability = json['rightEyeOpenProbability'];
    leftEyeOpenProbability = json['leftEyeOpenProbability'];
    moustacheProbability = json['moustacheProbability'];
    age = json['age'];
    hatProbability = json['hatProbability'];
  }
}

class Emotions {
  dynamic surpriseProbability;
  dynamic smilingProbability;
  dynamic sadProbability;
  dynamic neutralProbability;
  dynamic fearProbability;
  dynamic disgustProbability;
  dynamic angryProbability;

  Emotions(
      {this.surpriseProbability,
      this.smilingProbability,
      this.sadProbability,
      this.neutralProbability,
      this.fearProbability,
      this.disgustProbability,
      this.angryProbability});

  Emotions.fromJson(Map<String, dynamic> json) {
    surpriseProbability = json['surpriseProbability'];
    smilingProbability = json['smilingProbability'];
    sadProbability = json['sadProbability'];
    neutralProbability = json['neutralProbability'];
    fearProbability = json['fearProbability'];
    disgustProbability = json['disgustProbability'];
    angryProbability = json['angryProbability'];
  }
}

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

import 'dart:convert';
import 'dart:ui';

import 'ar_engine_scene.dart';
import 'utils.dart';

abstract class ARSceneBaseConfig {
  static const Color defaultRed = Color(0xFFED1C24);
  static const Color defaultWhite = Color(0xFFFFFFFF);
  static const Color defaultBlue = Color(0xFF0000FF);
  static const Color defaultGreen = Color(0xFF00FF00);

  ARSceneType getARSceneType();

  String getARSceneConfig();
}

class ARSceneHandConfig implements ARSceneBaseConfig {
  bool enableBoundingBox;
  Color boxColor;
  double lineWidth;

  ARSceneHandConfig(
      {this.boxColor = ARSceneBaseConfig.defaultGreen,
      this.lineWidth = 18.0,
      this.enableBoundingBox = true});

  @override
  ARSceneType getARSceneType() {
    return ARSceneType.HAND;
  }

  @override
  String getARSceneConfig() {
    return json.encode({
      "type": "arHand",
      "enableBoundingBox": enableBoundingBox,
      "boxColor": Utils.serializeColorToRGBA(boxColor),
      "lineWidth": lineWidth,
    }..removeWhere((k, v) => v == null));
  }
}

class ARSceneFaceConfig implements ARSceneBaseConfig {
  double pointSize;
  Color depthColor;
  String texturePath;
  bool drawFace;

  ARSceneFaceConfig(
      {this.pointSize = 5.0,
      this.depthColor = ARSceneBaseConfig.defaultWhite,
      this.texturePath,
      this.drawFace = true});

  @override
  String getARSceneConfig() {
    return json.encode({
      "type": "arFace",
      "pointSize": pointSize,
      "depthColor": Utils.serializeColorToRGBA(depthColor),
      "texturePath": texturePath,
      "drawFace": drawFace,
    });
  }

  @override
  ARSceneType getARSceneType() {
    return ARSceneType.FACE;
  }
}

class ARSceneBodyConfig implements ARSceneBaseConfig {
  bool drawLine;
  bool drawPoint;

  double lineWidth;
  double pointSize;

  Color lineColor;
  Color pointColor;

  ARSceneBodyConfig(
      {this.drawLine = true,
      this.drawPoint = true,
      this.lineWidth = 19.9,
      this.pointSize = 50.0,
      this.lineColor = ARSceneBaseConfig.defaultRed,
      this.pointColor = ARSceneBaseConfig.defaultBlue});

  @override
  String getARSceneConfig() {
    return json.encode({
      "type": "arBody",
      "drawLine": drawLine,
      "drawPoint": drawPoint,
      "lineWidth": lineWidth,
      "pointSize": pointSize,
      "lineColor": Utils.serializeColorToRGBA(lineColor),
      "pointColor": Utils.serializeColorToRGBA(pointColor),
    }..removeWhere((k, v) => v == null));
  }

  @override
  ARSceneType getARSceneType() {
    return ARSceneType.BODY;
  }
}

class ARSceneWorldConfig implements ARSceneBaseConfig {
  String objPath;
  String texturePath;
  bool drawLabel;

  String imageOther;
  String imageWall;
  String imageFloor;
  String imageSeat;
  String imageTable;
  String imageCeiling;
  String textOther;
  String textWall;
  String textFloor;
  String textSeat;
  String textTable;
  String textCeiling;
  Color colorOther;
  Color colorWall;
  Color colorFloor;
  Color colorSeat;
  Color colorTable;
  Color colorCeiling;

  ARSceneWorldConfig(
      {this.objPath,
      this.texturePath,
      this.drawLabel = true,
      this.imageOther,
      this.imageWall,
      this.imageFloor,
      this.imageSeat,
      this.imageTable,
      this.imageCeiling,
      this.textOther = "Other",
      this.textWall = "Wall",
      this.textFloor = "Floor",
      this.textSeat = "Seat",
      this.textTable = "Table",
      this.textCeiling = "Ceiling",
      this.colorOther = ARSceneBaseConfig.defaultRed,
      this.colorWall = ARSceneBaseConfig.defaultRed,
      this.colorFloor = ARSceneBaseConfig.defaultRed,
      this.colorSeat = ARSceneBaseConfig.defaultRed,
      this.colorTable = ARSceneBaseConfig.defaultRed,
      this.colorCeiling = ARSceneBaseConfig.defaultRed});

  @override
  String getARSceneConfig() {
    return json.encode({
      "type": "arWorld",
      "objPath": objPath,
      "texturePath": texturePath,
      "drawLabel": drawLabel,
      "imageOther": imageOther,
      "imageWall": imageWall,
      "imageFloor": imageFloor,
      "imageSeat": imageSeat,
      "imageTable": imageTable,
      "imageCeiling": imageCeiling,
      "textOther": textOther,
      "textWall": textWall,
      "textFloor": textFloor,
      "textSeat": textSeat,
      "textTable": textTable,
      "textCeiling": textCeiling,
      "colorOther": Utils.serializeColorToRGBA(colorOther),
      "colorWall": Utils.serializeColorToRGBA(colorWall),
      "colorFloor": Utils.serializeColorToRGBA(colorFloor),
      "colorSeat": Utils.serializeColorToRGBA(colorSeat),
      "colorTable": Utils.serializeColorToRGBA(colorTable),
      "colorCeiling": Utils.serializeColorToRGBA(colorCeiling)
    }..removeWhere((k, v) => v == null));
  }

  @override
  ARSceneType getARSceneType() {
    return ARSceneType.WORLD;
  }
}

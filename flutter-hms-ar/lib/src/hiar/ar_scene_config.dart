/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_ar;

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
  bool drawLine;
  bool drawPoint;
  double lineWidthSkeleton;
  double pointSize;
  Color lineColor;
  Color pointColor;
  CameraLensFacing cameraLensFacing;
  Semantic? semantic;
  LightMode lightMode;
  PowerMode powerMode;
  FocusMode focusMode;
  UpdateMode updateMode;

  ARSceneHandConfig({
    this.boxColor = ARSceneBaseConfig.defaultGreen,
    this.lineWidth = 18.0,
    this.enableBoundingBox = true,
    this.drawLine = true,
    this.drawPoint = true,
    this.lineWidthSkeleton = 19.9,
    this.pointSize = 50.0,
    this.lineColor = ARSceneBaseConfig.defaultBlue,
    this.pointColor = ARSceneBaseConfig.defaultGreen,
    this.cameraLensFacing = CameraLensFacing.FRONT,
    this.semantic,
    this.lightMode = LightMode.ALL,
    this.powerMode = PowerMode.PERFORMANCE_FIRST,
    this.focusMode = FocusMode.AUTO_FOCUS,
    this.updateMode = UpdateMode.LATEST_CAMERA_IMAGE,
  });

  @override
  String getARSceneConfig() {
    return json.encode(
      <String, dynamic>{
        'type': 'arHand',
        'enableBoundingBox': enableBoundingBox,
        'boxColor': Utils.serializeColorToRGBA(boxColor),
        'lineWidth': lineWidth,
        'drawLine': drawLine,
        'drawPoint': drawPoint,
        'lineWidthSkeleton': lineWidthSkeleton,
        'pointSize': pointSize,
        'lineColor': Utils.serializeColorToRGBA(lineColor),
        'pointColor': Utils.serializeColorToRGBA(pointColor),
        'cameraLensFacing': cameraLensFacing.index + 1,
        'semantic': semantic?.toMap(),
        'lightMode': lightMode.value,
        'powerMode': powerMode.index + 1,
        'focusMode': focusMode.index + 1,
        'updateMode': updateMode.index + 1,
      }..removeWhere((String k, dynamic v) => v == null),
    );
  }

  @override
  ARSceneType getARSceneType() {
    return ARSceneType.HAND;
  }
}

class ARSceneFaceConfig implements ARSceneBaseConfig {
  double pointSize;
  Color depthColor;
  String? texturePath;
  bool drawFace;
  bool enableHealthDevice;
  bool multiFace;
  CameraLensFacing cameraLensFacing;
  Semantic? semantic;
  LightMode lightMode;
  PowerMode powerMode;
  FocusMode focusMode;
  UpdateMode updateMode;

  ARSceneFaceConfig({
    this.pointSize = 5.0,
    this.depthColor = ARSceneBaseConfig.defaultWhite,
    this.texturePath,
    this.drawFace = true,
    this.enableHealthDevice = false,
    this.multiFace = false,
    this.cameraLensFacing = CameraLensFacing.FRONT,
    this.semantic,
    this.lightMode = LightMode.NONE,
    this.powerMode = PowerMode.NORMAL,
    this.focusMode = FocusMode.AUTO_FOCUS,
    this.updateMode = UpdateMode.LATEST_CAMERA_IMAGE,
  });

  @override
  String getARSceneConfig() {
    return json.encode(
      <String, dynamic>{
        'type': 'arFace',
        'pointSize': pointSize,
        'depthColor': Utils.serializeColorToRGBA(depthColor),
        'texturePath': texturePath,
        'drawFace': drawFace,
        'enableHealthDevice': enableHealthDevice,
        'multiFace': multiFace,
        'cameraLensFacing': cameraLensFacing.index + 1,
        'semantic': semantic?.toMap(),
        'lightMode': lightMode.value,
        'powerMode': powerMode.index + 1,
        'focusMode': focusMode.index + 1,
        'updateMode': updateMode.index + 1,
      }..removeWhere((String k, dynamic v) => v == null),
    );
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
  Semantic? semantic;
  LightMode lightMode;
  PowerMode powerMode;
  FocusMode focusMode;
  UpdateMode updateMode;

  ARSceneBodyConfig({
    this.drawLine = true,
    this.drawPoint = true,
    this.lineWidth = 19.9,
    this.pointSize = 50.0,
    this.lineColor = ARSceneBaseConfig.defaultRed,
    this.pointColor = ARSceneBaseConfig.defaultBlue,
    this.semantic,
    this.lightMode = LightMode.ALL,
    this.powerMode = PowerMode.PERFORMANCE_FIRST,
    this.focusMode = FocusMode.AUTO_FOCUS,
    this.updateMode = UpdateMode.LATEST_CAMERA_IMAGE,
  });

  @override
  String getARSceneConfig() {
    return json.encode(
      <String, dynamic>{
        'type': 'arBody',
        'drawLine': drawLine,
        'drawPoint': drawPoint,
        'lineWidth': lineWidth,
        'pointSize': pointSize,
        'lineColor': Utils.serializeColorToRGBA(lineColor),
        'pointColor': Utils.serializeColorToRGBA(pointColor),
        'semantic': semantic?.toMap(),
        'lightMode': lightMode.value,
        'powerMode': powerMode.index + 1,
        'focusMode': focusMode.index + 1,
        'updateMode': updateMode.index + 1,
      }..removeWhere((String k, dynamic v) => v == null),
    );
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

  String? imageOther;
  String? imageWall;
  String? imageFloor;
  String? imageSeat;
  String? imageTable;
  String? imageCeiling;
  String? imageDoor;
  String? imageWindow;
  String? imageBed;
  String textOther;
  String textWall;
  String textFloor;
  String textSeat;
  String textTable;
  String textCeiling;
  String textDoor;
  String textWindow;
  String textBed;
  Color colorOther;
  Color colorWall;
  Color colorFloor;
  Color colorSeat;
  Color colorTable;
  Color colorCeiling;
  Color colorDoor;
  Color colorWindow;
  Color colorBed;

  double maxMapSize;
  AugmentedImage? augmentedImage;
  PlaneFindingMode planeFindingMode;
  bool drawLine;
  bool drawPoint;
  double lineWidth;
  double pointSize;
  Color lineColor;
  Color pointColor;
  Semantic? semantic;
  LightMode lightMode;
  PowerMode powerMode;
  FocusMode focusMode;
  UpdateMode updateMode;

  ARSceneWorldConfig({
    required this.objPath,
    required this.texturePath,
    this.drawLabel = true,
    this.imageOther,
    this.imageWall,
    this.imageFloor,
    this.imageSeat,
    this.imageTable,
    this.imageCeiling,
    this.imageDoor,
    this.imageWindow,
    this.imageBed,
    this.textOther = 'Other',
    this.textWall = 'Wall',
    this.textFloor = 'Floor',
    this.textSeat = 'Seat',
    this.textTable = 'Table',
    this.textCeiling = 'Ceiling',
    this.textDoor = 'Door',
    this.textWindow = 'Window',
    this.textBed = 'Bed',
    this.colorOther = ARSceneBaseConfig.defaultRed,
    this.colorWall = ARSceneBaseConfig.defaultRed,
    this.colorFloor = ARSceneBaseConfig.defaultRed,
    this.colorSeat = ARSceneBaseConfig.defaultRed,
    this.colorTable = ARSceneBaseConfig.defaultRed,
    this.colorCeiling = ARSceneBaseConfig.defaultRed,
    this.colorDoor = ARSceneBaseConfig.defaultRed,
    this.colorWindow = ARSceneBaseConfig.defaultRed,
    this.colorBed = ARSceneBaseConfig.defaultRed,
    this.maxMapSize = 800,
    this.planeFindingMode = PlaneFindingMode.ENABLE,
    this.augmentedImage,
    this.drawLine = true,
    this.drawPoint = true,
    this.lineWidth = 19.9,
    this.pointSize = 50.0,
    this.lineColor = ARSceneBaseConfig.defaultRed,
    this.pointColor = ARSceneBaseConfig.defaultBlue,
    this.semantic,
    this.lightMode = LightMode.ALL,
    this.powerMode = PowerMode.PERFORMANCE_FIRST,
    this.focusMode = FocusMode.AUTO_FOCUS,
    this.updateMode = UpdateMode.LATEST_CAMERA_IMAGE,
  });

  @override
  String getARSceneConfig() {
    return json.encode(
      <String, dynamic>{
        'type': 'arWorld',
        'objPath': objPath,
        'texturePath': texturePath,
        'drawLabel': drawLabel,
        'imageOther': imageOther,
        'imageWall': imageWall,
        'imageFloor': imageFloor,
        'imageSeat': imageSeat,
        'imageTable': imageTable,
        'imageCeiling': imageCeiling,
        'imageDoor': imageDoor,
        'imageWindow': imageWindow,
        'imageBed': imageBed,
        'textOther': textOther,
        'textWall': textWall,
        'textFloor': textFloor,
        'textSeat': textSeat,
        'textTable': textTable,
        'textCeiling': textCeiling,
        'textDoor': textDoor,
        'textWindow': textWindow,
        'textBed': textBed,
        'colorOther': Utils.serializeColorToRGBA(colorOther),
        'colorWall': Utils.serializeColorToRGBA(colorWall),
        'colorFloor': Utils.serializeColorToRGBA(colorFloor),
        'colorSeat': Utils.serializeColorToRGBA(colorSeat),
        'colorTable': Utils.serializeColorToRGBA(colorTable),
        'colorCeiling': Utils.serializeColorToRGBA(colorCeiling),
        'colorDoor': Utils.serializeColorToRGBA(colorDoor),
        'colorWindow': Utils.serializeColorToRGBA(colorWindow),
        'colorBed': Utils.serializeColorToRGBA(colorBed),
        'maxMapSize': maxMapSize,
        'planeFindingMode': planeFindingMode.index + 1,
        'augmentedImage': augmentedImage?.toMap(),
        'drawLine': drawLine,
        'drawPoint': drawPoint,
        'lineWidth': lineWidth,
        'pointSize': pointSize,
        'lineColor': Utils.serializeColorToRGBA(lineColor),
        'pointColor': Utils.serializeColorToRGBA(pointColor),
        'semantic': semantic?.toMap(),
        'lightMode': lightMode.value,
        'powerMode': powerMode.index + 1,
        'focusMode': focusMode.index + 1,
        'updateMode': updateMode.index + 1,
      }..removeWhere((String k, dynamic v) => v == null),
    );
  }

  @override
  ARSceneType getARSceneType() {
    return ARSceneType.WORLD;
  }
}

class ARSceneAugmentedImageConfig implements ARSceneBaseConfig {
  AugmentedImage augmentedImage;
  bool drawLine;
  bool drawPoint;
  double lineWidth;
  double pointSize;
  Color lineColor;
  Color pointColor;
  Semantic? semantic;
  LightMode lightMode;
  PowerMode powerMode;
  FocusMode focusMode;
  UpdateMode updateMode;

  ARSceneAugmentedImageConfig({
    required this.augmentedImage,
    this.drawLine = true,
    this.drawPoint = true,
    this.lineWidth = 19.9,
    this.pointSize = 50.0,
    this.lineColor = ARSceneBaseConfig.defaultRed,
    this.pointColor = ARSceneBaseConfig.defaultBlue,
    this.semantic,
    this.lightMode = LightMode.ALL,
    this.powerMode = PowerMode.PERFORMANCE_FIRST,
    this.focusMode = FocusMode.AUTO_FOCUS,
    this.updateMode = UpdateMode.LATEST_CAMERA_IMAGE,
  });

  @override
  String getARSceneConfig() {
    return json.encode(
      <String, dynamic>{
        'type': 'arAugmentedImage',
        'augmentedImage': augmentedImage.toMap(),
        'drawLine': drawLine,
        'drawPoint': drawPoint,
        'lineWidth': lineWidth,
        'pointSize': pointSize,
        'lineColor': Utils.serializeColorToRGBA(lineColor),
        'pointColor': Utils.serializeColorToRGBA(pointColor),
        'semantic': semantic?.toMap(),
        'lightMode': lightMode.value,
        'powerMode': powerMode.index + 1,
        'focusMode': focusMode.index + 1,
        'updateMode': updateMode.index + 1,
      }..removeWhere((String k, dynamic v) => v == null),
    );
  }

  @override
  ARSceneType getARSceneType() {
    return ARSceneType.AUGMENTED_IMAGE;
  }
}

class ARSceneMeshConfig implements ARSceneBaseConfig {
  String objPath;
  String texturePath;
  Semantic? semantic;
  LightMode lightMode;
  PowerMode powerMode;
  FocusMode focusMode;
  UpdateMode updateMode;

  ARSceneMeshConfig({
    required this.objPath,
    required this.texturePath,
    this.semantic,
    this.lightMode = LightMode.ALL,
    this.powerMode = PowerMode.PERFORMANCE_FIRST,
    this.focusMode = FocusMode.AUTO_FOCUS,
    this.updateMode = UpdateMode.LATEST_CAMERA_IMAGE,
  });

  @override
  String getARSceneConfig() {
    return json.encode(
      <String, dynamic>{
        'type': 'arSceneMesh',
        'objPath': objPath,
        'texturePath': texturePath,
        'semantic': semantic?.toMap(),
        'lightMode': lightMode.value,
        'powerMode': powerMode.index + 1,
        'focusMode': focusMode.index + 1,
        'updateMode': updateMode.index + 1,
      }..removeWhere((String k, dynamic v) => v == null),
    );
  }

  @override
  ARSceneType getARSceneType() {
    return ARSceneType.SCENE_MESH;
  }
}

class ARSceneCloud3DObjectConfig implements ARSceneBaseConfig {
  String fileName;

  ARSceneCloud3DObjectConfig({
    required this.fileName,
  });

  @override
  String getARSceneConfig() {
    return json.encode(
      <String, Object>{
        'type': 'arCloud3DObject',
        'fileName': fileName,
      },
    );
  }

  @override
  ARSceneType getARSceneType() {
    return ARSceneType.CLOUD3D_OBJECT;
  }
}

class ARSceneWorldBodyConfig extends ARSceneBaseConfig {
  String objPath;
  String texturePath;
  bool drawLabel;

  String? imageOther;
  String? imageWall;
  String? imageFloor;
  String? imageSeat;
  String? imageTable;
  String? imageCeiling;
  String? imageDoor;
  String? imageWindow;
  String? imageBed;
  String textOther;
  String textWall;
  String textFloor;
  String textSeat;
  String textTable;
  String textCeiling;
  String textDoor;
  String textWindow;
  String textBed;
  Color colorOther;
  Color colorWall;
  Color colorFloor;
  Color colorSeat;
  Color colorTable;
  Color colorCeiling;
  Color colorDoor;
  Color colorWindow;
  Color colorBed;

  double maxMapSize;
  AugmentedImage? augmentedImage;
  PlaneFindingMode planeFindingMode;
  bool drawLine;
  bool drawPoint;
  double lineWidth;
  double pointSize;
  Color lineColor;
  Color pointColor;
  Semantic? semantic;
  LightMode lightMode;
  PowerMode powerMode;
  FocusMode focusMode;
  UpdateMode updateMode;

  ARSceneWorldBodyConfig({
    required this.objPath,
    required this.texturePath,
    this.drawLabel = true,
    this.imageOther,
    this.imageWall,
    this.imageFloor,
    this.imageSeat,
    this.imageTable,
    this.imageCeiling,
    this.imageDoor,
    this.imageWindow,
    this.imageBed,
    this.textOther = 'Other',
    this.textWall = 'Wall',
    this.textFloor = 'Floor',
    this.textSeat = 'Seat',
    this.textTable = 'Table',
    this.textCeiling = 'Ceiling',
    this.textDoor = 'Door',
    this.textWindow = 'Window',
    this.textBed = 'Bed',
    this.colorOther = ARSceneBaseConfig.defaultRed,
    this.colorWall = ARSceneBaseConfig.defaultRed,
    this.colorFloor = ARSceneBaseConfig.defaultRed,
    this.colorSeat = ARSceneBaseConfig.defaultRed,
    this.colorTable = ARSceneBaseConfig.defaultRed,
    this.colorCeiling = ARSceneBaseConfig.defaultRed,
    this.colorDoor = ARSceneBaseConfig.defaultRed,
    this.colorWindow = ARSceneBaseConfig.defaultRed,
    this.colorBed = ARSceneBaseConfig.defaultRed,
    this.maxMapSize = 800,
    this.planeFindingMode = PlaneFindingMode.ENABLE,
    this.augmentedImage,
    this.drawLine = true,
    this.drawPoint = true,
    this.lineWidth = 19.9,
    this.pointSize = 50.0,
    this.lineColor = ARSceneBaseConfig.defaultRed,
    this.pointColor = ARSceneBaseConfig.defaultBlue,
    this.semantic,
    this.lightMode = LightMode.ALL,
    this.powerMode = PowerMode.PERFORMANCE_FIRST,
    this.focusMode = FocusMode.AUTO_FOCUS,
    this.updateMode = UpdateMode.LATEST_CAMERA_IMAGE,
  });

  @override
  String getARSceneConfig() {
    return json.encode(
      <String, dynamic>{
        'type': 'arWorldBody',
        'objPath': objPath,
        'texturePath': texturePath,
        'drawLabel': drawLabel,
        'imageOther': imageOther,
        'imageWall': imageWall,
        'imageFloor': imageFloor,
        'imageSeat': imageSeat,
        'imageTable': imageTable,
        'imageCeiling': imageCeiling,
        'imageDoor': imageDoor,
        'imageWindow': imageWindow,
        'imageBed': imageBed,
        'textOther': textOther,
        'textWall': textWall,
        'textFloor': textFloor,
        'textSeat': textSeat,
        'textTable': textTable,
        'textCeiling': textCeiling,
        'textDoor': textDoor,
        'textWindow': textWindow,
        'textBed': textBed,
        'colorOther': Utils.serializeColorToRGBA(colorOther),
        'colorWall': Utils.serializeColorToRGBA(colorWall),
        'colorFloor': Utils.serializeColorToRGBA(colorFloor),
        'colorSeat': Utils.serializeColorToRGBA(colorSeat),
        'colorTable': Utils.serializeColorToRGBA(colorTable),
        'colorCeiling': Utils.serializeColorToRGBA(colorCeiling),
        'colorDoor': Utils.serializeColorToRGBA(colorDoor),
        'colorWindow': Utils.serializeColorToRGBA(colorWindow),
        'colorBed': Utils.serializeColorToRGBA(colorBed),
        'maxMapSize': maxMapSize,
        'planeFindingMode': planeFindingMode.index + 1,
        'augmentedImage': augmentedImage?.toMap(),
        'drawLine': drawLine,
        'drawPoint': drawPoint,
        'lineWidth': lineWidth,
        'pointSize': pointSize,
        'lineColor': Utils.serializeColorToRGBA(lineColor),
        'pointColor': Utils.serializeColorToRGBA(pointColor),
        'semantic': semantic?.toMap(),
        'lightMode': lightMode.value,
        'powerMode': powerMode.index + 1,
        'focusMode': focusMode.index + 1,
        'updateMode': updateMode.index + 1,
      }..removeWhere((String k, dynamic v) => v == null),
    );
  }

  @override
  ARSceneType getARSceneType() {
    return ARSceneType.WORLD_BODY;
  }
}

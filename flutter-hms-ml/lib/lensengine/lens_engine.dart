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

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_ml/models/ml_3d_face.dart';
import 'package:huawei_ml/models/ml_face.dart';
import 'package:huawei_ml/models/ml_hand_keypoint.dart';
import 'package:huawei_ml/models/ml_image_classification.dart';
import 'package:huawei_ml/models/ml_object.dart';
import 'package:huawei_ml/models/ml_scene_detection.dart';
import 'package:huawei_ml/models/ml_skeleton.dart';
import 'package:huawei_ml/models/ml_text.dart';
import 'package:huawei_ml/utils/channels.dart';
import 'package:huawei_ml/utils/ml_utils.dart';

import 'lens_view_controller.dart';

class LensEngine {
  final MethodChannel _channel = Channels.lensMethodChannel;

  LensTransactor _transactor;
  LensViewController _controller;
  StreamSubscription _subscription;

  LensEngine({@required LensViewController controller}) {
    _controller = controller;
  }

  Future<void> initLens() async {
    _startTransactor();
    _controller.setTextureId(await _channel.invokeMethod("initializeLensView", _controller.toMap()));
  }

  Future<void> run() async {
    await _channel.invokeMethod("run");
  }

  Future<bool> release() async {
    final bool res = await _channel.invokeMethod("release");
    _subscription?.cancel();
    return res;
  }

  Future<String> photograph() async {
    return await _channel.invokeMethod("photograph");
  }

  Future<void> zoom(double z) async {
    await _channel.invokeMethod("zoom", <String, dynamic>{'zoom': z});
  }

  Future<bool> getLens() async {
    return _channel.invokeMethod("getLens");
  }

  Future<int> getLensType() async {
    return await _channel.invokeMethod("getLensType");
  }

  Future<Size> getDisplayDimension() async {
    Map<dynamic, dynamic> map = await _channel.invokeMethod("getDisplayDimensions");
    int width = map['width'];
    int height = map['height'];
    return new Size(width.toDouble(), height.toDouble());
  }

  Future<void> switchCamera() async {
    await _channel.invokeMethod("switchCamera");
  }

  void setTransactor(LensTransactor transactor) {
    _transactor = transactor;
  }

  _startTransactor() {
    _subscription?.cancel();
    switch (_controller.analyzerType) {
      case LensEngineAnalyzerOptions.FACE:
        _subscription = Channels.faceAnalyzerEventChannel
            .receiveBroadcastStream()
            .listen((event) {
          Map<String, dynamic> map = json.decode(event);
          MLFace face = MLFace.fromJson(map['result']);
          bool isAvailable = map['isAnalyzerAvailable'];
          _transactor?.call(result: face, isAnalyzerAvailable: isAvailable);
        });
        break;
      case LensEngineAnalyzerOptions.FACE_3D:
        _subscription = Channels.face3dEventChannel
            .receiveBroadcastStream()
            .listen((event) {
          Map<String, dynamic> map = json.decode(event);
          ML3DFace face = new ML3DFace.fromJson(map['result']);
          bool isAvailable = map['isAnalyzerAvailable'];
          _transactor?.call(result: face, isAnalyzerAvailable: isAvailable);
        });
        break;
      case LensEngineAnalyzerOptions.MAX_SIZE_FACE:
        _subscription = Channels.faceAnalyzerEventChannel
            .receiveBroadcastStream()
            .listen((event) {
          _transactor?.call(result: event);
        });
        break;
      case LensEngineAnalyzerOptions.HAND:
        _subscription = Channels.handAnalyzerEventChannel
            .receiveBroadcastStream()
            .listen((event) {
          Map<String, dynamic> map = json.decode(event);
          MLHandKeypoints mlHandKeypoints =
              new MLHandKeypoints.fromJson(map['result']);
          bool isAvailable = map['isAnalyzerAvailable'];
          _transactor?.call(
              result: mlHandKeypoints, isAnalyzerAvailable: isAvailable);
        });
        break;
      case LensEngineAnalyzerOptions.SKELETON:
        _subscription = Channels.skeletonAnalyzerEventChannel
            .receiveBroadcastStream()
            .listen((event) {
          Map<String, dynamic> map = json.decode(event);
          MLSkeleton skeleton = new MLSkeleton.fromJson(map['result']);
          bool isAvailable = map['isAnalyzerAvailable'];
          _transactor?.call(result: skeleton, isAnalyzerAvailable: isAvailable);
        });
        break;
      case LensEngineAnalyzerOptions.CLASSIFICATION:
        _subscription = Channels.classificationEventChannel.receiveBroadcastStream().listen((event) {
          Map<String, dynamic> map = json.decode(event);
          MLImageClassification classification =
              new MLImageClassification.fromJson(map['result']);
          bool isAvailable = map['isAnalyzerAvailable'];
          _transactor?.call(
              result: classification, isAnalyzerAvailable: isAvailable);
        });
        break;
      case LensEngineAnalyzerOptions.TEXT:
        _subscription = Channels.textAnalyzerEventChannel
            .receiveBroadcastStream()
            .listen((event) {
          Map<String, dynamic> map = json.decode(event);
          Blocks block = Blocks.fromJson(map['result']);
          bool isAvailable = map['isAnalyzerAvailable'];
          _transactor?.call(result: block, isAnalyzerAvailable: isAvailable);
        });
        break;
      case LensEngineAnalyzerOptions.OBJECT:
        _subscription = Channels.objectAnalyzerEventChannel.receiveBroadcastStream().listen((event) {
          Map<String, dynamic> map = json.decode(event);
          MLObject object = new MLObject.fromJson(map['result']);
          bool isAvailable = map['isAnalyzerAvailable'];
          _transactor?.call(result: object, isAnalyzerAvailable: isAvailable);
        });
        break;
      case LensEngineAnalyzerOptions.SCENE:
        _subscription = Channels.sceneDetectionEventChannel.receiveBroadcastStream().listen((event) {
          Map<String, dynamic> map = json.decode(event);
          MLSceneDetection sceneDetection =
              new MLSceneDetection.fromJson(map['result']);
          bool isAvailable = map['isAnalyzerAvailable'];
          _transactor?.call(result: sceneDetection, isAnalyzerAvailable: isAvailable);
        });
        break;
      default:
        _transactor?.call(result: "No valid analyzer type is specified!");
        break;
    }
  }
}

typedef LensTransactor({dynamic result, bool isAnalyzerAvailable});

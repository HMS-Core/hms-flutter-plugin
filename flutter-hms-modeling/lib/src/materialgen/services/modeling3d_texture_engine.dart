/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:flutter/services.dart';

import '../listener/listener_export.dart';
import '../request/modeling3d_texture_setting.dart';
import '../result/result_export.dart';

/// Material generation engine.
class Modeling3dTextureEngine {
  late MethodChannel _c;

  Modeling3dTextureUploadListener? _uploadListener;
  Modeling3dTextureDownloadListener? _downloadListener;
  Modeling3dTexturePreviewListener? _previewListener;

  Modeling3dTextureEngine() {
    _c = _initMethodChannel();
  }

  MethodChannel _initMethodChannel() {
    MethodChannel channel =
        MethodChannel('com.huawei.modeling3d.materialgenengine/method');
    channel.setMethodCallHandler(_onMethodCall);
    return channel;
  }

  /// Disables the material generation engine.
  void close() {
    _c.invokeMethod('close');
  }

  /// Uploads images and triggers a material generation task.
  void asyncUploadFile(String taskId, String filePath) async {
    _c.invokeMethod("upload", {'taskId': taskId, 'filePath': filePath});
  }

  /// Downloads generated texture maps.
  void asyncDownloadTexture(String taskId, String fileSavePath) async {
    _c.invokeMethod("download", {'taskId': taskId, 'filePath': fileSavePath});
  }

  /// Previews the texture map.
  void previewTexture(String taskId,
      {Modeling3dTexturePreviewListener? listener}) {
    if (listener != null) {
      _previewListener = listener;
    }
    _c.invokeMethod('previewTexture', {'taskId': taskId});
  }

  /// Sets a listener for image upload.
  void setTextureUploadListener(Modeling3dTextureUploadListener listener) {
    _uploadListener = listener;
  }

  /// Sets a listener for texture map download.
  void setTextureDownloadListener(Modeling3dTextureDownloadListener listener) {
    _downloadListener = listener;
  }

  /// Cancels image upload.
  Future<int> cancelUpload(String taskId) async {
    return await _c.invokeMethod('cancelUpload', {'taskId': taskId});
  }

  /// Cancels texture map download.
  Future<int> cancelDownload(String taskId) async {
    return await _c.invokeMethod('cancelDownload', {'taskId': taskId});
  }

  /// Initializes a material generation task.
  Future<Modeling3dTextureInitResult> initTask(
      Modeling3dTextureSetting setting) async {
    return Modeling3dTextureInitResult.fromMap(
        await _c.invokeMethod('initTask', setting.toMap()));
  }

  /// Generates texture maps synchronously.
  Future<int> syncGenerateTexture(String filePath, String fileSavePath,
      Modeling3dTextureSetting setting) async {
    return await _c.invokeMethod('syncGenerateTexture', {
      'filePath': filePath,
      'fileSavePath': fileSavePath,
      'setting': setting.toMap()
    });
  }

  Future<dynamic> _onMethodCall(MethodCall call) {
    final String taskId = call.arguments['taskId'];
    switch (call.method) {
      case "textureUploadProgress":
        _uploadListener?.onUploadProgress
            .call(taskId, call.arguments['progress']);
        break;
      case "textureUploadResult":
        _uploadListener?.onResult.call(taskId,
            Modeling3dTextureUploadResult.fromMap(call.arguments['result']));
        break;
      case "textureUploadError":
        _uploadListener?.onError.call(
            taskId, call.arguments['errorCode'], call.arguments['message']);
        break;
      case "textureDownloadProgress":
        _downloadListener?.onDownloadProgress
            .call(taskId, call.arguments['progress']);
        break;
      case "textureDownloadResult":
        _downloadListener?.onResult.call(taskId,
            Modeling3dTextureDownloadResult.fromMap(call.arguments['result']));
        break;
      case "textureDownloadError":
        _downloadListener?.onError.call(
            taskId, call.arguments['errorCode'], call.arguments['message']);
        break;
      case "texturePreviewResult":
        _previewListener?.onResult(taskId);
        break;
      case "texturePreviewError":
        _previewListener?.onError(
            taskId, call.arguments['errorCode'], call.arguments['message']);
        break;
      default:
        throw "Not implemented!";
    }
    return Future<dynamic>.value(null);
  }
}

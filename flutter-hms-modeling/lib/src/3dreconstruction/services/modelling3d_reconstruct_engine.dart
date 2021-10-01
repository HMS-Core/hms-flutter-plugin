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

import 'package:flutter/services.dart';

import '../constants/channel.dart';
import '../listener/listener_export.dart';
import '../request/modeling3d_reconstruct_setting.dart';
import '../result/result_export.dart';

/// 3D object reconstruction engine.
class Modeling3dReconstructEngine {
  static const MethodChannel _channel = modelling3dRecEngineMethodChannel;

  Modeling3dReconstructDownloadListener? _downloadListener;
  Modeling3dReconstructUploadListener? _uploadListener;
  Modeling3dReconstructPreviewListener? _previewListener;

  static final _instance = Modeling3dReconstructEngine._();

  /// Obtains a Modeling3dReconstructEngine instance.
  static Future<Modeling3dReconstructEngine> get instance async {
    await _channel.invokeMethod("getInstance");
    return _instance;
  }

  Modeling3dReconstructEngine._() {
    _channel.setMethodCallHandler(_onMethodCall);
  }

  /// Initializes a 3D object reconstruction task.
  Future<Modeling3dReconstructInitResult> initTask(
      Modeling3dReconstructSetting setting) async {
    final resultMap = await _channel.invokeMethod("initTask", setting.toMap());
    return Modeling3dReconstructInitResult.fromMap(
        Map<String, dynamic>.from(resultMap));
  }

  /// Disables the 3D object reconstruction engine.
  Future<void> close() async {
    await _channel.invokeMethod("close");
  }

  /// Uploads images and triggers a 3D object reconstruction task.
  Future<void> uploadFile(String taskId, String filePath) async {
    await _channel
        .invokeMethod("uploadFile", {"taskId": taskId, "filePath": filePath});
  }

  /// Cancels image upload.
  Future<int> cancelUpload(String taskId) async {
    return await _channel.invokeMethod("cancelUpload", {"taskId": taskId});
  }

  /// Cancels image download.
  Future<int> cancelDownload(String taskId) async {
    return await _channel.invokeMethod("cancelDownload", {"taskId": taskId});
  }

  /// Downloads a generated 3D object model.
  Future<void> downloadModel(
    String taskId,
    String fileSavePath,
  ) async {
    await _channel.invokeMethod(
        "downloadModel", {"taskId": taskId, "fileSavePath": fileSavePath});
  }

  /// Sets a listener for image upload.
  Future<void> setReconstructUploadListener(
      Modeling3dReconstructUploadListener listener) async {
    _uploadListener = listener;
    _channel.invokeMethod("setReconstructUploadListener");
  }

  /// Sets a listener for model download.
  Future<void> setReconstructDownloadListener(
      Modeling3dReconstructDownloadListener listener) async {
    _downloadListener = listener;
    _channel.invokeMethod("setReconstructDownloadListener");
  }

  /// Previews a model.
  Future<void> previewModel(String taskId,
      {Modeling3dReconstructPreviewListener? previewListener}) async {
    final Map<String, dynamic> callMap = {
      "taskId": taskId,
      "attachListener": false
    };
    if (previewListener != null) {
      this._previewListener = previewListener;
    }
    _channel.invokeMethod("previewModel", callMap);
  }

  Future<void> _onMethodCall(MethodCall call) async {
    switch (call.method) {
      // PreviewListener
      case "previewListener#OnError":
        _previewListener?.onError.call(call.arguments["taskId"],
            call.arguments["errorCode"], call.arguments["errorMessage"]);
        break;
      case "previewListener#OnResult":
        _previewListener?.onResult.call(call.arguments);
        break;
      // Upload Listener
      case "uploadListener#OnResult":
        _uploadListener?.onResult.call(
            call.arguments["taskId"],
            Modeling3dReconstructUploadResult.fromMap(
                call.arguments['uploadResult']));
        break;
      case "uploadListener#OnError":
        _uploadListener?.onError.call(call.arguments["taskId"],
            call.arguments["errorCode"], call.arguments["errorMessage"]);
        break;
      case "uploadListener#OnProgress":
        _uploadListener?.onUploadProgress
            .call(call.arguments["taskId"], call.arguments["progress"]);
        break;
      // Download Listener
      case "downloadListener#OnResult":
        _downloadListener?.onResult.call(
            call.arguments["taskId"],
            Modeling3dReconstructDownloadResult.fromMap(
                call.arguments['downloadResult']));
        break;
      case "downloadListener#OnError":
        _downloadListener?.onError.call(call.arguments["taskId"],
            call.arguments["errorCode"], call.arguments["errorMessage"]);
        break;
      case "downloadListener#OnProgress":
        _downloadListener?.onDownloadProgress
            .call(call.arguments["taskId"], call.arguments["progress"]);
        break;
      default:
        throw "Not implemented.";
    }
  }
}

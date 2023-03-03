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

part of objreconstruct;

/// 3D object reconstruction engine.
abstract class Modeling3dReconstructEngine {
  static final MethodChannel _c = const MethodChannel(
    'com.huawei.hms.flutter.modeling3d/reconstructEngine/method',
  )..setMethodCallHandler(_onMethodCall);

  static Modeling3dReconstructUploadListener? _uploadListener;
  static Modeling3dReconstructDownloadListener? _downloadListener;
  static Modeling3dReconstructPreviewListener? _previewListener;

  /// Initializes a 3D object reconstruction task.
  static Future<Modeling3dReconstructInitResult> initTask(
    Modeling3dReconstructSetting setting,
  ) async {
    final Map<dynamic, dynamic> result = await _c.invokeMethod(
      'initTask',
      setting._toMap(),
    );
    return Modeling3dReconstructInitResult._fromMap(result);
  }

  /// Disables the 3D object reconstruction engine.
  static Future<void> close() async {
    await _c.invokeMethod(
      'close',
    );
  }

  /// Uploads images and triggers a 3D object reconstruction task.
  static Future<void> uploadFile(
    String taskId,
    String filePath,
  ) async {
    await _c.invokeMethod(
      'uploadFile',
      <String, dynamic>{
        'taskId': taskId,
        'filePath': filePath,
      },
    );
  }

  /// Cancels image upload.
  /// Returns cancellation result. 0 indicates success, and other values indicate failure.
  static Future<int> cancelUpload(String taskId) async {
    return await _c.invokeMethod(
      'cancelUpload',
      <String, dynamic>{
        'taskId': taskId,
      },
    );
  }

  /// Cancels image download.
  /// Returns cancellation result. 0 indicates success, and other values indicate failure.
  static Future<int> cancelDownload(String taskId) async {
    return await _c.invokeMethod(
      'cancelDownload',
      <String, dynamic>{
        'taskId': taskId,
      },
    );
  }

  /// Downloads a generated 3D object model.
  static Future<void> downloadModel(
    String taskId,
    String fileSavePath,
  ) async {
    await _c.invokeMethod(
      'downloadModel',
      <String, dynamic>{
        'taskId': taskId,
        'fileSavePath': fileSavePath,
      },
    );
  }

  /// Downloads the 3D object reconstruction task result using the custom configuration.
  static Future<void> downloadModelWithConfig(
    String taskId,
    String fileSavePath,
    Modeling3dReconstructDownloadConfig downloadConfig,
  ) async {
    await _c.invokeMethod(
      'downloadModelWithConfig',
      <String, dynamic>{
        'taskId': taskId,
        'fileSavePath': fileSavePath,
        'downloadConfig': downloadConfig._toMap(),
      },
    );
  }

  /// Sets a listener for image upload.
  static Future<void> setReconstructUploadListener(
    Modeling3dReconstructUploadListener? listener,
  ) async {
    _uploadListener = listener;
    await _c.invokeMethod(
      'setReconstructUploadListener',
    );
  }

  /// Sets a listener for model download.
  static Future<void> setReconstructDownloadListener(
    Modeling3dReconstructDownloadListener? listener,
  ) async {
    _downloadListener = listener;
    await _c.invokeMethod(
      'setReconstructDownloadListener',
    );
  }

  /// Previews a model.
  static Future<void> previewModel(
    String taskId, {
    Modeling3dReconstructPreviewListener? previewListener,
  }) async {
    _previewListener = previewListener;
    await _c.invokeMethod(
      'previewModel',
      <String, dynamic>{
        'taskId': taskId,
      },
    );
  }

  /// Previews a model.
  static Future<void> previewModelWithConfig(
    String taskId,
    Modeling3dReconstructPreviewConfig previewConfig, {
    Modeling3dReconstructPreviewListener? previewListener,
  }) async {
    _previewListener = previewListener;
    await _c.invokeMethod(
      'previewModelWithConfig',
      <String, dynamic>{
        'taskId': taskId,
        'previewConfig': previewConfig._toMap(),
      },
    );
  }

  static Future<void> _onMethodCall(MethodCall call) {
    switch (call.method) {
      case 'previewListener#OnError':
        _previewListener?.onError?.call(
          call.arguments['taskId'],
          call.arguments['errorCode'],
          call.arguments['errorMessage'],
        );
        break;
      case 'previewListener#OnResult':
        _previewListener?.onResult?.call(
          call.arguments,
        );
        break;
      case 'uploadListener#OnResult':
        _uploadListener?.onResult?.call(
          call.arguments['taskId'],
          Modeling3dReconstructUploadResult._fromMap(
            call.arguments['uploadResult'],
          ),
        );
        break;
      case 'uploadListener#OnError':
        _uploadListener?.onError?.call(
          call.arguments['taskId'],
          call.arguments['errorCode'],
          call.arguments['errorMessage'],
        );
        break;
      case 'uploadListener#OnProgress':
        _uploadListener?.onUploadProgress?.call(
          call.arguments['taskId'],
          call.arguments['progress'],
        );
        break;
      case 'downloadListener#OnResult':
        _downloadListener?.onResult?.call(
          call.arguments['taskId'],
          Modeling3dReconstructDownloadResult._fromMap(
            call.arguments['downloadResult'],
          ),
        );
        break;
      case 'downloadListener#OnError':
        _downloadListener?.onError?.call(
          call.arguments['taskId'],
          call.arguments['errorCode'],
          call.arguments['errorMessage'],
        );
        break;
      case 'downloadListener#OnProgress':
        _downloadListener?.onDownloadProgress?.call(
          call.arguments['taskId'],
          call.arguments['progress'],
        );
        break;
      default:
        throw 'Not implemented.';
    }
    return Future<void>.value();
  }
}

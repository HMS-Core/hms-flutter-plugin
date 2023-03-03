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

part of materialgen;

/// Material generation engine.
abstract class Modeling3dTextureEngine {
  static final MethodChannel _c = const MethodChannel(
    'com.huawei.hms.flutter.modeling3d/textureEngine/method',
  )..setMethodCallHandler(_onMethodCall);

  static Modeling3dTextureUploadListener? _uploadListener;
  static Modeling3dTextureDownloadListener? _downloadListener;
  static Modeling3dTexturePreviewListener? _previewListener;

  /// Disables the material generation engine.
  static Future<void> close() async {
    await _c.invokeMethod(
      'close',
    );
  }

  /// Uploads images and triggers a material generation task.
  static Future<void> asyncUploadFile(
    String taskId,
    String filePath,
  ) async {
    await _c.invokeMethod(
      'upload',
      <String, dynamic>{
        'taskId': taskId,
        'filePath': filePath,
      },
    );
  }

  /// Downloads generated texture maps.
  static Future<void> asyncDownloadTexture(
    String taskId,
    String fileSavePath,
  ) async {
    await _c.invokeMethod(
      'download',
      <String, dynamic>{
        'taskId': taskId,
        'filePath': fileSavePath,
      },
    );
  }

  /// Previews the texture map.
  static Future<void> previewTexture(
    String taskId, {
    Modeling3dTexturePreviewListener? listener,
  }) async {
    _previewListener = listener;
    await _c.invokeMethod(
      'previewTexture',
      <String, dynamic>{
        'taskId': taskId,
      },
    );
  }

  /// Sets a listener for image upload.
  static void setTextureUploadListener(
    Modeling3dTextureUploadListener? listener,
  ) {
    _uploadListener = listener;
  }

  /// Sets a listener for texture map download.
  static void setTextureDownloadListener(
    Modeling3dTextureDownloadListener? listener,
  ) {
    _downloadListener = listener;
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

  /// Cancels texture map download.
  /// Returns cancellation result. 0 indicates success, and other values indicate failure.
  static Future<int> cancelDownload(String taskId) async {
    return await _c.invokeMethod(
      'cancelDownload',
      <String, dynamic>{
        'taskId': taskId,
      },
    );
  }

  /// Initializes a material generation task.
  static Future<Modeling3dTextureInitResult> initTask(
    Modeling3dTextureSetting setting,
  ) async {
    final Map<dynamic, dynamic> result = await _c.invokeMethod(
      'initTask',
      setting._toMap(),
    );
    return Modeling3dTextureInitResult._fromMap(result);
  }

  /// Generates texture maps synchronously.
  /// Returns texture map generation result. 0 indicates success, and other values indicate failure.
  static Future<int> syncGenerateTexture(
    String filePath,
    String fileSavePath,
    Modeling3dTextureSetting setting,
  ) async {
    return await _c.invokeMethod(
      'syncGenerateTexture',
      <String, dynamic>{
        'filePath': filePath,
        'fileSavePath': fileSavePath,
        'setting': setting._toMap(),
      },
    );
  }

  static Future<void> _onMethodCall(MethodCall call) {
    switch (call.method) {
      case 'textureUploadProgress':
        _uploadListener?.onUploadProgress?.call(
          call.arguments['taskId'],
          call.arguments['progress'],
        );
        break;
      case 'textureUploadResult':
        _uploadListener?.onResult?.call(
          call.arguments['taskId'],
          Modeling3dTextureUploadResult._fromMap(
            call.arguments['result'],
          ),
        );
        break;
      case 'textureUploadError':
        _uploadListener?.onError?.call(
          call.arguments['taskId'],
          call.arguments['errorCode'],
          call.arguments['message'],
        );
        break;
      case 'textureDownloadProgress':
        _downloadListener?.onDownloadProgress?.call(
          call.arguments['taskId'],
          call.arguments['progress'],
        );
        break;
      case 'textureDownloadResult':
        _downloadListener?.onResult?.call(
          call.arguments['taskId'],
          Modeling3dTextureDownloadResult._fromMap(
            call.arguments['result'],
          ),
        );
        break;
      case 'textureDownloadError':
        _downloadListener?.onError?.call(
          call.arguments['taskId'],
          call.arguments['errorCode'],
          call.arguments['message'],
        );
        break;
      case 'texturePreviewResult':
        _previewListener?.onResult?.call(
          call.arguments['taskId'],
        );
        break;
      case 'texturePreviewError':
        _previewListener?.onError?.call(
          call.arguments['taskId'],
          call.arguments['errorCode'],
          call.arguments['message'],
        );
        break;
      default:
        throw 'Not implemented.';
    }
    return Future<void>.value();
  }
}

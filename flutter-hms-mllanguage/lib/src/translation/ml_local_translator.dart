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

part of '../../huawei_ml_language.dart';

class MLLocalTranslator {
  late MethodChannel _c;

  LanguageDownloadListener? _listener;

  MLLocalTranslator() {
    _c = _initMethodChannel();
  }

  MethodChannel _initMethodChannel() {
    const MethodChannel channel = MethodChannel('hms_lang_local_translator');
    channel.setMethodCallHandler(_onMethodCall);
    return channel;
  }

  void setDownloadListener(LanguageDownloadListener listener) {
    _listener = listener;
  }

  Future<bool> prepareModel(
    MLTranslateSetting? setting,
    LanguageModelDownloadStrategy? strategy,
  ) async {
    return await _c.invokeMethod(
      'prepareModel',
      <String, dynamic>{
        'setting': setting?.toMap() ?? MLTranslateSetting.local().toMap(),
        'strategy':
            strategy?.toMap() ?? LanguageModelDownloadStrategy().toMap(),
      },
    );
  }

  Future<String?> asyncTranslate(String text) async {
    return await _c.invokeMethod(
      'asyncTranslate',
      <String, dynamic>{
        'sourceText': text,
      },
    );
  }

  Future<String?> syncTranslate(String text) async {
    return await _c.invokeMethod(
      'syncTranslate',
      <String, dynamic>{
        'sourceText': text,
      },
    );
  }

  /// Deletes a specific model associated with [langCode].
  Future<bool> deleteModel(String langCode) async {
    return await _c.invokeMethod(
      'deleteModel',
      <String, dynamic>{
        'langCode': langCode,
      },
    );
  }

  Future<bool> stop() async {
    return await _c.invokeMethod(
      'stop',
    );
  }

  Future<dynamic> _onMethodCall(MethodCall call) {
    final int all = call.arguments['all'];
    final int downloaded = call.arguments['downloaded'];
    _listener?.call(
      all: all,
      downloaded: downloaded,
    );
    return Future<dynamic>.value(null);
  }
}

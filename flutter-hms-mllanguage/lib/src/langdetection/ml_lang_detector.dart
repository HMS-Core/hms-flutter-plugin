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

class MLLangDetector {
  /// Confidence threshold in the scenario where the language detection result with the highest confidence is returned.
  static const double FIRST_BEST_DETECTION_LANGUAGE_TRUSTED_THRESHOLD = 0.5;

  /// Confidence threshold in the scenario where detection results of multiple languages are returned.
  static const double PROBABILITY_DETECTION_LANGUAGE_TRUSTED_THRESHOLD =
      0.009999999776482582;

  /// Undetected language code.
  static const String UNDETECTION_LANGUAGE_TRUSTED_THRESHOLD = 'unknown';

  late MethodChannel _c;

  MLLangDetector() {
    _c = const MethodChannel('hms_lang_detection');
  }

  Future<String?> firstBestDetect({
    required MLLangDetectorSetting setting,
  }) async {
    return await _c.invokeMethod(
      'firstBestDetect',
      setting.toMap(),
    );
  }

  Future<String?> syncFirstBestDetect({
    required MLLangDetectorSetting setting,
  }) async {
    return await _c.invokeMethod(
      'syncFirstBestDetect',
      setting.toMap(),
    );
  }

  Future<List<MLDetectedLang>> probabilityDetect({
    required MLLangDetectorSetting setting,
  }) async {
    final List<dynamic> res = json.decode(
      await _c.invokeMethod(
        'probabilityDetect',
        setting.toMap(),
      ),
    );
    return res.map((dynamic e) => MLDetectedLang.fromJson(e)).toList();
  }

  Future<List<MLDetectedLang>> syncProbabilityDetect({
    required MLLangDetectorSetting setting,
  }) async {
    final List<dynamic> res = json.decode(
      await _c.invokeMethod(
        'syncProbabilityDetect',
        setting.toMap(),
      ),
    );
    return res.map((dynamic e) => MLDetectedLang.fromJson(e)).toList();
  }

  Future<bool> stop() async {
    return await _c.invokeMethod(
      'stopLangDetector',
    );
  }
}

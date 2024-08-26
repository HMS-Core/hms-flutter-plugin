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

part of '../../huawei_ml_text.dart';

class MLBankcardAnalyzer implements TextAnalyzer<dynamic, MlBankcardSettings> {
  late MethodChannel _channel;

  MLBankcardAnalyzer() {
    _channel = const MethodChannel('$baseChannel.bankcard');
  }

  Future<bool> stop() async {
    return await _channel.invokeMethod(
      'bankcard#stop',
    );
  }

  @override
  dynamic analyseFrame(MlBankcardSettings settings) async {
    return MLBankcard.fromMap(
      await _channel.invokeMethod(
        'bankcard#analyseFrame',
        settings.toMap(),
      ),
    );
  }

  @override
  dynamic asyncAnalyseFrame(MlBankcardSettings? settings) async {
    return MLBankcard.fromMap(
      await _channel.invokeMethod(
        'bankcard#asyncAnalyseFrame',
        settings?.toMap(),
      ),
    );
  }

  @override
  Future<bool> destroy() async {
    return await _channel.invokeMethod(
      'bankcard#destroy',
    );
  }

  @override
  Future<bool> isAvailable() async {
    return await _channel.invokeMethod(
      'bankcard#isAvailable',
    );
  }
}

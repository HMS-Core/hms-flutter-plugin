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

part of huawei_health;

class HealthRecordController {
  static const MethodChannel _channel = _healthRecordControllerMethodChannel;

  static Future<String?> addHealthRecord(
    HealthRecordInsertOptions insertOption,
  ) async {
    return await _channel.invokeMethod<String?>(
      'addHealthRecord',
      insertOption.toMap(),
    );
  }

  static Future<void> updateHealthRecord(
    HealthRecordUpdateOptions updateOption,
  ) async {
    await _channel.invokeMethod<void>(
      'updateHealthRecord',
      updateOption.toMap(),
    );
  }

  static Future<HealthRecordReply> getHealthRecord(
    HealthRecordReadOptions readOption,
  ) async {
    final Map<dynamic, dynamic>? result =
        await _channel.invokeMethod<Map<dynamic, dynamic>?>(
      'getHealthRecord',
      readOption.toMap(),
    );
    return HealthRecordReply.fromMap(result!);
  }

  static Future<void> deleteHealthRecord(
    HealthRecordDeleteOptions deleteOption,
  ) async {
    await _channel.invokeMethod<void>(
      'deleteHealthRecord',
      deleteOption.toMap(),
    );
  }
}

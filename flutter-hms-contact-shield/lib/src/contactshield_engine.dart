/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_contactshield;

class ContactShieldEngine {
  static const int DEFAULT_INCUBATION_PERIOD = 14;
  static const String TOKEN_A = 'TOKEN_WINDOW_MODE';

  static ContactShieldEngine? _instance;
  final MethodChannel _channel;

  ContactShieldCallback? contactShieldCallback;

  factory ContactShieldEngine() {
    _instance ??= ContactShieldEngine._create(
      const MethodChannel(
        'com.huawei.hms.flutter.contactshield_MethodChannel',
      ),
    );
    return _instance!;
  }

  ContactShieldEngine._create(this._channel) {
    _channel.setMethodCallHandler(_methodCallHandler);
  }

  Future<void> _methodCallHandler(MethodCall methodCall) async {
    if (contactShieldCallback != null) {
      final String? token = methodCall.arguments;
      switch (methodCall.method) {
        case 'onHasContact':
          contactShieldCallback!.onHasContact(token);
          break;
        case 'onNoContact':
          contactShieldCallback!.onNoContact(token);
          break;
        default:
          break;
      }
    }
  }

  Future<bool?> isContactShieldRunning() async {
    return await _channel.invokeMethod<bool>(
      'isContactShieldRunning',
    );
  }

  @Deprecated('')
  Future<void> startContactShieldCb([
    int incubationPeriod = DEFAULT_INCUBATION_PERIOD,
  ]) async {
    return await _channel.invokeMethod<void>(
      'startContactShieldCb',
      <String, dynamic>{
        'incubationPeriod': incubationPeriod,
      },
    );
  }

  Future<void> startContactShield([
    int incubationPeriod = DEFAULT_INCUBATION_PERIOD,
  ]) async {
    return await _channel.invokeMethod<void>(
      'startContactShield',
      <String, dynamic>{
        'incubationPeriod': incubationPeriod,
      },
    );
  }

  Future<void> startContactShieldNonPersistent([
    int incubationPeriod = DEFAULT_INCUBATION_PERIOD,
  ]) async {
    return await _channel.invokeMethod<void>(
      'startContactShieldNonPersistent',
      <String, dynamic>{
        'incubationPeriod': incubationPeriod,
      },
    );
  }

  Future<List<PeriodicKey>> getPeriodicKey() async {
    final String? response = await _channel.invokeMethod<String>(
      'getPeriodicKey',
    );
    if (response == null) {
      throw Exception();
    }
    final List<dynamic> items = json.decode(response);
    return List<PeriodicKey>.from(
      items.map(
        (dynamic i) => PeriodicKey.fromMap(i),
      ),
    );
  }

  @Deprecated('')
  Future<void> putSharedKeyFiles(
    List<String> filePaths,
    DiagnosisConfiguration config,
    String token,
  ) async {
    return await _channel.invokeMethod<void>(
      'putSharedKeyFiles',
      <String, dynamic>{
        'filePaths': filePaths,
        'diagnosisConfiguration': config.toJson(),
        'token': token,
      },
    );
  }

  Future<void> putSharedKeyFilesCb(
    List<String> filePaths,
    DiagnosisConfiguration config,
    String token,
  ) async {
    return await _channel.invokeMethod<void>(
      'putSharedKeyFilesCb',
      <String, dynamic>{
        'filePaths': filePaths,
        'diagnosisConfiguration': config.toJson(),
        'token': token,
      },
    );
  }

  Future<void> putSharedKeyFilesCbWithProvider(
    List<String> filePaths,
  ) async {
    return await _channel.invokeMethod<void>(
      'putSharedKeyFilesCbWithProvider',
      <String, dynamic>{
        'filePaths': filePaths,
      },
    );
  }

  Future<void> putSharedKeyFilesCbWithKeys(
    List<String> filePaths,
    List<String> publicKeys,
    DiagnosisConfiguration config,
    String token,
  ) async {
    return await _channel.invokeMethod<void>(
      'putSharedKeyFilesCbWithKeys',
      <String, dynamic>{
        'filePaths': filePaths,
        'publicKeys': publicKeys,
        'diagnosisConfiguration': config.toJson(),
        'token': token,
      },
    );
  }

  Future<void> putSharedKeyFilesCbProviderKeys(
    List<String> filePaths,
    List<String> publicKeys,
  ) async {
    return await _channel.invokeMethod<void>(
      'putSharedKeyFilesCbProviderKeys',
      <String, dynamic>{
        'filePaths': filePaths,
        'publicKeys': publicKeys,
      },
    );
  }

  @Deprecated('')
  Future<List<ContactDetail>> getContactDetail(String token) async {
    final String? response = await _channel.invokeMethod<String>(
      'getContactDetail',
      token,
    );
    if (response == null) {
      throw Exception();
    }
    final List<dynamic> items = json.decode(response);
    return List<ContactDetail>.from(
      items.map(
        (dynamic i) => ContactDetail.fromMap(i),
      ),
    );
  }

  Future<ContactSketch> getContactSketch(String token) async {
    final String? response = await _channel.invokeMethod<String>(
      'getContactSketch',
      token,
    );
    if (response == null) {
      throw Exception();
    }
    return ContactSketch.fromJson(response);
  }

  Future<List<ContactWindow>> getContactWindow([
    String token = TOKEN_A,
  ]) async {
    final String? response = await _channel.invokeMethod<String>(
      'getContactWindow',
      token,
    );
    if (response == null) {
      throw Exception();
    }
    final List<dynamic> items = json.decode(response);
    return List<ContactWindow>.from(
      items.map(
        (dynamic i) => ContactWindow.fromMap(i),
      ),
    );
  }

  Future<void> setSharedKeysDataMapping(
    SharedKeysDataMapping sharedKeysDataMapping,
  ) async {
    return await _channel.invokeMethod<void>(
      'setSharedKeysDataMapping',
      sharedKeysDataMapping.toJson(),
    );
  }

  Future<SharedKeysDataMapping> getSharedKeysDataMapping() async {
    final String? response = await _channel.invokeMethod<String>(
      'getSharedKeysDataMapping',
    );
    return SharedKeysDataMapping.fromJson(response!);
  }

  Future<List<DailySketch>> getDailySketch(
    DailySketchConfiguration config,
  ) async {
    final String? response = await _channel.invokeMethod<String>(
      'getDailySketch',
      config.toJson(),
    );
    if (response == null) {
      throw Exception();
    }
    final List<dynamic> items = json.decode(response);
    return List<DailySketch>.from(
      items.map(
        (dynamic i) => DailySketch.fromMap(i),
      ),
    );
  }

  Future<int?> getContactShieldVersion() async {
    return await _channel.invokeMethod<int>(
      'getContactShieldVersion',
    );
  }

  Future<int?> getDeviceCalibrationConfidence() async {
    return await _channel.invokeMethod<int>(
      'getDeviceCalibrationConfidence',
    );
  }

  Future<bool?> isSupportScanningWithoutLocation() async {
    return await _channel.invokeMethod<bool>(
      'isSupportScanningWithoutLocation',
    );
  }

  Future<Set<ContactShieldStatus>> getStatus() async {
    final String? response = await _channel.invokeMethod<String>(
      'getStatus',
    );
    if (response == null) {
      throw Exception();
    }
    final List<dynamic> items = json.decode(response);
    return Set<ContactShieldStatus>.from(
      items.map(
        (dynamic i) => ContactShieldStatus.fromText(i),
      ),
    );
  }

  Future<void> clearData() async {
    return await _channel.invokeMethod<void>(
      'clearData',
    );
  }

  Future<void> stopContactShield() async {
    return await _channel.invokeMethod<void>(
      'stopContactShield',
    );
  }

  Future<void> enableLogger() async {
    return await _channel.invokeMethod<void>(
      'enableLogger',
    );
  }

  Future<void> disableLogger() async {
    return await _channel.invokeMethod<void>(
      'disableLogger',
    );
  }
}

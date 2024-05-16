/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_nearbyservice;

class HMSNearby {
  final MethodChannel _channel;

  HMSNearby._(this._channel);

  static final HMSNearby _instance = HMSNearby._(
    const MethodChannel(_nearbyMethodChannel),
  );

  static Future<String?> getVersion() async {
    return await _instance._channel.invokeMethod(
      'getVersion',
    );
  }

  static Future<bool?> equalsMessage(Message object, Message other) async {
    ArgumentError.checkNotNull(object);
    ArgumentError.checkNotNull(other);
    return await _instance._channel.invokeMethod(
      'equalsMessage',
      <String, dynamic>{
        'object': object.toMap(),
        'other': other.toMap(),
      },
    );
  }

  static Future<int> setAgcRegion(RegionCode code) async {
    return await _instance._channel
        .invokeMethod('setAgcRegion', <String, dynamic>{
      'regionCode': code.index,
    });
  }

  static Future<void> enableLogger() async {
    return await _instance._channel.invokeMethod(
      'enableLogger',
    );
  }

  static Future<void> disableLogger() async {
    return await _instance._channel.invokeMethod(
      'disableLogger',
    );
  }
}

class HMSNearbyApiContext {
  static final HMSNearbyApiContext _instance = HMSNearbyApiContext._();
  static HMSNearbyApiContext get instance => _instance;

  HMSNearbyApiContext._();

  Future<void> setApiKey(String apiKey) async {
    return await HMSNearby._instance._channel.invokeMethod(
      'setApiKey',
      <String, dynamic>{
        'apiKey': apiKey,
      },
    );
  }

  Future<String?> getApiKey() async {
    final String? apiKey = await HMSNearby._instance._channel.invokeMethod(
      'getApiKey',
    );
    return apiKey;
  }
}

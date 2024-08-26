/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

part of '../../huawei_location.dart';

class GeocoderService {
  static GeocoderService? _instance;

  final MethodChannel _methodChannel;

  factory GeocoderService() {
    if (_instance == null) {
      const MethodChannel methodChannel =
          MethodChannel('com.huawei.flutter.location/geocoder_methodchannel');
      _instance = GeocoderService._create(
        methodChannel,
      );
    }
    return _instance!;
  }

  GeocoderService._create(
    this._methodChannel,
  );

  /// Initializes the `Geocoder` Service.
  Future<void> initGeocoderService(Locale locale) async {
    await _methodChannel.invokeMethod<void>(
      'initGeocoderService',
      <String, dynamic>{
        'locale': locale.toMap(),
      },
    );
  }

  /// Requests reverse geocoding.
  Future<List<HWLocation>> getFromLocation(
    GetFromLocationRequest getFromLocationRequest,
  ) async {
    final dynamic response = await _methodChannel.invokeMethod(
      'getFromLocation',
      <String, dynamic>{
        'getFromLocationRequest': getFromLocationRequest.toMap()
      },
    );
    return List<HWLocation>.from(
      response.map(
        (dynamic x) => HWLocation.fromMap(Map<dynamic, dynamic>.from(x)),
      ),
    ).toList();
  }

  /// Requests forward geocoding.
  Future<List<HWLocation>> getFromLocationName(
      GetFromLocationNameRequest getFromLocationNameRequest) async {
    final dynamic response = await _methodChannel.invokeMethod(
      'getFromLocationName',
      <String, dynamic>{
        'getFromLocationNameRequest': getFromLocationNameRequest.toMap(),
      },
    );
    return List<HWLocation>.from(
      response.map(
        (dynamic x) => HWLocation.fromMap(Map<dynamic, dynamic>.from(x)),
      ),
    ).toList();
  }
}

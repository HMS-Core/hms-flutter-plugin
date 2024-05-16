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

part of huawei_map;

abstract class HuaweiMapUtils {
  static const MethodChannel _c = MethodChannel(_mapUtilChannel);

  static Future<void> disableLogger() async {
    _c.invokeMethod(
      _Method.DisableLogger,
    );
  }

  static Future<void> enableLogger() async {
    _c.invokeMethod(
      _Method.EnableLogger,
    );
  }

  static Future<double?> distanceCalculator({
    required LatLng start,
    required LatLng end,
  }) async {
    return _c.invokeMethod<double>(
      _Method.MapDistanceCalculator,
      latLngStartEndToJson(start, end),
    );
  }

  static Future<LatLng> convertCoordinate(LatLng latLng) async {
    return LatLng.fromJson(
      await _c.invokeMethod(
        _Method.MapConvertCoordinate,
        latLngToJson(latLng),
      ),
    );
  }

  static Future<List<LatLng>> convertCoordinates(List<LatLng> latLngs) async {
    final List<List<double>> args = <List<double>>[];
    for (LatLng element in latLngs) {
      args.add(latLngToJson(element));
    }

    final List<dynamic> result = await _c.invokeMethod(
      _Method.MapConvertCoordinates,
      args,
    );
    return List<LatLng>.from(
      result.map((dynamic latLng) => LatLng.fromJson(latLng)),
    );
  }
}

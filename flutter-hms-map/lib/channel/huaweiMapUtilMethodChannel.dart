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

import 'package:flutter/services.dart' show MethodChannel;

import 'package:huawei_map/components/components.dart';
import 'package:huawei_map/constants/channel.dart' as Channel;
import 'package:huawei_map/constants/method.dart';
import 'package:huawei_map/utils/toJson.dart';

class HuaweiMapUtils {
  static const MethodChannel _mapUtilsChannel =
      MethodChannel(Channel.mapUtilChannel);

  static Future<void> disableLogger() async {
    _mapUtilsChannel.invokeMethod(Method.DisableLogger);
  }

  static Future<void> enableLogger() async {
    _mapUtilsChannel.invokeMethod(Method.EnableLogger);
  }

  static Future<double?> distanceCalculator(
      {required LatLng start, required LatLng end}) async {
    return _mapUtilsChannel.invokeMethod<double>(
        Method.MapDistanceCalculator, latLngStartEndToJson(start, end));
  }

  static Future<LatLng> convertCoordinate(LatLng latLng) async {
    return LatLng.fromJson(await _mapUtilsChannel.invokeMethod(
        Method.MapConvertCoordinate, latLngToJson(latLng)));
  }

  static Future<List<LatLng>> convertCoordinates(List<LatLng> latLngs) async {
    List<List<double>> args = [];
    latLngs.forEach((element) {
      args.add(latLngToJson(element));
    });

    return List<LatLng>.from((await _mapUtilsChannel.invokeMethod(
            Method.MapConvertCoordinates, args))
        .map((latLng) => LatLng.fromJson(latLng)));
  }
}

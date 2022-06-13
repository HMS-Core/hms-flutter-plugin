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

import 'dart:async' show Future;
import 'dart:typed_data' show Uint8List;
import 'package:flutter/foundation.dart' show listEquals;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:huawei_map/constants/param.dart';

class BitmapDescriptor {
  final dynamic _type;

  const BitmapDescriptor._(this._type);

  dynamic toJson() => _type;

  static const double hueRed = 0.0;
  static const double hueOrange = 30.0;
  static const double hueYellow = 60.0;
  static const double hueGreen = 120.0;
  static const double hueCyan = 180.0;
  static const double hueAzure = 210.0;
  static const double hueBlue = 240.0;
  static const double hueViolet = 270.0;
  static const double hueMagenta = 300.0;
  static const double hueRose = 330.0;

  static const BitmapDescriptor defaultMarker =
      BitmapDescriptor._(<dynamic>[Param.defaultMarker]);

  static BitmapDescriptor defaultMarkerWithHue(double hue) {
    return 0.0 <= hue && hue < 360.0
        ? BitmapDescriptor._(<dynamic>[Param.defaultMarker, hue])
        : defaultMarker;
  }

  static BitmapDescriptor fromBytes(Uint8List byteData) {
    return BitmapDescriptor._(<dynamic>[Param.fromBytes, byteData]);
  }

  static BitmapDescriptor fromAsset(String assetName, {String? package}) {
    return package == null
        ? BitmapDescriptor._(<dynamic>[Param.fromAsset, assetName])
        : BitmapDescriptor._(<dynamic>[Param.fromAsset, assetName, package]);
  }

  static Future<BitmapDescriptor> fromAssetImage(
    ImageConfiguration configuration,
    String assetName, {
    AssetBundle? bundle,
    String? package,
    bool mipmaps = true,
  }) async {
    if (!mipmaps && configuration.devicePixelRatio != null) {
      return BitmapDescriptor._(<dynamic>[
        Param.fromAssetImage,
        assetName,
        configuration.devicePixelRatio,
      ]);
    }
    final AssetImage assetImage =
        AssetImage(assetName, package: package, bundle: bundle);
    final AssetBundleImageKey assetBundleImageKey =
        await assetImage.obtainKey(configuration);
    return BitmapDescriptor._(<dynamic>[
      Param.fromAssetImage,
      assetBundleImageKey.name,
      assetBundleImageKey.scale,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is BitmapDescriptor && listEquals(this._type, other._type);
  }

  @override
  int get hashCode => _type.hashCode;
}

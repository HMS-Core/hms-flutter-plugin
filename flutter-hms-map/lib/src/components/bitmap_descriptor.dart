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

part of '../../huawei_map.dart';

/// Defines a bitmap image.
///
/// A bitmap image can be used as a [Marker] icon or for a [GroundOverlay].
class BitmapDescriptor {
  final dynamic _type;

  const BitmapDescriptor._(this._type);

  dynamic toJson() => _type;

  /// Red.
  static const double hueRed = 0.0;

  /// Orange.
  static const double hueOrange = 30.0;

  /// Yellow.
  static const double hueYellow = 60.0;

  /// Green.
  static const double hueGreen = 120.0;

  /// Cyan.
  static const double hueCyan = 180.0;

  /// Azure.
  static const double hueAzure = 210.0;

  /// Blue.
  static const double hueBlue = 240.0;

  // Violet.
  static const double hueViolet = 270.0;

  /// Magenta
  static const double hueMagenta = 300.0;

  /// Rose.
  static const double hueRose = 330.0;

  static const BitmapDescriptor defaultMarker = BitmapDescriptor._(
    <dynamic>[_Param.defaultMarker],
  );

  /// Creates a [BitmapDescriptor] object for default marker icons in different colors using different hue values.
  ///
  /// This class provides 10 hue values. You can call this constructor by passing a hue value.
  static BitmapDescriptor defaultMarkerWithHue(double hue) {
    return 0.0 <= hue && hue < 360.0
        ? BitmapDescriptor._(<dynamic>[_Param.defaultMarker, hue])
        : defaultMarker;
  }

  /// Creates a [BitmapDescriptor] object from a Uint8List.
  static BitmapDescriptor fromBytes(Uint8List byteData) {
    return BitmapDescriptor._(<dynamic>[_Param.fromBytes, byteData]);
  }

  /// Creates a [BitmapDescriptor] object from an asset.
  static BitmapDescriptor fromAsset(
    String assetName, {
    String? package,
  }) {
    return package == null
        ? BitmapDescriptor._(<dynamic>[_Param.fromAsset, assetName])
        : BitmapDescriptor._(<dynamic>[_Param.fromAsset, assetName, package]);
  }

  /// Creates a [BitmapDescriptor] object from an image asset.
  static Future<BitmapDescriptor> fromAssetImage(
    ImageConfiguration configuration,
    String assetName, {
    AssetBundle? bundle,
    String? package,
    bool mipmaps = true,
  }) async {
    if (!mipmaps && configuration.devicePixelRatio != null) {
      return BitmapDescriptor._(<dynamic>[
        _Param.fromAssetImage,
        assetName,
        configuration.devicePixelRatio,
      ]);
    }
    final AssetImage assetImage = AssetImage(
      assetName,
      package: package,
      bundle: bundle,
    );
    final AssetBundleImageKey assetBundleImageKey = await assetImage.obtainKey(
      configuration,
    );
    return BitmapDescriptor._(<dynamic>[
      _Param.fromAssetImage,
      assetBundleImageKey.name,
      assetBundleImageKey.scale,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is BitmapDescriptor && listEquals(_type, other._type);
  }

  @override
  int get hashCode => _type.hashCode;
}

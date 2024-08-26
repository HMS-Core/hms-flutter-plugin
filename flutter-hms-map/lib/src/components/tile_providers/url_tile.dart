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

part of '../../../huawei_map.dart';

/// Provides tile images for [TileOverlay] from URL.
class UrlTile {
  /// URL of the image to be used at the specified tile coordinates.
  String uri;

  /// Creates a [UrlTile] object.
  UrlTile({
    required this.uri,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      _Param.uri: uri,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is UrlTile && uri == other.uri;
  }

  @override
  int get hashCode => uri.hashCode;
}

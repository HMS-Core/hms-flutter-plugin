/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'dart:ui';

import 'package:huawei_health/src/hihealth/util/util.dart';

/// List of permissions that have been granted to your app.
class ScopeLangItem {
  /// Mapping between the permission scope URL and description.
  Map<String, String> url2Desc;

  /// Time when the permission is granted.
  String authTime;

  /// Application name.
  String appName;

  /// Path to the app icon image.
  String appIconPath;

  ScopeLangItem(
      {Map<String, String> url2Desc,
      String authTime,
      String appName,
      String appIconPath});

  factory ScopeLangItem.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ScopeLangItem instance = ScopeLangItem();
    return instance
      ..appIconPath = map['appIconPath']
      ..appName = map['appName']
      ..authTime = map['authTime']
      ..url2Desc = Map<String, String>.from(map['url2Desc']);
  }

  Map<String, dynamic> toMap() {
    return {
      "url2Desc": url2Desc,
      "authTime": authTime,
      "appName": appName,
      "appIconPath": appIconPath
    }..removeWhere((k, v) => v == null);
  }

  @override
  String toString() => toMap().toString();

  @override
  bool operator ==(Object other) {
    if (!isTypeEqual(this, other)) return false;
    ScopeLangItem compare = other;
    List<dynamic> currentArgs = [url2Desc, authTime, appName, appIconPath];
    List<dynamic> otherArgs = [
      compare.url2Desc,
      compare.authTime,
      compare.appName,
      compare.appIconPath,
    ];
    return isEquals(this, other, currentArgs, otherArgs);
  }

  @override
  int get hashCode =>
      hashValues(hashList(url2Desc?.values), authTime, appName, appIconPath);
}

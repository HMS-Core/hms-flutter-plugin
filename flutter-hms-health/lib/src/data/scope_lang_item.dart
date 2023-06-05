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

/// List of permissions that have been granted to your app.
class ScopeLangItem {
  /// Mapping between the permission scope URL and description.
  Map<String, String>? url2Desc;

  /// Time when the permission is granted.
  String? authTime;

  /// Application name.
  String? appName;

  /// Path to the app icon image.
  String? appIconPath;

  ScopeLangItem._();

  factory ScopeLangItem.fromMap(Map<dynamic, dynamic> map) {
    return ScopeLangItem._()
      ..appIconPath = map['appIconPath']
      ..appName = map['appName']
      ..authTime = map['authTime']
      ..url2Desc = Map<String, String>.from(map['url2Desc']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url2Desc': url2Desc,
      'authTime': authTime,
      'appName': appName,
      'appIconPath': appIconPath,
    }..removeWhere((String k, dynamic v) => v == null);
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  bool operator ==(Object other) {
    return other is ScopeLangItem &&
        mapEquals(other.url2Desc, url2Desc) &&
        other.authTime == authTime &&
        other.appName == appName &&
        other.appIconPath == appIconPath;
  }

  @override
  int get hashCode {
    return Object.hash(
      Object.hashAll(url2Desc?.values.toList() ?? <dynamic>[]),
      authTime,
      appName,
      appIconPath,
    );
  }
}

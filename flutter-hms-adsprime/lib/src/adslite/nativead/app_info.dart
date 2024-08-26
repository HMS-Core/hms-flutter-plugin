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

part of '../../../huawei_adsprime.dart';

class AppInfo {
  /// App name.
  final String? appName;

  /// App description.
  final String? appDesc;

  /// App icon URL.
  final String? iconUrl;

  /// App package name.
  final String? packageName;

  /// Privacy link.
  final String? privacyLink;

  /// HTML5 address of the app permission declaration page.
  final String? permissionUrl;

  /// HTML5 address of the app details page.
  final String? appDetailUrl;

  /// App version number (similar to 4.52.0).
  final String? versionName;

  /// App developer information.
  final String? developerName;

  AppInfo({
    this.appName,
    this.appDesc,
    this.iconUrl,
    this.packageName,
    this.privacyLink,
    this.permissionUrl,
    this.appDetailUrl,
    this.versionName,
    this.developerName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'appName': appName,
      'appDesc': appDesc,
      'iconUrl': iconUrl,
      'packageName': packageName,
      'privacyLink': privacyLink,
      'permissionUrl': permissionUrl,
      'appDetailUrl': appDetailUrl,
      'versionName': versionName,
      'developerName': developerName,
    };
  }

  static AppInfo fromJson(Map<dynamic, dynamic> args) {
    return AppInfo(
      appName: args['appName'],
      appDesc: args['appDesc'],
      iconUrl: args['iconUrl'],
      packageName: args['packageName'],
      privacyLink: args['privacyLink'],
      permissionUrl: args['permissionUrl'],
      appDetailUrl: args['appDetailUrl'],
      versionName: args['versionName'],
      developerName: args['developerName'],
    );
  }

  @override
  String toString() {
    return 'AppInfo {appName: $appName, appDesc: $appDesc, iconUrl: $iconUrl, packageName: $packageName, privacyLink: $privacyLink, permissionUrl: $permissionUrl, appDetailUrl: $appDetailUrl, versionName: $versionName, developerName: $developerName}';
  }
}

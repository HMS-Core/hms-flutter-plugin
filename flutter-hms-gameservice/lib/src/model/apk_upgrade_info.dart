/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_gameservice;

/// A class that includes the details about an upgrade apk.
///
/// An app does not need to pay attention to parameters in this object.
/// During app update, the [showUpdateDialog] method is called to directly pass
/// the [ApkUpgradeInfo] object obtained from the [checkAppUpdate] callback result.
class ApkUpgradeInfo {
  /// App name.
  String? name;

  /// App ID.
  String? id;

  /// App release time, accurate to day.
  /// The value is in the yyyy-MM-dd format.
  String? releaseDate;

  /// Internal version number parsed from the APK.
  int? versionCode;

  /// Package name parsed from the APK.
  String? package;

  /// URL of the app icon.
  String? icon;

  /// URL for downloading the complete or differential app package.
  String? downUrl;

  /// Size of the app of the target version.
  int? size;

  /// Size of the differential package.
  int? diffSize;

  /// Target version name.
  String? version;

  /// Indicates whether the signature is different.
  /// 0: No.
  /// 1: Yes.
  int? isSignatureDifferent;

  /// New features.
  String? newFeatures;

  /// App update time description, for example, "released on X.""
  /// The value is calculated by the server and displayed on the client.
  String? releaseDateDesc;

  /// ID of the AppGallery request details API.
  String? detailId;

  /// Indicates whether the update is forcible.
  /// 0: No.
  /// 1: Yes.
  int? isCompulsoryUpdate;

  /// Indicates whether the app is a Huawei-Developed app
  /// 0: No.
  /// 1: Yes.
  int? devType;

  /// Source version name.
  String? oldVersionName;

  /// Soruce version number.
  int? oldVersionCode;

  /// Reason for not recommending the update.
  String? notRcmReason;

  /// SHA-256 value of the app package.
  String? sha256;

  ApkUpgradeInfo({
    this.name,
    this.id,
    this.releaseDate,
    this.versionCode,
    this.package,
    this.icon,
    this.downUrl,
    this.size,
    this.diffSize,
    this.version,
    this.isSignatureDifferent,
    this.newFeatures,
    this.releaseDateDesc,
    this.detailId,
    this.isCompulsoryUpdate,
    this.devType,
    this.oldVersionName,
    this.oldVersionCode,
    this.notRcmReason,
    this.sha256,
  });

  factory ApkUpgradeInfo.fromMap(Map<dynamic, dynamic> map) {
    return ApkUpgradeInfo(
      name: map['name'],
      id: map['id'],
      releaseDate: map['releaseDate'],
      versionCode: map['versionCode'],
      package: map['package'],
      icon: map['icon'],
      downUrl: map['downUrl'],
      size: map['size'],
      diffSize: map['diffSize'],
      version: map['version'],
      isSignatureDifferent: map['isSignatureDifferent'],
      newFeatures: map['newFeatures'],
      releaseDateDesc: map['releaseDateDesc'],
      detailId: map['detailId'],
      isCompulsoryUpdate: map['isCompulsoryUpdate'],
      devType: map['devType'],
      oldVersionName: map['oldVersionName'],
      oldVersionCode: map['oldVersionCode'],
      notRcmReason: map['notRcmReason'],
      sha256: map['sha256'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'releaseDate': releaseDate,
      'versionCode': versionCode,
      'package': package,
      'icon': icon,
      'downUrl': downUrl,
      'size': size,
      'diffSize': diffSize,
      'version': version,
      'isSignatureDifferent': isSignatureDifferent,
      'newFeatures': newFeatures,
      'releaseDateDesc': releaseDateDesc,
      'detailId': detailId,
      'isCompulsoryUpdate': isCompulsoryUpdate,
      'devType': devType,
      'oldVersionName': oldVersionName,
      'oldVersionCode': oldVersionCode,
      'notRcmReason': notRcmReason,
      'sha256': sha256,
    };
  }

  @override
  String toString() {
    return '$ApkUpgradeInfo('
        'name: $name, '
        'id: $id, '
        'releaseDate: $releaseDate, '
        'versionCode: $versionCode, '
        'package: $package, '
        'icon: $icon, '
        'downUrl: $downUrl, '
        'size: $size, '
        'diffSize: $diffSize, '
        'version: $version, '
        'isSignatureDifferent: $isSignatureDifferent, '
        'newFeatures: $newFeatures, '
        'releaseDateDesc: $releaseDateDesc, '
        'detailId: $detailId, '
        'isCompulsoryUpdate: $isCompulsoryUpdate, '
        'devType: $devType, '
        'oldVersionName: $oldVersionName, '
        'oldVersionCode: $oldVersionCode, '
        'notRcmReason: $notRcmReason, '
        'sha256: $sha256)';
  }
}

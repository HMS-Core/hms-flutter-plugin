/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:huawei_gameservice/huawei_gameservice.dart';

/// A class that includes the update status information.
class UpdateInfo {
  /// Indicates that the parameter is incorrect.
  static const int PARAMETER_ERROR = 1;

  /// Indicates that the network connection is incorrect.
  static const int CONNECT_ERROR = 2;

  /// Indicates that no update is available.
  static const int NO_UPGRADE_INFO = 3;

  /// Indicates that the user cancels the update.
  static const int CANCEL = 4;

  /// Indicates that the app update fails.
  static const int INSTALL_FAILED = 5;

  /// Indicates that the update information fails to be queried.
  static const int CHECK_FAILED = 6;

  /// Indicates that an app update is available.
  static const int HAS_UPGRADE_INFO = 7;

  /// Indicates that Huawei AppGallery is disabled.
  static const int MARKET_FORBID = 8;

  /// Indicates that the app is being updated.
  static const int IN_MARKET_UPDATING = 9;

  /// App update status.
  int status;

  /// Result code of the update operation.
  ///
  /// The options are as follows:
  /// 0: Normal.
  /// 1: No network is available.
  /// 2: JSON exception.
  /// 3: Parameter exception.
  /// 4: I/O exception.
  /// 5: Network exception.
  /// 6: Unknown error.
  /// 7: Obfuscation is not excluded.
  int failcause;

  /// Result code description.
  String failreason;

  /// Indicates whether the user cancels the update during forcible update.
  bool compulsoryUpdateCancel;

  /// Indicates whether the user chooses to update the app immediately or later
  /// during non-forcible update.
  ///
  /// The options are as follow:
  /// 100: The user chooses to update the app later.
  /// 101: The user chooses to update the app immediately.
  int buttonstatus;

  /// An [ApkUpgradeInfo] object that contains app update information.
  ApkUpgradeInfo apkUpgradeInfo;

  UpdateInfo({
    this.status,
    this.failcause,
    this.failreason,
    this.compulsoryUpdateCancel,
    this.buttonstatus,
    this.apkUpgradeInfo,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'failcause': failcause,
      'failreason': failreason,
      'compulsoryUpdateCancel': compulsoryUpdateCancel,
      'buttonstatus': buttonstatus,
      'updatesdk_update_info': apkUpgradeInfo?.toMap(),
    };
  }

  factory UpdateInfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UpdateInfo(
      status: map['status'],
      failcause: map['failcause'],
      failreason: map['failreason'],
      compulsoryUpdateCancel: map['compulsoryUpdateCancel'],
      buttonstatus: map['buttonstatus'],
      apkUpgradeInfo: map['updatesdk_update_info'] == null
          ? null
          : ApkUpgradeInfo.fromMap(
              Map<String, dynamic>.from(map['updatesdk_update_info'])),
    );
  }

  @override
  String toString() {
    return 'UpdateInfo(status: $status, failcause: $failcause, failreason: $failreason, compulsoryUpdateCancel: $compulsoryUpdateCancel, buttonstatus: $buttonstatus, apkUpgradeInfo: $apkUpgradeInfo)';
  }
}

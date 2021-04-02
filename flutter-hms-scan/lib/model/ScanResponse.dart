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

import 'dart:convert' show json;
import 'dart:typed_data';
import 'dart:ui' show hashValues;

import 'BorderRect.dart';
import 'CornerPoint.dart';
import 'SmsContent.dart';
import 'EmailContent.dart';
import 'TelPhoneNumber.dart';
import 'LinkUrl.dart';
import 'WiFiConnectionInfo.dart';
import 'LocationCoordinate.dart';
import 'DriverInfo.dart';
import 'ContactDetail.dart';
import 'EventInfo.dart';

class ScanResponse {
  ScanResponse({
    this.hmsScanVersion,
    this.cornerPoints,
    this.originValueByte,
    this.originalValue,
    this.scanType,
    this.scanTypeForm,
    this.showResult,
    this.zoomValue,
    this.originalBitmap,
    this.smsContent,
    this.emailContent,
    this.telPhoneNumber,
    this.linkUrl,
    this.wifiConnectionInfo,
    this.locationCoordinate,
    this.driverInfo,
    this.contactDetail,
    this.eventInfo,
  });

  int hmsScanVersion;
  List<CornerPoint> cornerPoints;
  List<int> originValueByte;
  String originalValue;
  int scanType;
  int scanTypeForm;
  String showResult;
  double zoomValue;
  Uint8List originalBitmap;

  SmsContent smsContent;
  EmailContent emailContent;
  TelPhoneNumber telPhoneNumber;
  LinkUrl linkUrl;
  WiFiConnectionInfo wifiConnectionInfo;
  LocationCoordinate locationCoordinate;
  DriverInfo driverInfo;
  ContactDetail contactDetail;
  EventInfo eventInfo;
  HmsBorderRect borderRect;

  factory ScanResponse.fromJson(String str) =>
      ScanResponse.fromMap(json.decode(str));

  factory ScanResponse.fromMap(Map<String, dynamic> json) {
    ScanResponse response = ScanResponse(
      hmsScanVersion: json["HMS_SCAN_VERSION"] == null
          ? null
          : json["HMS_SCAN_VERSION"].round(),
      cornerPoints: json["cornerPoints"] == null
          ? null
          : List<CornerPoint>.from(json["cornerPoints"]
              .map((x) => CornerPoint.fromMap(Map<String, dynamic>.from(x)))),
      originValueByte: json["originValueByte"] == null
          ? null
          : List<int>.from(json["originValueByte"].map((x) => x.round())),
      originalValue:
          json["originalValue"] == null ? null : json["originalValue"],
      scanType: json["scanType"] == null ? null : json["scanType"].round(),
      scanTypeForm:
          json["scanTypeForm"] == null ? null : json["scanTypeForm"].round(),
      showResult: json["showResult"] == null ? null : json["showResult"],
      zoomValue: json["zoomValue"] == null ? null : json["zoomValue"],
      //Form fields
      smsContent: json["smsContent"] == null
          ? null
          : SmsContent.fromMap(Map<String, dynamic>.from(json["smsContent"])),
      emailContent: json["emailContent"] == null
          ? null
          : EmailContent.fromMap(
              Map<String, dynamic>.from(json["emailContent"])),
      telPhoneNumber: json["telPhoneNumber"] == null
          ? null
          : TelPhoneNumber.fromMap(
              Map<String, dynamic>.from(json["telPhoneNumber"])),
      linkUrl: json["linkUrl"] == null
          ? null
          : LinkUrl.fromMap(Map<String, dynamic>.from(json["linkUrl"])),
      wifiConnectionInfo: json["wifiConnectionInfo"] == null
          ? null
          : WiFiConnectionInfo.fromMap(
              Map<String, dynamic>.from(json["wifiConnectionInfo"])),
      locationCoordinate: json["locationCoordinate"] == null
          ? null
          : LocationCoordinate.fromMap(
              Map<String, dynamic>.from(json["locationCoordinate"])),
      driverInfo: json["driverInfo"] == null
          ? null
          : DriverInfo.fromMap(Map<String, dynamic>.from(json["driverInfo"])),
      contactDetail: json["contactDetail"] == null
          ? null
          : ContactDetail.fromMap(
              Map<String, dynamic>.from(json["contactDetail"])),
      eventInfo: json["eventInfo"] == null
          ? null
          : EventInfo.fromMap(Map<String, dynamic>.from(json["eventInfo"])),
      originalBitmap:
          json["originalBitmap"] == null ? null : json["originalBitmap"],
    );
    response.borderRect = HmsBorderRect(response.cornerPoints);
    return response;
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "HMS_SCAN_VERSION": hmsScanVersion == null ? null : hmsScanVersion,
        "cornerPoints": cornerPoints == null
            ? null
            : List<dynamic>.from(cornerPoints.map((x) => x.toMap())),
        "originValueByte": originValueByte == null
            ? null
            : List<dynamic>.from(originValueByte.map((x) => x)),
        "originalValue": originalValue == null ? null : originalValue,
        "scanType": scanType == null ? null : scanType,
        "scanTypeForm": scanTypeForm == null ? null : scanTypeForm,
        "showResult": showResult == null ? null : showResult,
        "zoomValue": zoomValue == null ? null : zoomValue,
        "smsContent": smsContent == null ? null : smsContent.toMap(),
        "emailContent": emailContent == null ? null : emailContent.toMap(),
        "telPhoneNumber":
            telPhoneNumber == null ? null : telPhoneNumber.toMap(),
        "linkUrl": linkUrl == null ? null : linkUrl.toMap(),
        "wifiConnectionInfo":
            wifiConnectionInfo == null ? null : wifiConnectionInfo.toMap(),
        "locationCoordinate":
            locationCoordinate == null ? null : locationCoordinate.toMap(),
        "driverInfo": driverInfo == null ? null : driverInfo.toMap(),
        "contactDetail": contactDetail == null ? null : contactDetail.toMap(),
        "eventInfo": eventInfo == null ? null : eventInfo.toMap(),
        "originalBitmap": originalBitmap,
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final ScanResponse check = o;
    return o is ScanResponse &&
        check.hmsScanVersion == hmsScanVersion &&
        check.cornerPoints == cornerPoints &&
        check.originValueByte == originValueByte &&
        check.originalValue == originalValue &&
        check.scanType == scanType &&
        check.scanTypeForm == scanTypeForm &&
        check.showResult == showResult &&
        check.zoomValue == zoomValue &&
        check.smsContent == smsContent &&
        check.emailContent == emailContent &&
        check.telPhoneNumber == telPhoneNumber &&
        check.linkUrl == linkUrl &&
        check.wifiConnectionInfo == wifiConnectionInfo &&
        check.locationCoordinate == locationCoordinate &&
        check.driverInfo == driverInfo &&
        check.contactDetail == contactDetail &&
        check.eventInfo == eventInfo &&
        check.borderRect == borderRect &&
        check.originalBitmap == originalBitmap;
  }

  @override
  int get hashCode => hashValues(
        hmsScanVersion,
        cornerPoints,
        originValueByte,
        originalValue,
        scanType,
        scanTypeForm,
        showResult,
        zoomValue,
        smsContent,
        emailContent,
        telPhoneNumber,
        linkUrl,
        wifiConnectionInfo,
        locationCoordinate,
        driverInfo,
        contactDetail,
        eventInfo,
        borderRect,
        originalBitmap,
      );
}

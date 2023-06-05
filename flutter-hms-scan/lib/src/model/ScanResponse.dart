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

part of huawei_scan;

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

  int? hmsScanVersion;
  List<CornerPoint?>? cornerPoints;
  List<int?>? originValueByte;
  String? originalValue;
  int? scanType;
  int? scanTypeForm;
  String? showResult;
  double? zoomValue;
  Uint8List? originalBitmap;

  SmsContent? smsContent;
  EmailContent? emailContent;
  TelPhoneNumber? telPhoneNumber;
  LinkUrl? linkUrl;
  WiFiConnectionInfo? wifiConnectionInfo;
  LocationCoordinate? locationCoordinate;
  DriverInfo? driverInfo;
  ContactDetail? contactDetail;
  EventInfo? eventInfo;
  HmsBorderRect? borderRect;

  factory ScanResponse.fromJson(String str) {
    return ScanResponse.fromMap(json.decode(str));
  }

  factory ScanResponse.fromMap(Map<String, dynamic> json) {
    ScanResponse response = ScanResponse(
      hmsScanVersion: json['HMS_SCAN_VERSION']?.round(),
      cornerPoints: json['cornerPoints'] == null
          ? null
          : List<CornerPoint?>.from(
              json['cornerPoints'].map(
                (dynamic x) => x == null
                    ? null
                    : CornerPoint.fromMap(Map<String, dynamic>.from(x)),
              ),
            ),
      originValueByte: json['originValueByte'] == null
          ? null
          : List<int?>.from(
              json['originValueByte'].map((dynamic x) => x?.round()),
            ),
      originalValue: json['originalValue'],
      scanType: json['scanType']?.round(),
      scanTypeForm: json['scanTypeForm']?.round(),
      showResult: json['showResult'],
      zoomValue: json['zoomValue'],
      //Form fields
      smsContent: json['smsContent'] == null
          ? null
          : SmsContent.fromMap(
              Map<String, dynamic>.from(json['smsContent']),
            ),
      emailContent: json['emailContent'] == null
          ? null
          : EmailContent.fromMap(
              Map<String, dynamic>.from(json['emailContent']),
            ),
      telPhoneNumber: json['telPhoneNumber'] == null
          ? null
          : TelPhoneNumber.fromMap(
              Map<String, dynamic>.from(json['telPhoneNumber']),
            ),
      linkUrl: json['linkUrl'] == null
          ? null
          : LinkUrl.fromMap(
              Map<String, dynamic>.from(json['linkUrl']),
            ),
      wifiConnectionInfo: json['wifiConnectionInfo'] == null
          ? null
          : WiFiConnectionInfo.fromMap(
              Map<String, dynamic>.from(json['wifiConnectionInfo']),
            ),
      locationCoordinate: json['locationCoordinate'] == null
          ? null
          : LocationCoordinate.fromMap(
              Map<String, dynamic>.from(json['locationCoordinate']),
            ),
      driverInfo: json['driverInfo'] == null
          ? null
          : DriverInfo.fromMap(
              Map<String, dynamic>.from(json['driverInfo']),
            ),
      contactDetail: json['contactDetail'] == null
          ? null
          : ContactDetail.fromMap(
              Map<String, dynamic>.from(json['contactDetail']),
            ),
      eventInfo: json['eventInfo'] == null
          ? null
          : EventInfo.fromMap(
              Map<String, dynamic>.from(json['eventInfo']),
            ),
      originalBitmap: json['originalBitmap'],
    );
    response.borderRect = HmsBorderRect(response.cornerPoints);
    return response;
  }

  String toJson() {
    return json.encode(toMap());
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'HMS_SCAN_VERSION': hmsScanVersion,
      'cornerPoints': cornerPoints == null
          ? null
          : List<dynamic>.from(
              cornerPoints!.map(
                (dynamic x) => x?.toMap(),
              ),
            ),
      'originValueByte': originValueByte == null
          ? null
          : List<dynamic>.from(originValueByte!.map((dynamic x) => x)),
      'originalValue': originalValue,
      'scanType': scanType,
      'scanTypeForm': scanTypeForm,
      'showResult': showResult,
      'zoomValue': zoomValue,
      'smsContent': smsContent == null ? null : smsContent!.toMap(),
      'emailContent': emailContent == null ? null : emailContent!.toMap(),
      'telPhoneNumber': telPhoneNumber == null ? null : telPhoneNumber!.toMap(),
      'linkUrl': linkUrl == null ? null : linkUrl!.toMap(),
      'wifiConnectionInfo':
          wifiConnectionInfo == null ? null : wifiConnectionInfo!.toMap(),
      'locationCoordinate':
          locationCoordinate == null ? null : locationCoordinate!.toMap(),
      'driverInfo': driverInfo == null ? null : driverInfo!.toMap(),
      'contactDetail': contactDetail == null ? null : contactDetail!.toMap(),
      'eventInfo': eventInfo == null ? null : eventInfo!.toMap(),
      'originalBitmap': originalBitmap,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is ScanResponse &&
        other.hmsScanVersion == hmsScanVersion &&
        listEquals(other.cornerPoints, cornerPoints) &&
        listEquals(other.originValueByte, originValueByte) &&
        other.originalValue == originalValue &&
        other.scanType == scanType &&
        other.scanTypeForm == scanTypeForm &&
        other.showResult == showResult &&
        other.zoomValue == zoomValue &&
        other.smsContent == smsContent &&
        other.emailContent == emailContent &&
        other.telPhoneNumber == telPhoneNumber &&
        other.linkUrl == linkUrl &&
        other.wifiConnectionInfo == wifiConnectionInfo &&
        other.locationCoordinate == locationCoordinate &&
        other.driverInfo == driverInfo &&
        other.contactDetail == contactDetail &&
        other.eventInfo == eventInfo &&
        other.borderRect == borderRect &&
        other.originalBitmap == originalBitmap;
  }

  @override
  int get hashCode {
    return Object.hash(
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
}

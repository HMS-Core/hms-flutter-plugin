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

import 'package:flutter/material.dart';
import 'package:huawei_scan/huawei_scan.dart';

//Get Unique List
List<ScanResponse> getUniqueList(List<ScanResponse> list) {
  Map<String?, ScanResponse> mp = <String?, ScanResponse>{};
  for (ScanResponse item in list) {
    mp[item.originalValue] = item;
  }
  List<ScanResponse> filteredList = mp.values.toList();
  return filteredList;
}

//Color Lists
List<Color> colorList = <Color>[
  Colors.white,
  Colors.yellow,
  Colors.red,
  Colors.green,
  Colors.grey,
  Colors.blue,
  Colors.black,
];

List<String> colorStringList = <String>[
  'White',
  'Yellow',
  'Red',
  'Green',
  'Gray',
  'Blue',
  'Black',
];

//Scan Types
List<int> scanTypeList = <int>[
  HmsScanTypes.AllScanType,
  HmsScanTypes.Aztec,
  HmsScanTypes.Code128,
  HmsScanTypes.Code39,
  HmsScanTypes.Code93,
  HmsScanTypes.Codabar,
  HmsScanTypes.DataMatrix,
  HmsScanTypes.EAN13,
  HmsScanTypes.EAN8,
  HmsScanTypes.ITF14,
  HmsScanTypes.QRCode,
  HmsScanTypes.UPCCodeA,
  HmsScanTypes.UPCCodeE,
  HmsScanTypes.Pdf417,
];

List<String> scanTypeStringList = <String>[
  'All Scan Types',
  'Aztec',
  'Code128',
  'Code39',
  'Code93',
  'Codabar',
  'DataMatrix',
  'EAN13',
  'EAN8',
  'ITF14',
  'QRCode',
  'UPCCodeA',
  'UPCCodeE',
  'Pdf417',
  'MultiFunctional',
];

//Dropdown Controllers
int dropdownController(String value) {
  int result = scanTypeStringList.indexOf(value);
  return scanTypeList[result];
}

Color dropdownColorController(String value) {
  int result = colorStringList.indexOf(value);
  return colorList[result];
}

int dropdownControllerBitmap(String value) {
  int result = scanTypeStringList.indexOf(value);
  return scanTypeList[result];
}

//Scan Types for Build Bitmap
List<int> scanTypeListBitmap = <int>[
  HmsScanTypes.Aztec,
  HmsScanTypes.Code128,
  HmsScanTypes.Code39,
  HmsScanTypes.Code93,
  HmsScanTypes.Codabar,
  HmsScanTypes.DataMatrix,
  HmsScanTypes.EAN13,
  HmsScanTypes.EAN8,
  HmsScanTypes.ITF14,
  HmsScanTypes.QRCode,
  HmsScanTypes.UPCCodeA,
  HmsScanTypes.UPCCodeE,
  HmsScanTypes.Pdf417,
  HmsScanTypes.MultiFunctional,
];

List<String> scanTypeStringListBitmap = <String>[
  'Aztec',
  'Code128',
  'Code39',
  'Code93',
  'Codabar',
  'DataMatrix',
  'EAN13',
  'EAN8',
  'ITF14',
  'QRCode',
  'UPCCodeA',
  'UPCCodeE',
  'Pdf417',
  'MultiFunctional',
];

//Scan Type Converter
String formatConverter(int? format) {
  switch (format) {
    case HmsScanTypes.Code128:
      return 'Code128 Code';
    case HmsScanTypes.Code39:
      return 'Code39 Code';
    case HmsScanTypes.Code93:
      return 'Code93 Code';
    case HmsScanTypes.Codabar:
      return 'Codabar Code';
    case HmsScanTypes.DataMatrix:
      return 'Data Matrix Code';
    case HmsScanTypes.EAN13:
      return 'EAN13 Code';
    case HmsScanTypes.EAN8:
      return 'EAN8 Code';
    case HmsScanTypes.ITF14:
      return 'ITF14 Code';
    case HmsScanTypes.QRCode:
      return 'QR Code';
    case HmsScanTypes.UPCCodeA:
      return 'UPC Code - A';
    case HmsScanTypes.UPCCodeE:
      return 'UPC Code - E';
    case HmsScanTypes.Pdf417:
      return 'Pdf417 Code';
    case HmsScanTypes.Aztec:
      return 'Aztec Code';
    case HmsScanTypes.MultiFunctional:
      return 'Multi Functional Code';
    default:
      return 'Other Scan Type';
  }
}

//Result Type Converter
String resultTypeConverter(int? type) {
  switch (type) {
    case HmsScanForm.ContactDetailForm:
      return 'Contact';
    case HmsScanForm.EmailContentForm:
      return 'Email';
    case HmsScanForm.ISBNNumberForm:
      return 'ISBN';
    case HmsScanForm.TelPhoneNumberForm:
      return 'Tel';
    case HmsScanForm.ArticleNumberForm:
      return 'Product';
    case HmsScanForm.SMSForm:
      return 'SMS';
    case HmsScanForm.PureTextForm:
      return 'Text';
    case HmsScanForm.UrlForm:
      return 'Website';
    case HmsScanForm.WIFIConnectInfoForm:
      return 'WIFI';
    case HmsScanForm.LocationCoordinateForm:
      return 'Location';
    case HmsScanForm.EventInfoForm:
      return 'Event';
    case HmsScanForm.DriverInfoForm:
      return 'License';
    default:
      return 'Other Form';
  }
}

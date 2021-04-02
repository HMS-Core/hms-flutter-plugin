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

import 'package:flutter/material.dart';
import 'package:huawei_scan/HmsScanLibrary.dart';

//Get Unique List
getUniqueList(List<ScanResponse> list) {
  Map<String, ScanResponse> mp = {};
  for (var item in list) {
    mp[item.originalValue] = item;
  }
  var filteredList = mp.values.toList();
  return filteredList;
}

//Color Lists
List<Color> colorList = [
  Colors.white,
  Colors.yellow,
  Colors.red,
  Colors.green,
  Colors.grey,
  Colors.blue,
  Colors.black,
];

List<String> colorStringList = [
  "White",
  "Yellow",
  "Red",
  "Green",
  "Gray",
  "Blue",
  "Black",
];

//Scan Types
List<int> scanTypeList = [
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

List<String> scanTypeStringList = [
  "All Scan Types",
  "Aztec",
  "Code128",
  "Code39",
  "Code93",
  "Codabar",
  "DataMatrix",
  "EAN13",
  "EAN8",
  "ITF14",
  "QRCode",
  "UPCCodeA",
  "UPCCodeE",
  "Pdf417",
];

//Dropdown Controllers
dropdownController(String value) {
  int result = scanTypeStringList.indexOf(value);
  return scanTypeList[result];
}

dropdownColorController(String value) {
  int result = colorStringList.indexOf(value);
  return colorList[result];
}

dropdownControllerBitmap(String value) {
  int result = scanTypeStringList.indexOf(value);
  return scanTypeList[result];
}

//Scan Types for Build Bitmap
List<int> scanTypeListBitmap = [
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

List<String> scanTypeStringListBitmap = [
  "Aztec",
  "Code128",
  "Code39",
  "Code93",
  "Codabar",
  "DataMatrix",
  "EAN13",
  "EAN8",
  "ITF14",
  "QRCode",
  "UPCCodeA",
  "UPCCodeE",
  "Pdf417",
];

//Scan Type Converter
formatConverter(int format) {
  switch (format) {
    case HmsScanTypes.Code128:
      return "Code128 Code";
      break;
    case HmsScanTypes.Code39:
      return "Code39 Code";
      break;
    case HmsScanTypes.Code93:
      return "Code93 Code";
      break;
    case HmsScanTypes.Codabar:
      return "Codabar Code";
      break;
    case HmsScanTypes.DataMatrix:
      return "Data Matrix Code";
      break;
    case HmsScanTypes.EAN13:
      return "EAN13 Code";
      break;
    case HmsScanTypes.EAN8:
      return "EAN8 Code";
      break;
    case HmsScanTypes.ITF14:
      return "ITF14 Code";
      break;
    case HmsScanTypes.QRCode:
      return "QR Code";
      break;
    case HmsScanTypes.UPCCodeA:
      return "UPC Code - A";
      break;
    case HmsScanTypes.UPCCodeE:
      return "UPC Code - E";
      break;
    case HmsScanTypes.Pdf417:
      return "Pdf417 Code";
      break;
    case HmsScanTypes.Aztec:
      return "Aztec Code";
      break;
  }
}

//Result Type Converter
resultTypeConverter(int type) {
  switch (type) {
    case HmsScanForm.ContactDetailForm:
      return "Contact";
      break;
    case HmsScanForm.EmailContentForm:
      return "Email";
      break;
    case HmsScanForm.ISBNNumberForm:
      return "ISBN";
      break;
    case HmsScanForm.TelPhoneNumberForm:
      return "Tel";
      break;
    case HmsScanForm.ArticleNumberForm:
      return "Product";
      break;
    case HmsScanForm.SMSForm:
      return "SMS";
      break;
    case HmsScanForm.PureTextForm:
      return "Text";
      break;
    case HmsScanForm.UrlForm:
      return "Website";
      break;
    case HmsScanForm.WIFIConnectInfoForm:
      return "WIFI";
      break;
    case HmsScanForm.LocationCoordinateForm:
      return "Location";
      break;
    case HmsScanForm.EventInfoForm:
      return "Event";
      break;
    case HmsScanForm.DriverInfoForm:
      return "License";
      break;
  }
}

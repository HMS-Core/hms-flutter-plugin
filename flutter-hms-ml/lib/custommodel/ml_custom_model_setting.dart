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

class MLCustomModelSetting {
  static const int FLOAT32 = 1;
  static const int INT32 = 2;
  static const int REGION_DR_CHINA = 1002;
  static const int REGION_DR_AFILA = 1003;
  static const int REGION_DR_EUROPE = 1004;
  static const int REGION_DR_RUSSIA = 1005;

  String? imagePath;
  String? modelName;
  int modelDataType;
  String? assetPathFile;
  String? localFullPathFile;
  bool isFromAsset;
  String? labelFileName;
  int bitmapSize;
  int channelSize;
  int outputLength;
  int region;
  bool needWifi;
  bool needCharging;
  bool needDeviceIdle;

  MLCustomModelSetting({
    this.imagePath,
    this.modelName,
    this.modelDataType = FLOAT32,
    this.assetPathFile,
    this.localFullPathFile,
    this.isFromAsset = true,
    this.labelFileName,
    this.bitmapSize = 224,
    this.channelSize = 3,
    this.outputLength = 1001,
    this.region = REGION_DR_CHINA,
    this.needWifi = true,
    this.needCharging = false,
    this.needDeviceIdle = false
});

  Map<String, dynamic> toMap() {
    return {
      "imagePath": imagePath,
      "modelName": modelName,
      "modelDataType": modelDataType,
      "assetPathFile": assetPathFile,
      "localFullPathFile": localFullPathFile,
      "isFromAsset": isFromAsset,
      "labelFileName": labelFileName,
      "bitmapSize": bitmapSize,
      "channelSize": channelSize,
      "outputLength": outputLength,
      "region": region,
      "wifiNeeded": needWifi,
      "chargingNeeded": needCharging,
      "deviceIdleNeeded": needDeviceIdle
    };
  }
}

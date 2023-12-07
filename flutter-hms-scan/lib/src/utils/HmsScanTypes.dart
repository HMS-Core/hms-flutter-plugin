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

class HmsScanTypes {
  static const int OtherScanType = -1;
  static const int AllScanType = 0;
  static const int Code128 = 64;
  static const int Code39 = 16;
  static const int Code93 = 32;
  static const int Codabar = 4096;
  static const int DataMatrix = 4;
  static const int EAN13 = 128;
  static const int EAN8 = 256;
  static const int ITF14 = 512;
  static const int QRCode = 1;
  static const int UPCCodeA = 1024;
  static const int UPCCodeE = 2048;
  static const int Pdf417 = 8;
  static const int Aztec = 2;
  static const int MultiFunctional = 8192;
}

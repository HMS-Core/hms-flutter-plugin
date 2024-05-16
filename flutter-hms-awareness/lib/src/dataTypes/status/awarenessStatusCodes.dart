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

part of huawei_awareness;

class AwarenessStatusCodes {
  static const int successCode = 0;
  static const int unknownErrorCode = 10000;
  static const int binderErrorCode = 10001;
  static const int registerFailedCode = 10002;
  static const int timeoutCode = 10003;
  static const int countLimitCode = 10004;
  static const int frequencyLimitCode = 10005;
  static const int barrierParameterErrorCode = 10006;
  static const int requestErrorCode = 10007;
  static const int agcFileError = 10008;
  static const int resultInvalidError = 10009;
  static const int remoteExceptionError = 10010;
  static const int waitCallbackError = 10011;
  static const int interfaceInvalid = 10012;
  static const int noEnoughResource = 10013;
  static const int sdkVersionError = 10100;
  static const int locationPermissionCode = 10101;
  static const int locationCorePermissionCode = 10102;
  static const int behaviorPermissionCode = 10103;
  static const int bluetoothPermissionCode = 10104;
  static const int wifiPermissionCode = 10105;
  static const int wifiCorePermissionCode = 10106;
  static const int locationNoCacheCode = 10200;
  static const int locationNotAvailableCode = 10201;
  static const int beaconNotAvailableCode = 10300;
  static const int bluetoothNotAvailableCode = 10400;
  static const int applicationNotHuaweiPhone = 10500;
  static const int updateKitCode = 1212;
  static const int updateHMSCode = 907135003;
}

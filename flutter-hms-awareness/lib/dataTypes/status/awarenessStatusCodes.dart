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

class AwarenessStatusCodes {
  static const int SuccessCode = 0;
  static const int UnknownErrorCode = 10000;
  static const int BinderErrorCode = 10001;
  static const int RegisterFailedCode = 10002;
  static const int TimeoutCode = 10003;
  static const int CountLimitCode = 10004;
  static const int FrequencyLimitCode = 10005;
  static const int BarrierParameterErrorCode = 10006;
  static const int RequestErrorCode = 10007;
  static const int AGCFileError = 10008;
  static const int ResultInvalidError = 10009;
  static const int RemoteExceptionError = 10010;
  static const int WaitCallbackError = 10011;
  static const int InterfaceInvalid = 10012;
  static const int NoEnoughResource = 10013;
  static const int SDKVersionError = 10100;
  static const int LocationPermissionCode = 10101;
  static const int LocationCorePermissionCode = 10102;
  static const int BehaviorPermissionCode = 10103;
  static const int BluetoothPermissionCode = 10104;
  static const int WifiPermissionCode = 10105;
  static const int WifiCorePermissionCode = 10106;
  static const int LocationNoCacheCode = 10200;
  static const int LocationNotAvailableCode = 10201;
  static const int BeaconNotAvailableCode = 10300;
  static const int BluetoothNotAvailableCode = 10400;
  static const int ApplicationNotHuaweiPhone = 10500;
  static const int UpdateKitCode = 1212;
  static const int UpdateHMSCode = 907135003;
}

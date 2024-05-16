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

abstract class _Method {
  //Common Client Methods
  static const String enableUpdateWindow = 'enableUpdateWindow';

  //Awareness Capture Client Methods
  static const String getBeaconStatus = 'getBeaconStatus';
  static const String getBehavior = 'getBehavior';
  static const String getHeadsetStatus = 'getHeadsetStatus';
  static const String getLocation = 'getLocation';
  static const String getCurrentLocation = 'getCurrentLocation';
  static const String getTimeCategories = 'getTimeCategories';
  static const String getTimeCategoriesByUser = 'getTimeCategoriesByUser';
  static const String getTimeCategoriesByCountryCode =
      'getTimeCategoriesByCountryCode';
  static const String getTimeCategoriesByIP = 'getTimeCategoriesByIP';
  static const String getTimeCategoriesForFuture = 'getTimeCategoriesForFuture';
  static const String getLightIntensity = 'getLightIntensity';
  static const String getWeatherByDevice = 'getWeatherByDevice';
  static const String getWeatherByPosition = 'getWeatherByPosition';
  static const String getBluetoothStatus = 'getBluetoothStatus';
  static const String querySupportingCapabilities =
      'querySupportingCapabilities';
  static const String getScreenStatus = 'getScreenStatus';
  static const String getWifiStatus = 'getWifiStatus';
  static const String getApplicationStatus = 'getApplicationStatus';
  static const String getDarkModeStatus = 'getDarkModeStatus';

  //Awareness Barrier Client Methods
  static const String queryBarriers = 'queryBarriers';
  static const String deleteBarrier = 'deleteBarrier';
  static const String updateBarrier = 'updateBarriers';

  //Awareness Utils Client Methods
  static const String enableLogger = 'enableLogger';
  static const String disableLogger = 'disableLogger';
}

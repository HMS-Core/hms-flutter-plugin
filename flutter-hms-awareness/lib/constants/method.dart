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

class Method {
  //Common Client Methods
  static const String EnableUpdateWindow = "enableUpdateWindow";

  //Awareness Capture Client Methods
  static const String GetBeaconStatus = "getBeaconStatus";
  static const String GetBehavior = "getBehavior";
  static const String GetHeadsetStatus = "getHeadsetStatus";
  static const String GetLocation = "getLocation";
  static const String GetCurrentLocation = "getCurrentLocation";
  static const String GetTimeCategories = "getTimeCategories";
  static const String GetTimeCategoriesByUser = "getTimeCategoriesByUser";
  static const String GetTimeCategoriesByCountryCode =
      "getTimeCategoriesByCountryCode";
  static const String GetTimeCategoriesByIP = "getTimeCategoriesByIP";
  static const String GetTimeCategoriesForFuture = "getTimeCategoriesForFuture";
  static const String GetLightIntensity = "getLightIntensity";
  static const String GetWeatherByDevice = "getWeatherByDevice";
  static const String GetWeatherByPosition = "getWeatherByPosition";
  static const String GetBluetoothStatus = "getBluetoothStatus";
  static const String QuerySupportingCapabilities =
      "querySupportingCapabilities";
  static const String GetScreenStatus = "getScreenStatus";
  static const String GetWifiStatus = "getWifiStatus";
  static const String GetApplicationStatus = "getApplicationStatus";
  static const String GetDarkModeStatus = "getDarkModeStatus";

  //Awareness Barrier Client Methods
  static const String QueryBarriers = "queryBarriers";
  static const String DeleteBarrier = "deleteBarrier";
  static const String UpdateBarrier = "updateBarriers";
  static const String UpdateBarrierWithAutoRemove =
      "UpdateBarriersWithAutoRemove";

  //Awareness Utils Client Methods
  static const String EnableLogger = "enableLogger";
  static const String DisableLogger = "disableLogger";
  static const String HasLocationPermission = "hasLocationPermission";
  static const String HasBackgroundLocationPermission =
      "hasBackgroundLocationPermission";
  static const String HasActivityRecognitionPermission =
      "hasActivityRecognitionPermission";
  static const String RequestLocationPermission = "requestLocationPermission";
  static const String RequestBackgroundLocationPermission =
      "requestBackgroundLocationPermission";
  static const String RequestActivityRecognitionPermission =
      "requestActivityRecognitionPermission";
}

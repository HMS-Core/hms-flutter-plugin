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

library huawei_awareness;

import 'dart:convert';

import 'package:flutter/services.dart';

part 'src/awarenessBarrierClient.dart';
part 'src/awarenessCaptureClient.dart';
part 'src/awarenessUtilsClient.dart';
part 'src/constants/channel.dart';
part 'src/constants/method.dart';
part 'src/constants/param.dart';
part 'src/dataTypes/barrierTypes/ambientLightBarrier.dart';
part 'src/dataTypes/barrierTypes/awarenessBarrier.dart';
part 'src/dataTypes/barrierTypes/barrier.dart';
part 'src/dataTypes/barrierTypes/barrierDeleteRequest.dart';
part 'src/dataTypes/barrierTypes/barrierQueryRequest.dart';
part 'src/dataTypes/barrierTypes/barrierQueryResponse.dart';
part 'src/dataTypes/barrierTypes/barrierStatus.dart';
part 'src/dataTypes/barrierTypes/beaconBarrier.dart';
part 'src/dataTypes/barrierTypes/behaviorBarrier.dart';
part 'src/dataTypes/barrierTypes/bluetoothBarrier.dart';
part 'src/dataTypes/barrierTypes/combinationBarrier.dart';
part 'src/dataTypes/barrierTypes/headsetBarrier.dart';
part 'src/dataTypes/barrierTypes/locationBarrier.dart';
part 'src/dataTypes/barrierTypes/screenBarrier.dart';
part 'src/dataTypes/barrierTypes/timeBarrier.dart';
part 'src/dataTypes/barrierTypes/wifiBarrier.dart';
part 'src/dataTypes/captureTypes/applicationResponse.dart';
part 'src/dataTypes/captureTypes/beaconData.dart';
part 'src/dataTypes/captureTypes/beaconResponse.dart';
part 'src/dataTypes/captureTypes/behaviorResponse.dart';
part 'src/dataTypes/captureTypes/bluetoothResponse.dart';
part 'src/dataTypes/captureTypes/capabilityResponse.dart';
part 'src/dataTypes/captureTypes/darkModeResponse.dart';
part 'src/dataTypes/captureTypes/detectedBehavior.dart';
part 'src/dataTypes/captureTypes/headsetResponse.dart';
part 'src/dataTypes/captureTypes/lightIntensityResponse.dart';
part 'src/dataTypes/captureTypes/locationResponse.dart';
part 'src/dataTypes/captureTypes/screenStatusResponse.dart';
part 'src/dataTypes/captureTypes/timeCategoriesResponse.dart';
part 'src/dataTypes/captureTypes/weather/aqi.dart';
part 'src/dataTypes/captureTypes/weather/city.dart';
part 'src/dataTypes/captureTypes/weather/dailyLiveInfo.dart';
part 'src/dataTypes/captureTypes/weather/dailySituation.dart';
part 'src/dataTypes/captureTypes/weather/dailyWeather.dart';
part 'src/dataTypes/captureTypes/weather/hourlyWeather.dart';
part 'src/dataTypes/captureTypes/weather/liveInfo.dart';
part 'src/dataTypes/captureTypes/weather/situation.dart';
part 'src/dataTypes/captureTypes/weather/weatherSituation.dart';
part 'src/dataTypes/captureTypes/weatherPosition.dart';
part 'src/dataTypes/captureTypes/weatherResponse.dart';
part 'src/dataTypes/captureTypes/wifiResponse.dart';
part 'src/dataTypes/status/applicationStatus.dart';
part 'src/dataTypes/status/awarenessStatusCodes.dart';
part 'src/dataTypes/status/beaconFilter.dart';
part 'src/dataTypes/status/bluetoothStatus.dart';
part 'src/dataTypes/status/capabilityStatus.dart';
part 'src/dataTypes/status/headsetStatus.dart';
part 'src/dataTypes/status/screenStatus.dart';
part 'src/dataTypes/status/weatherId.dart';
part 'src/dataTypes/status/wifiStatus.dart';

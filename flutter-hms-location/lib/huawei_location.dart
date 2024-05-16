/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

library huawei_location;

import 'dart:convert';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

part 'src/activity/activity_conversion_data.dart';
part 'src/activity/activity_conversion_info.dart';
part 'src/activity/activity_conversion_response.dart';
part 'src/activity/activity_identification_data.dart';
part 'src/activity/activity_identification_response.dart';
part 'src/activity/activity_identification_service.dart';
part 'src/geocoder/geocoder_service.dart';
part 'src/geocoder/get_from_location_name_request.dart';
part 'src/geocoder/get_from_location_request.dart';
part 'src/geocoder/locale.dart';
part 'src/geofence/geofence.dart';
part 'src/geofence/geofence_data.dart';
part 'src/geofence/geofence_request.dart';
part 'src/geofence/geofence_service.dart';
part 'src/location/fused_location_provider_client.dart';
part 'src/location/hwlocation.dart';
part 'src/location/location.dart';
part 'src/location/location_availability.dart';
part 'src/location/location_callback.dart';
part 'src/location/location_request.dart';
part 'src/location/location_result.dart';
part 'src/location/location_settings_request.dart';
part 'src/location/location_settings_states.dart';
part 'src/location/log_config.dart';
part 'src/location/navigation_request.dart';
part 'src/location/navigation_result.dart';
part 'src/location/notification.dart';
part 'src/logger/hmslogger.dart';
part 'src/location/location_utils.dart';
part 'src/location/lon_lat.dart';

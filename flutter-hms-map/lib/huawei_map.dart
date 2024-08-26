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

library huawei_map;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

part 'src/channel/huawei_map_initializer.dart';
part 'src/channel/huawei_map_method_channel.dart';
part 'src/channel/huawei_map_util_method_channel.dart';
part 'src/components/animations/alpha_animation.dart';
part 'src/components/animations/hms_animation.dart';
part 'src/components/animations/rotate_animation.dart';
part 'src/components/animations/scale_animation.dart';
part 'src/components/animations/translate_animation.dart';
part 'src/components/bitmap_descriptor.dart';
part 'src/components/callbacks.dart';
part 'src/components/camera_position.dart';
part 'src/components/camera_target_bounds.dart';
part 'src/components/camera_update.dart';
part 'src/components/cap.dart';
part 'src/components/circle.dart';
part 'src/components/circle_updates.dart';
part 'src/components/cirlce_id.dart';
part 'src/components/ground_overlay.dart';
part 'src/components/ground_overlay_id.dart';
part 'src/components/ground_overlay_updates.dart';
part 'src/components/heat_map.dart';
part 'src/components/heat_map_id.dart';
part 'src/components/heat_map_updates.dart';
part 'src/components/huawei_map_options.dart';
part 'src/components/info_window.dart';
part 'src/components/joint_type.dart';
part 'src/components/lat_lng.dart';
part 'src/components/lat_lng_bounds.dart';
part 'src/components/location.dart';
part 'src/components/marker.dart';
part 'src/components/marker_id.dart';
part 'src/components/marker_updates.dart';
part 'src/components/min_max_zoom_preference.dart';
part 'src/components/pattern_item.dart';
part 'src/components/point_of_interest.dart';
part 'src/components/polygon.dart';
part 'src/components/polygon_id.dart';
part 'src/components/polygon_updates.dart';
part 'src/components/polyline.dart';
part 'src/components/polyline_id.dart';
part 'src/components/polyline_updates.dart';
part 'src/components/screen_coordinate.dart';
part 'src/components/tile_overlay.dart';
part 'src/components/tile_overlay_id.dart';
part 'src/components/tile_overlay_updates.dart';
part 'src/components/tile_providers/repetitive_tile.dart';
part 'src/components/tile_providers/tile.dart';
part 'src/components/tile_providers/url_tile.dart';
part 'src/constants/channel.dart';
part 'src/constants/map_type.dart';
part 'src/constants/method.dart';
part 'src/constants/param.dart';
part 'src/constants/radius_unit.dart';
part 'src/events/events.dart';
part 'src/events/map_event.dart';
part 'src/events/map_event_coord.dart';
part 'src/events/map_event_location.dart';
part 'src/events/map_event_location_button.dart';
part 'src/events/map_event_poi.dart';
part 'src/map.dart';
part 'src/utils/circle.dart';
part 'src/utils/ground_overlay.dart';
part 'src/utils/heat_map.dart';
part 'src/utils/marker.dart';
part 'src/utils/polygon.dart';
part 'src/utils/polyline.dart';
part 'src/utils/tile_overlay.dart';
part 'src/utils/to_json.dart';
part 'src/utils/utils.dart';
part 'src/components/mylocation_style.dart';

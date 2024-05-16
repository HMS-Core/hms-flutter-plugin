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

library huawei_nearbyservice;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

part 'src/discovery/callback/response.dart';
part 'src/discovery/classes.dart';
part 'src/discovery/hms_discovery_engine.dart';
part 'src/hms_nearby.dart';
part 'src/message/callback/classes.dart';
part 'src/message/classes/beacon_id.dart';
part 'src/message/classes/ibeacon_info.dart';
part 'src/message/classes/message.dart';
part 'src/message/classes/message_option.dart';
part 'src/message/classes/message_picker.dart';
part 'src/message/classes/message_policy.dart';
part 'src/message/classes/namespace_type.dart';
part 'src/message/classes/uid_instance.dart';
part 'src/message/hms_message_engine.dart';
part 'src/transfer/callback/response.dart';
part 'src/transfer/classes.dart';
part 'src/transfer/hms_transfer_engine.dart';
part 'src/utils/channels.dart';
part 'src/utils/constants.dart';
part 'src/beacon/hms_beacon_engine.dart';
part 'src/beacon/classes.dart';

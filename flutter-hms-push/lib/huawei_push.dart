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

library huawei_push;

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'src/cli/hms_profile.dart';
part 'src/cli/proxy_settings.dart';
part 'src/cli/push.dart';
part 'src/constants/channels.dart';
part 'src/constants/result_codes.dart';
part 'src/local_notification/attributes.dart';
part 'src/local_notification/importance.dart';
part 'src/local_notification/priority.dart';
part 'src/local_notification/repeat_type.dart';
part 'src/local_notification/visibility.dart';
part 'src/model/remote_message.dart';
part 'src/model/remote_message_builder.dart';
part 'src/model/remote_message_notification.dart';

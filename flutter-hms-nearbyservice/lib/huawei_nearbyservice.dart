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

library huawei_nearby_lib;

/// Nearby Service
export 'src/hms_nearby.dart';

/// Nearby Service Discovery Engine
export 'src/discovery/hms_discovery_engine.dart';
export 'src/discovery/classes.dart';
export 'src/discovery/callback/response.dart';

/// Nearby Service Transfer Engine
export 'src/transfer/hms_transfer_engine.dart';
export 'src/transfer/classes.dart';
export 'src/transfer/callback/response.dart';

/// Nearby Wifi Share Engine
export 'src/wifi_share/hms_wifi_share_engine.dart';
export 'src/wifi_share/wifi_share_policy.dart';
export 'src/wifi_share/callback/response.dart';

/// Nearby Message Engine
export 'src/message/hms_message_engine.dart';
export 'src/message/classes/ibeacon_info.dart';
export 'src/message/classes/message.dart';
export 'src/message/classes/message_option.dart';
export 'src/message/classes/message_picker.dart';
export 'src/message/classes/message_policy.dart';
export 'src/message/classes/namespace_type.dart';
export 'src/message/classes/uid_instance.dart';
export 'src/message/callback/classes.dart';

/// Nearby Service permission handler';
export 'src/permission/nearby_permission_handler.dart';

/// Utility classes
export 'src/utils/constants.dart';

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

library huawei_account;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'src/common/account.dart';
part 'src/common/scope.dart';
part 'src/request/account_auth_extended_params.dart';
part 'src/request/account_auth_params_helper.dart';
part 'src/request/account_auth_params.dart';
part 'src/results/account_icon.dart';
part 'src/results/auth_account.dart';
part 'src/services/account_auth_manager.dart';
part 'src/services/account_auth_service.dart';
part 'src/services/huawei_id_auth_tool.dart';
part 'src/services/network_tool.dart';
part 'src/services/read_sms_manager.dart';
part 'src/ui/huawei_id_auth_button.dart';
part 'src/utils/account_utils.dart';
part 'src/utils/constants.dart';

/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

library huawei_scan;

import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

//Scan Methods
part 'src/hmsCustomizedView/HmsCustomizedView.dart';
part 'src/hmsScanUtils/HmsScanUtils.dart';
part 'src/hmsMultiProcessor/HmsMultiProcessor.dart';

//Requests
part 'src/hmsCustomizedView/CustomizedViewRequest.dart';
part 'src/hmsScanUtils/BuildBitmapRequest.dart';
part 'src/hmsScanUtils/DecodeRequest.dart';
part 'src/hmsScanUtils/DefaultViewRequest.dart';
part 'src/hmsMultiProcessor/MultiCameraRequest.dart';

//Results
part 'src/model/ScanResponse.dart';
part 'src/model/ScanResponseList.dart';

//Models
part 'src/hmsMultiProcessor/ScanTextOptions.dart';
part 'src/model/AddressInfo.dart';
part 'src/model/BorderRect.dart';
part 'src/model/ContactDetail.dart';
part 'src/model/CornerPoint.dart';
part 'src/model/DriverInfo.dart';
part 'src/model/EmailContent.dart';
part 'src/model/EventInfo.dart';
part 'src/model/EventTime.dart';
part 'src/model/LinkUrl.dart';
part 'src/model/LocationCoordinate.dart';
part 'src/model/PeopleName.dart';
part 'src/model/SmsContent.dart';
part 'src/model/TelPhoneNumber.dart';
part 'src/model/WiFiConnectionInfo.dart';

//Utilities
part 'src/utils/HmsScanForm.dart';
part 'src/utils/HmsScanTypes.dart';
part 'src/utils/HmsScanErrors.dart';

part 'src/HmsScan.dart';

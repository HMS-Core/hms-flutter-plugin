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

library hms_scan_library;

//Scan Methods
export 'hmsCustomizedView/HmsCustomizedView.dart';
export 'hmsScanUtils/HmsScanUtils.dart';
export 'hmsMultiProcessor/HmsMultiProcessor.dart';

//Permissions
export 'hmsScanPermissions/HmsScanPermissions.dart';

//Requests
export 'hmsCustomizedView/CustomizedViewRequest.dart';
export 'hmsScanUtils/BuildBitmapRequest.dart';
export 'hmsScanUtils/DecodeRequest.dart';
export 'hmsScanUtils/DefaultViewRequest.dart';
export 'hmsMultiProcessor/MultiCameraRequest.dart';

//Results
export 'model/ScanResponse.dart';
export 'model/ScanResponseList.dart';

//Models
export 'hmsMultiProcessor/ScanTextOptions.dart';
export 'model/AddressInfo.dart';
export 'model/BorderRect.dart';
export 'model/ContactDetail.dart';
export 'model/CornerPoint.dart';
export 'model/DriverInfo.dart';
export 'model/EmailContent.dart';
export 'model/EventInfo.dart';
export 'model/EventTime.dart';
export 'model/LinkUrl.dart';
export 'model/LocationCoordinate.dart';
export 'model/PeopleName.dart';
export 'model/SmsContent.dart';
export 'model/TelPhoneNumber.dart';
export 'model/WiFiConnectionInfo.dart';

//Utilities
export 'utils/HmsScanForm.dart';
export 'utils/HmsScanTypes.dart';
export 'utils/HmsScanErrors.dart';

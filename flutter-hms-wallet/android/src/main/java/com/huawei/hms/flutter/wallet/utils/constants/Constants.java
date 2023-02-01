/*
 * Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.wallet.utils.constants;

public abstract class Constants {
    // CreateWalletPassResult codes
    public static final int RESULT_OK = 10000;
    public static final int RESULT_CANCELED = 20000;
    public static final int NO_OWNER = 30000;
    public static final int HMS_VERSION_CODE = 40000;

    // WalletPassApi codes
    public static final int MISSING_PARAM = 50000;
    public static final int ACTIVITY_NOT_FOUND = 60000;
    public static final int MISSING_METHOD_RESULT = 70000;

    // Descriptions
    public static final String MISSING_PARAM_DESC = "One or more required parameters are missing.";
    public static final String ACTIVITY_NOT_FOUND_DESC = "Application's Activity not found.";
}

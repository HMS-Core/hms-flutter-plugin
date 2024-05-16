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

package com.huawei.hms.flutter.ads.utils.constants;

public interface ConsentConst {
    /**
     * SharedPreferences name.
     */
    String SP_NAME = "HuaweiAdsSdkSharedPreferences";

    /**
     * The SP key of protocol.
     */
    String SP_PROTOCOL_KEY = "protocol";

    /**
     * The SP key of consent.
     */
    String SP_CONSENT_KEY = "consent";

    /**
     * The SP default value of protocol.
     */
    int DEFAULT_SP_PROTOCOL_VALUE = 0;

    /**
     * The SP default value of consent.
     */
    int DEFAULT_SP_CONSENT_VALUE = -1;
}

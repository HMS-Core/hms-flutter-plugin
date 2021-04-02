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

package com.huawei.hms.flutter.safetydetect.constants;

public final class Constants {
    public static final String SUCCESS = "0";
    public static final String ERROR = "-1";

    public static final String APP_ID = "appId";

    private Constants() {
    }

    public static final class Channel {
        private Channel() {
        }

        public static final String METHOD_CHANNEL = "com.huawei.hms.flutter.safetydetect/method";
    }

    public static final class APIMethod {
        private APIMethod() {
        }

        public static final String SYS_INTEGRITY = "sysIntegrity";
        public static final String IS_VERIFY_APPS_CHECK = "isVerifyAppsCheck";
        public static final String ENABLE_APPS_CHECK = "enableAppsCheck";
        public static final String GET_MALICIOUS_APPS_LIST = "getMaliciousAppsList";
        public static final String INIT_URL_CHECK = "initUrlCheck";
        public static final String URL_CHECK = "urlCheck";
        public static final String SHUTDOWN_URL_CHECK = "shutdownUrlCheck";
        public static final String INIT_USER_DETECT = "initUserDetect";
        public static final String USER_DETECTION = "userDetection";
        public static final String SHUTDOWN_USER_DETECT = "shutdownUserDetect";
        public static final String GET_WIFI_DETECT_STATUS = "getWifiDetectStatus";
        public static final String INIT_ANTI_FRAUD = "initAntiFraud";
        public static final String GET_RISK_TOKEN = "getRiskToken";
        public static final String RELEASE_ANTI_FRAUD = "releaseAntiFraud";
    }
}

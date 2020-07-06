/*
Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.push.constants;

public enum Channel {

    TOKEN_CHANNEL("com.huawei.flutter.push/token"),
    DATA_MESSAGE_CHANNEL("com.huawei.flutter.push/data_message"),
    METHOD_CHANNEL("com.huawei.flutter.push/method");

    private String id;

    Channel(String id) {
        this.id = id;
    }

    public String id() {
        return id;
    }

}

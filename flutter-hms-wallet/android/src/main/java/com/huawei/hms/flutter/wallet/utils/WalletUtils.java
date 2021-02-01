/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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
package com.huawei.hms.flutter.wallet.utils;

import com.huawei.wallet.hmspass.service.WalletPassApiResponse;

import java.util.HashMap;

public class WalletUtils {
    public static HashMap<String, Object> walletPassApiResponseToMap(WalletPassApiResponse response){
        HashMap<String, Object> resultMap = new HashMap<>();
        resultMap.put("returnCode", response.getReturnCode());
        resultMap.put("returnRes", response.getReturnRes());
        resultMap.put("accessToken", response.getAccessToken());
        resultMap.put("tempAccessSec", response.getTempAccessSec());
        resultMap.put("cardParams", response.getCardParams());
        resultMap.put("passStatuslist", response.getPassStatusList());
        resultMap.put("cardInfolist", response.getCardInfoList());
        resultMap.put("teeTempAccessSec", response.getTeeTempAccessSec());
        resultMap.put("teeTempTransId", response.getTeeTempTransId());
        resultMap.put("version", response.getVersion());
        resultMap.put("readNFCResult", response.getReadNFCResult());
        resultMap.put("passDeviceId", response.getPassDeviceId());
        resultMap.put("transactionId", response.getTransactionId());
        resultMap.put("transactionIdSign", response.getTransactionIdSign());
        resultMap.put("authResult", response.getAuthResult());
        return resultMap;
    }
}

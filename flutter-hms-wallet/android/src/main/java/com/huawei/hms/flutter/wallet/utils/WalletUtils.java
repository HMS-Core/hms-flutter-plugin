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

package com.huawei.hms.flutter.wallet.utils;

import com.huawei.hms.wallet.pass.AppendField;
import com.huawei.hms.wallet.pass.BarCode;
import com.huawei.hms.wallet.pass.CommonField;
import com.huawei.hms.wallet.pass.Location;
import com.huawei.hms.wallet.pass.PassObject;
import com.huawei.hms.wallet.pass.PassStatus;
import com.huawei.hms.wallet.pass.RelatedPassInfo;
import com.huawei.wallet.hmspass.service.WalletCardInfo;
import com.huawei.wallet.hmspass.service.WalletPassApiResponse;
import com.huawei.wallet.hmspass.service.WalletPassStatus;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public abstract class WalletUtils {
    public static Map<String, Object> walletPassApiResponseToMap(WalletPassApiResponse passApiResponse) {
        final Map<String, Object> map = new HashMap<>();
        if (passApiResponse != null) {
            map.put("returnCode", passApiResponse.getReturnCode());
            map.put("returnRes", passApiResponse.getReturnRes());
            map.put("accessToken", passApiResponse.getAccessToken());
            map.put("tempAccessSec", passApiResponse.getTempAccessSec());
            map.put("cardParams", passApiResponse.getCardParams());

            final List<Map<String, Object>> passStatusList = new ArrayList<>();
            if (passApiResponse.getPassStatusList() != null) {
                for (WalletPassStatus passStatus : passApiResponse.getPassStatusList()) {
                    passStatusList.add(walletPassStatusToMap(passStatus));
                }
            }
            map.put("passStatusList", passStatusList);

            final List<Map<String, Object>> cardInfoList = new ArrayList<>();
            if (passApiResponse.getCardInfoList() != null) {
                for (WalletCardInfo cardInfo : passApiResponse.getCardInfoList()) {
                    cardInfoList.add(walletCardInfoToMap(cardInfo));
                }
            }
            map.put("cardInfoList", cardInfoList);

            map.put("teeTempAccessSec", passApiResponse.getTeeTempAccessSec());
            map.put("teeTempTransId", passApiResponse.getTeeTempTransId());
            if (passApiResponse.getPassStatus() != null) {
                map.put("passStatus", walletPassStatusToMap(passApiResponse.getPassStatus()));
            }
            map.put("version", passApiResponse.getVersion());
            map.put("readNFCResult", passApiResponse.getReadNFCResult());
            map.put("passDeviceId", passApiResponse.getPassDeviceId());
            map.put("transactionId", passApiResponse.getTransactionId());
            map.put("transactionIdSign", passApiResponse.getTransactionIdSign());
            map.put("authResult", passApiResponse.getAuthResult());
        }
        return map;
    }

    public static PassObject passObjectFromMap(Map<String, Object> map) {
        final PassObject.Builder builder = PassObject.getBuilder();
        builder.setPassTypeIdentifier((String) map.get("passTypeIdentifier"));
        builder.setPassStyleIdentifier((String) map.get("passStyleIdentifier"));
        builder.setOrganizationPassId((String) map.get("organizationPassId"));
        builder.setSerialNumber((String) map.get("serialNumber"));
        if (map.get("currencyCode") != null) {
            builder.setCurrencyCode((String) map.get("currencyCode"));
        }
        builder.setBarCode(barCodeFromMap((Map) map.get("barCode")));
        builder.setStatus(passStatusFromMap((Map) map.get("status")));

        for (Map<String, Object> m : (List<Map<String, Object>>) map.get("relatedPassIds")) {
            builder.addRelatedPassIds(Collections.singletonList(relatedPassInfoFromMap(m)));
        }
        for (Map<String, Object> m : (List<Map<String, Object>>) map.get("locationList")) {
            builder.addLocationList(Collections.singletonList(locationFromMap(m)));
        }
        for (Map<String, Object> m : (List<Map<String, Object>>) map.get("commonFields")) {
            builder.addCommonFields(Collections.singletonList(commonFieldFromMap(m)));
        }
        for (Map<String, Object> m : (List<Map<String, Object>>) map.get("appendFields")) {
            builder.addAppendFields(Collections.singletonList(appendFieldFromMap(m)));
        }
        for (Map<String, Object> m : (List<Map<String, Object>>) map.get("messageList")) {
            builder.addMessageList(Collections.singletonList(appendFieldFromMap(m)));
        }
        for (Map<String, Object> m : (List<Map<String, Object>>) map.get("imageList")) {
            builder.addImageList(Collections.singletonList(appendFieldFromMap(m)));
        }
        for (Map<String, Object> m : (List<Map<String, Object>>) map.get("textList")) {
            builder.addTextList(Collections.singletonList(appendFieldFromMap(m)));
        }
        for (Map<String, Object> m : (List<Map<String, Object>>) map.get("urlList")) {
            builder.addUrlList(Collections.singletonList(appendFieldFromMap(m)));
        }
        return builder.build();
    }

    private static RelatedPassInfo relatedPassInfoFromMap(Map<String, Object> map) {
        final String typeId = (String) map.get("typeId");
        final String id = (String) map.get("id");
        return new RelatedPassInfo(typeId, id);
    }

    private static Location locationFromMap(Map<String, Object> map) {
        final String latitude = (String) map.get("latitude");
        final String longitude = (String) map.get("longitude");
        return new Location(latitude, longitude);
    }

    private static CommonField commonFieldFromMap(Map<String, Object> map) {
        final CommonField.Builder builder = CommonField.getBuilder();
        builder.setKey((String) map.get("key"));
        builder.setValue((String) map.get("value"));
        builder.setLabel((String) map.get("label"));
        return builder.build();
    }

    private static AppendField appendFieldFromMap(Map<String, Object> map) {
        final AppendField.Builder builder = AppendField.getBuilder();
        builder.setKey((String) map.get("key"));
        builder.setValue((String) map.get("value"));
        builder.setLabel((String) map.get("label"));
        return builder.build();
    }

    private static BarCode barCodeFromMap(Map<String, Object> map) {
        final BarCode.Builder builder = BarCode.getBuilder();
        builder.setText((String) map.get("text"));
        builder.setType((String) map.get("type"));
        if (map.get("value") != null) {
            builder.setValue((String) map.get("value"));
        }
        return builder.build();
    }

    private static PassStatus passStatusFromMap(Map<String, Object> map) {
        final PassStatus.Builder builder = PassStatus.getBuilder();
        builder.setState((String) map.get("state"));
        builder.setEffectTime((String) map.get("effectTime"));
        builder.setExpireTime((String) map.get("expireTime"));
        return builder.build();
    }

    private static Map<String, Object> walletPassStatusToMap(WalletPassStatus passStatus) {
        final Map<String, Object> map = new HashMap<>();
        if (passStatus != null) {
            map.put("passId", passStatus.getPassId());
            map.put("status", passStatus.getStatus());
        }
        return map;
    }

    private static Map<String, Object> walletCardInfoToMap(WalletCardInfo cardInfo) {
        final Map<String, Object> map = new HashMap<>();
        if (cardInfo != null) {
            map.put("passId", cardInfo.getPassId());
            map.put("status", cardInfo.getStatus());
            map.put("lockID", cardInfo.getLockID());
            map.put("transactionTime", cardInfo.getTransactionTime());
            map.put("transactionResult", cardInfo.getTransactionResult());
        }
        return map;
    }
}

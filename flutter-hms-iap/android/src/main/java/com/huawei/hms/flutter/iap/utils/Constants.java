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

package com.huawei.hms.flutter.iap.utils;

import com.huawei.hms.iap.IapClient;
import com.huawei.hms.iap.entity.InAppPurchaseData;
import com.huawei.hms.iap.entity.OrderStatusCode;

public enum Constants {
    //OrderStatusCode
    orderAccountAreaNotSupported("ORDER_ACCOUNT_AREA_NOT_SUPPORTED", OrderStatusCode.ORDER_ACCOUNT_AREA_NOT_SUPPORTED),
    orderHighRiskOperations("ORDER_HIGH_RISK_OPERATIONS", OrderStatusCode.ORDER_HIGH_RISK_OPERATIONS),
    orderHwidNotLogin("ORDER_HWID_NOT_LOGIN", OrderStatusCode.ORDER_HWID_NOT_LOGIN),
    orderNotAcceptAgreement("ORDER_NOT_ACCEPT_AGREEMENT", OrderStatusCode.ORDER_NOT_ACCEPT_AGREEMENT),
    orderProductConsumed("ORDER_PRODUCT_CONSUMED", OrderStatusCode.ORDER_PRODUCT_CONSUMED),
    orderProductNotOwned("ORDER_PRODUCT_NOT_OWNED", OrderStatusCode.ORDER_PRODUCT_NOT_OWNED),
    orderProductOwned("ORDER_PRODUCT_OWNED", OrderStatusCode.ORDER_PRODUCT_OWNED),
    orderStateCancel("ORDER_STATE_CANCEL", OrderStatusCode.ORDER_STATE_CANCEL),
    orderStateFailed("ORDER_STATE_FAILED", OrderStatusCode.ORDER_STATE_FAILED),
    orderStateNetError("ORDER_STATE_NET_ERROR", OrderStatusCode.ORDER_STATE_NET_ERROR),
    orderStateParamError("ORDER_STATE_PARAM_ERROR", OrderStatusCode.ORDER_STATE_PARAM_ERROR),
    orderStateSuccess("ORDER_STATE_SUCCESS", OrderStatusCode.ORDER_STATE_SUCCESS),
    orderVrUninstallError("ORDER_VR_UNINSTALL_ERROR", OrderStatusCode.ORDER_VR_UNINSTALL_ERROR),

    //InAppPurchaseData
    purchaseDataNotPresent("PURCHASE_DATA_NOT_PRESENT", InAppPurchaseData.NOT_PRESENT),

    //PurchaseState
    purchaseStateCancelled("PURCHASE_STATE_CANCELED", InAppPurchaseData.PurchaseState.CANCELED),
    purchaseStateInitialized("PURCHASE_STATE_INITIALIZED", InAppPurchaseData.PurchaseState.INITIALIZED),
    purchaseStatePurchased("PURCHASE_STATE_PURCHASED", InAppPurchaseData.PurchaseState.PURCHASED),
    purchaseStateRefunded("PURCHASE_STATE_REFUNDED", InAppPurchaseData.PurchaseState.REFUNDED),

    //PriceType
    priceTypeInAppConsumable("PRICE_TYPE_IN_APP_CONSUMABLE", IapClient.PriceType.IN_APP_CONSUMABLE),
    priceTypeInAppNonConsumable("PRICE_TYPE_IN_APP_NONCONSUMABLE", IapClient.PriceType.IN_APP_NONCONSUMABLE),
    priceTypeInAppSubscriptions("PRICE_TYPE_IN_APP_SUBSCRIPTION", IapClient.PriceType.IN_APP_SUBSCRIPTION);

    private final String errorMessage;
    private final int errorCode;

    Constants(String errorMessage, int errorCode) {
        this.errorMessage = errorMessage;
        this.errorCode = errorCode;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public int getErrorCode() {
        return errorCode;
    }
}

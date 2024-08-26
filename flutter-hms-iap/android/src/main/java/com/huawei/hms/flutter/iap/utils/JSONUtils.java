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

package com.huawei.hms.flutter.iap.utils;

import android.util.Log;

import com.huawei.hms.iap.entity.ProductInfo;
import com.huawei.hms.iap.entity.ProductInfoResult;
import com.huawei.hms.iap.entity.PurchaseResultInfo;
import com.huawei.hms.support.api.client.Status;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.List;

public final class JSONUtils {
    private static final String TAG = JSONUtils.class.getSimpleName();

    private JSONUtils() {
    }

    private static <T> JSONArray mapList(final List<T> list) {
        final JSONArray jsonArray = new JSONArray();
        for (final T item : list) {
            jsonArray.put(getJSONFromProductInfo((ProductInfo) item));
        }
        return jsonArray;
    }

    public static JSONObject getJSONFromPurchaseResultInfo(final PurchaseResultInfo obj) {
        final JSONObject jsonObject = new JSONObject();
        try {
            jsonObject.put("returnCode", obj.getReturnCode());
            jsonObject.put("errMsg", obj.getErrMsg());
            jsonObject.put("inAppPurchaseData", obj.getInAppPurchaseData());
            jsonObject.put("inAppDataSignature", obj.getInAppDataSignature());
            jsonObject.put("signatureAlgorithm", obj.getSignatureAlgorithm());
        } catch (final JSONException e) {
            Log.e(TAG, e.toString());
        }
        return jsonObject;
    }

    public static JSONObject getJSONFromProductInfoResult(final ProductInfoResult obj) {
        final JSONObject jsonObject = new JSONObject();
        try {
            jsonObject.put("returnCode", obj.getReturnCode());
            jsonObject.put("errMsg", obj.getErrMsg());
            jsonObject.put("productInfoList", mapList(obj.getProductInfoList()));
            jsonObject.put("status", getJSONFromStatus(obj.getStatus()));
        } catch (final JSONException e) {
            Log.e(TAG, e.toString());
        }
        return jsonObject;
    }

    public static JSONObject getJSONFromProductInfo(final ProductInfo obj) {
        final JSONObject jsonObject = new JSONObject();
        try {
            jsonObject.put("productId", obj.getProductId());
            jsonObject.put("priceType", obj.getPriceType());
            jsonObject.put("price", obj.getPrice());
            jsonObject.put("microsPrice", obj.getMicrosPrice());
            jsonObject.put("originalLocalPrice", obj.getOriginalLocalPrice());
            jsonObject.put("originalMicroPrice", obj.getOriginalMicroPrice());
            jsonObject.put("currency", obj.getCurrency());
            jsonObject.put("productName", obj.getProductName());
            jsonObject.put("productDesc", obj.getProductDesc());
            jsonObject.put("subPeriod", obj.getSubPeriod());
            jsonObject.put("subSpecialPrice", obj.getSubSpecialPrice());
            jsonObject.put("subSpecialPriceMicros", obj.getSubSpecialPriceMicros());
            jsonObject.put("subSpecialPeriod", obj.getSubSpecialPeriod());
            jsonObject.put("subSpecialPeriodCycles", obj.getSubSpecialPeriodCycles());
            jsonObject.put("subFreeTrialPeriod", obj.getSubFreeTrialPeriod());
            jsonObject.put("subGroupId", obj.getSubGroupId());
            jsonObject.put("subGroupTitle", obj.getSubGroupTitle());
            jsonObject.put("subProductLevel", obj.getSubProductLevel());
            jsonObject.put("offerUsedStatus", obj.getOfferUsedStatus());
            jsonObject.put("status", obj.getStatus());
        } catch (final JSONException e) {
            Log.e(TAG, e.toString());
        }
        return jsonObject;
    }

    public static JSONObject getJSONFromStatus(final Status obj) {
        final JSONObject jsonObject = new JSONObject();
        try {
            jsonObject.put("statusCode", obj.getStatusCode());
            jsonObject.put("statusMessage", obj.getStatusMessage());
        } catch (final JSONException e) {
            Log.e(TAG, e.toString());
        }
        return jsonObject;
    }
}

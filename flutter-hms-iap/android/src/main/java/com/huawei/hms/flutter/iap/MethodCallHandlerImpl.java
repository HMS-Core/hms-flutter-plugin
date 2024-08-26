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

package com.huawei.hms.flutter.iap;

import android.app.Activity;
import android.content.Intent;
import android.content.IntentSender;
import android.util.Pair;

import androidx.annotation.NonNull;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import com.huawei.hms.flutter.iap.listeners.DefaultFailureListener;
import com.huawei.hms.flutter.iap.listeners.DefaultSuccessListener;
import com.huawei.hms.flutter.iap.listeners.IapActivitySuccessListener;
import com.huawei.hms.flutter.iap.listeners.IsEnvReadyFailureListener;
import com.huawei.hms.flutter.iap.listeners.PurchaseIntentSuccessListener;
import com.huawei.hms.flutter.iap.logger.HMSLogger;
import com.huawei.hms.flutter.iap.utils.Errors;
import com.huawei.hms.flutter.iap.utils.JSONUtils;
import com.huawei.hms.flutter.iap.utils.ValueGetter;
import com.huawei.hms.iap.Iap;
import com.huawei.hms.iap.IapClient;
import com.huawei.hms.iap.entity.ConsumeOwnedPurchaseReq;
import com.huawei.hms.iap.entity.IsSandboxActivatedReq;
import com.huawei.hms.iap.entity.OwnedPurchasesReq;
import com.huawei.hms.iap.entity.ProductInfoReq;
import com.huawei.hms.iap.entity.PurchaseIntentReq;
import com.huawei.hms.iap.entity.PurchaseResultInfo;
import com.huawei.hms.iap.entity.StartIapActivityReq;
import com.huawei.hms.support.api.client.Status;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener;

public class MethodCallHandlerImpl implements MethodCallHandler, ActivityResultListener {
    private static final int REQUEST_CREATE_PURCHASE_INTENT = 111;

    private static final int REQUEST_IS_ENVIRONMENT_READY = 222;

    private final Activity mActivity;

    private final IapClient mIapClient;

    private final Gson mGson;

    private final Map<Integer, Pair<Result, Integer>> mResultsForRequests;

    private final HMSLogger hmsLogger;

    private int mRequestNumber = 0;

    MethodCallHandlerImpl(final Activity activity) {
        mActivity = activity;
        mIapClient = Iap.getIapClient(activity);
        mGson = new GsonBuilder().create();
        mResultsForRequests = new HashMap<>();
        hmsLogger = HMSLogger.getInstance(mActivity.getApplicationContext());
    }

    private void isEnvReady(@NonNull final MethodCall call, @NonNull final Result result) {
        final String isEnvReadyMethodName = "isEnvReady";
        final Boolean isSupportAppTouch = call.argument("isSupportAppTouch") == null
            ? null
            : ValueGetter.getBoolean("isSupportAppTouch", call);
        hmsLogger.startMethodExecutionTimer(isEnvReadyMethodName);
        if (isSupportAppTouch == null) {
            mIapClient.isEnvReady()
                .addOnSuccessListener(new DefaultSuccessListener<>(result, mGson, hmsLogger, isEnvReadyMethodName))
                .addOnFailureListener(
                    new IsEnvReadyFailureListener(this, result, REQUEST_IS_ENVIRONMENT_READY, hmsLogger));
        } else {
            mIapClient.isEnvReady(isSupportAppTouch)
                .addOnSuccessListener(new DefaultSuccessListener<>(result, mGson, hmsLogger, isEnvReadyMethodName))
                .addOnFailureListener(
                    new IsEnvReadyFailureListener(this, result, REQUEST_IS_ENVIRONMENT_READY, hmsLogger));
        }
    }

    private void isSandboxActivated(@NonNull final Result result) {
        final String isSandboxActivatedMethodName = "isSandboxActivated";
        hmsLogger.startMethodExecutionTimer(isSandboxActivatedMethodName);
        mIapClient.isSandboxActivated(new IsSandboxActivatedReq())
            .addOnSuccessListener(new DefaultSuccessListener<>(result, mGson, hmsLogger, isSandboxActivatedMethodName))
            .addOnFailureListener(new DefaultFailureListener(result, Errors.IS_SANDBOX_READY.getErrorCode(), hmsLogger,
                isSandboxActivatedMethodName));
    }

    private void obtainProductInfo(@NonNull final MethodCall call, @NonNull final Result result) {
        // Arguments from call
        final List<String> productIdList = call.argument("skuIds");
        final int priceType = ValueGetter.getInt("priceType", call);
        final String reservedInfor = call.argument("reservedInfor") == null
            ? null
            : ValueGetter.getString("reservedInfor", call);

        // Constructing request
        final ProductInfoReq request = new ProductInfoReq();
        request.setPriceType(priceType);
        request.setProductIds(productIdList);
        request.setReservedInfor(reservedInfor);

        // Obtain product info from IAP service
        final String obtainProductInfoMethodName = "obtainProductInfo";
        hmsLogger.startMethodExecutionTimer(obtainProductInfoMethodName);
        mIapClient.obtainProductInfo(request)
            .addOnSuccessListener(new DefaultSuccessListener<>(result, mGson, hmsLogger, obtainProductInfoMethodName))
            .addOnFailureListener(
                new DefaultFailureListener(result, Errors.OBTAIN_PRODUCT_INFO.getErrorCode(), hmsLogger,
                    obtainProductInfoMethodName));
    }

    private void createPurchaseIntent(@NonNull final MethodCall call, @NonNull final Result result) {
        // Arguments from call
        final String productId = ValueGetter.getString("productId", call);
        final int priceType = ValueGetter.getInt("priceType", call);
        final String developerPayload = call.argument("developerPayload") == null
            ? null
            : ValueGetter.getString("developerPayload", call);
        final String reservedInfor = call.argument("reservedInfor") == null
            ? null
            : ValueGetter.getString("reservedInfor", call);
        final String signatureAlgorithm = call.argument("signatureAlgorithm") == null
            ? null
            : ValueGetter.getString("signatureAlgorithm", call);

        // Constructing request
        final PurchaseIntentReq request = new PurchaseIntentReq();
        request.setProductId(productId);
        request.setPriceType(priceType);
        request.setDeveloperPayload(developerPayload);
        request.setReservedInfor(reservedInfor);
        request.setSignatureAlgorithm(signatureAlgorithm);

        // Create purchase intent from IAP service
        final String createPurchaseIntentMethodName = "createPurchaseIntent";
        hmsLogger.startMethodExecutionTimer(createPurchaseIntentMethodName);
        mIapClient.createPurchaseIntent(request)
            .addOnSuccessListener(
                new PurchaseIntentSuccessListener(this, result, REQUEST_CREATE_PURCHASE_INTENT, hmsLogger))
            .addOnFailureListener(
                new DefaultFailureListener(result, Errors.PURCHASE_INTENT_EXCEPTION.getErrorCode(), hmsLogger,
                    createPurchaseIntentMethodName));
    }

    private void consumeOwnedPurchase(@NonNull final MethodCall call, @NonNull final Result result) {
        // Arguments
        final String purchaseToken = ValueGetter.getString("purchaseToken", call);
        final String developerChallenge = call.argument("developerChallenge") == null
            ? null
            : ValueGetter.getString("developerChallenge", call);
        final String signatureAlgorithm = call.argument("signatureAlgorithm") == null
            ? null
            : ValueGetter.getString("signatureAlgorithm", call);

        final String reservedInfor = call.argument("reservedInfor") == null
            ? null
            : ValueGetter.getString("reservedInfor", call);

        // Constructing request
        final ConsumeOwnedPurchaseReq request = new ConsumeOwnedPurchaseReq();
        request.setDeveloperChallenge(developerChallenge);
        request.setPurchaseToken(purchaseToken);
        request.setSignatureAlgorithm(signatureAlgorithm);
        request.setReservedInfor(reservedInfor);
        // Call service from IAP service`
        final String consumeOwnedPurchaseMethodName = "consumeOwnedPurchase";
        hmsLogger.startMethodExecutionTimer(consumeOwnedPurchaseMethodName);
        mIapClient.consumeOwnedPurchase(request)
            .addOnSuccessListener(
                new DefaultSuccessListener<>(result, mGson, hmsLogger, consumeOwnedPurchaseMethodName))
            .addOnFailureListener(
                new DefaultFailureListener(result, Errors.CONSUME_OWNED_PURCHASE.getErrorCode(), hmsLogger,
                    consumeOwnedPurchaseMethodName));
    }

    private void obtainOwnedPurchaseRecord(@NonNull final MethodCall call, @NonNull final Result result) {
        // Arguments
        final int priceType = ValueGetter.getInt("priceType", call);
        final String signatureAlgorithm = call.argument("signatureAlgorithm") == null
            ? null
            : ValueGetter.getString("signatureAlgorithm", call);
        final String continuationToken = call.argument("continuationToken") == null
            ? null
            : ValueGetter.getString("continuationToken", call);

        final String reservedInfor = call.argument("reservedInfor") == null
            ? null
            : ValueGetter.getString("reservedInfor", call);

        // Constructing request
        final OwnedPurchasesReq request = new OwnedPurchasesReq();
        request.setContinuationToken(continuationToken);
        request.setPriceType(priceType);
        request.setSignatureAlgorithm(signatureAlgorithm);
        request.setReservedInfor(reservedInfor);

        // Obtain record from IAP service
        final String obtainOwnedPurchaseRecordMethodName = "obtainOwnedPurchaseRecord";
        hmsLogger.startMethodExecutionTimer(obtainOwnedPurchaseRecordMethodName);
        mIapClient.obtainOwnedPurchaseRecord(request)
            .addOnSuccessListener(
                new DefaultSuccessListener<>(result, mGson, hmsLogger, obtainOwnedPurchaseRecordMethodName))
            .addOnFailureListener(
                new DefaultFailureListener(result, Errors.OBTAIN_OWNED_PURCHASES.getErrorCode(), hmsLogger,
                    obtainOwnedPurchaseRecordMethodName));
    }

    private void obtainOwnedPurchases(@NonNull final MethodCall call, @NonNull final Result result) {
        // Arguments
        final int priceType = ValueGetter.getInt("priceType", call);
        final String continuationToken = call.argument("continuationToken") == null
            ? null
            : ValueGetter.getString("continuationToken", call);
        final String signatureAlgorithm = call.argument("signatureAlgorithm") == null
            ? null
            : ValueGetter.getString("signatureAlgorithm", call);

        final String reservedInfor = call.argument("reservedInfor") == null
            ? null
            : ValueGetter.getString("reservedInfor", call);

        // Constructing request
        final OwnedPurchasesReq request = new OwnedPurchasesReq();
        request.setContinuationToken(continuationToken);
        request.setPriceType(priceType);
        request.setSignatureAlgorithm(signatureAlgorithm);
        request.setReservedInfor(reservedInfor);

        // Obtain owned purchase from IAP service
        final String obtainOwnedPurchasesMethodName = "obtainOwnedPurchases";
        hmsLogger.startMethodExecutionTimer(obtainOwnedPurchasesMethodName);
        mIapClient.obtainOwnedPurchases(request)
            .addOnSuccessListener(
                new DefaultSuccessListener<>(result, mGson, hmsLogger, obtainOwnedPurchasesMethodName))
            .addOnFailureListener(
                new DefaultFailureListener(result, Errors.OBTAIN_OWNED_PURCHASES.getErrorCode(), hmsLogger,
                    obtainOwnedPurchasesMethodName));
    }

    private void enablePendingPurchase(@NonNull final Result result) {
        hmsLogger.startMethodExecutionTimer("enablePendingPurchase");
        mIapClient.enablePendingPurchase();
        result.success("RESULT_SUCCESS");
    }

    private void startIapActivity(@NonNull final MethodCall call, final Result result) {
        // Arguments
        final int type = ValueGetter.getInt("type", call);
        final String productId = call.argument("productId") == null ? null : ValueGetter.getString("productId", call);

        // Constructing request
        final StartIapActivityReq request = new StartIapActivityReq();
        request.setType(type);
        request.setSubscribeProductId(productId);

        // Start activity using IAP service
        final String startIapActivityMethodName = "startIapActivity";
        hmsLogger.startMethodExecutionTimer(startIapActivityMethodName);
        mIapClient.startIapActivity(request)
            .addOnSuccessListener(new IapActivitySuccessListener(mActivity, hmsLogger))
            .addOnFailureListener(
                new DefaultFailureListener(result, Errors.START_IAP_ACTIVITY.getErrorCode(), hmsLogger,
                    startIapActivityMethodName));
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        switch (call.method) {
            case "isEnvReady":
                isEnvReady(call, result);
                break;
            case "isSandboxActivated":
                isSandboxActivated(result);
                break;
            case "obtainProductInfo":
                obtainProductInfo(call, result);
                break;
            case "createPurchaseIntent":
                createPurchaseIntent(call, result);
                break;
            case "consumeOwnedPurchase":
                consumeOwnedPurchase(call, result);
                break;
            case "obtainOwnedPurchaseRecord":
                obtainOwnedPurchaseRecord(call, result);
                break;
            case "obtainOwnedPurchases":
                obtainOwnedPurchases(call, result);
                break;
            case "startIapActivity":
                startIapActivity(call, result);
                break;
            case "disableLogger":
                hmsLogger.disableLogger();
                break;
            case "enableLogger":
                hmsLogger.enableLogger();
                break;
            case "enablePendingPurchase":
                enablePendingPurchase(result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    public synchronized void handleResolution(final Status status, final Result result, final Integer requestType) {
        final String handleResolutionMethodName = "handleResolution";
        mRequestNumber++;
        mResultsForRequests.put(mRequestNumber, Pair.create(result, requestType));
        hmsLogger.startMethodExecutionTimer(handleResolutionMethodName);
        try {
            status.startResolutionForResult(mActivity, mRequestNumber);
            hmsLogger.sendSingleEvent(handleResolutionMethodName);
        } catch (final IntentSender.SendIntentException exp) {
            mResultsForRequests.remove(mRequestNumber);
            hmsLogger.sendSingleEvent(handleResolutionMethodName, Errors.PURCHASE_INTENT_RESOLUTION.getErrorCode());
            result.error(Errors.PURCHASE_INTENT_RESOLUTION.getErrorCode(), exp.getMessage(), null);
        }
    }

    @Override
    public boolean onActivityResult(final int requestCode, final int resultCode, final Intent data) {
        final Pair<Result, Integer> pair = mResultsForRequests.get(requestCode);
        if (pair == null) {
            return false;
        }

        final Result result = pair.first;
        final int requestType = pair.second;

        if (result != null) {
            if (resultCode == Activity.RESULT_OK) {
                switch (requestType) {
                    case REQUEST_CREATE_PURCHASE_INTENT:
                        hmsLogger.startMethodExecutionTimer("parsePurchaseResultInfoFromIntent");
                        final PurchaseResultInfo purchaseResultInfo = mIapClient.parsePurchaseResultInfoFromIntent(
                            data);
                        hmsLogger.sendSingleEvent("parsePurchaseResultInfoFromIntent");
                        result.success(JSONUtils.getJSONFromPurchaseResultInfo(purchaseResultInfo).toString());
                        break;
                    case REQUEST_IS_ENVIRONMENT_READY:
                        final int returnCode = data.getIntExtra("returnCode", 1);
                        if (returnCode != 0) {
                            result.error(Errors.LOG_IN.getErrorCode(), Errors.LOG_IN.getErrorMessage(), null);
                            break;
                        }
                        result.success("LOGGED_IN");
                        break;
                    default:
                        result.error(Errors.UNKNOWN_REQUEST_CODE.getErrorCode(),
                            Errors.UNKNOWN_REQUEST_CODE.getErrorMessage(), null);
                        break;
                }
            } else {
                result.error(Errors.ACTIVITY_RESULT.getErrorCode(), Errors.ACTIVITY_RESULT.getErrorMessage(), null);
            }
        }
        return true;
    }
}

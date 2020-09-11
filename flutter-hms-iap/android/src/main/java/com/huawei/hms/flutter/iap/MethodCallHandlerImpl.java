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

package com.huawei.hms.flutter.iap;

import android.app.Activity;
import android.content.Intent;
import android.content.IntentSender;
import android.util.Pair;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.iap.listeners.DefaultFailureListener;
import com.huawei.hms.flutter.iap.listeners.DefaultSuccessListener;
import com.huawei.hms.flutter.iap.listeners.IapActivitySuccessListener;
import com.huawei.hms.flutter.iap.listeners.IsEnvReadyFailureListener;
import com.huawei.hms.flutter.iap.listeners.PurchaseIntentSuccessListener;
import com.huawei.hms.flutter.iap.utils.Errors;
import com.huawei.hms.flutter.iap.utils.ValueGetter;
import com.huawei.hms.iap.Iap;
import com.huawei.hms.iap.IapClient;
import com.huawei.hms.iap.entity.ConsumeOwnedPurchaseReq;
import com.huawei.hms.iap.entity.ConsumeOwnedPurchaseResult;
import com.huawei.hms.iap.entity.IsEnvReadyResult;
import com.huawei.hms.iap.entity.IsSandboxActivatedReq;
import com.huawei.hms.iap.entity.IsSandboxActivatedResult;
import com.huawei.hms.iap.entity.OwnedPurchasesReq;
import com.huawei.hms.iap.entity.OwnedPurchasesResult;
import com.huawei.hms.iap.entity.ProductInfoReq;
import com.huawei.hms.iap.entity.ProductInfoResult;
import com.huawei.hms.iap.entity.PurchaseIntentReq;
import com.huawei.hms.iap.entity.PurchaseResultInfo;
import com.huawei.hms.iap.entity.StartIapActivityReq;
import com.huawei.hms.support.api.client.Status;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

public class MethodCallHandlerImpl implements MethodCallHandler, ActivityResultListener {
    private static final int REQUEST_CREATE_PURCHASE_INTENT = 111;
    private static final int REQUEST_IS_ENVIRONMENT_READY = 222;
    private final Activity mActivity;
    private final IapClient mIapClient;
    private final Gson mGson;
    private int mRequestNumber = 0;
    private Map<Integer, Pair<Result, Integer>> mResultsForRequests;

    MethodCallHandlerImpl(Activity activity) {
        mActivity = activity;
        mIapClient = Iap.getIapClient(activity);
        mGson = new GsonBuilder().setPrettyPrinting().create();
        mResultsForRequests = new HashMap<>();
    }

    private void isEnvReady(@NonNull Result result) {
        mIapClient.isEnvReady()
            .addOnSuccessListener(new DefaultSuccessListener<IsEnvReadyResult>(result, mGson))
            .addOnFailureListener(new IsEnvReadyFailureListener(this, result, REQUEST_IS_ENVIRONMENT_READY));
    }

    private void isSandboxActivated(@NonNull Result result) {
        mIapClient.isSandboxActivated(new IsSandboxActivatedReq())
            .addOnSuccessListener(new DefaultSuccessListener<IsSandboxActivatedResult>(result, mGson))
            .addOnFailureListener(new DefaultFailureListener(result, Errors.isSandbocReady.getErrorCode()));
    }

    private void obtainProductInfo(@NonNull MethodCall call, @NonNull Result result) {
        //Arguments from call
        final List<String> productIdList = call.argument("skuIds");
        final int priceType = ValueGetter.getInt("priceType", call);

        //Constructing request
        final ProductInfoReq request = new ProductInfoReq();
        request.setPriceType(priceType);
        request.setProductIds(productIdList);

        //Obtain product info from IAP service
        mIapClient.obtainProductInfo(request)
            .addOnSuccessListener(new DefaultSuccessListener<ProductInfoResult>(result, mGson))
            .addOnFailureListener(new DefaultFailureListener(result, Errors.obtainProductInfo.getErrorCode()));
    }

    private void createPurchaseIntent(@NonNull MethodCall call, @NonNull Result result) {
        //Arguments from call
        final String productId = call.argument("productId");
        final int priceType = ValueGetter.getInt("priceType", call);
        final String developerPayload = call.argument("developerPayload");

        //Constructing request
        final PurchaseIntentReq request = new PurchaseIntentReq();
        request.setProductId(productId);
        request.setPriceType(priceType);
        request.setDeveloperPayload(developerPayload);

        //Create purchase intent from IAP service
        mIapClient.createPurchaseIntent(request)
            .addOnSuccessListener(new PurchaseIntentSuccessListener(this, result, REQUEST_CREATE_PURCHASE_INTENT))
            .addOnFailureListener(new DefaultFailureListener(result, Errors.purchaseIntentException.getErrorCode()));
    }

    private void consumeOwnedPurchase(@NonNull MethodCall call, @NonNull Result result) {
        //Arguments
        final String purchaseToken = call.argument("purchaseToken");
        final String developerChallenge = call.argument("developerChallenge");

        //Constructing request
        final ConsumeOwnedPurchaseReq request = new ConsumeOwnedPurchaseReq();
        request.setDeveloperChallenge(developerChallenge);
        request.setPurchaseToken(purchaseToken);

        // Call service from IAP service
        mIapClient.consumeOwnedPurchase(request)
            .addOnSuccessListener(new DefaultSuccessListener<ConsumeOwnedPurchaseResult>(result, mGson))
            .addOnFailureListener(new DefaultFailureListener(result, Errors.consumeOwnedPurchase.getErrorCode()));
    }

    private void obtainOwnedPurchaseRecord(@NonNull MethodCall call, @NonNull Result result) {
        //Arguments
        final int priceType = ValueGetter.getInt("priceType", call);
        final String continuationToken = call.argument("continuationToken");

        //Constructing request
        final OwnedPurchasesReq request = new OwnedPurchasesReq();
        request.setContinuationToken(continuationToken);
        request.setPriceType(priceType);

        //Obtain record from IAP service
        mIapClient.obtainOwnedPurchaseRecord(request)
            .addOnSuccessListener(new DefaultSuccessListener<OwnedPurchasesResult>(result, mGson))
            .addOnFailureListener(new DefaultFailureListener(result, Errors.obtainOwnedPurchases.getErrorCode()));
    }

    private void obtainOwnedPurchases(@NonNull MethodCall call, @NonNull Result result) {
        //Arguments
        final int priceType = ValueGetter.getInt("priceType", call);
        final String continuationToken = call.argument("continuationToken");

        //Constructing request
        final OwnedPurchasesReq request = new OwnedPurchasesReq();
        request.setContinuationToken(continuationToken);
        request.setPriceType(priceType);

        //Obtain owned purchase from IAP service
        mIapClient.obtainOwnedPurchases(request)
            .addOnSuccessListener(new DefaultSuccessListener<OwnedPurchasesResult>(result, mGson))
            .addOnFailureListener(new DefaultFailureListener(result, Errors.obtainOwnedPurchases.getErrorCode()));
    }

    private void startIapActivity(@NonNull MethodCall call, Result result) {
        //Arguments
        final int type = ValueGetter.getInt("type", call);
        final String productId = call.argument("productId");

        //Constructing request
        final StartIapActivityReq request = new StartIapActivityReq();
        request.setType(type);
        request.setSubscribeProductId(productId);

        //start activity using IAP service
        mIapClient.startIapActivity(request)
            .addOnSuccessListener(new IapActivitySuccessListener(mActivity))
            .addOnFailureListener(new DefaultFailureListener(result, Errors.startIapActivity.getErrorCode()));
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "isEnvReady":
                isEnvReady(result);
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
            default:
                result.notImplemented();
                break;
        }
    }

    public synchronized void handleResolution(Status status, Result result, Integer requestType) {
        mRequestNumber++;
        mResultsForRequests.put(mRequestNumber, Pair.create(result, requestType));
        try {
            status.startResolutionForResult(mActivity, mRequestNumber);
        } catch (IntentSender.SendIntentException exp) {
            mResultsForRequests.remove(mRequestNumber);
            result.error(Errors.purchaseIntentResolution.getErrorCode(), exp.getMessage(), null);
        }
    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        if( !mResultsForRequests.containsKey(requestCode) && !mResultsForRequests.containsKey(requestCode)){
            return  true;
        }
        final Result result = Objects.requireNonNull(mResultsForRequests.get(requestCode)).first;
        final int requestType = Objects.requireNonNull(mResultsForRequests.get(requestCode)).second;

        if (result != null) {
            if (resultCode == Activity.RESULT_OK) {
                switch (requestType) {
                    case REQUEST_CREATE_PURCHASE_INTENT:
                        final PurchaseResultInfo purchaseResultInfo = mIapClient.parsePurchaseResultInfoFromIntent(
                            data);
                        result.success(mGson.toJson(purchaseResultInfo));
                        break;
                    case REQUEST_IS_ENVIRONMENT_READY:
                        final int returnCode = data.getIntExtra("returnCode", 1);
                        if (returnCode != 0) {
                            result.error(Errors.logIn.getErrorCode(), Errors.logIn.getErrorMessage(), null);
                        }
                        break;
                    default:
                        result.error(Errors.unkownRequestCode.getErrorCode(),
                            Errors.unkownRequestCode.getErrorMessage(), null);
                        break;
                }
            } else {
                result.error(Errors.activityResult.getErrorCode(), Errors.activityResult.getErrorMessage(), null);
            }
        }
        return true;
    }
}

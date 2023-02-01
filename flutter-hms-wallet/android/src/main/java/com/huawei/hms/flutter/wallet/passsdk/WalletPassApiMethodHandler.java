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

package com.huawei.hms.flutter.wallet.passsdk;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.wallet.logger.HMSLogger;
import com.huawei.hms.flutter.wallet.utils.FromMap;
import com.huawei.hms.flutter.wallet.utils.WalletUtils;
import com.huawei.hms.flutter.wallet.utils.constants.Constants;
import com.huawei.wallet.hmspass.service.IpassModifyNFCCardImpl;
import com.huawei.wallet.hmspass.service.WalletPassApiResponse;
import com.hw.passsdk.WalletPassApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class WalletPassApiMethodHandler implements MethodChannel.MethodCallHandler {
    private final Context context;
    private final WalletPassApi walletPassApi;

    public WalletPassApiMethodHandler(Context context) {
        this.context = context;
        walletPassApi = new WalletPassApi(context);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull final MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer(call.method);
        final String passTypeId = FromMap.toString("passTypeId", call.argument("passTypeId"), false);
        final String passId = FromMap.toString("passId", call.argument("passId"), false);
        switch (call.method) {
            case "canAddPass": {
                final String appId = FromMap.toString("appid", call.argument("appid"), false);
                if (appId == null || passTypeId == null) {
                    result.error(String.valueOf(Constants.MISSING_PARAM), Constants.MISSING_PARAM_DESC, "");
                    HMSLogger.getInstance(context).sendSingleEvent(call.method, String.valueOf(Constants.MISSING_PARAM));
                    return;
                }
                canAddPass(result, appId, passTypeId);
                break;
            }
            case "addPass":
                final String hwPassData = FromMap.toString("hwPassData", call.argument("hwPassData"), false);
                if (hwPassData == null) {
                    result.error(String.valueOf(Constants.MISSING_PARAM), Constants.MISSING_PARAM_DESC, "");
                    HMSLogger.getInstance(context).sendSingleEvent(call.method, String.valueOf(Constants.MISSING_PARAM));
                    return;
                }
                addPass(result, hwPassData);
                break;
            case "requireAccessToken": {
                if (passTypeId == null) {
                    result.error(String.valueOf(Constants.MISSING_PARAM), Constants.MISSING_PARAM_DESC, "");
                    HMSLogger.getInstance(context).sendSingleEvent(call.method, String.valueOf(Constants.MISSING_PARAM));
                    return;
                }
                requireAccessToken(result, passTypeId);
                break;
            }
            case "requireAccessCardSec": {
                final String sign = FromMap.toString("sign", call.argument("sign"), false);
                if (passId == null || passTypeId == null || sign == null) {
                    result.error(String.valueOf(Constants.MISSING_PARAM), Constants.MISSING_PARAM_DESC, "");
                    HMSLogger.getInstance(context).sendSingleEvent(call.method, String.valueOf(Constants.MISSING_PARAM));
                    return;
                }
                requireAccessCardSec(result, passTypeId, passId, sign);
                break;
            }
            case "modifyNFCCard": {
                final String cardParams = FromMap.toString("cardParams", call.argument("cardParams"), false);
                final String reason = FromMap.toString("reason", call.argument("reason"), false);
                final String sign = FromMap.toString("sign", call.argument("sign"), false);

                final boolean c1 = passId == null || passTypeId == null;
                final boolean c2 = sign == null || reason == null || cardParams == null;
                if (c1 || c2) {
                    result.error(String.valueOf(Constants.MISSING_PARAM), Constants.MISSING_PARAM_DESC, "");
                    HMSLogger.getInstance(context).sendSingleEvent(call.method, String.valueOf(Constants.MISSING_PARAM));
                    return;
                }
                modifyNFCCard(result, passTypeId, passId, cardParams, reason, sign);
                break;
            }
            case "readNFCCard": {
                final String cardParams = FromMap.toString("cardParams", call.argument("cardParams"), false);
                final String reason = FromMap.toString("reason", call.argument("reason"), false);
                final String sign = FromMap.toString("sign", call.argument("sign"), false);

                final boolean c3 = passId == null || passTypeId == null;
                final boolean c4 = sign == null || reason == null || cardParams == null;
                if (c3 || c4) {
                    result.error(String.valueOf(Constants.MISSING_PARAM), Constants.MISSING_PARAM_DESC, "");
                    HMSLogger.getInstance(context).sendSingleEvent(call.method, String.valueOf(Constants.MISSING_PARAM));
                    return;
                }
                readNFCCard(result, passTypeId, passId, cardParams, reason, sign);
                break;
            }
            case "deletePass": {
                final String sign = FromMap.toString("sign", call.argument("sign"), false);
                if (passId == null || passTypeId == null || sign == null) {
                    result.error(String.valueOf(Constants.MISSING_PARAM), Constants.MISSING_PARAM_DESC, "");
                    HMSLogger.getInstance(context).sendSingleEvent(call.method, String.valueOf(Constants.MISSING_PARAM));
                    return;
                }
                deletePass(result, passTypeId, passId, sign);
                break;
            }
            case "queryPassStatus": {
                if (passId == null || passTypeId == null) {
                    result.error(String.valueOf(Constants.MISSING_PARAM), Constants.MISSING_PARAM_DESC, "");
                    HMSLogger.getInstance(context).sendSingleEvent(call.method, String.valueOf(Constants.MISSING_PARAM));
                    return;
                }
                queryPassStatus(result, passTypeId, passId);
                break;
            }
            case "requirePassDeviceId": {
                if (passTypeId == null) {
                    result.error(String.valueOf(Constants.MISSING_PARAM), Constants.MISSING_PARAM_DESC, "");
                    HMSLogger.getInstance(context).sendSingleEvent(call.method, String.valueOf(Constants.MISSING_PARAM));
                    return;
                }
                requirePassDeviceId(result, passTypeId);
                break;
            }
            case "queryPass":
                final String requestBody = FromMap.toString("requestBody", call.argument("requestBody"), false);
                if (requestBody == null) {
                    result.error(String.valueOf(Constants.MISSING_PARAM), Constants.MISSING_PARAM_DESC, "");
                    HMSLogger.getInstance(context).sendSingleEvent(call.method, String.valueOf(Constants.MISSING_PARAM));
                    return;
                }
                queryPass(result, requestBody);
                break;
            case "requestRegister":
                final String registerRequestBody = FromMap.toString("registerRequestBody", call.argument("registerRequestBody"), false);
                if (registerRequestBody == null) {
                    result.error(String.valueOf(Constants.MISSING_PARAM), Constants.MISSING_PARAM_DESC, "");
                    HMSLogger.getInstance(context).sendSingleEvent(call.method, String.valueOf(Constants.MISSING_PARAM));
                    return;
                }
                requestRegister(result, registerRequestBody);
                break;
            case "confirmRegister":
                final String registerConfirmBody = FromMap.toString("registerConfirmBody", call.argument("registerConfirmBody"), false);
                if (registerConfirmBody == null) {
                    result.error(String.valueOf(Constants.MISSING_PARAM), Constants.MISSING_PARAM_DESC, "");
                    HMSLogger.getInstance(context).sendSingleEvent(call.method, String.valueOf(Constants.MISSING_PARAM));
                    return;
                }
                confirmRegister(result, registerConfirmBody);
                break;
            case "requestPersonalize":
                final String personalizeRequestBody = FromMap.toString("personalizeRequestBody", call.argument("personalizeRequestBody"), false);
                if (personalizeRequestBody == null) {
                    result.error(String.valueOf(Constants.MISSING_PARAM), Constants.MISSING_PARAM_DESC, "");
                    HMSLogger.getInstance(context).sendSingleEvent(call.method, String.valueOf(Constants.MISSING_PARAM));
                    return;
                }
                requestPersonalize(result, personalizeRequestBody);
                break;
            case "confirmPersonalize":
                final String personalizeConfirmBody = FromMap.toString("personalizeConfirmBody", call.argument("personalizeConfirmBody"), false);
                if (personalizeConfirmBody == null) {
                    result.error(String.valueOf(Constants.MISSING_PARAM), Constants.MISSING_PARAM_DESC, "");
                    HMSLogger.getInstance(context).sendSingleEvent(call.method, String.valueOf(Constants.MISSING_PARAM));
                    return;
                }
                confirmPersonalize(result, personalizeConfirmBody);
                break;
            case "requestTransaction":
                final String requestTransBody = FromMap.toString("requestTransBody", call.argument("requestTransBody"), false);
                if (requestTransBody == null) {
                    result.error(String.valueOf(Constants.MISSING_PARAM), Constants.MISSING_PARAM_DESC, "");
                    HMSLogger.getInstance(context).sendSingleEvent(call.method, String.valueOf(Constants.MISSING_PARAM));
                    return;
                }
                requestTransaction(result, requestTransBody);
                break;
            case "confirmTransaction":
                final String confirmTransBody = FromMap.toString("confirmTransBody", call.argument("confirmTransBody"), false);
                if (confirmTransBody == null) {
                    result.error(String.valueOf(Constants.MISSING_PARAM), Constants.MISSING_PARAM_DESC, "");
                    HMSLogger.getInstance(context).sendSingleEvent(call.method, String.valueOf(Constants.MISSING_PARAM));
                    return;
                }
                confirmTransaction(result, confirmTransBody);
                break;
            default:
                result.notImplemented();
                HMSLogger.getInstance(context).sendSingleEvent(call.method, String.valueOf(Constants.MISSING_PARAM));
                break;
        }
    }

    private void canAddPass(final MethodChannel.Result result, final String appId, final String passTypeId) {
        new Thread(() -> {
            final WalletPassApiResponse response = walletPassApi.canAddPass(appId, passTypeId);
            new Handler(Looper.getMainLooper()).post(() -> {
                result.success(WalletUtils.walletPassApiResponseToMap(response));
                HMSLogger.getInstance(context).sendSingleEvent("canAddPass");
            });
        }).start();
    }

    private void addPass(final MethodChannel.Result result, final String hwPassData) {
        new Thread(() -> {
            final WalletPassApiResponse response = walletPassApi.addPass(hwPassData);
            new Handler(Looper.getMainLooper()).post(() -> {
                result.success(WalletUtils.walletPassApiResponseToMap(response));
                HMSLogger.getInstance(context).sendSingleEvent("addPass");
            });
        }).start();
    }

    private void requireAccessToken(final MethodChannel.Result result, final String passTypeId) {
        new Thread(() -> {
            final WalletPassApiResponse response = walletPassApi.requireAccessToken(passTypeId);
            new Handler(Looper.getMainLooper()).post(() -> {
                result.success(WalletUtils.walletPassApiResponseToMap(response));
                HMSLogger.getInstance(context).sendSingleEvent("requireAccessToken");
            });
        }).start();
    }

    private void requireAccessCardSec(final MethodChannel.Result result, final String passTypeId, final String passId, final String sign) {
        new Thread(() -> {
            final WalletPassApiResponse response = walletPassApi.requireAccessCardSec(passTypeId, passId, sign);
            new Handler(Looper.getMainLooper()).post(() -> {
                result.success(WalletUtils.walletPassApiResponseToMap(response));
                HMSLogger.getInstance(context).sendSingleEvent("requireAccessCardSec");
            });
        }).start();
    }

    private void modifyNFCCard(final MethodChannel.Result result, final String passTypeId, final String passId, final String cardParams, final String reason, final String sign) {
        new Thread(() -> {
            IpassModifyNFCCardImpl mIpassModifyNFCCardImpl = new IpassModifyNFCCardImpl.Stub() {
                @Override
                public void modifyCallBack(final WalletPassApiResponse walletPassApiResponse) {
                    new Handler(Looper.getMainLooper()).post(() -> {
                        result.success(WalletUtils.walletPassApiResponseToMap(walletPassApiResponse));
                        HMSLogger.getInstance(context).sendSingleEvent("modifyNFCCard");
                    });
                }
            };
            walletPassApi.modifyNFCCard(passTypeId, passId, cardParams, reason, sign, mIpassModifyNFCCardImpl);
        }).start();
    }

    private void readNFCCard(final MethodChannel.Result result, final String passTypeId, final String passId, final String cardParams, final String reason, final String sign) {
        new Thread(() -> {
            final WalletPassApiResponse response = walletPassApi.readNFCCard(passTypeId, passId, cardParams, reason, sign);
            new Handler(Looper.getMainLooper()).post(() -> {
                result.success(WalletUtils.walletPassApiResponseToMap(response));
                HMSLogger.getInstance(context).sendSingleEvent("readNFCCard");
            });
        }).start();
    }

    private void deletePass(final MethodChannel.Result result, final String passTypeId, final String passId, final String sign) {
        new Thread(() -> {
            final WalletPassApiResponse response = walletPassApi.deletePass(passTypeId, passId, sign);
            new Handler(Looper.getMainLooper()).post(() -> {
                result.success(WalletUtils.walletPassApiResponseToMap(response));
                HMSLogger.getInstance(context).sendSingleEvent("deletePass");
            });
        }).start();
    }

    private void queryPassStatus(final MethodChannel.Result result, final String passTypeId, final String passId) {
        new Thread(() -> {
            final WalletPassApiResponse response = walletPassApi.queryPassStatus(passTypeId, passId);
            new Handler(Looper.getMainLooper()).post(() -> {
                result.success(WalletUtils.walletPassApiResponseToMap(response));
                HMSLogger.getInstance(context).sendSingleEvent("queryPassStatus");
            });
        }).start();
    }

    private void requirePassDeviceId(final MethodChannel.Result result, final String passTypeId) {
        new Thread(() -> {
            final WalletPassApiResponse response = walletPassApi.requirePassDeviceId(passTypeId);
            new Handler(Looper.getMainLooper()).post(() -> {
                result.success(WalletUtils.walletPassApiResponseToMap(response));
                HMSLogger.getInstance(context).sendSingleEvent("requirePassDeviceId");
            });
        }).start();
    }


    private void queryPass(final MethodChannel.Result result, final String requestBody) {
        new Thread(() -> {
            final WalletPassApiResponse response = walletPassApi.queryPass(requestBody);
            new Handler(Looper.getMainLooper()).post(() -> {
                result.success(WalletUtils.walletPassApiResponseToMap(response));
                HMSLogger.getInstance(context).sendSingleEvent("queryPass");
            });
        }).start();
    }

    private void requestRegister(final MethodChannel.Result result, final String registerRequestBody) {
        new Thread(() -> {
            final WalletPassApiResponse response = walletPassApi.requestRegister(registerRequestBody);
            new Handler(Looper.getMainLooper()).post(() -> {
                result.success(WalletUtils.walletPassApiResponseToMap(response));
                HMSLogger.getInstance(context).sendSingleEvent("requestRegister");
            });
        }).start();
    }

    private void confirmRegister(final MethodChannel.Result result, final String registerConfirmBody) {
        new Thread(() -> {
            final WalletPassApiResponse response = walletPassApi.confirmRegister(registerConfirmBody);
            new Handler(Looper.getMainLooper()).post(() -> {
                result.success(WalletUtils.walletPassApiResponseToMap(response));
                HMSLogger.getInstance(context).sendSingleEvent("confirmRegister");
            });
        }).start();
    }

    private void requestPersonalize(final MethodChannel.Result result, final String personalizeRequestBody) {
        new Thread(() -> {
            final WalletPassApiResponse response = walletPassApi.requestPersonalize(personalizeRequestBody);
            new Handler(Looper.getMainLooper()).post(() -> {
                result.success(WalletUtils.walletPassApiResponseToMap(response));
                HMSLogger.getInstance(context).sendSingleEvent("requestPersonalize");
            });
        }).start();
    }

    private void confirmPersonalize(final MethodChannel.Result result, final String personalizeConfirmBody) {
        new Thread(() -> {
            final WalletPassApiResponse response = walletPassApi.confirmPersonalize(personalizeConfirmBody);
            new Handler(Looper.getMainLooper()).post(() -> {
                result.success(WalletUtils.walletPassApiResponseToMap(response));
                HMSLogger.getInstance(context).sendSingleEvent("confirmPersonalize");
            });
        }).start();
    }

    private void requestTransaction(final MethodChannel.Result result, final String requestTransBody) {
        new Thread(() -> {
            final WalletPassApiResponse response = walletPassApi.requestTransaction(requestTransBody);
            new Handler(Looper.getMainLooper()).post(() -> {
                result.success(WalletUtils.walletPassApiResponseToMap(response));
                HMSLogger.getInstance(context).sendSingleEvent("requestTransaction");
            });
        }).start();
    }

    private void confirmTransaction(final MethodChannel.Result result, final String confirmTransBody) {
        new Thread(() -> {
            final WalletPassApiResponse response = walletPassApi.confirmTransaction(confirmTransBody);
            new Handler(Looper.getMainLooper()).post(() -> {
                result.success(WalletUtils.walletPassApiResponseToMap(response));
                HMSLogger.getInstance(context).sendSingleEvent("confirmTransaction");
            });
        }).start();
    }
}

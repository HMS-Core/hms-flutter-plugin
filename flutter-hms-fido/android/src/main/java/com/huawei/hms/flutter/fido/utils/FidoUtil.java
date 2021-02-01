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

package com.huawei.hms.flutter.fido.utils;

import android.util.Log;

import com.huawei.hms.support.api.fido.fido2.Algorithm;
import com.huawei.hms.support.api.fido.fido2.Attachment;
import com.huawei.hms.support.api.fido.fido2.AttestationConveyancePreference;
import com.huawei.hms.support.api.fido.fido2.AuthenticatorTransport;
import com.huawei.hms.support.api.fido.fido2.OriginFormat;
import com.huawei.hms.support.api.fido.fido2.TokenBindingStatus;
import com.huawei.hms.support.api.fido.fido2.UserVerificationRequirement;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FidoUtil {
    private static final String TAG = FidoUtil.class.getSimpleName();

    public static Algorithm getAlgorithm(String s) {
        if (s == null) return null;

        switch (s) {
            case "ES256":
                return Algorithm.ES256;
            case "ES384":
                return Algorithm.ES384;
            case "ES512":
                return Algorithm.ES512;
            case "RS256":
                return Algorithm.RS256;
            case "RS384":
                return Algorithm.RS384;
            case "RS512":
                return Algorithm.RS512;
            case "PS256":
                return Algorithm.PS256;
            case "PS384":
                return Algorithm.PS384;
            case "PS512":
                return Algorithm.PS512;
            case "ECDH":
                return Algorithm.ECDH;
            default:
                return null;
        }
    }

    public static Attachment getAttachment(String s) {
        if (s == null) return null;

        switch (s) {
            case "PLATFORM":
                return Attachment.PLATFORM;
            case "CROSS_PLATFORM":
                return Attachment.CROSS_PLATFORM;
            default:
                return null;
        }
    }

    public static UserVerificationRequirement getVerificationRequirement(String s) {
        if (s == null) return null;

        switch (s) {
            case "PREFERRED":
                return UserVerificationRequirement.PREFERRED;
            case "REQUIRED":
                return UserVerificationRequirement.REQUIRED;
            case "DISCOURAGED":
                return UserVerificationRequirement.DISCOURAGED;
            default:
                return null;
        }
    }

    public static AttestationConveyancePreference getAttestation(String s) {
        if (s == null) return null;

        switch (s) {
            case "DIRECT":
                return AttestationConveyancePreference.DIRECT;
            case "INDIRECT":
                return AttestationConveyancePreference.INDIRECT;
            case "NONE":
                return AttestationConveyancePreference.NONE;
            default:
                return null;
        }
    }

    public static OriginFormat getOriginFormat(String s) {
        if (s == null) return null;

        switch (s) {
            case "HTML":
                return OriginFormat.HTML;
            case "ANDROID":
                return OriginFormat.ANDROID;
            default:
                return null;
        }
    }

    public static TokenBindingStatus getTokenStatus(String s) {
        if (s == null) return null;

        switch (s) {
            case "SUPPORTED":
                return TokenBindingStatus.SUPPORTED;
            case "PRESENT":
                return TokenBindingStatus.PRESENT;
            default:
                return null;
        }
    }

    public static AuthenticatorTransport getTransport(String s) {
        if (s == null) return null;

        switch (s) {
            case "NFC":
                return AuthenticatorTransport.NFC;
            case "BLE":
                return AuthenticatorTransport.BLE;
            case "USB":
                return AuthenticatorTransport.USB;
            default:
                return null;
        }
    }

    public static Map<String, Object> fromObject(Object args) {
        Map<String, Object> resMap = new HashMap<>();
        if (args instanceof Map) {
            for (Object entry : ((Map) args).entrySet()) {
                if (entry instanceof Map.Entry) {
                    resMap.put(((Map.Entry) entry).getKey().toString(), ((Map.Entry) entry).getValue());
                }
            }
        }
        return resMap;
    }

    public static List<?> listFromObject(Object args) {
        List<?> list = new ArrayList<>();
        if (args.getClass().isArray()) {
            list = Arrays.asList((Object[]) args);
        } else if (args instanceof Collection) {
            list = new ArrayList<>((Collection<?>) args);
        } else {
            Log.i(TAG, "Object is not list or collection");
        }
        return list;
    }

    public static List<String> stringCollToList(Collection<String> collection) {
        return new ArrayList<>(collection);
    }

}

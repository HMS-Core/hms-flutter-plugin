/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

import androidx.annotation.NonNull;

import com.huawei.hms.support.api.fido.bioauthn.BioAuthnResult;
import com.huawei.hms.support.api.fido.bioauthn.CryptoObject;

import java.io.IOException;
import java.security.AlgorithmParameters;
import java.security.Provider;
import java.security.Signature;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.Cipher;
import javax.crypto.Mac;

public class BioAuthBuilder {
    private static final String TAG = BioAuthBuilder.class.getSimpleName();
    
    public static Map<String, Object> bioAuthnResultToMap(@NonNull BioAuthnResult bioAuthnResult) {
        Map<String, Object> map = new HashMap<>();
        CryptoObject cryptoObject = bioAuthnResult.getCryptoObject();
        if (cryptoObject != null) {
            map.put("cryptoObject", cryptoObjectToMap(cryptoObject));
        }
        return map;
    }

    public static Map<String, Object> cryptoObjectToMap(@NonNull CryptoObject cryptoObject) {
        Map<String, Object> map = new HashMap<>();
        Cipher cipher = cryptoObject.getCipher();
        if (cipher != null) {
            map.put("cipher", cipherToMap(cipher));
        }
        Signature signature = cryptoObject.getSignature();
        if (signature != null) {
            map.put("signature", signatureToMap(signature));
        }
        Mac mac = cryptoObject.getMac();
        if (mac != null) {
            map.put("mac", macToMap(mac));
        }
        return map;
    }

    public static Map<String, Object> cipherToMap(@NonNull Cipher cipher) {
        Map<String, Object> map = new HashMap<>();
        map.put("algorithm", cipher.getAlgorithm());
        map.put("blockSize", cipher.getBlockSize());
        map.put("iv", cipher.getIV());
        if(cipher.getParameters() != null) {
            map.put("algorithmParameters", algorithmParamsToMap(cipher.getParameters()));
        }
        return map;
    }

    public static Map<String, Object> algorithmParamsToMap(@NonNull AlgorithmParameters parameters) {
        Map<String, Object> map = new HashMap<>();
        map.put("algorithm", parameters.getAlgorithm());
        try {
            map.put("encoded", parameters.getEncoded());
        } catch (IOException e) {
            Log.e(TAG, "Failed to put encoded", null);
        }
        if(parameters.getProvider() != null) {
            map.put("provider", providerToMap(parameters.getProvider()));
        }
        return map;
    }

    public static Map<String, Object> providerToMap(@NonNull Provider provider) {
        Map<String, Object> map = new HashMap<>();
        map.put("info", provider.getInfo());
        map.put("name", provider.getName());
        map.put("version", provider.getVersion());
        return map;
    }

    public static Map<String, Object> signatureToMap(@NonNull Signature signature) {
        Map<String, Object> map = new HashMap<>();
        map.put("algorithm", signature.getAlgorithm());
        if(signature.getParameters() != null) {
            map.put("algorithmParameters", algorithmParamsToMap(signature.getParameters()));
        }
        if(signature.getProvider() != null) {
            map.put("provider", providerToMap(signature.getProvider()));
        }
        return map;
    }

    public static Map<String, Object> macToMap(@NonNull Mac mac) {
        Map<String, Object> map = new HashMap<>();
        map.put("algorithm", mac.getAlgorithm());
        if(mac.getProvider() != null) {
            map.put("provider", providerToMap(mac.getProvider()));
        }
        map.put("length", mac.getMacLength());
        return map;
    }
}

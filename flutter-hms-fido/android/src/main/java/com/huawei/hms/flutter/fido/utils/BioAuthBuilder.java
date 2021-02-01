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
    
    public static Map<String, Object> bioAuthnResultToMap(BioAuthnResult bioAuthnResult) {
        Map<String, Object> map = new HashMap<>();
        if (bioAuthnResult.getCryptoObject() != null)
            map.put("cryptoObject", cryptoObjectToMap(bioAuthnResult.getCryptoObject()));
        return map;
    }

    public static Map<String, Object> cryptoObjectToMap(CryptoObject cryptoObject) {
        Map<String, Object> map = new HashMap<>();
        if (cryptoObject.getCipher() != null)
            map.put("cipher", cipherToMap(cryptoObject.getCipher()));
        if (cryptoObject.getSignature() != null)
            map.put("signature", signatureToMap(cryptoObject.getSignature()));
        if (cryptoObject.getMac() != null)
            map.put("mac", macToMap(cryptoObject.getMac()));
        return map;
    }

    public static Map<String, Object> cipherToMap(Cipher cipher) {
        Map<String, Object> map = new HashMap<>();
        map.put("algorithm", cipher.getAlgorithm());
        map.put("blockSize", cipher.getBlockSize());
        map.put("iv", cipher.getIV());
        map.put("algorithmParameters", algorithmParamsToMap(cipher.getParameters()));
        return map;
    }

    public static Map<String, Object> algorithmParamsToMap(AlgorithmParameters parameters) {
        Map<String, Object> map = new HashMap<>();
        map.put("algorithm", parameters.getAlgorithm());
        try {
            map.put("encoded", parameters.getEncoded());
        } catch (IOException e) {
            Log.e(TAG, "Failed to put encoded", null);
        }
        map.put("provider", providerToMap(parameters.getProvider()));
        return map;
    }

    public static Map<String, Object> providerToMap(Provider provider) {
        Map<String, Object> map = new HashMap<>();
        map.put("info", provider.getInfo());
        map.put("name", provider.getName());
        map.put("version", provider.getVersion());
        return map;
    }

    public static Map<String, Object> signatureToMap(Signature signature) {
        Map<String, Object> map = new HashMap<>();
        map.put("algorithm", signature.getAlgorithm());
        map.put("algorithmParameters", algorithmParamsToMap(signature.getParameters()));
        map.put("provider", providerToMap(signature.getProvider()));
        return map;
    }

    public static Map<String, Object> macToMap(Mac mac) {
        Map<String, Object> map = new HashMap<>();
        map.put("algorithm", mac.getAlgorithm());
        map.put("provider", providerToMap(mac.getProvider()));
        map.put("length", mac.getMacLength());
        return map;
    }
}

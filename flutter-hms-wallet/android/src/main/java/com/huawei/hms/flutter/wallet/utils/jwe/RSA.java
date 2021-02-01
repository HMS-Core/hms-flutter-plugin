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
package com.huawei.hms.flutter.wallet.utils.jwe;

import android.util.Base64;
import android.util.Log;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Signature;
import java.security.SignatureException;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

public class RSA {
    private static String TAG = "RSA";
    /**
     * Signature algorithm.
     */
    private static final String SIGN_ALGORITHMS256 = "SHA256WithRSA";

    /**
     * Sign content.
     *
     * @param content data to be signed.
     * @param privateKey merchant's private key.
     * @return Signed value.
     */
    public static String sign(String content, String privateKey, String signType) {
        String charset = "utf-8";
        try {
            PKCS8EncodedKeySpec privatePKCS8 = new PKCS8EncodedKeySpec(Base64.decode(privateKey,Base64.DEFAULT));
            KeyFactory keyf = KeyFactory.getInstance("RSA");
            PrivateKey priKey = keyf.generatePrivate(privatePKCS8);
            Signature signatureObj = Signature.getInstance(SIGN_ALGORITHMS256);
            signatureObj.initSign(priKey);
            signatureObj.update(content.getBytes(charset));
            byte[] signed = signatureObj.sign();
            return Base64.encodeToString(signed,Base64.DEFAULT);
        } catch (InvalidKeySpecException | NoSuchAlgorithmException | UnsupportedEncodingException | SignatureException | InvalidKeyException e) {
            Log.i(TAG, e.getMessage());
        }

        return "";
    }

    /**
     * encrypt bytes： src data
     *
     * @param bytes bytes
     * @param publicKey publicKey
     * @param algorithm algorithm
     * @param input_charset input_charset
     * @return encoded
     * @throws Exception
     */
    public static String encrypt(byte[] bytes, String publicKey, String algorithm, String input_charset) throws InvalidKeySpecException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, BadPaddingException, IllegalBlockSizeException {
        Key key = getPublicKey(publicKey);
        Cipher cipher = Cipher.getInstance(algorithm);
        cipher.init(Cipher.ENCRYPT_MODE, key);
        if (CommonUtil.isNull(input_charset)) {
            input_charset = "utf-8";
        }
        byte[] b1 = cipher.doFinal(bytes);
        String encoded = Base64.encodeToString(b1, Base64.DEFAULT);
        return encoded;
    }

    /**
     * getPublicKey
     *
     * @param key key(by Base64)
     * @throws Exception
     */
    private static PublicKey getPublicKey(String key) throws NoSuchAlgorithmException, InvalidKeySpecException {
        X509EncodedKeySpec keySpec = new X509EncodedKeySpec(Base64.decode(key, Base64.DEFAULT));
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        PublicKey publicKey = keyFactory.generatePublic(keySpec);
        return publicKey;
    }
}

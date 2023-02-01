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

package com.huawei.hms.flutter.wallet.utils.jwe;

import android.util.Base64;
import android.util.Log;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import java.util.zip.GZIPOutputStream;

public class JweUtil {
    private static final String TAG = "JweUtil";

    /**
     * Generate a JSON Web Encryption (JWE).
     *
     * @param dataJson JWE-type data. It can be a list of instance IDs or a wallet instance.
     * @return return a map containing a content string and a signature string.
     */
    public static String generateJwe(String issuerId, String dataJson, String jwePrivateKey, String sessionKeyPublicKey) throws JSONException {
        String sessionKey = RandomUtils.generateSecureRandomFactor(16);

        JSONObject jsonObject = new JSONObject(dataJson);
        jsonObject.put("iss", issuerId);

        // The first part: JWE Head
        JweHeader jweHeader = getHeader();
        String jweHeaderEncode = getEncodeHeader(jweHeader);

        // The Second part: JWE Encrypted Key
        String encryptedKeyEncode = getEncryptedKey(sessionKey, sessionKeyPublicKey);

        // The third part: JWE IV
        byte[] iv = AESUtils.getIvByte(12);
        String ivHexStr = HwHex.encodeHexString(iv);
        String ivEncode = Base64.encodeToString(ivHexStr.getBytes(StandardCharsets.UTF_8), Base64.URL_SAFE | Base64.NO_WRAP);

        // The fourth part: JWE CipherText
        String cipherTextEncode = getCipherText(jsonObject.toString(), sessionKey, iv, jweHeader);

        // The fifth part: JWE Authentication Tag
        String authenticationTagEncode =
                getAuthenticationTag(jwePrivateKey, sessionKey, jsonObject.toString(), jweHeaderEncode, ivEncode);

        StringBuilder stringBuilder = new StringBuilder();
        return stringBuilder.append(jweHeaderEncode)
                .append(".")
                .append(encryptedKeyEncode)
                .append(".")
                .append(ivEncode)
                .append(".")
                .append(cipherTextEncode)
                .append(".")
                .append(authenticationTagEncode)
                .toString();
    }

    private static JweHeader getHeader() {
        JweHeader jweHeader = new JweHeader();
        jweHeader.setAlg("RSA-OAEP");
        jweHeader.setEnc("A128GCM");
        jweHeader.setKid("1");
        jweHeader.setZip("gzip");
        return jweHeader;
    }

    private static String getEncodeHeader(JweHeader jweHeader) {
        StringBuffer stringBuffer = new StringBuffer();
        String headerJson = stringBuffer.append("alg=")
                .append(jweHeader.getAlg())
                .append(", enc=")
                .append(jweHeader.getEnc())
                .append(", kid=")
                .append(jweHeader.getKid())
                .append(", zip=")
                .append(jweHeader.getZip())
                .toString();
        return Base64.encodeToString(headerJson.getBytes(StandardCharsets.UTF_8), Base64.URL_SAFE | Base64.NO_WRAP);
    }

    private static String getEncryptedKey(String sessionKey, String sessionKeyPublicKey) {
        try {
            String encryptedSessionKey = RSA.encrypt(sessionKey.getBytes(StandardCharsets.UTF_8), sessionKeyPublicKey, "RSA/NONE/OAEPwithSHA-256andMGF1Padding");
            return Base64.encodeToString(encryptedSessionKey.getBytes(StandardCharsets.UTF_8), Base64.URL_SAFE | Base64.NO_WRAP);
        } catch (Exception e) {
            Log.e(TAG, "Encrypt session key failed.");
        }
        return "";
    }

    private static String getCipherText(String dataJson, String sessionKey, byte[] iv, JweHeader jweHeader) {
        if (!"A128GCM".equals(jweHeader.getEnc())) {
            Log.e(TAG, "enc only support A128GCM.");
            return "";
        }
        if (!"gzip".equals(jweHeader.getZip())) {
            Log.e(TAG, "zip only support gzip.");
            return "";
        }
        String payLoadEncrypt = AESUtils.encryptByGcm(dataJson, sessionKey, iv);
        byte[] payLoadEncryptCompressByte = compress(payLoadEncrypt.getBytes(StandardCharsets.UTF_8));
        return Base64.encodeToString(payLoadEncryptCompressByte, Base64.URL_SAFE | Base64.NO_WRAP);
    }

    private static String getAuthenticationTag(String jweSignPrivateKey, String sessionKey, String payLoadJson, String jweHeaderEncode, String ivEncode) {
        StringBuffer stringBuffer = new StringBuffer();
        String signContent = stringBuffer.append(jweHeaderEncode)
                .append(".")
                .append(sessionKey)
                .append(".")
                .append(ivEncode)
                .append(".")
                .append(payLoadJson)
                .toString();
        return RSA.sign(signContent, jweSignPrivateKey);
    }

    /**
     * gzip Compress
     *
     * @param originalBytes Data to be compressed
     * @return Compressed data
     */
    public static byte[] compress(byte[] originalBytes) {
        if (originalBytes == null || originalBytes.length == 0) {
            return null;
        }
        try (ByteArrayOutputStream out = new ByteArrayOutputStream();
             GZIPOutputStream gzip = new GZIPOutputStream(out)) {
            gzip.write(originalBytes);
            gzip.finish();
            return out.toByteArray();
        } catch (Exception e) {
            Log.e(TAG, e.getMessage());
            return null;
        }
    }
}

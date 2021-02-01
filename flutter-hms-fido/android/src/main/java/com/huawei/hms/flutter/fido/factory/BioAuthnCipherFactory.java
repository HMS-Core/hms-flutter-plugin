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

package com.huawei.hms.flutter.fido.factory;

import android.os.Build;
import android.security.keystore.KeyGenParameterSpec;
import android.security.keystore.KeyProperties;
import android.util.Log;

import androidx.annotation.RequiresApi;

import java.io.IOException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.UnrecoverableKeyException;
import java.security.cert.CertificateException;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;

public class BioAuthnCipherFactory {
    private static final String TAG = BioAuthnCipherFactory.class.getSimpleName();

    private final String storeKey;
    private final String password;
    private final boolean isUserAuthenticationRequired;

    private KeyStore keyStore;

    private KeyGenerator keyGenerator;

    private Cipher defaultCipher;

    public BioAuthnCipherFactory(String storeKey, String password, boolean isUserAuthenticationRequired) {
        this.storeKey = storeKey;
        this.password = password;
        this.isUserAuthenticationRequired = isUserAuthenticationRequired;

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            initDefaultCipherObject();
        } else {
            defaultCipher = null;
            Log.e(TAG, "Failed to init Cipher.");
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.M)
    private void initDefaultCipherObject() {
        try {
            keyStore = KeyStore.getInstance("AndroidKeyStore");
        } catch (KeyStoreException e) {
            Log.e(TAG, "Failed to get an instance of KeyStore(AndroidKeyStore). " + e.getMessage());
        }
        try {
            keyGenerator = KeyGenerator.getInstance(KeyProperties.KEY_ALGORITHM_AES, "AndroidKeyStore");
        } catch (NoSuchAlgorithmException | NoSuchProviderException e) {
            Log.e(TAG, "Failed to get an instance of KeyGenerator(AndroidKeyStore). " + e.getMessage());
        }

        createSecretKey(storeKey);

        try {
            defaultCipher = Cipher.getInstance("AES/CBC/PKCS7Padding");
        } catch (NoSuchAlgorithmException | NoSuchPaddingException e) {
            Log.e(TAG, "Failed to get an instance of Cipher. " + e.getMessage());
        }
        initCipher(defaultCipher, storeKey);
    }

    private void initCipher(Cipher cipher, String storeKeyName) {
        try {
            keyStore.load(null);
            SecretKey secretKey = (SecretKey) keyStore.getKey(storeKeyName, password != null ? password.toCharArray() : null);
            cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        } catch (CertificateException | IOException | NoSuchAlgorithmException | UnrecoverableKeyException | KeyStoreException | InvalidKeyException e) {
            Log.e(TAG, "Failed to init Cipher. " + e.getMessage());
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.M)
    private void createSecretKey(String storeKeyName) {
        try {
            keyStore.load(null);
            KeyGenParameterSpec.Builder builder = new KeyGenParameterSpec.Builder(storeKeyName, KeyProperties.PURPOSE_ENCRYPT | KeyProperties.PURPOSE_DECRYPT)
                    .setBlockModes(KeyProperties.BLOCK_MODE_CBC)
                    .setUserAuthenticationRequired(isUserAuthenticationRequired)
                    .setEncryptionPaddings(KeyProperties.ENCRYPTION_PADDING_PKCS7);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                builder.setInvalidatedByBiometricEnrollment(true);
            }
            keyGenerator.init(builder.build());
            keyGenerator.generateKey();
        } catch (CertificateException | IOException | NoSuchAlgorithmException | InvalidAlgorithmParameterException e) {
            Log.e(TAG, "Failed to create secret key. " + e.getMessage());
        }
    }

    public Cipher getCipher() {
        return defaultCipher;
    }
}

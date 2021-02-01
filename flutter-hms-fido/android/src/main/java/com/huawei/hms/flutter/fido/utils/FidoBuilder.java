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

import android.os.Build;
import android.util.Log;

import androidx.annotation.RequiresApi;

import com.huawei.hms.support.api.fido.fido2.Algorithm;
import com.huawei.hms.support.api.fido.fido2.Attachment;
import com.huawei.hms.support.api.fido.fido2.AuthenticatorAssertionResponse;
import com.huawei.hms.support.api.fido.fido2.AuthenticatorAttestationResponse;
import com.huawei.hms.support.api.fido.fido2.AuthenticatorMetadata;
import com.huawei.hms.support.api.fido.fido2.AuthenticatorSelectionCriteria;
import com.huawei.hms.support.api.fido.fido2.AuthenticatorTransport;
import com.huawei.hms.support.api.fido.fido2.Fido2AuthenticationResponse;
import com.huawei.hms.support.api.fido.fido2.Fido2RegistrationResponse;
import com.huawei.hms.support.api.fido.fido2.NativeFido2AuthenticationOptions;
import com.huawei.hms.support.api.fido.fido2.NativeFido2Options;
import com.huawei.hms.support.api.fido.fido2.NativeFido2RegistrationOptions;
import com.huawei.hms.support.api.fido.fido2.PublicKeyCredentialCreationOptions;
import com.huawei.hms.support.api.fido.fido2.PublicKeyCredentialDescriptor;
import com.huawei.hms.support.api.fido.fido2.PublicKeyCredentialParameters;
import com.huawei.hms.support.api.fido.fido2.PublicKeyCredentialRequestOptions;
import com.huawei.hms.support.api.fido.fido2.PublicKeyCredentialRpEntity;
import com.huawei.hms.support.api.fido.fido2.PublicKeyCredentialType;
import com.huawei.hms.support.api.fido.fido2.PublicKeyCredentialUserEntity;
import com.huawei.hms.support.api.fido.fido2.TokenBinding;
import com.huawei.hms.support.api.fido.fido2.UserVerificationRequirement;

import org.json.JSONArray;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

import io.flutter.plugin.common.MethodCall;

public class FidoBuilder {
    private static final String TAG = FidoBuilder.class.getSimpleName();

    public static NativeFido2RegistrationOptions createNativeRegOptions(MethodCall call) {
        NativeFido2RegistrationOptions registrationOptions;
        NativeFido2RegistrationOptions.Builder builder = new NativeFido2RegistrationOptions.Builder();

        Map<String, Object> options = FidoUtil.fromObject(call.argument("options"));

        if (!options.isEmpty()) {
            String origin = (String) options.get("originFormat");
            Map<String, Object> promptInfo = FidoUtil.fromObject(options.get("info"));

            if (origin != null)
                builder.setOriginFormat(FidoUtil.getOriginFormat(origin));
            if (!promptInfo.isEmpty())
                builder.setBiometricPromptInfo(buildPromptInfo(promptInfo));

            Log.i(TAG, "Native registration options created.");
            registrationOptions = builder.build();
        } else {
            Log.i(TAG, "Default native registration options created.");
            registrationOptions = NativeFido2RegistrationOptions.DEFAULT_OPTIONS;
        }

        return registrationOptions;
    }

    public static NativeFido2AuthenticationOptions createNativeAuthOptions(MethodCall call) {
        NativeFido2AuthenticationOptions authenticationOptions;
        NativeFido2AuthenticationOptions.Builder builder1 = new NativeFido2AuthenticationOptions.Builder();

        Map<String, Object> options1 = FidoUtil.fromObject(call.argument("options"));

        if (!options1.isEmpty()) {
            String origin1 = (String) options1.get("originFormat");
            Map<String, Object> promptInfo = FidoUtil.fromObject(options1.get("info"));

            if (origin1 != null)
                builder1.setOriginFormat(FidoUtil.getOriginFormat(origin1));
            if (!promptInfo.isEmpty())
                builder1.setBiometricPromptInfo(buildPromptInfo(promptInfo));

            Log.i(TAG, "Native authentication options created.");
            authenticationOptions = builder1.build();
        } else {
            Log.i(TAG, "Default native authentication options created.");
            authenticationOptions = NativeFido2AuthenticationOptions.DEFAULT_OPTIONS;
        }

        return authenticationOptions;
    }

    public static TokenBinding createTokenBinding(MethodCall call) {
        Map<String, Object> options = FidoUtil.fromObject(call.argument("tokenBinding"));

        String id = (String) options.get("id");
        String status = (String) options.get("status");

        return new TokenBinding(FidoUtil.getTokenStatus(status), id);
    }

    public static NativeFido2Options.BiometricPromptInfo buildPromptInfo(Map<String, Object> map) {
        String title = (String) map.get("title");
        String desc = (String) map.get("description");

        return new NativeFido2Options.BiometricPromptInfo(title, desc);
    }

    @RequiresApi(api = Build.VERSION_CODES.N)
    public static PublicKeyCredentialCreationOptions buildCredentialCreationOptions(MethodCall call) {
        byte[] challenge = call.argument("challenge");
        Map<String, Object> extensions = FidoUtil.fromObject(call.argument("extensions"));
        Double timeoutSeconds = call.argument("timeoutSeconds");
        Map<String, Object> rpEntity = FidoUtil.fromObject(call.argument("rp"));
        Map<String, Object> userEntity = FidoUtil.fromObject(call.argument("user"));
        List<Map<String, Object>> keyCredParams = call.argument("pubKeyCredParams");
        List<Map<String, Object>> excludeList = call.argument("excludeList");
        String attestation = call.argument("attestation");
        Map<String, Object> criteria = FidoUtil.fromObject(call.argument("authenticatorSelection"));

        PublicKeyCredentialCreationOptions.Builder builder = new PublicKeyCredentialCreationOptions.Builder();
        builder.setChallenge(challenge).setExtensions(extensions);
        if (!rpEntity.isEmpty())
            builder.setRp(buildRpEntity(rpEntity));
        if (!userEntity.isEmpty())
            builder.setUser(buildUserEntity(userEntity));
        if (keyCredParams != null)
            builder.setPubKeyCredParams(buildParamList(keyCredParams));
        if (excludeList != null)
            builder.setExcludeList(buildDescriptorList(excludeList));
        if (attestation != null)
            builder.setAttestation(FidoUtil.getAttestation(attestation));
        if (!criteria.isEmpty())
            builder.setAuthenticatorSelection(getCriteria(criteria));
        if (timeoutSeconds != null)
            builder.setTimeoutSeconds(timeoutSeconds.longValue());
        return builder.build();
    }

    @RequiresApi(api = Build.VERSION_CODES.N)
    public static PublicKeyCredentialRequestOptions buildCredentialRequestOptions(MethodCall call) {
        String rpId = call.argument("rpId");
        byte[] challenge = call.argument("challenge");
        List<Map<String, Object>> allowList = call.argument("allowList");
        Map<String, Object> extensions = call.argument("extensions");
        Double timeoutSeconds = call.argument("timeoutSeconds");

        return new PublicKeyCredentialRequestOptions.Builder()
                .setRpId(rpId)
                .setAllowList(buildDescriptorList(allowList))
                .setExtensions(extensions)
                .setTimeoutSeconds(timeoutSeconds.longValue())
                .setChallenge(challenge)
                .build();
    }

    public static PublicKeyCredentialRpEntity buildRpEntity(Map<String, Object> map) {
        String name = (String) map.get("name");
        String id = (String) map.get("id");
        String icon = (String) map.get("icon");

        return new PublicKeyCredentialRpEntity(id, name, icon);
    }

    public static PublicKeyCredentialUserEntity buildUserEntity(Map<String, Object> map) {
        String displayName = (String) map.get("displayName");
        byte[] id = (byte[]) map.get("id");

        return new PublicKeyCredentialUserEntity(displayName, id);
    }

    public static List<PublicKeyCredentialParameters> buildParamList(List<Map<String, Object>> list) {
        List<PublicKeyCredentialParameters> list1 = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> innerMap = list.get(i);
            String alg = (String) innerMap.get("algorithm");
            Algorithm algorithm = FidoUtil.getAlgorithm(alg);
            PublicKeyCredentialParameters credentialParameters = new PublicKeyCredentialParameters(PublicKeyCredentialType.PUBLIC_KEY, algorithm);
            list1.add(credentialParameters);
        }
        return list1;
    }

    @RequiresApi(api = Build.VERSION_CODES.N)
    public static List<PublicKeyCredentialDescriptor> buildDescriptorList(List<Map<String, Object>> list) {
        if (list == null || list.isEmpty()) return new ArrayList<>(0);
        List<PublicKeyCredentialDescriptor> list1 = new ArrayList<>();
        PublicKeyCredentialDescriptor descriptor;
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> innerMap = list.get(i);
            byte[] id = (byte[]) innerMap.get("id");
            List<?> listFromObject = FidoUtil.listFromObject(innerMap.get("transports"));
            List<String> transports = listFromObject.stream().map(o -> Objects.toString(o, null)).collect(Collectors.toList());

            if (transports != null && !transports.isEmpty()) {
                Log.i(TAG, "Descriptor created with transports");
                descriptor = new PublicKeyCredentialDescriptor(PublicKeyCredentialType.PUBLIC_KEY, id, buildTransportList(transports));
            } else {
                Log.i(TAG, "Descriptor created without transports");
                descriptor = new PublicKeyCredentialDescriptor(PublicKeyCredentialType.PUBLIC_KEY, id);
            }
            list1.add(descriptor);
        }
        return list1;
    }

    public static List<AuthenticatorTransport> buildTransportList(List<String> transports) {
        List<AuthenticatorTransport> list = new ArrayList<>();
        if (transports != null && !transports.isEmpty()) {
            for (int i = 0; i < transports.size(); i++) {
                String s = transports.get(i);
                AuthenticatorTransport transport = FidoUtil.getTransport(s);
                list.add(transport);
            }
            return list;
        } else {
            return Collections.emptyList();
        }
    }

    public static AuthenticatorSelectionCriteria getCriteria(Map<String, Object> map) {
        String attachment = (String) map.get("attachment");
        String requirement = (String) map.get("requirement");
        Boolean resident = (Boolean) map.get("resident");

        Attachment attachment1 = FidoUtil.getAttachment(attachment);
        UserVerificationRequirement requirement1 = FidoUtil.getVerificationRequirement(requirement);
        return new AuthenticatorSelectionCriteria(attachment1, resident, requirement1);
    }

    // REGISTRATION RESPONSE

    public static Map<String, Object> getRegistrationResponse(Fido2RegistrationResponse response) {
        Map<String, Object> map = new HashMap<>();
        map.put("isSuccess", response.isSuccess());
        map.put("fido2Status", response.getFido2Status());
        map.put("ctapStatus", response.getCtapStatus());
        map.put("ctapStatusMessage", response.getCtapStatusMessage());
        map.put("fido2StatusMessage", response.getFido2StatusMessage());
        if (response.getAuthenticatorAttestationResponse() != null)
            map.put("authenticatorAttestationResponse", getAuthenticatorAttestation(response.getAuthenticatorAttestationResponse()));
        return map;
    }

    public static Map<String, Object> getAuthenticatorAttestation(AuthenticatorAttestationResponse response) {
        Map<String, Object> map = new HashMap<>();
        map.put("attestationObject", response.getAttestationObject());
        map.put("clientDataJson", response.getClientDataJson());
        map.put("credentialId", response.getCredentialId());
        return map;
    }

    // AUTHENTICATION RESPONSE

    public static Map<String, Object> getAuthenticationResponse(Fido2AuthenticationResponse response) {
        Map<String, Object> map = new HashMap<>();
        map.put("isSuccess", response.isSuccess());
        map.put("ctapStatus", response.getCtapStatus());
        map.put("ctapStatusMessage", response.getCtapStatusMessage());
        map.put("fido2Status", response.getFido2Status());
        map.put("fido2StatusMessage", response.getFido2StatusMessage());
        if (response.getAuthenticatorAssertionResponse() != null)
            map.put("assertionResponse", getAssertionResponse(response.getAuthenticatorAssertionResponse()));
        return map;
    }

    public static Map<String, Object> getAssertionResponse(AuthenticatorAssertionResponse response) {
        Map<String, Object> map = new HashMap<>();
        map.put("authenticatorData", response.getAuthenticatorData());
        map.put("clientDataJson", response.getClientDataJson());
        map.put("credentialId", response.getCredentialId());
        map.put("signature", response.getSignature());
        return map;
    }

    public static JSONArray authMetadataToMap(List<AuthenticatorMetadata> list) {
        ArrayList<Map<String, Object>> authList = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            AuthenticatorMetadata metadata = list.get(i);
            map.put("isAvailable", metadata.isAvailable);
            map.put("aaGuid", metadata.getAaguid());
            map.put("uVms", metadata.getUvms());
            map.put("extensions", FidoUtil.stringCollToList(metadata.getExtensions()));
            authList.add(map);
        }
        return new JSONArray(authList);
    }
}

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

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:huawei_fido/huawei_fido.dart';
import 'package:huawei_fido_example/widgets/custom_button.dart';

class FidoExample extends StatefulWidget {
  @override
  _FidoExampleState createState() => _FidoExampleState();
}

class _FidoExampleState extends State<FidoExample> {
  late HmsFido2Client fido2client;
  late PublicKeyCredentialCreationOptions options;
  late PublicKeyCredentialRequestOptions requestOptions;

  Map<String, dynamic> extensionMap = {};
  late Uint8List _challenge;
  Uint8List? _credentialId;
  List<String> _results = ["Results will be listed here\n"];

  @override
  void initState() {
    _challenge = new Uint8List(16);
    fido2client = new HmsFido2Client();
    options = new PublicKeyCredentialCreationOptions();
    requestOptions = new PublicKeyCredentialRequestOptions();
    prepareExtensions();
    super.initState();
  }

  void prepareExtensions() async {
    bool? hasAuthenticators = await fido2client.hasPlatformAuthenticators();
    if (hasAuthenticators ?? false) {
      List<String?> list = [];
      List<AuthenticatorMetadata?>? metaList =
          await fido2client.getPlatformAuthenticators();
      if (metaList == null) {
        return;
      }
      for (AuthenticatorMetadata? data in metaList) {
        if (!(data?.isAvailable ?? false)) {
          continue;
        }
        if (data!.isSupportedUvm(AuthenticatorMetadata.UVM_FINGERPRINT)) {
          list.add(data.aaGuid);
          if (data.extensions!
              .contains(Fido2Extension.webAuthN.getIdentifier())) {
            extensionMap[Fido2Extension.webAuthN.getIdentifier()] = true;
          }
          if (data.extensions?.contains(Fido2Extension.cIBBe.getIdentifier()) ??
              false) {
            extensionMap[Fido2Extension.cIBBe.getIdentifier()] = true;
          }
        } else if (data.isSupportedUvm(AuthenticatorMetadata.UVM_FACEPRINT)) {
          print("Lock screen 3D face authenticator");
        }
      }
      extensionMap[Fido2Extension.pAcl.getIdentifier()] = list;
    }
  }

  void setRegistrationOptions() {
    options.challenge = _challenge;
    options.nativeFido2Options = new NativeFido2Options(
        info: new BiometricPromptInfo(
            title: "Registration title",
            description: "Registration description"));
    options.rp =
        new PublicKeyCredentialRpEntity(name: "example_name", id: "rp_id");
    options.user = new PublicKeyCredentialUserEntity(
        displayName: "display_name", id: new Uint8List(10));
    options.pubKeyCredParams = [
      new PublicKeyCredentialParameters(algorithm: Algorithm.ES256)
    ];
    options.excludeList = [new PublicKeyCredentialDescriptor(id: _challenge)];
    options.extensions = Map.from(extensionMap);
    options.authenticatorSelection = new AuthenticatorSelectionCriteria(
        attachment: null, requirement: null, resident: null);
    options.timeoutSeconds = 15874587;
    options.attestation = null;
  }

  void setAuthenticationOptions() {
    requestOptions.nativeFido2Options = new NativeFido2Options(
        info: new BiometricPromptInfo(
            title: "Authentication title",
            description: "Authentication description"));
    requestOptions.rpId = "rp_id";
    requestOptions.challenge = _challenge;
    requestOptions.timeoutSeconds = 15874587;
    requestOptions.extensions = Map.from(extensionMap);
    requestOptions.allowList = [
      new PublicKeyCredentialDescriptor(id: _credentialId)
    ];
  }

  void _isSupported() async {
    var result = await fido2client.isSupported();
    _updateList("\n\nIS SUPPORTED result: $result");
  }

  void _isSupportedCb() async {
    await fido2client
        .isSupportedExAsync(({int? resultCode, String? errString}) {
      _updateList("\n\nIS SUPPORTED CB result: $resultCode");
    });
  }

  void _register() async {
    setRegistrationOptions();
    Fido2RegistrationResponse? response =
        await fido2client.getRegistrationIntent(options);
    _updateList(
        "REGISTRATION SUCCESS: ${response?.isSuccess} \n\n CREDENTIAL ID: ${response?.authenticatorAttestationResponse?.credentialId}");
    setState(() => _credentialId =
        response?.authenticatorAttestationResponse?.credentialId);
  }

  void _authenticate() async {
    setAuthenticationOptions();
    Fido2AuthenticationResponse? response =
        await fido2client.getAuthenticationIntent(requestOptions);
    _updateList("\n\nAUTHENTICATION SUCCESS: ${response?.isSuccess}");
  }

  void _hasPlatformAuthenticatorsCb() async {
    await fido2client.hasPlatformAuthenticatorsWithCb(({result}) {
      _updateList("\n\nHAS PLATFORM AUTHENTICATORS CB: $result");
    }, ({errString, errorCode}) {
      _updateList(
          "\n\nHAS PLATFORM AUTHENTICATORS CB: $errorCode - $errString");
    });
  }

  void _getPlatformAuthenticators() async {
    List<AuthenticatorMetadata?>? list =
        await fido2client.getPlatformAuthenticators();
    if (list == null) {
      return;
    }
    for (AuthenticatorMetadata? meta in list) {
      _updateList(meta?.aaGuid ?? '');
    }
    print(list.length);
  }

  void _getPlatformAuthenticatorsCb() async {
    await fido2client.getPlatformAuthenticatorsWithCb(({result}) {
      if (result == null) return;
      for (AuthenticatorMetadata? meta in result) {
        _updateList(meta?.aaGuid ?? '');
      }
      print(result.length);
    }, ({errString, errorCode}) {
      _updateList(
          "\n\nGET PLATFORM AUTHENTICATORS CB: $errorCode - $errString");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FIDO EXAMPLE")),
      body: Column(
        children: [
          customButton("IS SUPPORTED", _isSupported),
          customButton("IS SUPPORTED CB", _isSupportedCb),
          customButton("REGISTER", _register),
          customButton("AUTHENTICATE", _authenticate),
          customButton("HAS AUTHENTICATORS CB", _hasPlatformAuthenticatorsCb),
          customButton("GET AUTHENTICATORS", _getPlatformAuthenticators),
          customButton("GET AUTHENTICATORS CB", _getPlatformAuthenticatorsCb),
          Expanded(
              child: GestureDetector(
            onDoubleTap: () {
              setState(() => _results.clear());
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey)),
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (ctx, index) {
                  return Text(_results[index]);
                },
              ),
            ),
          ))
        ],
      ),
    );
  }

  void _updateList(String obj) {
    setState(() => _results.add(obj));
  }
}

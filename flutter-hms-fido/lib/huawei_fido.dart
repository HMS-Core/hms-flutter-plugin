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

library huawei_fido;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

part './src/bioauthn/bio_authn_manager.dart';
part './src/bioauthn/bio_authn_prompt.dart';
part './src/bioauthn/bio_authn_prompt_info.dart';
part './src/bioauthn/bio_authn_result.dart';
part './src/bioauthn/cipher_factory.dart';
part './src/bioauthn/face_manager.dart';
part './src/fido/fido2_client.dart';
part './src/fido/request/authenticator_selection_criteria.dart';
part './src/fido/request/public_key_credential_creation_options.dart';
part './src/fido/request/public_key_credential_request_options.dart';
part './src/fido/request/public_key_credential_descriptor.dart';
part './src/fido/request/public_key_credential_parameters.dart';
part './src/fido/request/public_key_credential_rp_entity.dart';
part './src/fido/request/public_key_credential_user_entity.dart';
part './src/fido/request/native_fido2_options.dart';
part './src/fido/request/fido2_extension.dart';
part './src/fido/request/biometric_prompt_info.dart';
part './src/fido/request/token_binding.dart';
part './src/fido/constant/fido_constants.dart';
part './src/fido/response/authenticator_metadata.dart';
part './src/fido/response/fido2_registration_response.dart';
part './src/fido/response/fido2_authentication_response.dart';
part './src/fido/response/ctap_status.dart';
part './src/fido/response/fido2_status.dart';
part './src/utils/fido2_plugin_util.dart';

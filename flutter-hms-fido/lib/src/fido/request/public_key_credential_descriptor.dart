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

import 'package:flutter/foundation.dart';
import '../constant/fido_constants.dart';

class PublicKeyCredentialDescriptor {
  PublicKeyCredentialType? type;
  List<AuthenticatorTransport>? transports;
  List<String>? _transportValues;
  Uint8List? id;

  PublicKeyCredentialDescriptor({this.type, this.id, this.transports}) {
    _transportValues = [];
    if (transports != null && transports!.isNotEmpty) {
      transports!.forEach((element) {
        _transportValues!.add(describeEnum(element));
      });
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "type": describeEnum(PublicKeyCredentialType.PUBLIC_KEY),
      "id": id,
      "transports": _transportValues
    };
  }

  PublicKeyCredentialType? get getType => type;

  Uint8List? get getId => id;

  List<AuthenticatorTransport>? get getTransports => transports;
}

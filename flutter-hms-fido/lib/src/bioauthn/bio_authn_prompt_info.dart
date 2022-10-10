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
part of huawei_fido;

class HmsBioAuthnPromptInfo {
  int? _id;
  String? title;
  String? subtitle;
  String? description;
  String navigateButtonText;
  bool confirmationRequired;
  bool deviceCredentialAllowed;

  HmsBioAuthnPromptInfo({
    this.title,
    this.subtitle,
    this.description,
    this.navigateButtonText = 'Cancel',
    this.confirmationRequired = true,
    this.deviceCredentialAllowed = true,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': _id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'navigateButtonText': navigateButtonText,
      'isConfirmationRequired': confirmationRequired,
      'isDeviceCredentialAllowed': deviceCredentialAllowed
    };
  }

  String? get getTitle => title;

  String? get getSubtitle => subtitle;

  String? get getDescription => description;

  String get getNavigateButtonText => navigateButtonText;

  bool get isConfirmationRequired => confirmationRequired;

  bool get isDeviceCredentialAllowed => deviceCredentialAllowed;

  void setId(int id) {
    _id = id;
  }
}

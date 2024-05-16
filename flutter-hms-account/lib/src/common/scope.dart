/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_account;

/// Describes the authorization request for OAuth 2.0, which affects user security.
///
/// When authorization is requested, an authorization dialog box is displayed.
class Scope {
  static final Scope profile = Scope._('profile');
  static final Scope email = Scope._('email');
  static final Scope openId = Scope._('openid');
  static final Scope game = Scope._('https://www.huawei.com/auth/games');
  static final Scope accountMobileNumber =
      Scope._('https://www.huawei.com/auth/account/mobile.number');
  static final Scope accountCountry =
      Scope._('https://www.huawei.com/auth/account/country');
  static final Scope accountBirthday =
      Scope._('https://www.huawei.com/auth/account/birthday');
  static final Scope ageRange =
      Scope._('https://www.huawei.com/auth/account/age.range');

  final String _uri;

  Scope._(this._uri);

  String getScopeUri() => _uri;

  int describeContents() => 0;

  @override
  String toString() {
    return '$Scope($_uri)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Scope && _uri == other._uri;
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <dynamic>[
        _uri,
      ],
    );
  }
}

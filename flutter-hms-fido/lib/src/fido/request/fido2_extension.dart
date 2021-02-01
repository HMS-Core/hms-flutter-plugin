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

class Fido2Extension {
  static const int SPEC_W3C_WEBAUTHN = 0;
  static const int SPEC_HMS = 1;
  static const int API_REGISTRATION = 1;
  static const int API_AUTHENTICATION = 2;
  static const int COMPONENT_CLIENT = 1;
  static const int COMPONENT_PLATFORM_AUTHENTICATOR = 2;
  static const int COMPONENT_ROAMING_AUTHENTICATOR = 4;

  final String name;
  String _identifier;
  final int specification;
  final int apis;
  final int components;
  final int version;

  Fido2Extension(
      this.name, this.specification, this.apis, this.components, this.version) {
    this._identifier = _initIdentifier();
  }

  static Fido2Extension pAcl = Fido2Extension("pacl", 1, 3, 1, 1);

  static Fido2Extension cIBBe = Fido2Extension("cibbe", 1, 1, 2, 1);

  static Fido2Extension webAuthN = Fido2Extension("uvi", 0, 3, 6, 0);

  String _specName() {
    int var1;
    if ((var1 = this.specification) != null) {
      return var1 != 1 ? "undefined" : "hms";
    } else {
      return "w3c-webauthn";
    }
  }

  String _apiName() {
    StringBuffer var1 = new StringBuffer();
    String var2;
    if (this.isApplicableApi(1)) {
      var2 = "r";
    } else {
      var2 = "";
    }

    Fido2Extension var10000 = this;
    var1.write(var2);
    String var3;
    if (var10000.isApplicableApi(2)) {
      var3 = "a";
    } else {
      var3 = "";
    }
    var1.write(var3);
    return var1.toString();
  }

  String _compName() {
    StringBuffer var1 = new StringBuffer();
    if (this.isApplicableComponent(1)) {
      var1.write("c");
    }

    bool var10000 = this.isApplicableComponent(2);
    bool var2 = this.isApplicableComponent(4);
    if (var10000) {
      var var3;
      if (var2) {
        var3 = "a";
      } else {
        var3 = "pa";
      }

      var1.write(var3);
    } else if (var2) {
      var1.write("pa");
    }
    return var1.toString();
  }

  String _initIdentifier() {
    if (this.specification == 0) {
      return this.name;
    } else {
      var v1 = this._specName();
      var v2 = this._apiName();
      var v3 = this._compName();
      var v4 = this.name;
      var v5 = this.version;
      String s = v5.toString();

      if (v5.toString().length == 1) {
        s = v5.toString().padLeft(2, '0');
      }

      return "$v1" + "_" + "$v2" + "_" + "$v3" + "_" + "$v4" + "_" + "$s";
    }
  }

  String getName() => this.name;

  String getIdentifier() => this._identifier;

  int getVersion() => this.version;

  int getSpecification() => this.specification;

  int getApis() => this.apis;

  int getComponents() => this.components;

  bool isApplicableComponent(int i) {
    return (this.components & i) != 0;
  }

  bool isApplicableApi(int api) {
    return (this.apis & api) != 0;
  }
}

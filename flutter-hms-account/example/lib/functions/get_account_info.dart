/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:http/http.dart' as http;

/// If you want to do a verification, you can use the link below.
///
/// [idToken] the token received token from signed HUAWEI ID.
Future<void> performServerVerification(String idToken) async {
  var response = await http.post(
      "https://oauth-login.cloud.huawei.com/oauth2/v3/tokeninfo",
      body: {'id_token': idToken});
  print(response.body);
}

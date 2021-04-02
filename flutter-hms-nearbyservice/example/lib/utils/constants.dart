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
import 'package:flutter/material.dart';

class Routes {
  // Routes
  static const String menuPage = '/';
  static const String discoveryAndTransfer = '/discovery-and-transfer';
  static const String wifi = '/wifi';
  static const String message = '/message';
}

class Styles {
  static const TextStyle menuButtonStyle = TextStyle(
    fontSize: 17,
  );
  static const TextStyle controlButtonStyle = TextStyle(
    fontSize: 17,
  );
  static const TextStyle warningTextStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white);
  static const TextStyle headerTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: Colors.black,
  );
  static const TextStyle textContentStyle = TextStyle(
    fontSize: 15,
  );
}

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

import 'package:flutter/material.dart';

Widget customButton(String title, VoidCallback callback) => Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15),
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              elevation: 0),
          child: Text(title.toUpperCase()),
          onPressed: callback),
    );

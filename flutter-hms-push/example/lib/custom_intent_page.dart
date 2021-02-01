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

class CustomIntentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Push Kit Demo - Custom Intent URI Page',
            style: TextStyle(fontSize: 16)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
                'https://developer.huawei.com/dev_index/img/bbs_en_logo.png?v=123'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Page to be opened with Custom Intent URI',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
            )
          ],
        ),
      ),
    );
  }
}

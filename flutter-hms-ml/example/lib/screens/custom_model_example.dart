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

class CustomModelExample extends StatefulWidget {
  @override
  _CustomModelExampleState createState() => _CustomModelExampleState();
}

class _CustomModelExampleState extends State<CustomModelExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Model Demo"),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Prerequisites",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(height: 15),
                    Text(
                        "1- Configure settings and prepare your custom model by using 'prepareCustomModel' method"),
                    SizedBox(height: 15),
                    Text(
                        "2- Execute the model with 'executeCustomModel' method and get the recognition results"),
                    SizedBox(height: 15),
                    Text(
                        "3- Call 'getOutputIndex' to obtain the channel index based on the output channel name"),
                    SizedBox(height: 15),
                    Text(
                        "4- Call 'stopExecutor' method to stop an inference task to release resources"),
                    SizedBox(height: 15),
                    Text(
                        "For details and model preparation please explore Huawei Developer Website")
                  ]))),
    );
  }
}

/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_scan/huawei_scan.dart';
import 'package:huawei_scan_example/widgets/CustomButton.dart';
import 'package:huawei_scan_example/widgets/ListResponseWidget.dart';
import 'package:huawei_scan_example/widgets/ResponseWidget.dart';

class DecodeBodyWidget extends StatelessWidget {
  const DecodeBodyWidget(
      {Key? key,
      required this.imageUrl,
      required this.customButtonName,
      required this.onPressed,
      this.responseList,
      required this.photoMode})
      : super(key: key);
  final String imageUrl;
  final String customButtonName;
  final void Function() onPressed;
  final List<ScanResponse?>? responseList;
  final bool photoMode;

  @override
  Widget build(BuildContext context) {
    print(responseList);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(imageUrl),
            ],
          ),
          CustomButton(
            text: customButtonName,
            onPressed: onPressed,
          ),
          if (responseList != null)
            ...List.generate(
              responseList!.length,
              (index) => photoMode == false
                  ? ListResponseWidget(
                      isMulti: false,
                      codeFormat: responseList?[index]?.scanType,
                      result: responseList?[index]?.originalValue,
                      resultType: responseList?[index]?.scanTypeForm,
                    )
                  : ResponseWidget(
                      isMulti: false,
                      codeFormat: responseList?[index]?.scanType,
                      result: responseList?[index]?.originalValue,
                      resultType: responseList?[index]?.scanTypeForm,
                    ),
            )
        ],
      ),
    );
  }
}

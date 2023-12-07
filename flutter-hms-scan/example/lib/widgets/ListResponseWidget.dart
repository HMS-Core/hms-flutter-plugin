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
import 'package:huawei_scan_example/Utils.dart';

class ListResponseWidget extends StatelessWidget {
  final int? codeFormat;
  final int? resultType;
  final String? result;
  final bool? isMulti;

  const ListResponseWidget({
    Key? key,
    this.codeFormat,
    this.result,
    this.resultType,
    this.isMulti,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color.fromRGBO(247, 242, 241, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 4.0),
                    child: Text(
                      'Code Format',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
              Text(formatConverter(codeFormat)),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 4.0),
                    child: Text(
                      'Result Type',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
              Text(resultTypeConverter(resultType)),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 4.0),
                    child: Text(
                      'Result',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
              Text(result ?? ''),
              isMulti != false
                  ? const SizedBox(
                      height: 16.0,
                    )
                  : const SizedBox(
                      height: 150.0,
                    )
            ],
          ),
        ),
      ),
    );
  }
}

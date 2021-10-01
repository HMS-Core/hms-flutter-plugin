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

class ProgressDetail extends StatefulWidget {
  const ProgressDetail(
      this.action, this.progress, this.callback, this.restartCallback);

  final String action;
  final double progress;
  final VoidCallback callback;
  final VoidCallback restartCallback;

  @override
  _ProgressDetailState createState() => _ProgressDetailState();
}

class _ProgressDetailState extends State<ProgressDetail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          elevation: 2,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            strokeWidth: 8,
                            backgroundColor: Colors.grey,
                            color: Colors.red,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.greenAccent),
                            value: widget.progress,
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          child: Text(
                              "${(widget.progress * 100).toStringAsFixed(1)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24)),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text("${widget.action} Progress",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: widget.progress == 1
                                    ? Colors.orange
                                    : Colors.redAccent),
                            onPressed: widget.progress == 0
                                ? null
                                : widget.progress == 1
                                    ? widget.restartCallback
                                    : widget.callback,
                            child: widget.progress == 1
                                ? Text("Restart ${widget.action}")
                                : Text("Cancel ${widget.action}"))
                      ],
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}

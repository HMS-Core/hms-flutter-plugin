/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'custom_multi_select_checkbox.dart';

class CustomCheckboxWithFormField extends FormField<List<String>> {
  final List<String> dialogItemList;
  final String buttonText;
  final String dialogTitleText;

  CustomCheckboxWithFormField({
    required this.buttonText,
    required this.dialogTitleText,
    required this.dialogItemList,
    required BuildContext context,
    FormFieldSetter<List<String>>? onSaved,
    FormFieldValidator<List<String>>? validator,
    required List<String> initialValue,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (FormFieldState<List<String>> state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                    child: Container(
                      height: 50,
                      child: Card(
                          elevation: 4,
                          child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: Icon(Icons.location_city_outlined,
                                        size: 20.0)),
                                Expanded(
                                  flex: 4,
                                  child: (state.value!.length <= 0)
                                      ? Text(buttonText,
                                          style: TextStyle(fontSize: 16.0))
                                      : Text('${state.value!}',
                                          style: TextStyle(fontSize: 16.0)),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Icon(
                                        Icons.keyboard_arrow_right_outlined,
                                        size: 20.0)),
                              ])),
                    ),
                    onTap: () async => state.didChange(await showDialog(
                            context: context,
                            builder: (_) => CustomMultiSelectDialogCheckbox(
                                  dialogTextQuestion: Text(dialogTitleText),
                                  selectedFromList: dialogItemList,
                                )) ??
                        [])),
                state.hasError
                    ? Center(
                        child: Text(
                          state.errorText!,
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : Container()
              ],
            );
          },
        );
}

/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

class CustomMultiSelectDialogCheckbox extends StatefulWidget {
  final List<String> selectedFromList;
  final Widget dialogTextQuestion;

  const CustomMultiSelectDialogCheckbox({
    Key? key,
    required this.selectedFromList,
    required this.dialogTextQuestion,
  }) : super(key: key);

  @override
  State<CustomMultiSelectDialogCheckbox> createState() =>
      _CustomMultiSelectDialogCheckboxState();
}

class _CustomMultiSelectDialogCheckboxState
    extends State<CustomMultiSelectDialogCheckbox> {
  final List<String> selectedItems = <String>[];
  final TextEditingController _newListItem = TextEditingController();
  Map<String, bool>? mappedItem;
  String? errorMessage;

  /// The method that converts the selected List response to a map.
  Map<String, bool> initMap() {
    return mappedItem = <String, bool>{
      for (String item in widget.selectedFromList) item: false
    };
  }

  /// Add new country/region code
  void _addNewCountryListItem() {
    errorMessage = null;

    if (_newListItem.text.isNotEmpty) {
      if (!widget.selectedFromList.contains(_newListItem.text)) {
        setState(() => widget.selectedFromList.first = _newListItem.text);
        initMap();

        /// We reset the Text Field area.
        _newListItem.clear();
      } else {
        setState(() {
          errorMessage = 'This country code already exists in the list';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (mappedItem == null) {
      initMap();
    }
    return SimpleDialog(
      title: widget.dialogTextQuestion,
      children: <Widget>[
        ...mappedItem!.keys.map((String data) {
          return StatefulBuilder(
            builder: (_, StateSetter setState) => CheckboxListTile(
              title: Text(data),
              activeColor: Colors.green,
              value: mappedItem![data],
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) => setState(
                () => mappedItem![data] = value!,
              ),
            ),
          );
        }).toList(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            decoration: InputDecoration(errorText: errorMessage),
            controller: _newListItem,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: _addNewCountryListItem,
              child: const Text('Add Item'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                visualDensity: VisualDensity.comfortable,
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: const Text('Submit List'),
              onPressed: () {
                selectedItems.clear();
                mappedItem!.forEach((String key, bool value) {
                  if (value == true) {
                    selectedItems.add(key);
                  }
                });
                Navigator.pop(context, selectedItems);
              },
            ),
          ],
        ),
      ],
    );
  }
}

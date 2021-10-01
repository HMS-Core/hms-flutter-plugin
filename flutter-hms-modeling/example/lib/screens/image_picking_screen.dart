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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'material_engine_screen.dart';

class ImagePickingScreen extends StatefulWidget {
  @override
  _ImagePickingScreenState createState() => _ImagePickingScreenState();
}

class _ImagePickingScreenState extends State<ImagePickingScreen> {
  int _selectedIndex = 0;
  late DateTime _date;
  late String _filesPath;

  saveAssetImageToFolder(BuildContext context) async {
    _date = DateTime.now();

    final bt = await rootBundle
        .load('assets/material_generation_images/$_selectedIndex.jpg');

    final file = await File(
            '${(await getApplicationDocumentsDirectory()).path}/$_selectedIndex.jpg')
        .create(recursive: true);

    final image = await file.writeAsBytes(
        bt.buffer.asUint8List(bt.offsetInBytes, bt.lengthInBytes));

    final extDirectory = await getExternalStorageDirectory();

    final imgPath =
        '${extDirectory!.path}/${_date.millisecondsSinceEpoch.toString()}';

    await new Directory(imgPath).create();
    setState(() => _filesPath = imgPath);

    for (int i = 0; i < 5; i++) {
      final imgName = DateTime.now();
      await image.copy(
          "$imgPath/${basename('${imgName.millisecondsSinceEpoch.toString()}.jpg')}");
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MaterialEngineScreen(_filesPath)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Material Generation"),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text("Pick a texture to create 3D model",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                      4,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() => _selectedIndex = index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.greenAccent,
                                        width:
                                            _selectedIndex == index ? 4 : 0)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                        'assets/material_generation_images/$index.jpg',
                                        width: 75,
                                        height: 75)),
                              ),
                            ),
                          )),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 25),
              width: MediaQuery.of(context).size.width * .8,
              child: ElevatedButton(
                onPressed: () => saveAssetImageToFolder(context),
                child: Text('Get started'),
              ),
            ),
          ],
        ));
  }
}

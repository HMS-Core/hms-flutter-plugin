/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_modeling3d_example/screens/material_engine_screen.dart';
import 'package:path_provider/path_provider.dart';

class ImagePickingScreen extends StatefulWidget {
  const ImagePickingScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickingScreen> createState() => _ImagePickingScreenState();
}

class _ImagePickingScreenState extends State<ImagePickingScreen> {
  int _selectedIndex = 0;

  void saveAssetImageToFolder() async {
    final ByteData byteData = await rootBundle.load(
      'assets/material_generation_images/$_selectedIndex.jpg',
    );
    final File file = await File(
      '${(await getApplicationDocumentsDirectory()).path}/$_selectedIndex.jpg',
    ).create(recursive: true);
    final File image = await file.writeAsBytes(
      byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
    );
    final Directory? extDirectory = await getExternalStorageDirectory();
    final String imgPath =
        '${extDirectory!.path}/${DateTime.now().millisecondsSinceEpoch}';
    await Directory(imgPath).create();

    for (int i = 0; i < 5; i++) {
      await image.copy('$imgPath/${DateTime.now().millisecondsSinceEpoch}.jpg');
    }

    push(imgPath);
  }

  void push(String filesPath) {
    Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return MaterialEngineScreen(filesPath);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Generation'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.count(
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              children: List<Widget>.generate(4, (int index) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedIndex = index),
                  child: Container(
                    foregroundDecoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: _selectedIndex == index ? 4 : 0,
                      ),
                    ),
                    child: Image.asset(
                      'assets/material_generation_images/$index.jpg',
                    ),
                  ),
                );
              }),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Pick a texture to create 3D model',
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: ElevatedButton(
              onPressed: () => saveAssetImageToFolder(),
              child: const Text('Get started'),
            ),
          ),
        ],
      ),
    );
  }
}

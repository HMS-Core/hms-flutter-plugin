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

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_account/huawei_account.dart';
import 'package:huawei_gameservice/clients/achievement_client.dart';
import 'package:huawei_gameservice/huawei_gameservice.dart';
import 'package:huawei_gameservice_example/custom_widgets/utils.dart';

import 'custom_dialog.dart';

class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  String playerName;
  String playerImage;

  @override
  void initState() {
    handleSignIn();
    super.initState();
  }

  void handleSignIn() async {
    HmsAuthHuaweiId id = await signIn();
    if (id != null) {
      setState(() {
        playerImage = id.avatarUriString;
        playerName = id.displayName;
      });
    }
  }

  void showPlayerDialog() async {
    showDialog(context: context, builder: (_) => CustomDialog(playerImage));
    earnAchievement();
  }

  /// Create a hidden achievement on AppGallery Connect and enter its id to the visualizeWithResult
  /// method below.
  void earnAchievement() async {
    try {
      // Reveals the hidden achievement.
      AchievementClient.visualizeWithResult("<achievement_id>");
      // Awards the achievement.
      bool result = await AchievementClient.reachWithResult("<achievement_id>");
      log(result.toString(), name: "earnAchievement");
    } on PlatformException catch (e) {
      log(buildErrorMessage("earnAchievement", e.code));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 270.0,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/banner.jpg",
              ),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: 36.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "HUAWEI Game Service",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Flutter Plugin Demo",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                onTap: showPlayerDialog,
                child: CircleAvatar(
                  radius: 35,
                  child: ClipOval(
                    child: playerImage == null || playerImage == ""
                        ? Image.asset("assets/duck.jpg")
                        : Image.network(playerImage),
                  ),
                  backgroundImage: AssetImage("assets/duck.jpg"),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            playerName == null
                ? RaisedButton(
                    onPressed: handleSignIn,
                    child: Text("Sign In with Huawei ID"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  )
                : Text(
                    "Welcome" + (playerName != null ? ", " + playerName : ""),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
          ],
        ));
  }
}

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
import 'package:huawei_gameservice/huawei_gameservice.dart';
import 'package:huawei_gameservice_example/custom_widgets/utils.dart';

class CustomDialog extends StatefulWidget {
  final String imgUri;

  CustomDialog(this.imgUri);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  Player playerResult;
  GamePlayerStatistics statResult;
  GameSummary gameSummaryResult;

  @override
  void initState() {
    getPlayer();
    getPlayerStatistics();
    getGameSummary();
    super.initState();
  }

  void getPlayer() async {
    try {
      Player player =
          await PlayersClient.getGamePlayer(isRequirePlayerId: true);

      setState(() {
        playerResult = player;
      });
    } on PlatformException catch (e) {
      log(buildErrorMessage("getGamePlayer", e.code));
    }
  }

  void getPlayerStatistics() async {
    try {
      GamePlayerStatistics gamePlayerStatistics =
          await GamePlayerStatisticsClient.getGamePlayerStatistics(true);

      setState(() {
        statResult = gamePlayerStatistics;
      });
    } on PlatformException catch (e) {
      log(buildErrorMessage("getGamePlayerStatictics", e.code));
    }
  }

  void getGameSummary() async {
    try {
      GameSummary gameSummary = await GameSummaryClient.getGameSummary();

      setState(() {
        gameSummaryResult = gameSummary;
      });
    } on PlatformException catch (e) {
      log(buildErrorMessage("getGameSummary", e.code));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 60,
                right: 20,
                bottom: 20,
              ),
              margin: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  playerResult == null
                      ? SizedBox.shrink()
                      : Text(
                          playerResult.displayName,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                  SizedBox(
                    height: 15,
                  ),
                  playerResult == null
                      ? CircularProgressIndicator()
                      : Column(
                          children: <Widget>[
                            Text(
                              "Player ID",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              playerResult.playerId,
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                  statResult == null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Average Online Minutes",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              statResult.averageOnLineMinutes.toString(),
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text("Days Elapsed From Last Game",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Text(
                              statResult.daysFromLastGame.toString(),
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text("Total Number of Sessions",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Text(
                              statResult.onlineTimes.toString(),
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                            gameSummaryResult == null
                                ? CircularProgressIndicator()
                                : Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 40),
                                        child: Divider(
                                          thickness: 2.0,
                                        ),
                                      ),
                                      Text("Game Summary",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Text("App Name",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                Text(
                                                    gameSummaryResult.gameName),
                                              ],
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                  "App ID",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(gameSummaryResult.appId),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Text("Achievement\nCount",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                Text(gameSummaryResult
                                                    .achievementCount
                                                    .toString())
                                              ],
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Text("Ranking\nCount",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                Text(gameSummaryResult
                                                    .rankingCount
                                                    .toString())
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                          ],
                        ),
                  SizedBox(
                    height: 22,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Close",
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  child: widget.imgUri == null || widget.imgUri == ""
                      ? Image.asset("assets/duck.jpg")
                      : Image.network(widget.imgUri),
                ),
              ),
            ),
          ],
        ));
  }
}

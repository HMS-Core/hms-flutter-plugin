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
import 'package:huawei_gameservice_example/custom_widgets/intent_container.dart';
import 'package:huawei_gameservice_example/custom_widgets/match_game/hms_card_info.dart';
import 'package:huawei_gameservice_example/custom_widgets/match_game/hms_cards.dart';
import 'package:huawei_gameservice_example/custom_widgets/match_game/match_game.dart';
import 'package:huawei_gameservice_example/custom_widgets/utils.dart';

class CustomBodyLayout extends StatefulWidget {
  final List<HMSCardInfo> hmsCards;

  const CustomBodyLayout(this.hmsCards);

  @override
  _CustomBodyLayoutState createState() => _CustomBodyLayoutState();
}

class _CustomBodyLayoutState extends State<CustomBodyLayout> {
  List<HMSCardInfo> hmsCards;
  @override
  void initState() {
    super.initState();
    hmsCards = widget.hmsCards;
    showWarning();
  }

  void showWarning() async {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        child: AlertDialog(
          title: Text(
            "Note",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Text(
            "To try Game Service methods, Please Add Your Huawei ID to the test accounts for your account on AppGallery Connect.",
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            MaterialButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
              color: Colors.blue,
            )
          ],
        )));
  }

  /// Showcase of ranking methods.
  void showRankings(BuildContext context) async {
    try {
      // Displays all leaderboards and their rankings.
      RankingClient.showTotalRankingsIntent();
      // Obtains all leaderboards and their rankings.
      List<Ranking> rankings = await RankingClient.getAllRankingSummaries(true);
      log(rankings.toString());
    } on PlatformException catch (e) {
      String error = buildErrorMessage("showRankings", e.code);

      log(error);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  /// Showcase of achievement methods.
  void showAchievements(BuildContext context) async {
    try {
      // Displays all achievements.
      AchievementClient.showAchievementListIntent();
      // Obtains all achievements.
      List<Achievement> achievements =
          await AchievementClient.getAchievementList(true);
      log(achievements.toString());
    } on PlatformException catch (e) {
      String error = buildErrorMessage("showAchievements", e.code);
      log(error);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  /// Showcase of ranking methods.
  void showSaves(BuildContext context) async {
    try {
      String title = "Flutter Plugin Demo";
      bool allowAddButton = true;
      bool allowDeleteButton = true;
      int maxArchive = 10;
      // Displays all archives.
      ArchivesClient.showArchiveListIntent(
          title, allowAddButton, allowDeleteButton, maxArchive);
      // Obtains all archive summaries.
      List<ArchiveSummary> archiveSummaries =
          await ArchivesClient.getArchiveSummaryList(true);
      log(archiveSummaries.toString());
    } on PlatformException catch (e) {
      String error = buildErrorMessage("showSaves", e.code);
      log(error);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  void shuffleCards() {
    setState(() {
      hmsCards = HMSCardInfo.getShuffledCards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height - 230,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            )),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                "Match All HMS Kits",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 22.0,
                ),
              ),
            ),
            HMSCards(cardInfos: hmsCards, child: MatchGame(shuffleCards)),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IntentContainer(Color.fromRGBO(255, 159, 72, 1), "Rankings",
                    Icons.equalizer, () {
                  showRankings(context);
                }),
                IntentContainer(Color.fromRGBO(173, 200, 255, 1),
                    "Achievements", Icons.bubble_chart, () {
                  showAchievements(context);
                }),
                IntentContainer(
                    Color.fromRGBO(250, 91, 90, 1), "Saves", Icons.save, () {
                  showSaves(context);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

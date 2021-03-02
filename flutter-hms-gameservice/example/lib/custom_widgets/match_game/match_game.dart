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

import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_gameservice/huawei_gameservice.dart';
import 'package:huawei_gameservice_example/custom_widgets/utils.dart';

import 'game_card.dart';
import 'hms_card_info.dart';
import 'hms_cards.dart';

class MatchGame extends StatefulWidget {
  final Function shuffleCards;

  const MatchGame(this.shuffleCards, {Key key}) : super(key: key);

  @override
  _MatchGameState createState() => _MatchGameState();
}

class _MatchGameState extends State<MatchGame> {
  List<HMSCardInfo> hmsCards;
  Stopwatch stopwatch = Stopwatch();
  HMSCardInfo current;
  bool blockGameGesture = true;
  bool startTimer = false;
  bool isPlaying = false;
  Timer timer;
  int milliseconds;

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 30), timerCallback);
    super.initState();
  }

  /// Create an achievement on AppGallery Connect and enter its id to the reachWithResult
  /// method below
  void earnFirstTimeAchievement() async {
    try {
      bool result = await AchievementClient.reachWithResult("<achievement_id>");
      log(result.toString(), name: "earnFirstTimeAchievement");
    } on PlatformException catch (e) {
      log(buildErrorMessage("reachWithResult", e.code));
    }
  }

  /// Create an incremental achievement on AppGallery Connect and enter its id to the growWithResult
  /// method below.
  void earnIncrementalAchievement() async {
    try {
      bool result =
          await AchievementClient.growWithResult("<achievement_id>", 1);
      log(result.toString(), name: "earnIncrementalAchievement");
    } on PlatformException catch (e) {
      log(buildErrorMessage("growWithResult", e.code));
    }
  }

  /// Create an event on AppGallery Connect and enter the event id as parameter to the grow method
  /// in order to send game start event to your game on AppGallery Connect.
  void sendGameStartEvent() async {
    try {
      EventsClient.grow("<event_id>", 1);
    } on PlatformException catch (e) {
      log(buildErrorMessage("growWithResult", e.code));
    }
  }

  /// Updates stopwatch timer.
  void timerCallback(Timer timer) {
    if (stopwatch.isRunning) {
      setState(() {});
    }
  }

  /// Updates game logic.
  void _updateGame(HMSCardInfo info, int idx) {
    List<HMSCardInfo> hmsCards = HMSCards.of(context).cardInfos;
    if (hmsCards.fold(0, (prev, next) => prev + (next.selected ? 1 : 0)) > 2) {
      setState(() {
        int i = 0;
        HMSCards.of(context).cardInfos.forEach((f) {
          if (idx != i) f.selected = false;
          i++;
        });
        current = null;
      });
    }

    if (current == null) {
      current = info;
    } else {
      // Found a match
      if (info.name == current.name && info.idx != current.idx) {
        setState(() {
          HMSCards.of(context).cardInfos.forEach((card) {
            if (card.name == info.name) {
              card.isFound = true;
            }
          });
          current = null;
        });
      } else {
        // No match flip cards.
        setState(() {
          blockGameGesture = true;
        });
        Future.delayed(Duration(seconds: 1)).then((_) {
          setState(() {
            HMSCards.of(context).cardInfos.forEach((f) => f.selected = false);
          });
          setState(() {
            blockGameGesture = false;
          });
        });
      }
      current = null;
    }

    // Check if all cards are matched.
    if (hmsCards.fold(true, (prev, next) => prev & next.isFound)) {
      _endGame();
    }
  }

  void _startGame() {
    setState(() {
      // Played before so shuffle the cards.
      if (stopwatch.elapsedMilliseconds > 0) {
        widget.shuffleCards();
      }
      stopwatch.reset();
      blockGameGesture = true;
    });
    HMSCards.of(context).cardInfos.forEach((f) => f.selected = true);
    Future.delayed(Duration(seconds: 3)).then((_) {
      setState(() {
        HMSCards.of(context).cardInfos.forEach((f) => f.selected = false);
      });
      setState(() {
        blockGameGesture = false;
        stopwatch.start();
        isPlaying = true;
      });
      // Send game start event to AppGallery Connect.
      sendGameStartEvent();
      // Award the first achievement.
      earnFirstTimeAchievement();
      // Grow the step of incremental achievement.
      earnIncrementalAchievement();
    });
  }

  void _endGame() {
    setState(() {
      int score = stopwatch.elapsedMilliseconds;
      log("Congrats! You finished the game., Your score is: " +
          score.toString());
      stopwatch.stop();
      isPlaying = false;
      blockGameGesture = true;
      submitRankingScore(score);
      addArchive(score);
    });
  }

  void addArchive(int score) async {
    try {
      Uint8List thumbnail =
          (await rootBundle.load('assets/HuaweiLogo.png')).buffer.asUint8List();
      Uint8List bytes = Uint8List.fromList((score.toString()).codeUnits);
      ArchiveDetails archiveDetails = ArchiveDetails(bytes);
      ArchiveSummaryUpdate archiveSummaryUpdate = ArchiveSummaryUpdate(
        descInfo: "My saved score on ${DateTime.now()}.",
        thumbnailMimeType: 'png',
        thumbnail: thumbnail,
      );
      bool isSupportCache = false;

      final ArchiveSummary summary = await ArchivesClient.addArchive(
          archiveDetails, archiveSummaryUpdate, isSupportCache);
      log("Saved the score to archives: " + summary.toString());
    } on PlatformException catch (e) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(buildErrorMessage("addArchive", e.code))));
    }
  }

  /// In order to submit ranking scores, you should create a leaderboard on the AppGallery Connect and
  /// enter the Leaderboard ID as parameter to the method below.
  void submitRankingScore(int elapsedTime) async {
    try {
      final ScoreSubmissionInfo info =
          await RankingClient.submitScoreWithResult(
              "<leaderboard_id>", elapsedTime);
      log("Submitted the score to the leaderboard, score submission info is: $info");
    } on PlatformException catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(buildErrorMessage("submitRankingScore", e.code))));
    }
  }

  @override
  Widget build(BuildContext context) {
    hmsCards = HMSCards.of(context).cardInfos;

    buildCards() {
      List<Widget> cardWidgets = [];
      int i = 0;
      hmsCards.forEach((c) {
        cardWidgets.add(
          GameCard(
            onTap: (hmsCardInfo, idx) {
              _updateGame(hmsCardInfo, idx);
            },
            idx: i,
          ),
        );
        i++;
      });
      return cardWidgets;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.2,
            child: RaisedButton(
              color: Color.fromRGBO(173, 200, 255, 1),
              onPressed: isPlaying ? null : _startGame,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Play",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Time: "),
                Text(formatMilliseconds(stopwatch.elapsedMilliseconds))
              ],
            ),
          ),
          AbsorbPointer(
            absorbing: blockGameGesture,
            child: GridView.count(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 12.0,
              children: buildCards(),
            ),
          ),
        ],
      ),
    );
  }
}

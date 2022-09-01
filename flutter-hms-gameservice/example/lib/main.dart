/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_account/huawei_account.dart';
import 'package:huawei_gameservice/huawei_gameservice.dart';

void main() {
  runApp(const _MyApp());
}

class _MyApp extends StatelessWidget {
  const _MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _Home(),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home({Key? key}) : super(key: key);

  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  AuthAccount? authAccount;

  @override
  void initState() {
    super.initState();
    init();
  }

  /// Initializes the Game Service.
  ///
  /// This method should be called before calling any other API.
  void init() async {
    await JosAppsClient.init();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Warning'),
          content: Text(
            'To try Game Service methods, please add your Huawei ID to the test accounts for your account on AppGallery Connect.',
          ),
        );
      },
    );
  }

  Future<dynamic> signIn() async {
    final AccountAuthParamsHelper authParamsHelper = AccountAuthParamsHelper()
      ..setIdToken()
      ..setAccessToken()
      ..setAuthorizationCode()
      ..setEmail()
      ..setScopeList(<Scope>[Scope.game])
      ..setProfile();
    final AccountAuthParams authParams = authParamsHelper.createParams();
    final AccountAuthService authService = AccountAuthManager.getService(
      authParams,
    );
    final AuthAccount authAccount = await authService.signIn();
    setState(() => this.authAccount = authAccount);
    return authAccount.toMap();
  }

  Future<dynamic> getAppId() async {
    final String appId = await GamesClient.getAppId();
    return appId;
  }

  Future<dynamic> earnAchievement() async {
    // Reveals the hidden achievement.
    await AchievementClient.visualizeWithResult('<achievement_id>');
    // Awards the achievement.
    final bool result =
        await AchievementClient.reachWithResult('<achievement_id>');
    return result;
  }

  Future<dynamic> getGamePlayer() async {
    final Player gamePlayer = await PlayersClient.getGamePlayer(
      isRequirePlayerId: true,
    );
    return gamePlayer;
  }

  Future<dynamic> getGamePlayerStatistics() async {
    final GamePlayerStatistics gamePlayerStatistics =
        await GamePlayerStatisticsClient.getGamePlayerStatistics(true);
    return gamePlayerStatistics;
  }

  Future<dynamic> getGameSummary() async {
    final GameSummary gameSummary = await GameSummaryClient.getGameSummary();
    return gameSummary;
  }

  /// Create an achievement on AppGallery Connect and enter its id to the reachWithResult
  /// method below
  Future<dynamic> earnFirstTimeAchievement() async {
    final bool result =
        await AchievementClient.reachWithResult('<achievement_id>');
    return result;
  }

  /// Create an incremental achievement on AppGallery Connect and enter its id to the growWithResult
  /// method below.
  Future<dynamic> earnIncrementalAchievement() async {
    final bool result = await AchievementClient.growWithResult(
      '<achievement_id>',
      1,
    );
    return result;
  }

  /// Create an event on AppGallery Connect and enter the event id as parameter to the grow method
  /// in order to send game start event to your game on AppGallery Connect.
  Future<dynamic> sendGameStartEvent() async {
    await EventsClient.grow('<event_id>', 1);
  }

  /// In order to submit ranking scores, you should create a leaderboard on the AppGallery Connect and
  /// enter the Leaderboard ID as parameter to the method below.
  Future<dynamic> submitRankingScore() async {
    final ScoreSubmissionInfo info = await RankingClient.submitScoreWithResult(
      '<leaderboard_id>',
      30,
    );
    return info;
  }

  Future<dynamic> addArchive() async {
    const int score = 30;
    final Uint8List bytes = Uint8List.fromList(score.toString().codeUnits);
    final ArchiveDetails archiveDetails = ArchiveDetails(bytes);
    final ArchiveSummaryUpdate archiveSummaryUpdate = ArchiveSummaryUpdate(
      descInfo: 'My saved score on ${DateTime.now()}.',
    );
    final ArchiveSummary archiveSummary = await ArchivesClient.addArchive(
      archiveDetails,
      archiveSummaryUpdate,
      false,
    );
    return archiveSummary;
  }

  /// Showcase of ranking methods.
  Future<dynamic> showRankings() async {
    await RankingClient.showTotalRankingsIntent();
    // Obtains all leaderboards and their rankings.
    final List<Ranking> rankings =
        await RankingClient.getAllRankingSummaries(true);
    return rankings;
  }

  /// Showcase of achievement methods.
  Future<dynamic> showAchievements() async {
    // Displays all achievements.
    await AchievementClient.showAchievementListIntent();
    // Obtains all achievements.
    final List<Achievement> achievements =
        await AchievementClient.getAchievementList(true);
    return achievements;
  }

  /// Showcase of ranking methods.
  Future<dynamic> showSaves() async {
    // Displays all archives.
    await ArchivesClient.showArchiveListIntent(
      'Flutter Plugin Demo',
      true,
      true,
      10,
    );
    // Obtains all archive summaries.
    final List<ArchiveSummary> archiveSummaries =
        await ArchivesClient.getArchiveSummaryList(true);
    return archiveSummaries;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Huawei Game Service Demo'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              authAccount != null
                  ? 'Welcome, ${authAccount?.displayName}'
                  : 'Welcome',
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: <Widget>[
                  buildButton(
                    text: 'Sign In with Huawei ID',
                    onPressed: signIn,
                  ),
                  buildButton(
                    text: 'Get App Id',
                    onPressed: getAppId,
                  ),
                  const Divider(),
                  buildButton(
                    text: 'Get Game Player',
                    onPressed: getGamePlayer,
                  ),
                  buildButton(
                    text: 'Get Game Player Statistics',
                    onPressed: getGamePlayerStatistics,
                  ),
                  buildButton(
                    text: 'Get Game Summary',
                    onPressed: getGameSummary,
                  ),
                  const Divider(),
                  buildButton(
                    text: 'Send Game Start Event',
                    onPressed: sendGameStartEvent,
                  ),
                  buildButton(
                    text: 'Add Archive',
                    onPressed: addArchive,
                  ),
                  const Divider(),
                  buildButton(
                    text: 'Earn Achievement',
                    onPressed: earnAchievement,
                  ),
                  buildButton(
                    text: 'Earn First Time Achievement',
                    onPressed: earnFirstTimeAchievement,
                  ),
                  buildButton(
                    text: 'Earn Incremental Achievement',
                    onPressed: earnIncrementalAchievement,
                  ),
                  const Divider(),
                  buildButton(
                    text: 'Show Rankings',
                    onPressed: showRankings,
                  ),
                  buildButton(
                    text: 'Show Achievements',
                    onPressed: showAchievements,
                  ),
                  const Divider(),
                  buildButton(
                    text: 'Show Saves',
                    onPressed: showSaves,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton({
    required String text,
    required Future<dynamic> Function() onPressed,
  }) {
    return ElevatedButton(
      onPressed: () async {
        String dialogTitle;
        String dialogMessage;
        String logMessage;
        try {
          final dynamic result = await onPressed.call() ?? '';
          dialogTitle = 'SUCCESS';
          dialogMessage = '$result';
          logMessage = 'SUCCESS $result';
        } on PlatformException catch (e) {
          dialogTitle = 'FAILURE';
          dialogMessage = 'Exception: $e\n\n'
              'Code: ${e.code}\n'
              'Message: ${GameServiceResultCodes.getStatusCodeMessage(e.code)}';
          logMessage = 'FAILURE $e';
        }

        log(logMessage, name: text);
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(dialogTitle),
              content: dialogMessage.isNotEmpty
                  ? SingleChildScrollView(
                      child: Text(dialogMessage),
                    )
                  : null,
            );
          },
        );
      },
      child: Text(text),
    );
  }
}

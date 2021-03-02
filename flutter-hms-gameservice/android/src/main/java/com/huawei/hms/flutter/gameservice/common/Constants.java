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

package com.huawei.hms.flutter.gameservice.common;

import com.huawei.hms.flutter.gameservice.common.methodenum.EnumGetter;
import com.huawei.hms.flutter.gameservice.common.methodenum.MethodEnum;

public class Constants {
    private Constants() {
    }

    public static final String UNKNOWN_ERROR = "-1";

    public static final class Channel {
        private Channel() {
        }

        public static final String GAME_SERVICE_METHOD_CHANNEL = "com.huawei.hms.flutter.gameservice/method";
    }

    public enum ClientNames implements MethodEnum {
        ACHIEVEMENT("AchievementClient"),
        ARCHIVES("ArchivesClient"),
        BUOY("BuoyClient"),
        EVENTS("EventsClient"),
        GAME_PLAYER_STATS("GamePlayerStatisticsClient"),
        GAMES("GamesClient"),
        GAME_SUMMARY("GameSummaryClient"),
        PLAYERS("PlayersClient"),
        RANKINGS("RankingsClient"),
        HMS_LOGGER("HMSLogger");

        private final String value;

        private static EnumGetter<ClientNames> enumGetter = new EnumGetter<>(ClientNames.values());

        ClientNames(final String value) {
            this.value = value;
        }

        @Override
        public String getValue() {
            return value;
        }

        public static ClientNames getEnum(final String value) {
            return enumGetter.getEnum(value);
        }
    }

    public enum AchievementClientMethods implements MethodEnum {
        GET_SHOW_ACHIEVEMENT_LIST_INTENT("getShowAchievementListIntent"),
        GROW("grow"),
        GROW_WITH_RESULT("growWithResult"),
        GET_ACHIEVEMENT_LIST("getAchievementList"),
        VISUALIZE("visualize"),
        VISUALIZE_WITH_RESULT("visualizeWithResult"),
        MAKE_STEPS("makeSteps"),
        MAKE_STEPS_WITH_RESULT("makeStepsWithResult"),
        REACH("reach"),
        REACH_WITH_RESULT("reachWithResult");

        private String value;

        private static EnumGetter<AchievementClientMethods> enumGetter = new EnumGetter<>(
            AchievementClientMethods.values());

        AchievementClientMethods(final String value) {
            this.value = value;
        }

        @Override
        public String getValue() {
            return value;
        }

        public static AchievementClientMethods getEnum(final String value) {
            return enumGetter.getEnum(value);
        }
    }

    public enum ArchiveClientController implements MethodEnum {
        ADD_ARCHIVE("addArchive"),
        REMOVE_ARCHIVE("removeArchive"),
        GET_LIMIT_THUMBNAIL_SIZE("getLimitThumbnailSize"),
        GET_LIMIT_DETAILS_SIZE("getLimitDetailsSize"),
        SHOW_ARCHIVE_LIST_INTENT("showArchiveListIntent"),
        GET_ARCHIVE_SUMMARY_LIST("getArchiveSummaryList"),
        LOAD_ARCHIVE_DETAILS("loadArchiveDetails"),
        UPDATE_ARCHIVE_BY_DATA("updateArchiveByData"),
        UPDATE_ARCHIVE("updateArchive"),
        GET_THUMBNAIL("getThumbnail");

        private String value;

        private static EnumGetter<ArchiveClientController> enumGetter = new EnumGetter<>(
            ArchiveClientController.values());

        ArchiveClientController(final String value) {
            this.value = value;
        }

        @Override
        public String getValue() {
            return value;
        }

        public static ArchiveClientController getEnum(final String value) {
            return enumGetter.getEnum(value);
        }
    }

    public enum BuoyClientMethods implements MethodEnum {
        SHOW_FLOAT_WINDOW("showFloatWindow"),
        HIDE_FLOAT_WINDOW("hideFloatWindow");

        private String value;

        private static EnumGetter<BuoyClientMethods> enumGetter = new EnumGetter<>(BuoyClientMethods.values());

        BuoyClientMethods(final String value) {
            this.value = value;
        }

        @Override
        public String getValue() {
            return value;
        }

        public static BuoyClientMethods getEnum(final String value) {
            return enumGetter.getEnum(value);
        }
    }

    public enum EventsClientMethods implements MethodEnum {
        GROW("grow"),
        GET_EVENT_LIST("getEventList"),
        GET_EVENT_LIST_BY_IDS("getEventListByIds");

        private String value;

        private static EnumGetter<EventsClientMethods> enumGetter = new EnumGetter<>(EventsClientMethods.values());

        EventsClientMethods(final String value) {
            this.value = value;
        }

        @Override
        public String getValue() {
            return value;
        }

        public static EventsClientMethods getEnum(final String value) {
            return enumGetter.getEnum(value);
        }
    }

    public enum GamePlayerStatisticsClientMethods implements MethodEnum {
        GET_GAME_PLAYER_STATISTICS("getGamePlayerStatistics");

        private String value;

        private static EnumGetter<GamePlayerStatisticsClientMethods> enumGetter = new EnumGetter<>(
            GamePlayerStatisticsClientMethods.values());

        GamePlayerStatisticsClientMethods(final String value) {
            this.value = value;
        }

        @Override
        public String getValue() {
            return value;
        }

        public static GamePlayerStatisticsClientMethods getEnum(final String value) {
            return enumGetter.getEnum(value);
        }
    }

    public enum GamesClientMethods implements MethodEnum {
        GET_APP_ID("getAppId"),
        SET_POPUPS_POSITION("setPopupsPosition"),
        CANCEL_GAME_SERVICE("cancelGameService");

        private String value;

        private static EnumGetter<GamesClientMethods> enumGetter = new EnumGetter<>(GamesClientMethods.values());

        GamesClientMethods(final String value) {
            this.value = value;
        }

        @Override
        public String getValue() {
            return value;
        }

        public static GamesClientMethods getEnum(final String value) {
            return enumGetter.getEnum(value);
        }
    }

    public enum GamesSummaryClientMethods implements MethodEnum {
        GET_LOCAL_GAME_SUMMARY("getLocalGameSummary"),
        GET_GAME_SUMMARY("getGameSummary");

        private String value;

        private static EnumGetter<GamesSummaryClientMethods> enumGetter = new EnumGetter<>(
            GamesSummaryClientMethods.values());

        GamesSummaryClientMethods(final String value) {
            this.value = value;
        }

        @Override
        public String getValue() {
            return value;
        }

        public static GamesSummaryClientMethods getEnum(final String value) {
            return enumGetter.getEnum(value);
        }
    }

    public enum PlayersClientMethods implements MethodEnum {
        GET_CURRENT_PLAYER("getCurrentPlayer"),
        GET_GAME_PLAYER("getGamePlayer"),
        GET_CACHE_PLAYER_ID("getCachePlayerId"),
        GET_PLAYER_EXTRA_INFO("getPlayerExtraInfo"),
        SUBMIT_PLAYER_EVENT("submitPlayerEvent"),
        SAVE_PLAYER_INFO("savePlayerInfo"),
        SET_GAME_TRIAL_PROCESS("setGameTrialProcess");

        private String value;

        private static EnumGetter<PlayersClientMethods> enumGetter = new EnumGetter<>(PlayersClientMethods.values());

        PlayersClientMethods(final String value) {
            this.value = value;
        }

        @Override
        public String getValue() {
            return value;
        }

        public static PlayersClientMethods getEnum(final String value) {
            return enumGetter.getEnum(value);
        }
    }

    public enum RankingsClientMethods implements MethodEnum {
        GET_TOTAL_RANKINGS_INTENT("getTotalRankingsIntent"),
        GET_RANKING_INTENT("getRankingIntent"),
        GET_CURRENT_PLAYER_RANKING_SCORE("getCurrentPlayerRankingScore"),
        GET_RANKING_SUMMARY("getRankingSummary"),
        GET_ALL_RANKING_SUMMARIES("getAllRankingSummaries"),
        GET_MORE_RANKING_SCORES("getMoreRankingScores"),
        GET_PLAYER_CENTERED_RANKING_SCORES("getPlayerCenteredRankingScores"),
        GET_RANKING_TOP_SCORES("getRankingTopScores"),
        SUBMIT_RANKING_SCORES("submitRankingScores"),
        SUBMIT_SCORE_WITH_RESULT("submitScoreWithResult"),
        GET_RANKING_SWITCH_STATUS("getRankingSwitchStatus"),
        SET_RANKING_SWITCH_STATUS("setRankingSwitchStatus");

        private String value;

        private static EnumGetter<RankingsClientMethods> enumGetter = new EnumGetter<>(RankingsClientMethods.values());

        RankingsClientMethods(final String value) {
            this.value = value;
        }

        @Override
        public String getValue() {
            return value;
        }

        public static RankingsClientMethods getEnum(final String value) {
            return enumGetter.getEnum(value);
        }
    }

    public enum HMSLoggerMethods implements MethodEnum {
        ENABLE_LOGGER("enableLogger"),
        DISABLE_LOGGER("disableLogger");

        private String value;

        private static EnumGetter<HMSLoggerMethods> enumGetter = new EnumGetter<>(HMSLoggerMethods.values());

        HMSLoggerMethods(final String value) {
            this.value = value;
        }

        @Override
        public String getValue() {
            return value;
        }

        public static HMSLoggerMethods getEnum(final String value) {
            return enumGetter.getEnum(value);
        }
    }
}

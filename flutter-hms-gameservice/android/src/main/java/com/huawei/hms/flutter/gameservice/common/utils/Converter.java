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

package com.huawei.hms.flutter.gameservice.common.utils;

import android.content.Intent;
import android.util.Log;

import com.huawei.hms.jos.games.RankingsClient;
import com.huawei.hms.jos.games.achievement.Achievement;
import com.huawei.hms.jos.games.archive.Archive;
import com.huawei.hms.jos.games.archive.ArchiveSummary;
import com.huawei.hms.jos.games.archive.OperationResult;
import com.huawei.hms.jos.games.event.Event;
import com.huawei.hms.jos.games.gamesummary.GameSummary;
import com.huawei.hms.jos.games.player.Player;
import com.huawei.hms.jos.games.player.PlayerExtraInfo;
import com.huawei.hms.jos.games.playerstats.GamePlayerStatistics;
import com.huawei.hms.jos.games.ranking.Ranking;
import com.huawei.hms.jos.games.ranking.RankingScore;
import com.huawei.hms.jos.games.ranking.RankingVariant;
import com.huawei.hms.jos.games.ranking.ScoreSubmissionInfo;
import com.huawei.hms.jos.product.ProductOrderInfo;
import com.huawei.updatesdk.service.appmgr.bean.ApkUpgradeInfo;
import com.huawei.updatesdk.service.otaupdate.UpdateKey;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Converter {
    private static final String TAG = "HMSConverter";

    private Converter() {
    }

    public static <T> List<Map<String, Object>> listResponseToMap(List<T> object, Class<T> type) {
        List<Map<String, Object>> list = new ArrayList<>();
        if (object != null) {
            for (int i = 0; i < object.size(); i++) {
                T innerObj = type.cast(object.get(i));
                if (innerObj instanceof Achievement) {
                    list.add(achievementToMap((Achievement) object.get(i)));
                } else if (innerObj instanceof Ranking) {
                    list.add(rankingToMap((Ranking) object.get(i)));
                } else if (innerObj instanceof Event) {
                    list.add(eventToMap((Event) object.get(i)));
                } else if (innerObj instanceof ArchiveSummary) {
                    list.add(archiveSummaryToMap((ArchiveSummary) innerObj));
                } else if (innerObj instanceof ProductOrderInfo) {
                    list.add(productOrderInfoToMap((ProductOrderInfo) innerObj));
                }
            }
        }
        return list;
    }

    public static <T> Map<String, Object> toMap(T object, String clientName) {
        switch (clientName) {
            case "PlayersClient":
                return playerClientResponseToMap(object);
            case "RankingsClient":
                return rankingsClientResponseToMap(object);
            case "GameSummaryClient":
                return gameSummaryToMap((GameSummary) object);
            case "GamePlayerStatisticsClient":
                return gamePlayerStatisticsToMap((GamePlayerStatistics) object);
            case ("ArchivesClient"):
                return archivesClientResponseToMap(object);
            default:
                throw new IllegalArgumentException();
        }
    }

    private static <T> Map<String, Object> playerClientResponseToMap(T object) {
        Map<String, Object> map = new HashMap<>();
        if (object instanceof Player) {
            map = playerToMap((Player) object);
        } else if (object instanceof PlayerExtraInfo) {
            map = playerExtraInfoToMap((PlayerExtraInfo) object);
        }
        return map;
    }

    private static <T> Map<String, Object> rankingsClientResponseToMap(T object) {
        Map<String, Object> map = new HashMap<>();
        if (object instanceof RankingScore) {
            map = rankingScoreToMap((RankingScore) object);
        } else if (object instanceof Ranking) {
            map = rankingToMap((Ranking) object);
        } else if (object instanceof RankingsClient.RankingScores) {
            map = clientRankingScoresToMap((RankingsClient.RankingScores) object);
        } else if (object instanceof ScoreSubmissionInfo) {
            map = scoreSubmissionInfoToMap((ScoreSubmissionInfo) object);
        }
        return map;
    }

    private static <T> Map<String, Object> archivesClientResponseToMap(T object) {
        Map<String, Object> map = new HashMap<>();
        if (object instanceof ArchiveSummary) {
            map = archiveSummaryToMap((ArchiveSummary) object);
        } else if (object instanceof OperationResult) {
            map = operationResultToMap((OperationResult) object);
        }
        return map;
    }

    // ARCHIVE CLIENT
    private static Map<String, Object> archiveSummaryToMap(ArchiveSummary summary) {
        Map<String, Object> map = new HashMap<>();
        map.put("activeTime", summary.getActiveTime());
        map.put("currentProgress", summary.getCurrentProgress());
        map.put("descInfo", summary.getDescInfo());
        map.put("fileName", summary.getFileName());
        map.put("id", summary.getId());
        map.put("recentUpdateTime", summary.getRecentUpdateTime());
        map.put("hasThumbnail", summary.hasThumbnail());
        map.put("gamePlayer", summary.getGamePlayer() == null ? null : playerToMap(summary.getGamePlayer()));
        map.put("thumbnailRatio", summary.getThumbnailRatio());
        map.put("gameSummary", summary.getGameSummary() == null ? null : gameSummaryToMap(summary.getGameSummary()));
        return map;
    }

    private static Map<String, Object> operationResultToMap(OperationResult operationResult) {
        Map<String, Object> map = new HashMap<>();
        map.put("archive", operationResult.getArchive() == null ? null : archiveToMap(operationResult.getArchive()));
        map.put("isDifference", operationResult.isDifference());
        map.put("difference",
            operationResult.getDifference() == null ? null : differenceToMap(operationResult.getDifference()));
        return map;
    }

    private static Map<String, Object> archiveToMap(Archive archive) {
        Map<String, Object> map = new HashMap<>();
        map.put("summary", archive.getSummary() == null ? null : archiveSummaryToMap(archive.getSummary()));
        try {
            map.put("details", archive.getDetails() == null ? null : archive.getDetails().get());
        } catch (IOException e) {
            Log.i(TAG, "Could not parse details of the archive.");
        }
        return map;
    }

    private static Map<String, Object> differenceToMap(OperationResult.Difference difference) {
        Map<String, Object> map = new HashMap<>();
        map.put("serverArchive",
            difference.getServerArchive() == null ? null : archiveToMap(difference.getServerArchive()));
        map.put("recentArchive",
            difference.getRecentArchive() == null ? null : archiveToMap(difference.getRecentArchive()));
        try {
            map.put("descInfo",
                difference.getEmptyArchiveDetails() == null ? null : difference.getEmptyArchiveDetails().get());
        } catch (IOException e) {
            Log.i(TAG, "Could not parse details of the OperationResult.Difference.");
        }
        return map;
    }

    // PLAYER CLIENT
    public static Map<String, Object> playerToMap(Player player) {
        Map<String, Object> map = new HashMap<>();
        map.put("displayName", player.getDisplayName());
        map.put("hiResImageUri", player.getHiResImageUri() == null ? null : player.getHiResImageUri().toString());
        map.put("iconImageUri", player.getIconImageUri() == null ? null : player.getIconImageUri().toString());
        map.put("level", player.getLevel());
        map.put("playerId", player.getPlayerId());
        map.put("hasHiResImage", player.hasHiResImage());
        map.put("hasIconImage", player.hasIconImage());
        map.put("playerSign", player.getPlayerSign());
        map.put("signTs", player.getSignTs());
        map.put("openId", player.getOpenId());
        map.put("unionId", player.getUnionId());
        map.put("accessToken", player.getAccessToken());
        map.put("openIdSign", player.getOpenIdSign());
        return map;
    }

    public static Map<String, Object> playerExtraInfoToMap(PlayerExtraInfo playerExtraInfo) {
        Map<String, Object> map = new HashMap<>();
        map.put("isAdult", playerExtraInfo.getIsAdult());
        map.put("playerId", playerExtraInfo.getPlayerId());
        map.put("openId", playerExtraInfo.getOpenId());
        map.put("playerDuration", playerExtraInfo.getPlayerDuration());
        map.put("isRealName", playerExtraInfo.getIsRealName());
        return map;
    }

    // RANKING CLIENT
    public static Map<String, Object> rankingScoreToMap(RankingScore rankingScore) {
        Map<String, Object> map = new HashMap<>();
        map.put("displayRank", rankingScore.getDisplayRank());
        map.put("rankingDisplayScore", rankingScore.getRankingDisplayScore());
        map.put("playerRank", rankingScore.getPlayerRank());
        map.put("playerRawScore", rankingScore.getPlayerRawScore());
        map.put("scoreOwnerPlayer",
            rankingScore.getScoreOwnerPlayer() == null ? null : playerToMap(rankingScore.getScoreOwnerPlayer()));
        map.put("scoreOwnerDisplayName", rankingScore.getScoreOwnerDisplayName());
        map.put("scoreOwnerHiIconUri",
            rankingScore.getScoreOwnerHiIconUri() == null ? null : rankingScore.getScoreOwnerHiIconUri().toString());
        map.put("scoreOwnerIconUri",
            rankingScore.getScoreOwnerIconUri() == null ? null : rankingScore.getScoreOwnerIconUri().toString());
        map.put("scoreTips", rankingScore.getScoreTips());
        map.put("scoreTimeStamp", rankingScore.getScoreTimestamp());
        map.put("timeDimension", rankingScore.getTimeDimension());
        return map;
    }

    public static Map<String, Object> rankingVariantToMap(RankingVariant rankingVariant) {
        Map<String, Object> map = new HashMap<>();
        map.put("displayRanking", rankingVariant.getDisplayRanking());
        map.put("playerDisplayScore", rankingVariant.getPlayerDisplayScore());
        map.put("rankTotalScoreNum", rankingVariant.getRankTotalScoreNum());
        map.put("playerRank", rankingVariant.getPlayerRank());
        map.put("playerScoreTips", rankingVariant.getPlayerScoreTips());
        map.put("playerRawScore", rankingVariant.getPlayerRawScore());
        map.put("timeDimension", rankingVariant.timeDimension());
        map.put("hasPlayerInfo", rankingVariant.hasPlayerInfo());
        return map;
    }

    private static List<Map<String, Object>> rankingVariantsToList(ArrayList<RankingVariant> rankingVariants) {
        List<Map<String, Object>> rankingVs = new ArrayList<>();
        for (RankingVariant variant : rankingVariants) {
            rankingVs.add(rankingVariantToMap(variant));
        }
        return rankingVs;
    }

    public static Map<String, Object> rankingToMap(Ranking ranking) {
        Map<String, Object> map = new HashMap<>();
        map.put("rankingDisplayName", ranking.getRankingDisplayName());
        map.put("rankingImageUri",
            ranking.getRankingImageUri() == null ? null : ranking.getRankingImageUri().toString());
        map.put("rankingId", ranking.getRankingId());
        map.put("rankingScoreOrder", ranking.getRankingScoreOrder());
        map.put("rankingVariants",
            ranking.getRankingVariants() == null ? null : rankingVariantsToList(ranking.getRankingVariants()));
        return map;
    }

    private static List<Map<String, Object>> rankingScoresToList(List<RankingScore> rankingScores) {
        List<Map<String, Object>> rankingScs = new ArrayList<>();
        for (RankingScore score : rankingScores) {
            rankingScs.add(rankingScoreToMap(score));
        }
        return rankingScs;
    }

    public static Map<String, Object> clientRankingScoresToMap(RankingsClient.RankingScores rankingScores) {
        Map<String, Object> map = new HashMap<>();
        map.put("ranking", rankingScores.getRanking() == null ? null : rankingToMap(rankingScores.getRanking()));
        map.put("rankingScores",
            rankingScores.getRankingScores() == null ? null : rankingScoresToList(rankingScores.getRankingScores()));
        return map;
    }

    public static Map<Integer, Object> submissionScoreResultToMap(ScoreSubmissionInfo scoreSubmissionInfo) {
        Map<Integer, Object> map = new HashMap<>();
        map.put(0, scoreSubmissionInfo.getSubmissionScoreResult(0) == null
            ? null
            : scoreSubmissionInfoResultToMap(scoreSubmissionInfo.getSubmissionScoreResult(0)));
        map.put(1, scoreSubmissionInfo.getSubmissionScoreResult(1) == null
            ? null
            : scoreSubmissionInfoResultToMap(scoreSubmissionInfo.getSubmissionScoreResult(1)));
        map.put(2, scoreSubmissionInfo.getSubmissionScoreResult(2) == null
            ? null
            : scoreSubmissionInfoResultToMap(scoreSubmissionInfo.getSubmissionScoreResult(2)));
        return map;
    }

    public static Map<String, Object> scoreSubmissionInfoResultToMap(ScoreSubmissionInfo.Result result) {
        Map<String, Object> map = new HashMap<>();
        map.put("displayScore", result.displayScore);
        map.put("isBest", result.isBest);
        map.put("playerRawScore", result.playerRawScore);
        map.put("scoreTips", result.scoreTips);
        return map;
    }

    public static Map<String, Object> scoreSubmissionInfoToMap(ScoreSubmissionInfo scoreSubmissionInfo) {
        Map<String, Object> map = new HashMap<>();
        map.put("rankingId", scoreSubmissionInfo.getRankingId());
        map.put("playerId", scoreSubmissionInfo.getPlayerId());
        map.put("submissionScoreResult", submissionScoreResultToMap(scoreSubmissionInfo));
        return map;
    }

    // ACHIEVEMENT CLIENT
    public static Map<String, Object> achievementToMap(Achievement achievement) {
        Map<String, Object> map = new HashMap<>();
        map.put("id", achievement.getId());
        map.put("reachedSteps", achievement.getReachedSteps());
        map.put("descInfo", achievement.getDescInfo());
        map.put("localeReachedSteps", achievement.getLocaleReachedSteps());
        map.put("locateAllSteps", achievement.getLocaleAllSteps());
        map.put("recentUpdateTime", achievement.getRecentUpdateTime());
        map.put("displayName", achievement.getDisplayName());
        map.put("gamePlayer", achievement.getGamePlayer() == null ? null : playerToMap(achievement.getGamePlayer()));
        map.put("visualizedThumbnailUri", achievement.getVisualizedThumbnailUri() == null
            ? null
            : achievement.getVisualizedThumbnailUri().toString());
        map.put("state", achievement.getState());
        map.put("allSteps", achievement.getAllSteps());
        map.put("type", achievement.getType());
        map.put("reachedThumbnailUri",
            achievement.getReachedThumbnailUri() == null ? null : achievement.getReachedThumbnailUri().toString());
        return map;
    }

    public static Map<String, Object> eventToMap(Event event) {
        Map<String, Object> map = new HashMap<>();
        map.put("description", event.getDescription());
        map.put("eventId", event.getEventId());
        map.put("localeValue", event.getLocaleValue());
        map.put("thumbnailUrl", event.getThumbnailUri() == null ? null : event.getThumbnailUri().toString());
        map.put("name", event.getName());
        map.put("gamePlayer", event.getGamePlayer() == null ? null : playerToMap(event.getGamePlayer()));
        map.put("value", event.getValue());
        map.put("isVisible", event.isVisible());
        return map;
    }

    public static Map<String, Object> gameSummaryToMap(GameSummary gameSummary) {
        Map<String, Object> map = new HashMap<>();
        map.put("achievementCount", gameSummary.getAchievementCount());
        map.put("appId", gameSummary.getAppId());
        map.put("descInfo", gameSummary.getDescInfo());
        map.put("gameName", gameSummary.getGameName());
        map.put("gameHdImgUri",
            gameSummary.getGameHdImgUri() == null ? null : gameSummary.getGameHdImgUri().toString());
        map.put("gameIconUri", gameSummary.getGameIconUri() == null ? null : gameSummary.getGameIconUri().toString());
        map.put("rankingCount", gameSummary.getRankingCount());
        map.put("firstKind", gameSummary.getFirstKind());
        map.put("secondKind", gameSummary.getSecondKind());
        return map;
    }

    public static Map<String, Object> gamePlayerStatisticsToMap(GamePlayerStatistics gamePlayerStatistics) {
        Map<String, Object> map = new HashMap<>();
        map.put("averageOnLineMinutes", gamePlayerStatistics.getAverageOnLineMinutes());
        map.put("daysFromLastGame", gamePlayerStatistics.getDaysFromLastGame());
        map.put("paymentTimes", gamePlayerStatistics.getPaymentTimes());
        map.put("onlineTimes", gamePlayerStatistics.getOnlineTimes());
        map.put("totalPurchasesAmountRange", gamePlayerStatistics.getTotalPurchasesAmountRange());
        return map;
    }

    public static Map<String, Object> productOrderInfoToMap(ProductOrderInfo productOrderInfo) {
        Map<String, Object> map = new HashMap<>();
        map.put("tradeId", productOrderInfo.getTradeId());
        map.put("productNo", productOrderInfo.getProductNo());
        map.put("orderId", productOrderInfo.getOrderId());
        map.put("sign", productOrderInfo.getSign());
        return map;
    }

    public static ApkUpgradeInfo apkUpgradeInfoFromMap(Map<String, Object> args) {
        ApkUpgradeInfo apkUpgradeInfo = new ApkUpgradeInfo();

        apkUpgradeInfo.setName_((String) args.get("name"));
        apkUpgradeInfo.setId_((String) args.get("id"));
        apkUpgradeInfo.setReleaseDate_((String) args.get("releaseDate"));
        if (args.get("versionCode") != null) {
            apkUpgradeInfo.setVersionCode_((int) args.get("versionCode"));
        }
        apkUpgradeInfo.setPackage_((String) args.get("package"));
        apkUpgradeInfo.setIcon_((String) args.get("icon"));
        apkUpgradeInfo.setDownurl_((String) args.get("downUrl"));
        if (args.get("size") != null) {
            apkUpgradeInfo.setSize_(((Number) args.get("size")).longValue());
        }
        if (args.get("diffSize") != null) {
            apkUpgradeInfo.setDiffSize_((int) args.get("diffSize"));
        }
        apkUpgradeInfo.setVersion_((String) args.get("version"));
        if (args.get("isSignatureDifferent") != null) {
            apkUpgradeInfo.setSameS_((int) args.get("isSignatureDifferent"));
        }
        apkUpgradeInfo.setNewFeatures_((String) args.get("newFeatures"));
        apkUpgradeInfo.setReleaseDateDesc_((String) args.get("releaseDateDesc"));
        apkUpgradeInfo.setDetailId_((String) args.get("detailId"));
        if (args.get("isCompulsoryUpdate") != null) {
            apkUpgradeInfo.setIsCompulsoryUpdate_((int) args.get("isCompulsoryUpdate"));
        }
        if (args.get("devType") != null) {
            apkUpgradeInfo.setDevType_((int) args.get("devType"));
        }
        apkUpgradeInfo.setOldVersionName_((String) args.get("oldVersionName"));
        if (args.get("oldVersionCode") != null) {
            apkUpgradeInfo.setOldVersionCode_((int) args.get("oldVersionCode"));
        }
        apkUpgradeInfo.setNotRcmReason_((String) args.get("notRcmReason"));
        apkUpgradeInfo.setSha256_((String) args.get("sha256"));
        return apkUpgradeInfo;

    }

    public static Map<String, Object> apkUpgradeInfoToMap(Serializable apkUpgradeInfo) {
        ApkUpgradeInfo info = (ApkUpgradeInfo) apkUpgradeInfo;
        Map<String, Object> map = new HashMap<>();
        map.put("name", info.getName_());
        map.put("id", info.getId_());
        map.put("releaseDate", info.getReleaseDate_());
        map.put("versionCode", info.getVersionCode_());
        map.put("package", info.getPackage_());
        map.put("icon", info.getIcon_());
        map.put("downUrl", info.getDownurl_());
        map.put("diffSize", info.getDiffSize_());
        map.put("version", info.getVersion_());
        map.put("isSignatureDifferent", info.getSameS_());
        map.put("newFeatures", info.getNewFeatures_());
        map.put("releaseDateDesc", info.getReleaseDateDesc_());
        map.put("detailId", info.getDetailId_());
        map.put("isCompulsoryUpdate", info.getIsCompulsoryUpdate_());
        map.put("devType", info.getDevType_());
        map.put("oldVersionName", info.getOldVersionName_());
        map.put("oldVersionCode", info.getOldVersionCode_());
        map.put("notRcmReason", info.getNotRcmReason_());
        map.put("sha256", info.getSha256_());
        return map;
    }

    public static Map<String, Object> updateInfoToMap(Intent intent) {
        Map<String, Object> map = new HashMap<>();
        Serializable info = intent.getSerializableExtra(UpdateKey.INFO);
        map.put(UpdateKey.STATUS, intent.getIntExtra(UpdateKey.STATUS, -1));
        map.put(UpdateKey.FAIL_CODE, intent.getIntExtra(UpdateKey.FAIL_CODE, -1));
        map.put(UpdateKey.FAIL_REASON, intent.getStringExtra(UpdateKey.FAIL_REASON));
        map.put(UpdateKey.MUST_UPDATE, intent.getBooleanExtra(UpdateKey.MUST_UPDATE, false));
        map.put(UpdateKey.BUTTON_STATUS, intent.getIntExtra(UpdateKey.BUTTON_STATUS, -1));
        map.put(UpdateKey.INFO, info instanceof ApkUpgradeInfo ? apkUpgradeInfoToMap(info) : null);
        return map;
    }

}


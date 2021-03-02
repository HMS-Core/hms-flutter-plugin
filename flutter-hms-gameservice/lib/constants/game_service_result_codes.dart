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

/// Defines the Huawei Game Service result codes.
class GameServiceResultCodes {
  /// Status codes map of the Game Service Flutter Plugin.
  static const Map codes = {
    /// Success message.
    "0": "Success.",

    /// [Solution:] Call the corresponding API again. If the failure persists,
    /// contact Huawei technical support.
    "-1": "Common game API failure.",

    /// [Solution:] Call the corresponding API again. If the failure persists,
    /// contact Huawei technical support.
    "7001": "Common error.",

    /// [Solution:] Ensure that the network is normal and that the service
    /// address setting on HUAWEI AppGallery is correct.
    "7002":
        "Network error or incorrect service address setting on HUAWEI AppGallery.",

    /// [Solution:] Call the corresponding API again when necessary.
    "7003": "The user cancels the operation.",

    /// [Solution:] If a user cancels sign-in, you can instruct the user to sign
    /// in again.
    "7004": "The user cancels the sign-in.",

    /// [Solution:] Check the API input parameter setting. If the setting is
    /// correct but the failure persists, contact Huawei technical support.
    "7005": "Incorrect input parameters.",

    /// [Solution:] Ensure that the country or region where the player is
    /// located supports Game Service.
    "7006": "Game Service is unavailable in the region.",

    /// [Solution:] The current device does not support hardware registration.
    /// You can ignore this error.
    "7010": "The current device does not support Game Service.",

    /// [Solution:] Check whether the API input parameter is empty. If the parameter
    /// is empty but the failure persists, contact Huawei technical support.
    "7011": "Empty input parameter.",

    /// [Solution:] An API cannot be called repeatedly within 10 seconds.
    "7012": "Repeated API call.",

    /// [Solution:] Call the authorization API of HUAWEI Account Flutter Plugin
    /// to instruct the user to complete account authorization.
    "7013": "The HUAWEI ID is not signed in.",

    /// [Solution:] The user has completed identity verification, and the
    /// relevant API does not need to be called again.
    "7016": "The user has completed identity verification.",

    /// [Solution:] Check the parameter setting. If the setting is correct but
    /// the failure persists, contact Huawei technical support.
    "7017": "Incorrect system settings (game registration failure).",

    /// [Solution:] The init API is not called. Call the init API before
    /// calling any Game Service API.
    "7018": "The initialization API is not called.",

    /// [Solution:] The HUAWEI ID has been switched. Please call the authorization
    /// API of Account Plgin again to instruct the user to perform authorization
    /// and sign in to your game again.
    "7019": "The signed-in HUAWEI ID is different from that of the device.",

    /// [Solution:] No basic information about the game is found. Check whether
    /// the game has been released on HUAWEI AppGallery. If the failure persists,
    /// contact Huawei technical support.
    "7020": "No game is found when obtaining the basic game information.",

    /// [Solution:] The user has canceled identity verification and API calling
    /// cannot continue. Please instruct the user to complete identity
    /// verification again.
    "7021": "The user has canceled identity verification.",

    /// [Solution:] If the user has not performed identity verification,
    /// instruct the user to do so. If the user is an adult, real-name duration
    /// statistics are not required.
    "7022":
        "The real-name duration statistics function is not supported for adult users or users whose identity is not verified.",

    /// [Solution:] The API for obtaining basic player information is called too
    /// frequently. Call the API only when necessary. In other cases, you can
    /// also obtain player information from the cache.
    "7023": "Too frequent calls.",

    /// [Solution:] Instruct the user to install or upgrade HUAWEI AppGallery
    /// to the latest version.
    "7024":
        "The HUAWEI AppGallery APK has not been installed, or the HUAWEI AppGallery version does not support this function.",

    /// [Solution:] Check whether the achievement is an incremental achievement.
    /// If so, contact Huawei technical support.
    "7200": "The achievement is not increased.",

    /// [Solution:] Check whether the achievement ID is the same as that created
    /// in AppGallery Connect. If so, contact Huawei technical support.
    "7201": "The achievement is not found.",

    /// [Solution:] The incremental achievement increases and the achievement is
    /// unlocked. Deliver the achievement to the player.
    "7202": "The achievement is unlocked.",

    /// [Solution:] The achievement has been unlocked and cannot be unlocked again.
    "7203": "The achievement fails to be unlocked.",

    /// [Solution:] You can ignore the result code. The user will be instructed
    /// to install HUAWEI AppAssistant.
    "7204":
        "HUAWEI AppAssistant does not support achievement display. (The EMUI version is earlier than 10.0, HUAWEI AppAssistant is not installed, the HUAWEI AppAssistant version is earlier than 10.1, or the app has not been released.)",

    /// [Solution:] You can ignore the result code. The user will be instructed
    /// to install HUAWEI AppAssistant.
    "7205":
        "HUAWEI AppAssistant does not support leaderboard display. (The EMUI version is earlier than 10.0, HUAWEI AppAssistant is not installed, the HUAWEI AppAssistant version is earlier than 10.3, or the app has not been released.)",

    /// [Solution:] Obtain the archive list again.
    "7207": "The conflict does not exist.",

    /// [Solution:] Obtain the saved game list again.
    "7208": "An error occurred when reading the content of the archive file.",

    /// [Solution:] Contact Huawei technical support.
    "7209": "Failed to create the archive.",

    /// [Solution:] Contact Huawei technical support.
    "7210":
        "The root folder for the archive is not found or cannot be created when the archive is submitted",

    /// [Solution:] Check whether the archive has been deleted.
    /// You are advised to obtain the archive list again.
    "7211": "The specified archive does not exist.",

    /// [Solution:] You can ignore the result code. The user will be instructed
    /// to install HUAWEI AppAssistant.
    "7212":
        "HUAWEI AppAssistant does not support saved game display. (The EMUI version is earlier than 10.0, HUAWEI AppAssistant is not installed, the HUAWEI AppAssistant version is earlier than 10.3, or the app has not been released.)",

    /// [Solution:] Delete some earlier archives, or instruct the player to
    /// manually delete some archives.
    "7213": "The number of archives has reached the upper limit.",

    /// [Solution:] If the cover image size exceeds 200 KB, please cut the image.
    /// If the archive file size exceeds 3 MB, please change the archive file setting.
    "7214":
        "The size of the archive image or file has reached the upper limit.",

    /// [Solution:] Check whether the leaderboard ID is the same as that
    /// configured in AppGallery Connect. If so, contact Huawei technical support.
    "7215": "No leaderboard data found.",

    /// [Solution:] Ensure that the archive cover image is in JPG or PNG format.
    "7216": "Unsupported archive image format.",

    /// [Solution:] The locally cached archive will be submitted to Huawei game
    /// server when the network connection is recovered.
    "7217": "The archive is not uploaded, but only cached locally.",

    /// [Solution:] You can ignore the result code. The AppGallery agreement
    /// will be autocratically displayed to the user for signing.
    "7218":
        "Game Service authorization fails. The user does not agree to the AppGallery agreement.",

    /// [Solution:] Instruct the user to the page (https://cloud.huawei.com/)
    /// for enabling Drive Kit and signing the Drive Kit user agreement.
    "7219": "The user has not enabled HUAWEI Drive Kit.",
  };

  /// Returns the error description according to the result code.
  static getStatusCodeMessage(String statusCode) {
    if (codes.containsKey(statusCode)) {
      return codes[statusCode];
    } else
      return 'UNKNOWN_ERROR';
  }
}

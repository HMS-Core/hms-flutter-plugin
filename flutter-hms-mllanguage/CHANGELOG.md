## 3.12.0+300

- Minor optimization.

## 3.11.0+300

- **Real-time translation**:

  - Additionally supported Lithuanian and Georgian.

- **Text to speech**:

  - Supported Russian in Russia.


## 3.7.0+300

- Added `setUserRegion` and `getCountryCode` methods to **MLLanguageApp**.
- Added following constants to **MLTtsConstants**: `TTS_SPEAKER_MALE_ZH_2`, `TTS_SPEAKER_FEMALE_ZH_2`, `TTS_SPEAKER_MALE_EN_2`, and `TTS_SPEAKER_FEMALE_EN_2`.

- **On-device translation**:

  - Supported Croatian, Macedonian, Urdu, Maltese, Bosnian, Icelandic, Bulgarian, Ukrainian, Catalan, Slovenian, Bengali, and Georgian. (Note that Maltese, Bosnian, Icelandic, and Georgian are not supported by on-device language detection.)
  - Additionally supported the following languages: Marathi, Punjabi, Telugu, and Malagasy. (Note that Malagasy is not supported by on-device language detection.)

- **Real-time translation**:

  - Added Afrikaans to the list of languages supported. (Note that this language is available only in Asia, Africa, and Latin America.)
  - Additionally supported the following languages: Marathi, Gujarati, Punjabi, and Telugu.
  - Supported Malagasy and Swahili.
  - Supported Albanian, Welsh, Irish, and Haitian Creole.
  - Supported direct translation between Chinese and French, Chinese and German, Chinese and Japanese, and Chinese and Russian.
  - Supported direct translation between Chinese and Korean, Chinese and Spanish, Chinese and Portuguese, and Chinese and Turkish.

- **Breaking Changes:**

  - With this release, `PermissionClient` has been removed. You are expected to handle required permissions on your own. You can learn more about the required permissions from our [official documentations](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/assigning-permissions-0000001052789343?ha_source=hms1).
  - Modified the internal structure of the plugin. Please use import **package:huawei_ml_language/huawei_ml_language.dart** not to get any errors.

  **Updated API List**

  - MLLanguageApp:
    - Return type of `setApiKey` changed to `Future<void>` from `void`.
    - Return type of `setAccessToken` changed to `Future<void>` from `void`.
    - Return type of `enableLogger` changed to `Future<void>` from `void`.
    - Return type of `disableLogger` changed to `Future<void>` from `void`.

## 3.2.0+301

- Deleted the capability of prompting users to install HMS Core (APK).

## 3.2.0+300

- Initial release.

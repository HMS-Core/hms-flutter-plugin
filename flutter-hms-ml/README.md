# Huawei ML Kit Flutter Plugin

## Table Of Contents

- Introduction
- Installation Guide
- API Reference
- Configuration Description
- Licensing and Terms

## Introduction

This plugin enables communication between Huawei ML SDK and Flutter platform. It allows your apps to easily leverage Huawei's long-term proven expertise in machine learning to support diverse artificial intelligence (AI) applications throughout a wide range of industries. Thanks to Huawei's technology accumulation, ML Kit provides diversified leading machine learning capabilities that are easy to use, helping you develop various AI apps.

## Installation Guide

- Before you get started, you must register as a HUAWEI developer and complete identity verification on the [HUAWEI Developer](https://developer.huawei.com/consumer/en/) website. For details, please refer to [Register a HUAWEI ID](https://developer.huawei.com/consumer/en/doc/10104).

- Create an app by referring to [Creating an AppGallery Connect Project](https://developer.huawei.com/consumer/en/doc/development/AppGallery-connect-Guides/agc-get-started#h1-1587521853252) and [Adding an App to the Project](https://developer.huawei.com/consumer/en/doc/development/AppGallery-connect-Guides/agc-get-started#h1-1587521946133).

- The data storage location determines the region where your app will connect to on-cloud services of ML Kit. To set the data storage location, go to **Project Setting > General Information**, click **Set** next to **Data storage location** under **Project**, and select a data storage location in the displayed dialog box. For details, please refer to [Setting a Data Storage Location](https://developer.huawei.com/consumer/en/doc/distribution/app/agc-data-storage-location).

- A signing certificate fingerprint is used to verify the authenticity of an app when it attempts to access an HMS Core (APK) through the HMS SDK. Before using the HMS Core (APK), you must locally generate a signing certificate fingerprint and configure it in AppGallery Connect.  For details, please refer to [Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#2).

- Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and select **My projects**. After selecting your project, on the **Project Setting** page, set **SHA-256 certificate fingerprint** to the SHA-256 fingerprint. For details, please refer to [Adding Fingerprint Certificate to AppGallery Connect](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#4).

- In [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html), on **My projects** page, find your project from the list and select it. Go to **Project Settings > General Information > App information**. Click **agconnect-service.json** to download configuration file.

- Copy the **agconnect-service.json** file to the **android/app** directory of your project.

- Open the **build.gradle** file in the **android** directory of your project.
    - Go to **buildscript** then configure the Maven repository address and agconnect plugin for the  HMS SDK.

        ```gradle
        buildscript {
            repositories {
                google()
                jcenter()
                maven { url 'https://developer.huawei.com/repo/' }
            }

            dependencies {
                /*
                 * <Other dependencies>
                 */
                classpath 'com.huawei.agconnect:agcp:1.3.1.300'
            }
        }
        ```

    - Go to **allprojects** then configure the Maven repository address for the HMS SDK.

        ```gradle
        allprojects {
            repositories {
                google()
                jcenter()
                maven { url 'https://developer.huawei.com/repo/' }
            }
        }
        ```

- Open the **build.gradle** file in the **android/app** directory.

    - Add `apply plugin: 'com.huawei.agconnect'` line after the `apply plugin: 'com.android.application'` line.

        ```gradle
        apply plugin: 'com.android.application'
        apply plugin: 'com.huawei.agconnect'
        apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"
        ```

    - Set your package name in **defaultConfig** > **applicationId** and set **minSdkVersion** to **19** or **higher**.
        Package name must match with the **package_name** entry in **agconnect-services.json** file.
        ```gradle
        defaultConfig {
                applicationId "<package_name>"
                minSdkVersion 19
                /*
                 * <Other configurations>
                 */
            }
        ```

    - Copy the signature file that generated in [Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#2) to **android/app** directory.

    - Configure the signature in **android** according to the signature file information.

        ```gradle
        android {
            /*
             * <Other configurations>
             */

            signingConfigs {
                config {
                    storeFile file('<keystore_file>.jks')
                    storePassword '<keystore_password>'
                    keyAlias '<key_alias>'
                    keyPassword '<key_password>'
                }
            }

            buildTypes {
                debug {
                    signingConfig signingConfigs.config
                }
                release {
                    signingConfig signingConfigs.config
                    minifyEnabled true
                    shrinkResources true
                    proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
                }
            }
        }
        ```

- On your Flutter project directory find and open your **pubspec.yaml** file and add library to dependencies to download the package from [pub.dev.](https://pub.dev/publishers/developer.huawei.com/packages)

    ```yaml
    dependencies:
        huawei_ml: {library version}
    ```
    **or**

    if you downloaded the package from the HUAWEI Developer website, specify the **library path** on your local device.

    ```yaml
    dependencies:
        huawei_ml:
            # Replace {library path} with actual library path of Huawei ML Kit Flutter Plugin.
            path: {library path}
    ```


- Run following command to update package info.

    ```
    [project_path]> flutter pub get
    ```

- Run following command to start the app.

    ```
    [project_path]> flutter run
    ```

## API Reference

This section does not cover all of the API, to read more, visit [Huawei Developer](https://developer.huawei.com/en).

### MlTextClient

#### Methods

| Return Type | Method | Description |
| ---- | ---- | ----- |
| Future\<MlText\> | analyzeLocally(MlTextSettings settings) | Sets LocalTextAnalyzer, starts the analyze operation by using current Frame and returns the result. |
| Future\<MlText\> | analyzeRemotely(MlTextSettings settings) | Sets RemoteTextAnalyzer, starts the analyze operation and returns the result. |
| Future\<List\<MlTextBlock\>\> | analyzeWithSparseArray(MlTextSettings settings) | Makes a synchronous call and returns a list of MlTextBlock objects. |
| Future\<MlTextAnalyzer\> | getAnalyzerInfo() | Returns analyzer information. |
| Future\<String\> | stopAnalyzer() | Closes the analyzer. |

#### Data Types

##### MlText

| Properties | Type | Description |
| ---- | ----- | ----- |
| stringValue | String | Obtains the string value of recognized text. |
| blocks | MlTextBlock | Obtains the MlTextBlock object. |

##### MlTextSettings

| Properties | Type | Description |
| ---- | ----- | ----- |
| ocrMode | int | Sets the detection mode. |
| language | String | Sets the language |
| path | String | Sets the image path. |
| languageList | List\<String\> | Sets the language list. |
| borderType | String | Sets the border type. |
| textDensityScene | int | Sets the text density scene. |

##### MlTextAnalyzer

| Properties | Type | Description |
| ---- | ----- | ----- |
| analyzeType | int | Obtains analyze type. |
| isAvailable | bool | Checks whether analyzer is available or not. |

##### MlTextBlock

| Properties | Type | Description |
| ---- | ----- | ----- |
| contents | MlTextContents | Obtains the lower-level text object contained in the current text object. |
| border | [MlBorder](#mlborder) | Obtains the axis-aligned bounding rectangle of the text. |
| vertexes | [MlCoordinatePoints](#mlcoordinatepoints) | Obtains the corner points of the text bounding box. |
| stringValue | String | Obtains the text value of the block. |
| possibility | dynamic | Obtains the confidence of the detection result. |
| language | String | Obtains the recognized language. |
| languageList | List\<dynamic\> | Obtains the list of recognized languages |

##### MlTextContents

| Properties | Type | Description |
| ---- | ----- | ----- |
| border | [MlBorder](#mlborder) | Obtains the axis-aligned bounding rectangle of the text. |
| vertexes | [MlCoordinatePoints](#mlcoordinatepoints) | Obtains the corner points of the text bounding box. |
| contents | Contents | Obtains the lower-level text object contained in the current text object. |
| stringValue | String | Obtains the text value of the block. |
| rotationDegree | dynamic | Obtains the roll angle of the current text line relative to the horizontal position. |
| isVertical | bool | Determines whether the text in the current text line is in a vertical layout. |
| language | String | Obtains the recognized language. |
| possibility | dynamic | Obtains the confidence of the detection result. |
| languageList | List\<dynamic\> | Obtains the list of recognized languages |

##### Contents

| Properties | Type | Description |
| ---- | ----- | ----- |
| border | [MlBorder](#mlborder) | Obtains the axis-aligned bounding rectangle of the text. |
| vertexes | [MlCoordinatePoints](#mlcoordinatepoints) | Obtains the corner points of the text bounding box. |
| stringValue | String | Obtains the text value of the block. |
| language | String | Obtains the recognized language. |
| possibility | dynamic | Obtains the confidence of the detection result. |
| languageList | List\<dynamic\> | Obtains the list of recognized languages |

##### MlTextLanguage

| Properties | Type | Value | Description |
| ---- | ----- | ----- | ------ |
| English | String | en | Value for English. |
| Chinese  | String | zh | Value for Chinese. |
| Japanese  | String | ja | Value for Japanese. |
| Korean  | String | ko | Value for Korean. |
| Russian  | String | ru | Value for Russian. |
| German  | String | de | Value for German. |
| French  | String | fr | Value for French. |
| Italian  | String | it | Value for Italian. |
| Portuguese   | String | pt | Value for Portuguese. |
| Spanish  | String | es | Value for Spanish. |
| RomanceLanguages   | String | rm | Value for RomanceLanguages. |
| Polish   | String | pl | Value for Polish. |
| Norwegian   | String | no | Value for Norwegian. |
| Swedish    | String | sv | Value for Swedish. |
| Danish    | String | da | Value for Danish. |
| Turkish    | String | tr | Value for Turkish. |
| Finnish    | String | fi | Value for Finnish. |
| Thai    | String | th | Value for Thai. |
| Arabic     | String | ar | Value for Arabic. |
| Hindi     | String | hi | Value for Hindi. |

##### MlTextOcrMode

| Properties | Type | Value | Description |
| ---- | ----- | ----- | ------ |
| OCR_DETECT_MODE | int | 1 | Value for detection mode in text recognition. |

##### MlTextDensityScene

| Properties | Type | Value | Description |
| ---- | ----- | ----- | ------ |
| OCR_COMPACT_SCENE | int | 2 | dense text recognition |
| OCR_LOOSE_SCENE | int | 1 | sparse text recognition |

### MlDocumentClient

#### Methods

| Return Type | Method | Description |
| ---- | ---- | ----- |
| Future\<MlDocument\> | getDocumentAnalyzeInformation(MlDocumentSettings settings) | Sets DocumentAnalyzer, starts the analyze operation by using current Frame and returns the result. |
| Future\<String\> | closeAnalyzer() | Closes the analyzer. |

#### Data Types

##### MlDocument

| Properties | Type | Description |
| ---- | ----- | ----- |
| stringValue | String | Obtains the detected text content. |
| blocks | MlDocumentBlocks | Represents a detected text block. |

##### MlDocumentSettings

| Properties | Type | Description |
| ---- | ----- | ----- |
| borderType | String | Sets the border type. |
| path | String | Sets the image path. |
| languageList | List\<String\> | Sets the language list. |

##### MlDocumentBlocks

| Properties | Type | Description |
| ---- | ----- | ----- |
| stringValue | String | Obtains the detected text content. |
| possibility | dynamic | Obtains the detection result confidence. |
| border | [MlBorder](#mlborder) | Obtains the text block bounding box. |
| sections | MlDocumentSections | Represents a detected section. |
| interval | MlDocumentInterval | Represents a text interval. |

##### MlDocumentSections

| Properties | Type | Description |
| ---- | ----- | ----- |
| stringValue | String | Obtains the detected text content. |
| possibility | dynamic | Obtains the detection result confidence. |
| border | [MlBorder](#mlborder) | Obtains the text block bounding box. |
| languageList | List\<dynamic\> | Obtains the detected languages. |
| lineList | MlDocumentLineList | Represents a detected line. |
| wordList | MlDocumentWordList | Represents a detected word. |
| interval | MlDocumentInterval | Represents a text interval. |

##### MlDocumentLineList

| Properties | Type | Description |
| ---- | ----- | ----- |
| stringValue | String | Obtains the detected text content. |
| possibility | dynamic | Obtains the detection result confidence. |
| border | [MlBorder](#mlborder) | Obtains the text block bounding box. |
| languageList | List\<dynamic\> | Obtains the detected languages. |
| wordList | MlDocumentWordList | Represents a detected word. |
| interval | MlDocumentInterval | Represents a text interval. |
| points | [MlCoordinatePoints](#mlcoordinatepoints) | Obtains the corner points of a line bounding box. |

##### MlDocumentWordList

| Properties | Type | Description |
| ---- | ----- | ----- |
| stringValue | String | Obtains the detected text content. |
| possibility | dynamic | Obtains the detection result confidence. |
| border | [MlBorder](#mlborder) | Obtains the text block bounding box. |
| languageList | List\<dynamic\> | Obtains the detected languages. |
| interval | MlDocumentInterval | Represents a text interval. |
| characterList | MlDocumentCharacterList | Represents a detected character. |

##### MlDocumentCharacterList

| Properties | Type | Description |
| ---- | ----- | ----- |
| stringValue | String | Obtains the detected text content. |
| possibility | dynamic | Obtains the detection result confidence. |
| border | [MlBorder](#mlborder) | Obtains the text block bounding box. |
| languageList | List\<dynamic\> | Obtains the detected languages. |
| interval | MlDocumentInterval | Represents a text interval. |

##### MlDocumentInterval

| Properties | Type | Description |
| ---- | ----- | ----- |
| intervalType | dynamic | Obtains the type of the detected text interval. |
| isTextFollowed | bool | Determines whether there is text after the text interval. |

### MlBankcardClient

#### Methods

| Return Type | Method | Description |
| ---- | ---- | ----- |
| Future\<MlBankcard\> | analyzeBankcard(MlBankcardSettings settings) | Sets Bank Card Recognition Analyzer, starts the analyze operation by using current Frame and returns the result. |
| Future\<MlBankcard\> | captureBankcard(MlBankcardSettings settings) | Starts capture activity and returns the capture result. |
| Future\<String\> | stopAnalyzer() | Closes the analyzer. |

#### Data Types

##### MlBankcard

| Properties | Type | Description |
| ---- | ----- | ----- |
| expire | String | Obtains the card's expire date |
| number | String | Obtains the card number |
| String | issuer | Obtains the issuing bank. |
| retCode | int | Obtains the ret code |
| tipsCode | int | Obtains the tips code |
| originalBitmap | dynamic | Obtains image path generated from bitmap. |
| numberBitmap | dynamic | Obtains bankcard number image path generated from bitmap. |
| type | dynamic | Obtains the bankcard type. |

##### MlBankcardSettings

| Properties | Type | Description |
| ---- | ----- | ----- |
| path | String | Sets the image path. |
| langType | String | Sets the language type. |
| orientation | int | Sets the orientation. |


### MlGeneralCardClient

#### Methods

| Return Type | Method | Description |
| ---- | ---- | ----- |
| Future\<MlGeneralCard\> | getResultWithCapturing(MlGeneralCardSettings settings) | Starts capture activity and returns result. |
| Future\<MlGeneralCard\> | getResultWithTakingPicture(MlGeneralCardSettings settings) | Starts activity to take picture and returns the result. |
| Future\<MlGeneralCard\> | getResultWithLocalImage(MlGeneralCardSettings settings) | Sets General Card Recognition Analyzer, starts the analyze operation by using current Frame and returns the result. |

#### Data Types

##### MlGeneralCard

| Properties | Type | Description |
| ---- | ----- | ----- |
| text | String | General card recognition result. |
| cardBitmapUri | String | Obtains image path generated from bitmap. |

##### MlGeneralCardSettings

| Properties | Type | Description |
| ---- | ----- | ----- |
| path | String | Sets the image path. |
| language | String | Sets the language. |
| tipText | String | Sets the tip text in capture activity. |
| orientation | int | Sets the orientation. |
| scanBoxCornerColor | int | Sets the scan box corner color in capture activity. |
| tipTextColor | int | Sets the tip text color in capture activity. |
| backButtonResId | int | Sets the back button res id in capture activity. |
| photoButtonResId | int | Sets the photo button res id in capture activity. |


### MlTranslatorClient

#### Methods

| Return Type | Method | Description |
| ---- | ---- | ----- |
| Future\<String\> | getTranslateResult(MlTranslatorSettings settings) | Returns translate result. |
| Future\<String\> | stopTranslator() | Stops translator. |

#### Data Types

##### MlTranslatorSettings

| Properties | Type | Description |
| ---- | ----- | ----- |
| targetLangCode | String | Sets the target language. |
| sourceLangCode | String | Sets the source language. |
| sourceText | String | Sets the text to be translated. |

##### MlTranslateLanguageOptions

| Properties | Type | Value | Description |
| ---- | ----- | ----- | ------ |
| English | String | en | Value for English. |
| Chinese  | String | zh | Value for Chinese. |
| French  | String | fr | Value for French. |
| Arabic  | String | ar | Value for Arabic. |
| Thai  | String | th | Value for Thai. |
| Spanish | String | es | Value for Spanish. |
| Turkish | String | tr | Value for Turkish. |
| Portuguese | String | pt | Value for Portuguese. |
| Japanese | String | ja | Value for Japanese. |
| German | String | de | Value for German. |
| Italian | String | it | Value for Italian. |
| Russian | String | ru | Value for Russian. |
| Polish  | String | pl | Value for Polish. |
| Swedish  | String | sv | Value for Swedish. |
| Finnish  | String | fi | Value for Finnish. |
| Norwegian  | String | no | Value for Norwegian. |
| Danish | String | da | Value for Danish. |
| Korean | String | ko | Value for Korean. |
| Malay | String | ms | Value for Malay. |

### MlLangDetectionClient

#### Methods

| Return Type | Method | Description |
| ---- | ---- | ----- |
| Future\<String\> | getFirstBestDetect(MlLangDetectionSettings settings) | Returns confident detection result. |
| Future\<MlDetectedLanguage\> | getProbabilityDetect(MlLangDetectionSettings settings) | Returns possible detection result. |
| Future\<String\> | stopDetection() | Stops detection. |

#### Data Types

##### MlDetectedLanguage

| Properties | Type | Description |
| ---- | ----- | ----- |
| langCode | String | Obtains the language code in the language detection result. |
| probability | dynamic | Obtains the confidence of the language detection result. |
| hashcode | dynamic | Calculates the hash value of the language detection result instance. |

##### MlLangDetectionSettings

| Properties | Type | Description |
| ---- | ----- | ----- |
| sourceText | String | Sets the text to be used to detect language. |
| trustedThreshold | double | Sets the minimum confidence threshold for language detection. |

### MlTextToSpeechClient

#### Methods

| Return Type | Method | Description |
| ---- | ---- | ----- |
| Future | getSpeechFromText(MlTextToSpeechSettings settings) | Starts the speech. |
| Future\<bool\> | pauseSpeech() | Pauses the speech. |
| Future\<bool\> | resumeSpeech() | Resumes the speech. |
| Future\<String\> | stopTextToSpeech() | Stops text to speech. |

#### Data Types

##### MlTextToSpeechSettings

| Properties | Type | Description |
| ---- | ----- | ----- |
| text | String | Sets the text to be converted to speech. |
| language | String | Sets the language. |
| person | String | Sets the sex & nation of speech. |
| speed | double | Sets the speed of speech. |
| volume | double | Sets the volume of speech. |
| queingMode | int | Sets the queing mode. |

##### MlTtsLanguage

| Properties | Type | Value | Description |
| ---- | ----- | ----- | ------ |
| TTS_EN_US | String | en-US | Value for English. |
| TTS_ZH_HANS | String | zh-Hans | Value for Chinese. |

##### MlTtsPerson

| Properties | Type | Value | Description |
| ---- | ----- | ----- | ------ |
| TTS_SPEAKER_FEMALE_EN | String | Female-en | Sets the speaker as an English female. |
| TTS_SPEAKER_FEMALE_ZH | String | Female-zh | Sets the speaker as an Chinese female. |
| TTS_SPEAKER_MALE_EN | String | Male-en | Sets the speaker as an English male. |
| TTS_SPEAKER_MALE_ZH  | String | Male-zh | Sets the speaker as an Chinese male. |

##### MlTtsQueuingMode

| Properties | Type | Value | Description |
| ---- | ----- | ----- | ------ |
| QUEUE_APPEND | int | 0 | If playback pauses, the playback is resumed and the task is added to the queue for execution in sequence. If there is no playback, the audio synthesis task is executed immediately. |
| QUEUE_FLUSH | int | 1 | The ongoing audio synthesis task and playback are stopped immediately, all audio synthesis tasks in the queue are cleared, and the current audio synthesis task is executed immediately and played. |

### MlAsrClient

#### Methods

| Return Type | Method | Description |
| ---- | ---- | ----- |
| Future\<String\> | getTextFromSpeech(MLAsrSettings settings) | Returns text from speech. |
| Future\<String\> | stopRecognition() | Stops the recognition. |

#### Data Types

##### MLAsrSettings

| Properties | Type | Description |
| ---- | ----- | ----- |
| language | String | Sets the language. |
| feature | int | Sets feature to return the recognition result along with the speech. |

##### MLAsrFeature

| Properties | Type | Value | Description |
| ---- | ----- | ----- | ------ |
| FEATURE_WORD_FLUX | int | 11 | Recognizes and returns texts through onRecognizingResults. |
| FEATURE_ALL_IN_ONE | int | 12 | After the recognition is complete, texts are returned through onResults. |

##### MLAsrLanguage

| Properties | Type | Value | Description |
| ---- | ----- | ----- | ------ |
| chinese | String | zh-CN | Value for Chinese. |
| english | String | en-US | Value for English. |
| french | String | fr-FR | Value for French. |

### MlAftClient

#### Methods

| Return Type | Method | Description |
| ---- | ---- | ----- |
| Future\<String\> | getAudioTranscriptionResult(MLAftSettings settings) | Returns text from audio file. |

#### Data Types

##### MLAftSettings

| Properties | Type | Description |
| ---- | ----- | ----- |
| path | String | Sets the audio file path. |
| language | String | Sets the language. |

##### MLAftLanguage

| Properties | Type | Value | Description |
| ---- | ----- | ----- | ------ |
| chinese | String | zh | Value for Chinese. |
| english | String | en-US | Value for English. |

### MlImageClassificationClient

#### Methods

| Return Type | Method | Description |
| ---- | ---- | ----- |
| Future\<List\<MlImageClassification\>\> | getDefaultClassificationResult(String path) | Obtains classification result with default parameters. |
| Future\<List\<MlImageClassification\>\> | getLocalClassificationResult(MlImageClassificationSettings settings) | Sets Image Classification Analyzer, starts the analyze operation by using current Frame and returns the result. |
| Future\<List\<MlImageClassification\>\> | getRemoteClassificationResult(MlImageClassificationSettings settings) | Sets Image Classification Analyzer, starts the analyze operation by using current Frame and returns the result. |
| Future\<List\<MlImageClassification\>\> | getAnalyzeFrameClassificationResult(MlImageClassificationSettings settings) | Returns result by using analyze frame. |
| Future\<String\> | closeAnalyzer() | Closes the analyzer. |

#### Data Types

##### MlImageClassification

| Properties | Type | Description |
| ---- | ----- | ----- |
| classificationIdentity | String | Obtains the classification ID. |
| name | String | Obtains the classification name. |
| possibility | dynamic | Obtains the classification confidence. |

##### MlImageClassificationSettings

| Properties | Type | Description |
| ---- | ----- | ----- |
| path | String | Sets the image path. |
| minAcceptablePossibility | double | Sets the confidence threshold. |
| largestNumberOfReturns | int | Sets the max return count. |

### MlObjectClient

#### Methods

| Return Type | Method | Description |
| ---- | ---- | ----- |
| Future\<MlObject\> | getObjectAnalyzerInformation(MlObjectSettings settings) | Creates the analyzer, analyzes the current frame, returns the result. |
| Future\<String\> | stopAnalyzer() | Stops the analyzer. |

#### Data Types

##### MlObject

| Properties | Type | Description |
| ---- | ----- | ----- |
| border | [MlBorder](#mlborder) | Obtains the axis-aligned bounding rectangle of an object. |
| typeIdentity | int | Obtains the object classification result. |
| typePossibility | dynamic | Obtains the object detection confidence. |

##### MlObjectSettings

| Properties | Type | Description |
| ---- | ----- | ----- |
| path | String | Sets the image path. |
| allowMultiResults | bool | Sets the multi-object detection. |
| allowClassification | bool | Sets whether to support detection result classification or not. |


### MlLandMarkClient

#### Methods

| Return Type | Method | Description |
| ---- | ---- | ----- |
| Future\<MlLandmark\> | getDefaultLandmarkAnalyzeInformation(String path) | Starts recognition with default parameters and returns the result. |
| Future\<MlLandmark\> | getLandmarkAnalyzeInformation(MlLandMarkSettings settings) | Creates the analyzer, analyzes the frame, returns the result. |
| Future\<String\> | stopAnalyzer() | Stops the analyzer. |

#### Data Types

##### MlLandmark

| Properties | Type | Description |
| ---- | ----- | ----- |
| border | [MlBorder](#mlborder) | Obtains the axis-aligned bounding rectangle of an object. |
| landmark | String | Obtains the landmark description. |
| landmarkIdentity | String | Obtains the landmark identity. |
| possibility | dynamic | Obtains the result confidence. |
| position | Position | Obtains landmark location information. |

##### MlLandmarkSettings

| Properties | Type | Description |
| ---- | ----- | ----- |
| path | String | Sets the image path. |
| patternType | int | Sets the recognition pattern type. |
| largestNumberOfReturns | int | Sets max return count. |

##### Position

| Properties | Type | Description |
| ---- | ----- | ----- |
| lat | dynamic | Obtains the latitude |
| lng | dynamic | Obtains the longitude |


##### LandmarkAnalyzerPattern

| Properties | Type | value | Description |
| ---- | ----- | ----- | ----- |
| STEADY_PATTERN | int | 1 | Stable mode. |
| NEWEST_PATTERN | int | 2 | Newest mode. |

### MlImageSegmentationClient

#### Methods

| Return Type | Method | Description |
| ---- | ---- | ----- |
| Future\<MlImageSegmentationResult\> | getDefaultSegmentation(String path) | Starts analyzing with default parameters and returns the result. |
| Future\<MlImageSegmentationResult\> | getSegmentation(MlImageSegmentationSettings settings) | Creates the analyzer, analyzes the frame, returns the result. |
| Future\<List\<MlImageSegmentationResult\>\> | getSparseSegmentation(MlImageSegmentationSettings settings) | Returns result by using analyze frame. |
| Future\<String\> | stopSegmentation() | Stops segmentation. |

#### Data Types

##### MlImageSegmentationResult

| Properties | Type | Description |
| ---- | ----- | ----- |
| foregroundUri | dynamic | Obtains the image uri that is generated with foreground bitmap. |
| grayscaleUri | dynamic | Obtains the image uri that is generated with grayscale bitmap. |
| originalUri | dynamic | Obtains the image uri that is generated with original bitmap. |

##### MlImageSegmentationSettings

| Properties | Type | Description |
| ---- | ----- | ----- |
| path | String | Sets the image path. |
| analyzerType | int | Sets the analyzer type. |
| scene | int | Sets the scene. |
| exactMode | bool | Sets to whether the fine detection is supported or not. |

##### ImgSegmentationAnalyzerType

| Properties | Type | value | Description |
| ---- | ----- | ----- | ------ |
| BODY_SEG | int | 0 | Detection based on the human body model. |
| IMAGE_SEG | int | 1 | detection based on the multi class image model. |

##### ImgSegmentationScene

| Properties | Type | value | Description |
| ---- | ----- | ----- | ------ |
| ALL | int | 0 | All results. |
| MASK_ONLY | int | 1 | Only mask results. |
| FOREGROUND_ONLY  | int | 2 | Only foreground results. |
| GRAYSCALE_ONLY  | int | 3 | Only grayscale results. |

### MlProductVisionSearchClient

#### Methods

| Return Type | Method | Description |
| ---- | ---- | ----- |
| Future\<MlProductVisionSearch\> | getProductVisionSearchResult(MlProductVisionSearchSettings settings) | Creates the analyzer, analyzes the current frame, returns the result. |
| Future\<String\> | stopAnalyzer() | Stops the analyzer. |

#### Data Types

##### MlProductVisionSearch

| Properties | Type | Description |
| ---- | ----- | ----- |
| type | String | Obtains the product type. |
| border | [MlBorder](#mlborder) | Obtains the axis-aligned bounding rectangle of an object. |
| productList | ProductList | Obtains the product list. |

##### MlProductVisionSearchSettings
| Properties | Type | Description |
| ---- | ----- | ----- |
| path | String | Sets the image path. |
| largestNumberOfReturns | int | Sets the max return count. |
| region | int | Sets the region. |

##### ProductList

| Properties | Type | Description |
| ---- | ----- | ----- |
| possibility | dynamic | Obtains the result confident. |
| productId | String | Obtains the product id. |
| imageList | ImageList | Obtains the image list. |

##### ImageList

| Properties | Type | Description |
| ---- | ----- | ----- |
| possibility | dynamic | Obtains the result confident. |
| productId | String | Obtains the product id. |
| imageId | String | Obtains the image id. |

##### ProductVisionRegion

| Properties | Type | value | Description |
| ---- | ----- | ----- | ------ |
| REGION_DR_UNKNOWN | int | 1001 | Unknown region. |
| REGION_DR_CHINA  | int | 1002 | China region. |
| REGION_DR_AFILA  | int | 1003 | Asia, Africa and Latin America regions. |
| REGION_DR_EUROPE  | int | 1004 | Europe region. |
| REGION_DR_RUSSIA   | int | 1005 | Russia region. |

### MlFaceClient

#### Methods

| Return Type | Method | Description |
| ---- | ---- | ----- |
| Future\<MlFace\> | getDefaultFaceAnalyzeInformation(String path) | Creates analyzer with default parameters and return the result. |
| Future\<MlFace\> | getAsyncAnalyzeInformation(MlFaceSettings settings) | Creates the analyzer, analyzes the frame, returns the result. |
| Future\<List\<MlFace\>\> | getAnalyzeFrameInformation(String path) | Returns result by using analyze frame. |
| Future\<MlFaceAnalyzer\> | getAnalyzerInfo() | Returns analyzer info. |
| Future\<String\> | closeAnalyzer() | Closes the analyzer. |

#### Data Types

##### MlFace

| Properties | Type | Description |
| ---- | ----- | ----- |
| opennessOfLeftEye | dynamic | Obtains openness of the left eye. |
| opennessOfRightEye | dynamic | Obtains openness of the right eye. |
| tracingIdentity | dynamic | Obtains tracing identity. |
| possibilityOfSmiling | dynamic | Obtains possibility of smiling. |
| rotationAngleX | dynamic | Obtains the rotation angle X. |
| rotationAngleY | dynamic | Obtains the rotation angle Y. |
| rotationAngleZ | dynamic | Obtains the rotation angle Z. |
| width | dynamic | Obtains the width. |
| height | dynamic | Obtains the height. |
| border | [MlBorder](#mlborder) | Obtains the axis-aligned bounding rectangle of an object. |
| allPoints | AllPoints | Obtains all key position points of a complete face shape. A total of 855 points are included. |
| keyPoints | KeyPoints | Obtains all 12 facial key-points. |
| faceShapeList | FaceShapeList | Obtains all 14 key facial shapes. |
| features | Features | Obtains all facial features. |
| emotions | Emotions | Obtains all facial expressions. |

##### MlFaceSettings

| Properties | Type | Description |
| ---- | ----- | ----- |
| path | String | Sets the image path. |
| keyPointType | int | Sets the key point type. |
| featureType | int | Sets the feature type. |
| shapeType | int | Sets the shape type. |
| performanceType | int | Sets the performance type. |
| tracingAllowed | bool | Sets to tracing allowed true or not. |

##### MlFaceAnalyzer

| Properties | Type | Description |
| ---- | ----- | ----- |
| isAvailable | bool | Checks whether the analyzer is available. |

##### MlFacePerformanceType

| Properties | Type | value | Description |
| ---- | ----- | ----- | ------ |
| TYPE_PRECISION | int | 1 | Sets the speed and precision of the detector. |
| TYPE_SPEED  | int | 2 | Sets the speed and precision of the detector. |

##### AllPoints

| Properties | Type | Description |
| ---- | ----- | ----- |
| x | dynamic | Obtains x points. |
| y | dynamic | Obtains y points. |

##### KeyPoints

| Properties | Type | Description |
| ---- | ----- | ----- |
| type | int | Obtains the key point type. |
| points | Points | Obtains the points. |
| coordinatePoint | [MlCoordinatePoints](#mlcoordinatepoints) | Obtains coordinates of points. |

##### Points

| Properties | Type | Description |
| ---- | ----- | ----- |
| x | dynamic | Obtains the x value of point. |
| y | dynamic | Obtains the y value of point. |
| z | dynamic | Obtains the z value of point. |


##### FaceShapeList

| Properties | Type | Description |
| ---- | ----- | ----- |
| faceShapeType | int | Obtains the face shape type. |
| points | Points | Obtains the points. |

##### Features

| Properties | Type | Description |
| ---- | ----- | ----- |
| sunGlassProbability | dynamic | Obtains sun glasses wearing probability. |
| sexProbability | dynamic | Obtains the sex probability. |
| rightEyeOpenProbability | dynamic | Obtains the right eye open probability. |
| leftEyeOpenProbability | dynamic | Obtains the left eye open probability. |
| moustacheProbability | dynamic | Obtains the moustache probability. |
| hatProbability | dynamic | Obtains the hat wearing probability. |
| age | int | Obtains age. |

##### Emotions

| Properties | Type | Description |
| ---- | ----- | ----- |
| surpriseProbability | dynamic | Obtains surprise probability. |
| smilingProbability | dynamic | Obtains smiling probability. |
| sadProbability | dynamic | Obtains sad probability. |
| neutralProbability | dynamic | Obtains neutral probability. |
| fearProbability | dynamic | Obtains fear probability. |
| disgustProbability | dynamic | Obtains disgust probability. |
| angryProbability | dynamic | Obtains angry probability. |


### MlPermissionClient

#### Methods

| Return Type | Method | Description |
| ---- | ---- | ----- |
| Future\<bool\> | checkCameraPermission() | Checks if camera permission is granted or not. |
| Future\<bool\> | checkInternetPermission() | Checks if internet permission is granted or not. |
| Future\<bool\> | checkWriteExternalStoragePermission() | Checks if write external storage permission is granted or not. |
| Future\<bool\> | checkReadExternalStoragePermission() | Checks if read external storage permission is granted or not. |
| Future\<bool\> | checkRecordAudioPermission() | Checks if record audio permission is granted or not. |
| Future\<bool\> | checkAccessNetworkStatePermission() | Checks if access network state permission is granted or not. |
| Future\<bool\> | checkAccessWifiStatePermission() | Checks if record access wifi state permission is granted or not. |
| Future | requestCameraPermission() | Requests camera permission. |
| Future | requestInternetPermission() | Requests internet permission. |
| Future | requestStoragePermission() | Requests storage permission. |
| Future | requestRecordAudioPermission() | Requests record audio permission. |
| Future | requestConnectionStatePermission() | Requests connection state permission. |

### Common Classes

##### MlBorder

| Properties | Type | Description |
| ---- | ----- | ----- |
| bottom | dynamic | Obtains the bottom value. |
| top | dynamic | Obtains the top value. |
| left | dynamic | Obtains the left value. |
| right | dynamic | Obtains the right value. |
| exactCenterX | dynamic | Obtains the exactCenterX value. |
| centerX | dynamic | Obtains the centerX value. |
| centerY | dynamic | Obtains the centerY value. |
| describeContents | dynamic | Obtains the describeContents value. |
| height | dynamic | Obtains the height |
| width | dynamic | Obtains the width |

##### CardOrientation

| Properties | Type | Value | Description |
| ---- | ----- | ----- | ------ |
| ORIENTATION_AUTO | int | 0 | Auto orientation |
| ORIENTATION_LANDSCAPE  | int | 1 | Landscape |
| ORIENTATION_PORTRAIT  | int | 2 | Portrait |

##### MlTextBorderType

| Properties | Type | Value | Description |
| ---- | ----- | ----- | ------ |
| ARC | String | ARC | Return the corner points of a polygon border in an arc. |
| NGON | String | NGON | Return the coordinates of the four corner points of the quadrilateral. |

##### MlCoordinatePoints

| Properties | Type | Description |
| ---- | ----- | ----- |
| x | dynamic | Obtains the x point |
| y | dynamic | Obtains the y point |
| describeContents | dynamic | Obtains describe contents value |

## Configuration Description

No

## Licensing And Terms

Huawei ML Kit Flutter Plugin uses the Apache 2.0 license.

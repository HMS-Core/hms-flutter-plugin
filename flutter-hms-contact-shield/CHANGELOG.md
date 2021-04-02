## 5.1.0+301

* Updated HMSLogger.

## 5.1.0+300

**Breaking Changes**

* PeriodicKey's **content** field type is changed from **Uint8List** to **Int8List**.
* **startContactShieldOld()** method is renamed to **startContactShieldCb()**.
* **putSharedKeyFilesOld()** method is renamed to **putSharedKeyFiles()**.
* **putSharedKeyFiles()** method is renamed to **putSharedKeyFilesCb()**.

**New Methods**

* **putSharedKeyFilesCbWithKeys()**: Provides the shared key list file obtained from the diagnosis server to the Contact Shield SDK. The SDK performs signature verification on the key file. If the Window mode is used a maximum of 60 calls are allowed within 24 hours.
* **putSharedKeyFilesCbWithProvider()**: Provides the shared key list file obtained from the diagnosis server to the Contact Shield SDK. If the Window mode is used a maximum of 60 calls are allowed within 24 hours.
* **setSharedKeysDataMapping()**: Sets a **SharedKeysDataMapping** object as the default configuration for the Window mode risk calculation.
* **getSharedKeysDataMapping()**: Obtains the **SharedKeysDataMapping** object.
* **getDailySketch()**: Obtains the daily contact summary. This is a new API added for the Window mode.
* **getContactShieldVersion()**: Obtains the current API version.
* **getDeviceCalibrationConfidence()**: Obtains the calibration confidence of the Bluetooth broadcast power of the current device.
* **isSupportScanningWithoutLocation()**: Checks whether the device supports Bluetooth scanning without location permission.
* **getStatus()**: Obtains the status of the current ContactShield Service.

 **New Classes**

* **SketchData**: Defines contact summary data.
* **DailySketch**: Defines daily contact summary.
* **DailySketchConfiguration**: Configuration information of **DailySketch**.
* **SharedKeysDataMapping**: Mapping definition of SharedKey.
* **Contagiousness**: Defines contagiousness
* **CalibrationConfidence**: Calibration confidence of the Bluetooth BLE broadcast power.
* **ContactShieldStatus**: The running status of Contact Shield.
* **CsApiException**: HMS Core ApiException class encapsulated in Contact Shield, which is used to return the API calling status.
* **StatusCode**: Defines the Contact Shield status code.

## 5.0.4+300

* Initial release.

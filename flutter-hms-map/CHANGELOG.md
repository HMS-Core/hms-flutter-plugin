## 5.0.3+303

* Updated HMSLogger.
* Fixed the bug that causes the Huawei Map to crash when running on earlier HMS Core versions.
* Fixed the bug that causes the app to crash when pressing the "Legal" button on the Huawei Map instances.
* Added missing permission for the demo application that prevents the app from running. 

## 5.0.3+302

* Added Tile Overlays and tile types.
    - Added Tile.
    - Added UrlTile.
    - Added RepetitiveTile.
* Added Ground Overlays.
* Added marker animations to Markers.
    - Added startAnimationOnMarker method to HuaweiMapController.
    - Added animationSet field to Marker object.
    - Added Alpha Animation.
    - Added Rotate Animation.
    - Added Scale Animation.
    - Added Translate Animation.
* Added marker clustering feature to Markers.
    - Added markersClusteringEnabled field to HuaweiMap.
    - Added isMarkerClusterable method to HuaweiMapController.
    - Added clusterable field to Marker object.
* Added HuaweiMapUtils class.
    - Added HMS Logger for usage analytics of Huawei Map SDK.
        - Added the enableLogger method.
        - Added the disableLogger method.
    - Added distanceCalculator method. 
* Bug fixes and improvements.
* Updated demo application. 

## 4.0.4+300

* Removed pubspec.lock file in example.

## 4.0.4

* Initial release.

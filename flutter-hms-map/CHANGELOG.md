## 6.11.2+303

- Dart improvements.

## 6.11.2+302

- Minor optimization and bug fixes.

## 6.11.2+301

- Updated Huawei Map SDK version to 6.11.2.301.

## 6.11.0+304

- **Breaking Change:** Renamed the HmsMarkerAnimation, HmsMarkerAlphaAnimation, HmsMarkerRotateAnimation, HmsMarkerScaleAnimation and HmsMarkerTranslateAnimation classes to HmsAnimation, HmsAlphaAnimation, HmsRotateAnimation, HmsScaleAnimation and HmsTranslateAnimation respectively. 

- Updated Huawei Map SDK version to 6.11.0.304.
- Added **animation** property to Circle class. Currently only the HmsTranslateAnimation is supported on Circles.
- Added **getScalePerPixel** method to HuaweiMapController class. This method is used to obtain the length of one pixel point on the map at the current zoom level.
- Added **myLocationStyle** property to HuaweiMap class. This property is used to set my-location icon style.
- Added **gradient** property to Polyline class. This property is used to set gradient for a polyline.
- Added **colorValues** property to Polyline class. This property is used to set colors for different segments of a polyline.
- Fixed the bug that prevents **clickable** property of Marker class. 
- Updated targetSdkVersion to 33, to make sure that your app can run properly on Android 13.

## 6.9.0+300

- **Breaking Change:** Modified the internal structure of the plugin. Please use import **package:huawei_map/huawei_map.dart** not to get any errors.

- Added the **setAccessToken** method to the `HuaweiMapInitializer` class.
- Added the **routePolicy** parameter to the `HuaweiMapInitializer.initializeMap` method.
- Added the **isDark** parameter to the `HuaweiMap` class. The parameter are used to specify whether to enable the dark mode after the map is loaded.
- Added the **isDark** parameter to the `HuaweiMapOptions` class. The parameter are used to specify whether to enable the dark mode before the map is loaded.

## 6.5.0+301

- Updated Huawei Map SDK version to 6.5.0.301.
- [Breaking Change] Added the requirement of calling the HuaweiMapInitializer.initializeMap API before using the latest SDK.
- Added the Heatmap function, allowing you to add, modify, delete, and customize a heatmap layer.
- Added the convertCoordinate and convertCoordinates API, which converts WGS84 coordinates into GCJ02 coordinates.

## 6.0.1+305

- Deleted the capability of prompting users to install HMS Core (APK).

## 6.0.1+304

- Updated Huawei Map SDK version to 6.0.1.304.
- Added the Terrain Map Type.
- Supported Lite Mode for maps.
- Renamed animation.dart to hmsMarkerAnimation.dart. Class name (HmsMarkerAnimation) remains unchanged.

## 5.3.0+301

- [Hotfix] Meta package change to support Flutter and Dart versions.

## 5.3.0+300

- [Breaking Change] Migrated library to null safety.
- Updated Huawei Map SDK version to 5.3.0.300.
- Fixed the bug that prevents setting initial padding values to Huawei Map instance.
- Fixed the bug that prevents creating a Ground Overlay by specifying bounds.
- On invalid refWidth value, Cap.customCapFromBitmap method now returns roundcap instead of null.
- Added PointOfInterest class.
- New features to Polygons.
  - Added holes property to create holes on a shape.
  - Added strokeJointType property to customize the joint types.
  - Added strokePattern property to customize the stroke patterns.
- New feature to Circles.
  - Added strokePattern property to customize the stroke patterns.
- New features to InfoWindows.
  - Added onLongClick callback to listen for long clicks on InfoWindows.
  - Added onClose callback to listen for close events of InfoWindows.
- New Features to Markers.
  - Added onDragStart callback to listen for start of the drag events.
  - Added onDrag callback to listen for drag positions of the event.
- New features to HuaweiMap.
  - Added onPoiClick callback to listen for Point of Interest clicks.
  - Added allGesturesEnabled property to enable all gestures.
  - Added isScrollGesturesEnabledDuringRotateOrZoom property to enable scroll gestures during rotate or zoom.
  - Added pointToCenter property to set a fixed screen center for zooming.
  - Added gestureScaleByMapCenter property to specify whether a fixed screen center can be set for zooming.
  - Added onMyLocationClick callback to listen for my location clicks.
  - Added onMyLocationButtonClick callback to listen for my location buttons clicks.
  - Added stopAnimation API to HuaweiMapController to stop camera animation.
  - Added onCameraMoveCanceled callback to listen for canceled camera movements.
  - onCameraMoveStarted callback now returns a reason for the camera movement.
    - Added REASON_API_ANIMATION constant.
    - Added REASON_DEVELOPER_ANIMATION constant.
    - Added REASON_GESTURE constant.
  - Added clusterIconDescriptor property to customize the cluster markar.
  - Added clusterMarkerColor property to customize the color of the cluster marker.
  - Added clusterMarkerTextColor property to customize the text color of the customized cluster marker.
  - Added logoPosition property to specify the position of the Petal Maps logo.
  - Added logoPadding property to adjust the position of the Petal Maps logo.
  - Added position constants for logoPosition property.
    - Added LOWER_LEFT constant.
    - Added LOWER_RIGHT constant.
    - Added UPPER_LEFT constant.
    - Added UPPER_RIGHT constant.
  - Added styleId property to set a custom style for a Huawei Map instance.
  - Added previewId property to set a custom style for a Huawei Map instance.
  - Added setLocationSource API to HuaweiMapController to enable location source feature.
  - Added setLocation API to HuaweiMapController to specify custom location to location source.
  - Added deactivateLocationSource API to HuaweiMapController to deactivate the location source feature.

## 5.0.3+303

- Updated HMSLogger.
- Fixed the bug that causes the Huawei Map to crash when running on earlier HMS Core versions.
- Fixed the bug that causes the app to crash when pressing the "Legal" button on the Huawei Map instances.
- Added missing permission for the demo application that prevents the app from running.

## 5.0.3+302

- Added Tile Overlays and tile types.
  - Added Tile.
  - Added UrlTile.
  - Added RepetitiveTile.
- Added Ground Overlays.
- Added marker animations to Markers.
  - Added startAnimationOnMarker method to HuaweiMapController.
  - Added animationSet field to Marker object.
  - Added Alpha Animation.
  - Added Rotate Animation.
  - Added Scale Animation.
  - Added Translate Animation.
- Added marker clustering feature to Markers.
  - Added markersClusteringEnabled field to HuaweiMap.
  - Added isMarkerClusterable method to HuaweiMapController.
  - Added clusterable field to Marker object.
- Added HuaweiMapUtils class.
  - Added HMS Logger for usage analytics of Huawei Map SDK.
    - Added the enableLogger method.
    - Added the disableLogger method.
  - Added distanceCalculator method.
- Bug fixes and improvements.
- Updated demo application.

## 4.0.4+300

- Removed pubspec.lock file in example.

## 4.0.4

- Initial release.

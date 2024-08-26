/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.huawei.hms.flutter.map.constants;

public interface Param {
    String MAP = "map";
    String OPTIONS = "options";
    String INITIAL_CAMERA_POSITION = "initialCameraPosition";
    String CAMERA_UPDATE = "cameraUpdate";
    String MARKERS_TO_INSERT = "markersToAdd";
    String MARKERS_TO_UPDATE = "markersToChange";
    String MARKERS_TO_DELETE = "markerIdsToRemove";
    String POLYLINES_TO_INSERT = "polylinesToAdd";
    String POLYLINES_TO_UPDATE = "polylinesToChange";
    String POLYLINES_TO_DELETE = "polylineIdsToRemove";
    String POLYGONS_TO_INSERT = "polygonsToAdd";
    String POLYGONS_TO_UPDATE = "polygonsToChange";
    String POLYGONS_TO_DELETE = "polygonIdsToRemove";
    String CIRCLES_TO_INSERT = "circlesToAdd";
    String CIRCLES_TO_UPDATE = "circlesToChange";
    String CIRCLES_TO_DELETE = "circleIdsToRemove";
    String HEAT_MAPS_TO_INSERT = "heatMapsToAdd";
    String HEAT_MAPS_TO_UPDATE = "heatMapsToChange";
    String HEAT_MAPS_TO_DELETE = "heatMapIdsToRemove";
    String NEW_CAMERA_POSITION = "newCameraPosition";
    String NEW_LAT_LNG = "newLatLng";
    String NEW_LAT_LNG_BOUNDS = "newLatLngBounds";
    String NEW_LAT_LNG_ZOOM = "newLatLngZoom";
    String SCROLL_BY = "scrollBy";
    String ZOOM_BY = "zoomBy";
    String ZOOM_IN = "zoomIn";
    String ZOOM_OUT = "zoomOut";
    String ZOOM_TO = "zoomTo";
    String POSITION = "position";
    String REASON = "reason";
    String MARKER_ID = "markerId";
    String COMPASS_ENABLED = "compassEnabled";
    String IS_DARK = "isDark";
    String MAP_TOOLBAR_ENABLED = "mapToolbarEnabled";
    String CAMERA_TARGET_BOUNDS = "cameraTargetBounds";
    String MAP_TYPE = "mapType";
    String MIN_MAX_ZOOM_PREFERENCE = "minMaxZoomPreference";
    String ROTATE_GESTURES_ENABLED = "rotateGesturesEnabled";
    String SCROLL_GESTURES_ENABLED = "scrollGesturesEnabled";
    String TILT_GESTURES_ENABLED = "tiltGesturesEnabled";
    String ZOOM_CONTROLS_ENABLED = "zoomControlsEnabled";
    String ZOOM_GESTURES_ENABLED = "zoomGesturesEnabled";
    String ALL_GESTURES_ENABLED = "allGesturesEnabled";
    String TRACK_CAMERA_POSITION = "trackCameraPosition";
    String MY_LOCATION_ENABLED = "myLocationEnabled";
    String MY_LOCATION_BUTTON_ENABLED = "myLocationButtonEnabled";
    String PADDING = "padding";
    String TRAFFIC_ENABLED = "trafficEnabled";
    String BUILDINGS_ENABLED = "buildingsEnabled";
    String CIRCLE_ID = "circleId";
    String POLYLINE_ID = "polylineId";
    String DEFAULT_MARKER = "defaultMarker";
    String FROM_ASSET = "fromAsset";
    String FROM_ASSET_IMAGE = "fromAssetImage";
    String FROM_BYTES = "fromBytes";
    String BEARING = "bearing";
    String TARGET = "target";
    String TILT = "tilt";
    String ZOOM = "zoom";
    String CLICKABLE = "clickable";
    String GEODESIC = "geodesic";
    String VISIBLE = "visible";
    String FILL_COLOR = "fillColor";
    String STROKE_COLOR = "strokeColor";
    String STROKE_WIDTH = "strokeWidth";
    String Z_INDEX = "zIndex";
    String POINTS = "points";
    String POLYGON_ID = "polygonId";
    String COLOR = "color";
    String END_CAP = "endCap";
    String JOINT_TYPE = "jointType";
    String START_CAP = "startCap";
    String WIDTH = "width";
    String PATTERN = "pattern";
    String CENTER = "center";
    String RADIUS = "radius";
    String DOT = "dot";
    String DASH = "dash";
    String GAP = "gap";
    String BUTT_CAP = "buttCap";
    String ROUND_CAP = "roundCap";
    String SQUARE_CAP = "squareCap";
    String CUSTOM_CAP = "customCap";
    String ERROR = "ERROR";
    String SOUTHWEST = "southwest";
    String NORTHEAST = "northeast";
    String X = "x";
    String Y = "y";
    String TITLE = "title";
    String SNIPPET = "snippet";
    String ANCHOR = "anchor";
    String ROTATION = "rotation";
    String INFO_WINDOW = "infoWindow";
    String ICON = "icon";
    String FLAT = "flat";
    String DRAGGABLE = "draggable";
    String ALPHA = "alpha";
    String GROUND_OVERLAYS_TO_INSERT = "groundOverlaysToAdd";
    String GROUND_OVERLAYS_TO_UPDATE = "groundOverlaysToChange";
    String GROUND_OVERLAYS_TO_DELETE = "groundOverlayIdsToRemove";
    String GROUND_OVERLAY_ID = "groundOverlayId";
    String HEIGHT = "height";
    String IMAGE_DESCRIPTOR = "imageDescriptor";
    String BOUNDS = "bounds";
    String TRANSPARENCY = "transparency";
    String MARKERS_CLUSTERING_ENABLED = "markersClusteringEnabled";
    String CLUSTERABLE = "clusterable";
    String TILE_OVERLAY_ID = "tileOverlayId";
    String FADE_IN = "fadeIn";
    String TILE_OVERLAYS_TO_INSERT = "tileOverlaysToAdd";
    String TILE_OVERLAYS_TO_UPDATE = "tileOverlaysToChange";
    String TILE_OVERLAYS_TO_DELETE = "tileOverlayIdsToRemove";
    String TILE_PROVIDER = "tileProvider";
    String URI = "uri";
    String IMAGE_DATA = "imageData";
    String ANIMATION_ID = "animationId";
    String ANIMATION = "animation";
    String FROM_ALPHA = "fromAlpha";
    String TO_ALPHA = "toAlpha";
    String FROM_DEGREE = "fromDegree";
    String TO_DEGREE = "toDegree";
    String FROM_X = "fromX";
    String FROM_Y = "fromY";
    String TO_X = "toX";
    String TO_Y = "toY";
    String LAT_LNG = "latLng";
    String DURATION = "duration";
    String FILL_MODE = "fillMode";
    String REPEAT_COUNT = "repeatCount";
    String REPEAT_MODE = "repeatMode";
    String INTERPOLATOR = "interpolator";
    String ANIMATION_TYPE = "animationType";
    String POINT_OF_INTEREST = "pointOfInterest";
    String NAME = "name";
    String PLACE_ID = "placeId";
    String HOLES = "holes";
    String STROKE_JOINT_TYPE = "strokeJointType";
    String STROKE_PATTERN = "strokePattern";
    String IS_SCROLL_GESTURES_ENABLED_DURING_ROTATE_OR_ZOOM = "isScrollGesturesEnabledDuringRotateOrZoom";
    String GESTURE_SCALE_BY_MAP_CENTER = "gestureScaleByMapCenter";
    String POINT_TO_CENTER = "pointToCenter";
    String LOCATION = "location";
    String LATITUDE = "latitude";
    String LONGITUDE = "longitude";
    String ALTITUDE = "altitude";
    String SPEED = "speed";
    String ACCURACY = "accuracy";
    String VERTICAL_ACCURACY_METERS = "verticalAccuracyMeters";
    String BEARING_ACCURACY_DEGREES = "bearingAccuracyDegrees";
    String SPEED_ACCURACY_METERS_PER_SECOND = "speedAccuracyMetersPerSecond";
    String TIME = "time";
    String FROM_MOCK_PROVIDER = "fromMockProvider";
    String CLUSTER_MARKER_COLOR = "clusterMarkerColor";
    String CLUSTER_MARKER_TEXT_COLOR = "clusterMarkerTextColor";
    String CLUSTER_MARKER_ICON = "clusterMarkerIcon";
    String LOGO_POSITION = "logoPosition";
    String LOGO_PADDING = "logoPadding";
    String STYLE_ID = "styleId";
    String PREVIEW_ID = "previewId";
    String LITE_MODE = "liteMode";
    String HEAT_MAP_ID = "heatMapId";
    String RESOURCE_ID = "resourceId";
    String JSON_DATA = "jsonData";
    String INTENSITY = "intensity";
    String INTENSITY_MAP = "intensityMap";
    String OPACITY = "opacity";
    String OPACITY_MAP = "opacityMap";
    String RADIUS_MAP = "radiusMap";
    String RADIUS_UNIT = "radiusUnit";
    String MYLOCATION_STYLE = "myLocationStyle";
    String RADIUS_FILL_COLOR = "radiusFillColor";
    String GRADIENT = "gradient";
    String COLOR_VALUES = "colorValues";
}

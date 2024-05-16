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

package com.huawei.hms.flutter.map.map;

import android.app.Application;

import com.huawei.hms.flutter.map.circle.CircleUtils;
import com.huawei.hms.flutter.map.constants.Method;
import com.huawei.hms.flutter.map.constants.Param;
import com.huawei.hms.flutter.map.groundoverlay.GroundOverlayUtils;
import com.huawei.hms.flutter.map.heatmap.HeatMapUtils;
import com.huawei.hms.flutter.map.logger.HMSLogger;
import com.huawei.hms.flutter.map.marker.MarkersUtils;
import com.huawei.hms.flutter.map.polygon.PolygonUtils;
import com.huawei.hms.flutter.map.polyline.PolylineUtils;
import com.huawei.hms.flutter.map.tileoverlay.TileOverlayUtils;
import com.huawei.hms.flutter.map.utils.Convert;
import com.huawei.hms.maps.CameraUpdate;
import com.huawei.hms.maps.HuaweiMap;
import com.huawei.hms.maps.model.CameraPosition;
import com.huawei.hms.maps.model.LatLng;
import com.huawei.hms.maps.model.MapStyleOptions;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

class MapUtils {
    private HuaweiMap huaweiMap;

    private final float compactness;

    private final MarkersUtils markersUtils;

    private final PolylineUtils polylineUtils;

    private final PolygonUtils polygonUtils;

    private final CircleUtils circleUtils;

    private final GroundOverlayUtils groundOverlayUtils;

    private final TileOverlayUtils tileOverlayUtils;

    private final HeatMapUtils heatMapUtils;

    private BinaryMessenger messenger;

    private final HMSLogger logger;

    MapUtils(final MethodChannel mChannel, final float compactness, final Application application) {
        logger = HMSLogger.getInstance(application);
        this.compactness = compactness;

        markersUtils = new MarkersUtils(mChannel, application);
        polylineUtils = new PolylineUtils(mChannel, compactness, application);
        polygonUtils = new PolygonUtils(mChannel, compactness, application);
        circleUtils = new CircleUtils(mChannel, compactness, application);
        groundOverlayUtils = new GroundOverlayUtils(mChannel, application);
        tileOverlayUtils = new TileOverlayUtils(application);
        heatMapUtils = new HeatMapUtils(mChannel, application);
    }

    void init(final HuaweiMap huaweiMap, final List<HashMap<String, Object>> initMarkers,
        final List<HashMap<String, Object>> initPolylines, final List<HashMap<String, Object>> initPolygons,
        final List<HashMap<String, Object>> initCircles, final List<HashMap<String, Object>> initGroundOverlays,
        final List<HashMap<String, Object>> initTileOverlays, final List<HashMap<String, Object>> initHeatMaps,
        final boolean markersClustering, final BinaryMessenger messenger) {
        this.huaweiMap = huaweiMap;
        markersUtils.setMap(huaweiMap);
        polylineUtils.setMap(huaweiMap);
        polygonUtils.setMap(huaweiMap);
        circleUtils.setMap(huaweiMap);
        groundOverlayUtils.setMap(huaweiMap);
        tileOverlayUtils.setMap(huaweiMap);
        heatMapUtils.setMap(huaweiMap);
        huaweiMap.setMarkersClustering(markersClustering);
        initComponents(initMarkers, initPolylines, initPolygons, initCircles, initGroundOverlays, initTileOverlays,
            initHeatMaps, messenger);
    }

    void initComponents(final List<HashMap<String, Object>> initMarkers,
        final List<HashMap<String, Object>> initPolylines, final List<HashMap<String, Object>> initPolygons,
        final List<HashMap<String, Object>> initCircles, final List<HashMap<String, Object>> initGroundOverlays,
        final List<HashMap<String, Object>> initTileOverlays, final List<HashMap<String, Object>> initHeatMaps,
        final BinaryMessenger messenger) {
        this.messenger = messenger;
        initMarkers(initMarkers);
        initPolylines(initPolylines);
        initPolygons(initPolygons);
        initCircles(initCircles);
        initGroundOverlays(initGroundOverlays);
        initTileOverlays(initTileOverlays);
        initHeatMaps(initHeatMaps);
    }

    void initMarkers(final List<HashMap<String, Object>> initMarkers) {
        markersUtils.insertMulti(initMarkers, messenger);
    }

    void initPolygons(final List<HashMap<String, Object>> initPolygons) {
        polygonUtils.insertMulti(initPolygons);
    }

    void initPolylines(final List<HashMap<String, Object>> initPolylines) {
        polylineUtils.insertMulti(initPolylines);
    }

    void initCircles(final List<HashMap<String, Object>> initCircles) {
        circleUtils.insertMulti(initCircles, messenger);
    }

    void initGroundOverlays(final List<HashMap<String, Object>> initGroundOverlays) {
        groundOverlayUtils.insertMulti(initGroundOverlays);
    }

    void initTileOverlays(final List<HashMap<String, Object>> initTileOverlays) {
        tileOverlayUtils.insertMulti(initTileOverlays);
    }

    void initHeatMaps(final List<HashMap<String, Object>> initHeatMaps) {
        heatMapUtils.insertMulti(initHeatMaps);
    }

    void moveCamera(final CameraUpdate cameraUpdate) {
        logger.startMethodExecutionTimer("moveCamera");
        huaweiMap.moveCamera(cameraUpdate);
        logger.sendSingleEvent("moveCamera");
    }

    void animateCamera(final CameraUpdate cameraUpdate) {
        logger.startMethodExecutionTimer("animateCamera");
        huaweiMap.animateCamera(cameraUpdate);
        logger.sendSingleEvent("animateCamera");
    }

    CameraPosition getCameraPosition(final boolean trackCameraPosition) {
        return trackCameraPosition ? huaweiMap.getCameraPosition() : null;
    }

    void onMethodCallCamera(final MethodCall call, final MethodChannel.Result result) {
        switch (call.method) {
            case Method.CAMERA_ANIMATE: {
                final CameraUpdate cameraUpdate = Convert.toCameraUpdate(call.argument(Param.CAMERA_UPDATE),
                    compactness);
                animateCamera(cameraUpdate);
                result.success(true);
                break;
            }
            case Method.MAP_SET_STYLE: {
                final String mapStyle = (String) call.arguments;
                logger.startMethodExecutionTimer(Method.MAP_SET_STYLE);
                final boolean mapStyleSet = mapStyle == null
                    ? huaweiMap.setMapStyle(null)
                    : huaweiMap.setMapStyle(new MapStyleOptions(mapStyle));
                final ArrayList<Object> mapStyleResult = new ArrayList<>();
                mapStyleResult.add(mapStyleSet);
                if (!mapStyleSet) {
                    mapStyleResult.add(Param.ERROR);
                }
                result.success(mapStyleResult);
                logger.sendSingleEvent(Method.MAP_SET_STYLE);
                break;
            }
            default:
                onMethodCallComponents(call, result);
        }
    }

    private void onMethodCallComponents(final MethodCall call, final MethodChannel.Result result) {
        switch (call.method) {
            case Method.MARKERS_UPDATE: {
                markersUtils.insertMulti(call.argument(Param.MARKERS_TO_INSERT), messenger);
                markersUtils.updateMulti(call.argument(Param.MARKERS_TO_UPDATE));
                markersUtils.deleteMulti(call.argument(Param.MARKERS_TO_DELETE));
                result.success(true);
                break;
            }
            case Method.POLYGONS_UPDATE: {
                polygonUtils.insertMulti(call.argument(Param.POLYGONS_TO_INSERT));
                polygonUtils.updateMulti(call.argument(Param.POLYGONS_TO_UPDATE));
                polygonUtils.deleteMulti(call.argument(Param.POLYGONS_TO_DELETE));
                result.success(true);
                break;
            }
            case Method.POLYLINES_UPDATE: {
                polylineUtils.insertMulti(call.argument(Param.POLYLINES_TO_INSERT));
                polylineUtils.updateMulti(call.argument(Param.POLYLINES_TO_UPDATE));
                polylineUtils.deleteMulti(call.argument(Param.POLYLINES_TO_DELETE));
                result.success(true);
                break;
            }
            case Method.CIRCLES_UPDATE: {
                circleUtils.insertMulti(call.argument(Param.CIRCLES_TO_INSERT), messenger);
                circleUtils.updateMulti(call.argument(Param.CIRCLES_TO_UPDATE));
                circleUtils.deleteMulti(call.argument(Param.CIRCLES_TO_DELETE));
                result.success(true);
                break;
            }
            case Method.GROUND_OVERLAYS_UPDATE: {
                groundOverlayUtils.insertMulti(call.argument(Param.GROUND_OVERLAYS_TO_INSERT));
                groundOverlayUtils.updateMulti(call.argument(Param.GROUND_OVERLAYS_TO_UPDATE));
                groundOverlayUtils.deleteMulti(call.argument(Param.GROUND_OVERLAYS_TO_DELETE));
                result.success(true);
                break;
            }
            case Method.TILE_OVERLAYS_UPDATE: {
                tileOverlayUtils.insertMulti(call.argument(Param.TILE_OVERLAYS_TO_INSERT));
                tileOverlayUtils.updateMulti(call.argument(Param.TILE_OVERLAYS_TO_UPDATE));
                tileOverlayUtils.deleteMulti(call.argument(Param.TILE_OVERLAYS_TO_DELETE));
                result.success(true);
                break;
            }
            case Method.HEAT_MAPS_UPDATE: {
                heatMapUtils.insertMulti(call.argument(Param.HEAT_MAPS_TO_INSERT));
                heatMapUtils.updateMulti(call.argument(Param.HEAT_MAPS_TO_UPDATE));
                heatMapUtils.deleteMulti(call.argument(Param.HEAT_MAPS_TO_DELETE));
                result.success(true);
                break;
            }
            case Method.CLEAR_TILE_CACHE: {
                final Object tileOverlayId = call.argument(Param.TILE_OVERLAY_ID);
                tileOverlayUtils.clearTileCache((String) tileOverlayId);
                result.success(null);
                break;
            }
            case Method.MARKER_START_ANIMATION: {
                final Object markerId = call.argument(Param.MARKER_ID);
                logger.startMethodExecutionTimer(Method.MARKER_START_ANIMATION);
                markersUtils.startAnimation((String) markerId);
                logger.sendSingleEvent(Method.MARKER_START_ANIMATION);
                break;
            }
            case Method.CIRCLE_START_ANIMATION: {
                final Object circleId = call.argument(Param.CIRCLE_ID);
                logger.startMethodExecutionTimer(Method.CIRCLE_START_ANIMATION);
                circleUtils.startAnimation((String) circleId);
                logger.sendSingleEvent(Method.CIRCLE_START_ANIMATION);
                break;
            }
            case Method.MARKERS_SHOW_INFO_WINDOW: {
                final Object markerId = call.argument(Param.MARKER_ID);
                logger.startMethodExecutionTimer(Method.MARKERS_SHOW_INFO_WINDOW);
                markersUtils.showInfoWindow((String) markerId, result);
                logger.sendSingleEvent(Method.MARKERS_SHOW_INFO_WINDOW);
                break;
            }
            case Method.MARKERS_HIDE_INFO_WINDOW: {
                final Object markerId = call.argument(Param.MARKER_ID);
                logger.startMethodExecutionTimer(Method.MARKERS_HIDE_INFO_WINDOW);
                markersUtils.hideInfoWindow((String) markerId, result);
                logger.sendSingleEvent(Method.MARKERS_HIDE_INFO_WINDOW);
                break;
            }
            case Method.MARKERS_IS_INFO_WINDOW_SHOWN: {
                final Object markerId = call.argument(Param.MARKER_ID);
                logger.startMethodExecutionTimer(Method.MARKERS_IS_INFO_WINDOW_SHOWN);
                markersUtils.isInfoWindowShown((String) markerId, result);
                logger.sendSingleEvent(Method.MARKERS_IS_INFO_WINDOW_SHOWN);
                break;
            }
            case Method.MARKER_IS_CLUSTERABLE: {
                final Object markerId = call.argument(Param.MARKER_ID);
                logger.startMethodExecutionTimer(Method.MARKER_IS_CLUSTERABLE);
                markersUtils.isMarkerClusterable((String) markerId, result);
                logger.sendSingleEvent(Method.MARKER_IS_CLUSTERABLE);
                break;
            }
            default:
                onMethodCallGetters(call, result);
        }
    }

    private void onMethodCallGetters(final MethodCall call, final MethodChannel.Result result) {
        switch (call.method) {
            case Method.MAP_IS_COMPASS_ENABLED: {
                logger.startMethodExecutionTimer(Method.MAP_IS_COMPASS_ENABLED);
                result.success(huaweiMap.getUiSettings().isCompassEnabled());
                logger.sendSingleEvent(Method.MAP_IS_COMPASS_ENABLED);
                break;
            }
            case Method.MAP_IS_DARK: {
                logger.startMethodExecutionTimer(Method.MAP_IS_DARK);
                result.success(huaweiMap.isDark());
                logger.sendSingleEvent(Method.MAP_IS_DARK);
                break;
            }
            case Method.MAP_IS_MAP_TOOLBAR_ENABLED: {
                logger.startMethodExecutionTimer(Method.MAP_IS_MAP_TOOLBAR_ENABLED);
                result.success(huaweiMap.getUiSettings().isMapToolbarEnabled());
                logger.sendSingleEvent(Method.MAP_IS_MAP_TOOLBAR_ENABLED);
                break;
            }
            case Method.MAP_GET_MIN_MAX_ZOOM_LEVELS: {
                logger.startMethodExecutionTimer(Method.MAP_GET_MIN_MAX_ZOOM_LEVELS);
                final List<Float> zoomLevels = new ArrayList<>();
                zoomLevels.add(huaweiMap.getMinZoomLevel());
                zoomLevels.add(huaweiMap.getMaxZoomLevel());
                result.success(zoomLevels);
                logger.sendSingleEvent(Method.MAP_GET_MIN_MAX_ZOOM_LEVELS);
                break;
            }
            case Method.MAP_IS_TILT_GESTURES_ENABLED: {
                logger.startMethodExecutionTimer(Method.MAP_IS_TILT_GESTURES_ENABLED);
                result.success(huaweiMap.getUiSettings().isTiltGesturesEnabled());
                logger.sendSingleEvent(Method.MAP_IS_TILT_GESTURES_ENABLED);
                break;
            }
            case Method.MAP_IS_ROTATE_GESTURES_ENABLED: {
                logger.startMethodExecutionTimer(Method.MAP_IS_ROTATE_GESTURES_ENABLED);
                result.success(huaweiMap.getUiSettings().isRotateGesturesEnabled());
                logger.sendSingleEvent(Method.MAP_IS_ROTATE_GESTURES_ENABLED);
                break;
            }
            case Method.MAP_IS_ZOOM_GESTURES_ENABLED: {
                logger.startMethodExecutionTimer(Method.MAP_IS_ZOOM_GESTURES_ENABLED);
                result.success(huaweiMap.getUiSettings().isZoomGesturesEnabled());
                logger.sendSingleEvent(Method.MAP_IS_ZOOM_GESTURES_ENABLED);
                break;
            }
            case Method.MAP_IS_ZOOM_CONTROLS_ENABLED: {
                logger.startMethodExecutionTimer(Method.MAP_IS_ZOOM_CONTROLS_ENABLED);
                result.success(huaweiMap.getUiSettings().isZoomControlsEnabled());
                logger.sendSingleEvent(Method.MAP_IS_ZOOM_CONTROLS_ENABLED);
                break;
            }
            case Method.MAP_IS_SCROLL_GESTURES_ENABLED: {
                logger.startMethodExecutionTimer(Method.MAP_IS_SCROLL_GESTURES_ENABLED);
                result.success(huaweiMap.getUiSettings().isScrollGesturesEnabled());
                logger.sendSingleEvent(Method.MAP_IS_SCROLL_GESTURES_ENABLED);
                break;
            }
            case Method.MAP_IS_MY_LOCATION_BUTTON_ENABLED: {
                logger.startMethodExecutionTimer(Method.MAP_IS_MY_LOCATION_BUTTON_ENABLED);
                result.success(huaweiMap.getUiSettings().isMyLocationButtonEnabled());
                logger.sendSingleEvent(Method.MAP_IS_MY_LOCATION_BUTTON_ENABLED);
                break;
            }
            case Method.MAP_GET_ZOOM_LEVEL: {
                logger.startMethodExecutionTimer(Method.MAP_GET_ZOOM_LEVEL);
                result.success(huaweiMap.getCameraPosition().zoom);
                logger.sendSingleEvent(Method.MAP_GET_ZOOM_LEVEL);
                break;
            }
            case Method.MAP_IS_TRAFFIC_ENABLED: {
                logger.startMethodExecutionTimer(Method.MAP_IS_TRAFFIC_ENABLED);
                result.success(huaweiMap.isTrafficEnabled());
                logger.sendSingleEvent(Method.MAP_IS_TRAFFIC_ENABLED);
                break;
            }
            case Method.MAP_IS_BUILDINGS_ENABLED: {
                logger.startMethodExecutionTimer(Method.MAP_IS_BUILDINGS_ENABLED);
                result.success(huaweiMap.isBuildingsEnabled());
                logger.sendSingleEvent(Method.MAP_IS_BUILDINGS_ENABLED);
                break;
            }
            default:
                result.notImplemented();
        }
    }

    void onMarkerDragEnd(final String idOnMap, final LatLng latLng) {
        logger.startMethodExecutionTimer("onMarkerDragEnd");
        markersUtils.onMarkerDragEnd(idOnMap, latLng);
        logger.sendSingleEvent("onMarkerDragEnd");
    }

    void onMarkerDragStart(final String idOnMap, final LatLng latLng) {
        logger.startMethodExecutionTimer("onMarkerDragStart");
        markersUtils.onMarkerDragStart(idOnMap, latLng);
        logger.sendSingleEvent("onMarkerDragStart");
    }

    void onMarkerDrag(final String idOnMap, final LatLng latLng) {
        logger.startMethodExecutionTimer("onMarkerDrag");
        markersUtils.onMarkerDrag(idOnMap, latLng);
        logger.sendSingleEvent("onMarkerDrag");
    }

    boolean onMarkerClick(final String idOnMap) {
        return markersUtils.onMarkerClick(idOnMap);
    }

    void onPolygonClick(final String idOnMap) {
        logger.startMethodExecutionTimer("onPolygonClick");
        polygonUtils.onPolygonClick(idOnMap);
        logger.sendSingleEvent("onPolygonClick");
    }

    void onPolylineClick(final String idOnMap) {
        logger.startMethodExecutionTimer("onPolylineClick");
        polylineUtils.onPolylineClick(idOnMap);
        logger.sendSingleEvent("onPolylineClick");
    }

    void onCircleClick(final String idOnMap) {
        logger.startMethodExecutionTimer("onCircleClick");
        circleUtils.onCircleClick(idOnMap);
        logger.sendSingleEvent("onCircleClick");
    }

    void onGroundOverlayClick(final String idOnMap) {
        logger.startMethodExecutionTimer("onGroundOverlayClick");
        groundOverlayUtils.onGroundOverlayClick(idOnMap);
        logger.sendSingleEvent("onGroundOverlayClick");
    }

    void onInfoWindowClick(final String idOnMap) {
        logger.startMethodExecutionTimer("onInfoWindowClick");
        markersUtils.onInfoWindowClick(idOnMap);
        logger.sendSingleEvent("onInfoWindowClick");
    }

    void onInfoWindowLongClick(final String idOnMap) {
        logger.startMethodExecutionTimer("onInfoWindowLongClick");
        markersUtils.onInfoWindowLongClick(idOnMap);
        logger.sendSingleEvent("onInfoWindowLongClick");
    }

    void onInfoWindowClose(final String idOnMap) {
        logger.startMethodExecutionTimer("onInfoWindowClose");
        markersUtils.onInfoWindowClose(idOnMap);
        logger.sendSingleEvent("onInfoWindowClose");
    }
}

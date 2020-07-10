/*
Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.map.map;

import com.huawei.hms.flutter.map.circle.CircleUtils;
import com.huawei.hms.flutter.map.constants.Method;
import com.huawei.hms.flutter.map.constants.Param;
import com.huawei.hms.flutter.map.marker.MarkersUtils;
import com.huawei.hms.flutter.map.polygon.PolygonUtils;
import com.huawei.hms.flutter.map.polyline.PolylineUtils;
import com.huawei.hms.flutter.map.utils.Convert;
import com.huawei.hms.maps.CameraUpdate;
import com.huawei.hms.maps.HuaweiMap;
import com.huawei.hms.maps.model.CameraPosition;
import com.huawei.hms.maps.model.LatLng;
import com.huawei.hms.maps.model.MapStyleOptions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

class MapUtils {
    private HuaweiMap huaweiMap;

    private final float compactness;

    private final MarkersUtils markersUtils;
    private final PolylineUtils polylineUtils;
    private final PolygonUtils polygonUtils;
    private final CircleUtils circleUtils;

    MapUtils(MethodChannel mChannel, float compactness) {

        this.compactness = compactness;

        this.markersUtils = new MarkersUtils(mChannel);
        this.polylineUtils = new PolylineUtils(mChannel, compactness);
        this.polygonUtils = new PolygonUtils(mChannel, compactness);
        this.circleUtils = new CircleUtils(mChannel, compactness);
    }

    void init(HuaweiMap huaweiMap, List<HashMap<String, Object>> initMarkers, List<HashMap<String, Object>> initPolylines, List<HashMap<String, Object>> initPolygons, List<HashMap<String, Object>> initCircles) {
        this.huaweiMap = huaweiMap;
        markersUtils.setMap(huaweiMap);
        polylineUtils.setMap(huaweiMap);
        polygonUtils.setMap(huaweiMap);
        circleUtils.setMap(huaweiMap);
        initComponents(initMarkers, initPolylines, initPolygons, initCircles);
    }

    void initComponents(List<HashMap<String, Object>> initMarkers, List<HashMap<String, Object>> initPolylines, List<HashMap<String, Object>> initPolygons, List<HashMap<String, Object>> initCircles) {
        initMarkers(initMarkers);
        initPolylines(initPolylines);
        initPolygons(initPolygons);
        initCircles(initCircles);
    }

    void initMarkers(List<HashMap<String, Object>> initMarkers) {
        markersUtils.insertMulti(initMarkers);
    }

    void initPolygons(List<HashMap<String, Object>> initPolygons) {
        polygonUtils.insertMulti(initPolygons);
    }

    void initPolylines(List<HashMap<String, Object>> initPolylines) {
        polylineUtils.insertMulti(initPolylines);
    }

    void initCircles(List<HashMap<String, Object>> initCircles) {
        circleUtils.insertMulti(initCircles);
    }

    void moveCamera(CameraUpdate cameraUpdate) {
        huaweiMap.moveCamera(cameraUpdate);
    }

    void animateCamera(CameraUpdate cameraUpdate) {
        huaweiMap.animateCamera(cameraUpdate);
    }

    CameraPosition getCameraPosition(boolean trackCameraPosition) {
        return trackCameraPosition ? huaweiMap.getCameraPosition() : null;
    }


    void onMethodCallCamera(MethodCall call, MethodChannel.Result result) {
        switch (call.method) {
            case Method.CAMERA_ANIMATE: {
                final CameraUpdate cameraUpdate =
                        Convert.toCameraUpdate(call.argument(Param.CAMERA_UPDATE), compactness);
                animateCamera(cameraUpdate);
                result.success(true);
                break;
            }
            case Method.MAP_SET_STYLE: {
                String mapStyle = (String) call.arguments;
                boolean mapStyleSet = mapStyle == null ? huaweiMap.setMapStyle(null) : huaweiMap.setMapStyle(new MapStyleOptions(mapStyle));
                ArrayList<Object> mapStyleResult = new ArrayList<>();
                mapStyleResult.add(mapStyleSet);
                if (!mapStyleSet) mapStyleResult.add(Param.ERROR);
                result.success(mapStyleResult);
                break;
            }
            default:
                onMethodCallComponents(call, result);
        }
    }

    private void onMethodCallComponents(MethodCall call, MethodChannel.Result result) {
        switch (call.method) {
            case Method.MARKERS_UPDATE: {
                markersUtils.insertMulti(call.argument(Param.MARKERS_TO_INSERT));
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
                circleUtils.insertMulti(call.argument(Param.CIRCLES_TO_INSERT));
                circleUtils.updateMulti(call.argument(Param.CIRCLES_TO_UPDATE));
                circleUtils.deleteMulti(call.argument(Param.CIRCLES_TO_DELETE));
                result.success(true);
                break;
            }
            case Method.MARKERS_SHOW_INFO_WINDOW: {
                Object markerId = call.argument(Param.MARKER_ID);
                markersUtils.showInfoWindow((String) markerId, result);
                break;
            }
            case Method.MARKERS_HIDE_INFO_WINDOW: {
                Object markerId = call.argument(Param.MARKER_ID);
                markersUtils.hideInfoWindow((String) markerId, result);
                break;
            }
            case Method.MARKERS_IS_INFO_WINDOW_SHOWN: {
                Object markerId = call.argument(Param.MARKER_ID);
                markersUtils.isInfoWindowShown((String) markerId, result);
                break;
            }
            default:
                onMethodCallGetters(call, result);
        }
    }

    private void onMethodCallGetters(MethodCall call, MethodChannel.Result result) {
        switch (call.method) {
            case Method.MAP_IS_COMPASS_ENABLED: {
                result.success(huaweiMap.getUiSettings().isCompassEnabled());
                break;
            }
            case Method.MAP_IS_MAP_TOOLBAR_ENABLED: {
                result.success(huaweiMap.getUiSettings().isMapToolbarEnabled());
                break;
            }
            case Method.MAP_GET_MIN_MAX_ZOOM_LEVELS: {
                List<Float> zoomLevels = new ArrayList<>();
                zoomLevels.add(huaweiMap.getMinZoomLevel());
                zoomLevels.add(huaweiMap.getMaxZoomLevel());
                result.success(zoomLevels);
                break;
            }
            case Method.MAP_IS_TILT_GESTURES_ENABLED: {
                result.success(huaweiMap.getUiSettings().isTiltGesturesEnabled());
                break;
            }
            case Method.MAP_IS_ROTATE_GESTURES_ENABLED: {
                result.success(huaweiMap.getUiSettings().isRotateGesturesEnabled());
                break;
            }
            case Method.MAP_IS_ZOOM_GESTURES_ENABLED: {
                result.success(huaweiMap.getUiSettings().isZoomGesturesEnabled());
                break;
            }
            case Method.MAP_IS_ZOOM_CONTROLS_ENABLED: {
                result.success(huaweiMap.getUiSettings().isZoomControlsEnabled());
                break;
            }
            case Method.MAP_IS_SCROLL_GESTURES_ENABLED: {
                result.success(huaweiMap.getUiSettings().isScrollGesturesEnabled());
                break;
            }
            case Method.MAP_IS_MY_LOCATION_BUTTON_ENABLED: {
                result.success(huaweiMap.getUiSettings().isMyLocationButtonEnabled());
                break;
            }
            case Method.MAP_GET_ZOOM_LEVEL: {
                result.success(huaweiMap.getCameraPosition().zoom);
                break;
            }
            case Method.MAP_IS_TRAFFIC_ENABLED: {
                result.success(huaweiMap.isTrafficEnabled());
                break;
            }
            case Method.MAP_IS_BUILDINGS_ENABLED: {
                result.success(huaweiMap.isBuildingsEnabled());
                break;
            }
            default:
                result.notImplemented();
        }
    }

    void onMarkerDragEnd(String idOnMap, LatLng latLng) {
        markersUtils.onMarkerDragEnd(idOnMap, latLng);
    }

    boolean onMarkerClick(String idOnMap) {
        return markersUtils.onMarkerClick(idOnMap);
    }

    void onPolygonClick(String idOnMap) {
        polygonUtils.onPolygonClick(idOnMap);
    }

    void onPolylineClick(String idOnMap) {
        polylineUtils.onPolylineClick(idOnMap);
    }

    void onCircleClick(String idOnMap) {
        circleUtils.onCircleClick(idOnMap);
    }

    void onInfoWindowClick(String idOnMap) {
        markersUtils.onInfoWindowClick(idOnMap);
    }
}

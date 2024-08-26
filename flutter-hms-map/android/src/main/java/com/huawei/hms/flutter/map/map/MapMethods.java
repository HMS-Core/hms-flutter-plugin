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

import android.graphics.Point;

import com.huawei.hms.maps.model.BitmapDescriptor;
import com.huawei.hms.maps.model.LatLngBounds;
import com.huawei.hms.maps.model.MyLocationStyle;

import java.util.HashMap;
import java.util.List;

/**
 * The interface Map methods.
 *
 * @since v.6.0.1
 */
public interface MapMethods {

    /**
     * Sets markers.
     *
     * @param initMarkers the initial markers
     */
    void setMarkers(List<HashMap<String, Object>> initMarkers);

    /**
     * Sets polygons.
     *
     * @param initPolygons the initial polygons
     */
    void setPolygons(List<HashMap<String, Object>> initPolygons);

    /**
     * Sets polylines.
     *
     * @param initPolylines the initial polylines
     */
    void setPolylines(List<HashMap<String, Object>> initPolylines);

    /**
     * Sets circles.
     *
     * @param initCircles the initial circles
     */
    void setCircles(List<HashMap<String, Object>> initCircles);

    /**
     * Sets ground overlays.
     *
     * @param initGroundOverlays the initial ground overlays
     */
    void setGroundOverlays(List<HashMap<String, Object>> initGroundOverlays);

    /**
     * Sets tile overlays.
     *
     * @param initTileOverlays the initial tile overlays
     */
    void setTileOverlays(List<HashMap<String, Object>> initTileOverlays);

    /**
     * Sets heat maps.
     *
     * @param initHeatMaps the initial heat maps
     */
    void setHeatMaps(List<HashMap<String, Object>> initHeatMaps);

    /**
     * Sets camera target bounds.
     *
     * @param bounds the bounds
     */
    void setCameraTargetBounds(LatLngBounds bounds);

    /**
     * Sets track camera position.
     *
     * @param trackCameraPosition the track camera position
     */
    void setTrackCameraPosition(boolean trackCameraPosition);

    /**
     * Sets min max zoom preference.
     *
     * @param min the min
     * @param max the max
     */
    void setMinMaxZoomPreference(Float min, Float max);

    /**
     * Sets padding.
     *
     * @param top the top
     * @param left the left
     * @param bottom the bottom
     * @param right the right
     */
    void setPadding(float top, float left, float bottom, float right);

    /**
     * Sets compass enabled.
     *
     * @param compassEnabled the compass enabled
     */
    void setCompassEnabled(boolean compassEnabled);

    /**
     * Sets dark mode.
     *
     * @param isDark whether to enable dark mode
     */
    void setDark(boolean isDark);

    /**
     * Sets map toolbar enabled.
     *
     * @param setMapToolbarEnabled the set map toolbar enabled
     */
    void setMapToolbarEnabled(boolean setMapToolbarEnabled);

    /**
     * Sets map type.
     *
     * @param mapType the map type
     */
    void setMapType(int mapType);

    /**
     * Sets traffic enabled.
     *
     * @param trafficEnabled the traffic enabled
     */
    void setTrafficEnabled(boolean trafficEnabled);

    /**
     * Sets marker clustering enabled.
     *
     * @param markersClustering the clustering markers.
     */
    void setMarkersClustering(boolean markersClustering);

    /**
     * Sets buildings enabled.
     *
     * @param buildingsEnabled the buildings enabled
     */
    void setBuildingsEnabled(boolean buildingsEnabled);

    /**
     * Sets zoom gestures enabled.
     *
     * @param zoomGesturesEnabled the zoom gestures enabled
     */
    void setZoomGesturesEnabled(boolean zoomGesturesEnabled);

    /**
     * Sets my location enabled.
     *
     * @param myLocationEnabled the my location enabled
     */
    void setMyLocationEnabled(boolean myLocationEnabled);

    /**
     * Sets zoom controls enabled.
     *
     * @param zoomControlsEnabled the zoom controls enabled
     */
    void setZoomControlsEnabled(boolean zoomControlsEnabled);

    /**
     * Sets my location button enabled.
     *
     * @param myLocationButtonEnabled the my location button enabled
     */
    void setMyLocationButtonEnabled(boolean myLocationButtonEnabled);

    /**
     * Sets rotate gestures enabled.
     *
     * @param rotateGesturesEnabled the rotate gestures enabled
     */
    void setRotateGesturesEnabled(boolean rotateGesturesEnabled);

    /**
     * Sets scroll gestures enabled.
     *
     * @param scrollGesturesEnabled the scroll gestures enabled
     */
    void setScrollGesturesEnabled(boolean scrollGesturesEnabled);

    /**
     * Sets tilt gestures enabled.
     *
     * @param tiltGesturesEnabled the tilt gestures enabled
     */
    void setTiltGesturesEnabled(boolean tiltGesturesEnabled);

    /**
     * Sets all gestures enabled.
     *
     * @param allGesturesEnabled the all gestures enabled
     */
    void setAllGesturesEnabled(Boolean allGesturesEnabled);

    /**
     * Sets scroll gestures during rotate or zoom.
     *
     * @param scrollGesturesEnabledDuringRotateOrZoom the scroll gestures enabled during rotate or zoom
     */
    void setScrollGesturesEnabledDuringRotateOrZoom(boolean scrollGesturesEnabledDuringRotateOrZoom);

    /**
     * Sets gesture scale by map center.
     *
     * @param gestureScaleByMapCenter the gesture scale
     */
    void setGestureScaleByMapCenter(boolean gestureScaleByMapCenter);

    /**
     * Sets point to center.
     *
     * @param pointToCenter point to center
     */
    void setPointToCenter(Point pointToCenter);

    /**
     * Sets the color of the default cluster marker.
     *
     * @param color the color
     */
    void setClusterMarkerColor(Integer color);

    /**
     * Sets the text color of the custom cluster marker.
     *
     * @param color the color
     */
    void setClusterMarkerTextColor(Integer color);

    /**
     * Sets the icon of the custom cluster marker.
     *
     * @param iconDescriptor the icon
     */
    void setClusterMarkerIcon(BitmapDescriptor iconDescriptor);

    /**
     * Sets the logo position.
     *
     * @param logoPosition the logo position
     */
    void setLogoPosition(int logoPosition);

    /**
     * Sets the logo padding.
     *
     * @param paddingStart left padding
     * @param paddingTop top padding
     * @param paddingEnd right padding
     * @param paddingBottom bottom padding
     */
    void setLogoPadding(int paddingStart, int paddingTop, int paddingEnd, int paddingBottom);

    /**
     * Sets style id.
     *
     * @param styleId the style id
     */
    void setStyleId(String styleId);

    /**
     * Sets preview id.
     *
     * @param previewId the preview id
     */
    void setPreviewId(String previewId);

    /**
     * Sets lite mode.
     *
     * @param liteMode the lite mode
     */
    void setLiteMode(Boolean liteMode);

    /**
     * Sets my location style.
     *
     * @param myLocationStyle the my location style
     */
    void setMyLocationStyle(MyLocationStyle myLocationStyle);
}

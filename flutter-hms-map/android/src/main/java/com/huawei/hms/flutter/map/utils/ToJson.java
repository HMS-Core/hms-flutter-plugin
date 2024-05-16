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

package com.huawei.hms.flutter.map.utils;

import android.graphics.Point;
import android.location.Location;
import android.os.Build;

import com.huawei.hms.flutter.map.constants.Param;
import com.huawei.hms.maps.model.CameraPosition;
import com.huawei.hms.maps.model.LatLng;
import com.huawei.hms.maps.model.LatLngBounds;
import com.huawei.hms.maps.model.PointOfInterest;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class ToJson {

    public static List<Double> latLng(final LatLng latLng) {
        return Arrays.asList(latLng.latitude, latLng.longitude);
    }

    public static List<List<Double>> latLngList(final LatLng[] latLngs) {
        List<List<Double>> result = new ArrayList<>();
        for (LatLng latLng : latLngs) {
            result.add(latLng(latLng));
        }
        return result;
    }

    public static HashMap<String, Object> cameraPosition(final CameraPosition position) {
        if (position == null) {
            return null;
        }

        final HashMap<String, Object> args = new HashMap<>();
        args.put(Param.BEARING, position.bearing);
        args.put(Param.TARGET, ToJson.latLng(position.target));
        args.put(Param.TILT, position.tilt);
        args.put(Param.ZOOM, position.zoom);
        return args;
    }

    public static HashMap<String, Object> latlngBounds(final LatLngBounds latLngBounds) {
        if (latLngBounds == null) {
            return null;
        }

        final HashMap<String, Object> args = new HashMap<>();
        args.put(Param.SOUTHWEST, ToJson.latLng(latLngBounds.southwest));
        args.put(Param.NORTHEAST, ToJson.latLng(latLngBounds.northeast));
        return args;
    }

    public static HashMap<String, Object> polygonId(final String polygonId) {
        if (polygonId == null) {
            return null;
        }

        final HashMap<String, Object> args = new HashMap<>();
        args.put(Param.POLYGON_ID, polygonId);
        return args;
    }

    public static HashMap<String, Object> polylineId(final String polylineId) {
        if (polylineId == null) {
            return null;
        }

        final HashMap<String, Object> args = new HashMap<>();
        args.put(Param.POLYLINE_ID, polylineId);
        return args;
    }

    public static HashMap<String, Object> circleId(final String id) {
        if (id == null) {
            return null;
        }

        final HashMap<String, Object> args = new HashMap<>();
        args.put(Param.CIRCLE_ID, id);
        return args;
    }

    public static HashMap<String, Object> groundOverlayId(final String id) {
        if (id == null) {
            return null;
        }

        final HashMap<String, Object> args = new HashMap<>();
        args.put(Param.GROUND_OVERLAY_ID, id);
        return args;
    }

    public static HashMap<String, Integer> point(final Point point) {
        if (point == null) {
            return null;
        }

        final HashMap<String, Integer> args = new HashMap<>();
        args.put(Param.X, point.x);
        args.put(Param.Y, point.y);
        return args;
    }

    public static HashMap<String, Object> pointOfInterest(PointOfInterest pointOfInterest) {
        if (pointOfInterest == null) {
            return null;
        }

        final HashMap<String, Object> args = new HashMap<>();
        args.put(Param.LAT_LNG, latLng(pointOfInterest.latLng));
        args.put(Param.NAME, pointOfInterest.name);
        args.put(Param.PLACE_ID, pointOfInterest.placeId);
        return args;
    }

    public static HashMap<String, Object> location(Location location) {
        if (location == null) {
            return null;
        }

        final HashMap<String, Object> args = new HashMap<>();
        args.put(Param.LATITUDE, location.getLatitude());
        args.put(Param.LONGITUDE, location.getLongitude());
        args.put(Param.ALTITUDE, location.getAltitude());
        args.put(Param.SPEED, location.getSpeed());
        args.put(Param.BEARING, location.getBearing());
        args.put(Param.ACCURACY, location.getAccuracy());
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            args.put(Param.VERTICAL_ACCURACY_METERS, location.getVerticalAccuracyMeters());
            args.put(Param.BEARING_ACCURACY_DEGREES, location.getBearingAccuracyDegrees());
            args.put(Param.SPEED_ACCURACY_METERS_PER_SECOND, location.getSpeedAccuracyMetersPerSecond());
        } else {
            args.put(Param.VERTICAL_ACCURACY_METERS, 0.0);
            args.put(Param.BEARING_ACCURACY_DEGREES, 0.0);
            args.put(Param.SPEED_ACCURACY_METERS_PER_SECOND, 0.0);
        }
        args.put(Param.TIME, location.getTime());
        args.put(Param.FROM_MOCK_PROVIDER, location.isFromMockProvider());
        return args;
    }
}

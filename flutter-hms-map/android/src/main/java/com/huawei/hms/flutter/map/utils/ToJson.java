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

package com.huawei.hms.flutter.map.utils;

import android.graphics.Point;

import com.huawei.hms.flutter.map.constants.Param;
import com.huawei.hms.maps.model.CameraPosition;
import com.huawei.hms.maps.model.LatLng;
import com.huawei.hms.maps.model.LatLngBounds;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class ToJson {

    public static List<Double> latLng(LatLng latLng) {
        return Arrays.asList(latLng.latitude, latLng.longitude);
    }

    public static HashMap<String, Object> cameraPosition(CameraPosition position) {
        if (position == null) return null;

        final HashMap<String, Object> args = new HashMap<>();
        args.put(Param.BEARING, position.bearing);
        args.put(Param.TARGET, ToJson.latLng(position.target));
        args.put(Param.TILT, position.tilt);
        args.put(Param.ZOOM, position.zoom);
        return args;
    }

    public static HashMap<String, Object> latlngBounds(LatLngBounds latLngBounds) {
        if (latLngBounds == null) return null;

        final HashMap<String, Object> args = new HashMap<>();
        args.put(Param.SOUTHWEST, ToJson.latLng(latLngBounds.southwest));
        args.put(Param.NORTHEAST, ToJson.latLng(latLngBounds.northeast));
        return args;
    }


    public static HashMap<String, Object> polygonId(String polygonId) {
        if (polygonId == null) return null;

        final HashMap<String, Object> args = new HashMap<>();
        args.put(Param.POLYGON_ID, polygonId);
        return args;
    }

    public static HashMap<String, Object> polylineId(String polylineId) {
        if (polylineId == null) return null;

        final HashMap<String, Object> args = new HashMap<>();
        args.put(Param.POLYLINE_ID, polylineId);
        return args;
    }

    public static HashMap<String, Object> circleId(String id) {
        if (id == null) return null;

        final HashMap<String, Object> args = new HashMap<>();
        args.put(Param.CIRCLE_ID, id);
        return args;
    }


    public static HashMap<String, Integer> point(Point point) {
        if (point == null) return null;

        final HashMap<String, Integer> args = new HashMap<>();
        args.put(Param.X, point.x);
        args.put(Param.Y, point.y);
        return args;
    }
}

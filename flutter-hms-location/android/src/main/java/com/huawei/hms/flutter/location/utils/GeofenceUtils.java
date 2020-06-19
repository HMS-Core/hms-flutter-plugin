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

package com.huawei.hms.flutter.location.utils;

import com.huawei.hms.location.Geofence;
import com.huawei.hms.location.GeofenceData;
import com.huawei.hms.location.GeofenceRequest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GeofenceUtils {
    public static Map<String, Object> fromGeofenceDataToMap(final GeofenceData geofenceData) {
        final Map<String, Object> map = new HashMap<>();

        if (geofenceData == null) {
            return map;
        }

        final List<String> convertingGeofenceIdList = new ArrayList<>();

        for (final Geofence geofence : geofenceData.getConvertingGeofenceList()) {
            convertingGeofenceIdList.add(geofence.getUniqueId());
        }

        map.put("errorCode", geofenceData.getErrorCode());
        map.put("conversion", geofenceData.getConversion());
        map.put("convertingGeofenceIdList", convertingGeofenceIdList);
        map.put("convertingLocation", LocationUtils.fromLocationToMap(geofenceData.getConvertingLocation()));

        return map;
    }

    private static Geofence fromMapToGeofence(final Map map) {
        final Geofence.Builder builder = new Geofence.Builder();

        final double lat = ValueGetter.getDouble("latitude", map);
        final double lng = ValueGetter.getDouble("longitude", map);
        final float rad = ValueGetter.getFloat("radius", map);

        builder.setRoundArea(lat, lng, rad);
        builder.setUniqueId(ValueGetter.getString("uniqueId", map));
        builder.setConversions(ValueGetter.getInt("conversions", map));
        builder.setDwellDelayTime(ValueGetter.getInt("dwellDelayTime", map));
        builder.setValidContinueTime(ValueGetter.getLong("validDuration", map));
        builder.setNotificationInterval(ValueGetter.getInt("notificationInterval", map));

        return builder.build();
    }

    public static GeofenceRequest fromMapToGeofenceRequest(final Map map) {
        final GeofenceRequest.Builder builder = new GeofenceRequest.Builder();
        final List geofenceMapList = ObjectUtils.cast(map.get("geofenceList"), List.class);

        if (geofenceMapList != null) {
            for (final Object geofence : geofenceMapList) {
                final Map geofenceMap = ObjectUtils.cast(geofence, Map.class);
                builder.createGeofence(fromMapToGeofence(geofenceMap));
            }
        }

        builder.setCoordinateType(ValueGetter.getInt("coordinateType", map));
        builder.setInitConversions(ValueGetter.getInt("initConversions", map));

        return builder.build();
    }
}

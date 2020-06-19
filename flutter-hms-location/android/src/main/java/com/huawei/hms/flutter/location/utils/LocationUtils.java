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

import android.location.Location;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;

import com.huawei.hms.location.HWLocation;
import com.huawei.hms.location.LocationAvailability;
import com.huawei.hms.location.LocationRequest;
import com.huawei.hms.location.LocationResult;
import com.huawei.hms.location.LocationSettingsRequest;
import com.huawei.hms.location.LocationSettingsStates;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class LocationUtils {
    public static Map<String, Object> fromLocationToMap(final Location location) {
        final Map<String, Object> map = new HashMap<>();

        if (location == null) {
            return map;
        }

        map.put("provider", location.getProvider());
        map.put("latitude", location.getLatitude());
        map.put("longitude", location.getLongitude());
        map.put("altitude", location.getAltitude());
        map.put("speed", location.getSpeed());
        map.put("bearing", location.getBearing());
        map.put("horizontalAccuracyMeters", location.getAccuracy());
        map.put("time", location.getTime());
        map.put("elapsedRealtimeNanos", location.getElapsedRealtimeNanos());
        map.put("isFromMockProvider", location.isFromMockProvider());

        if (VERSION.SDK_INT >= VERSION_CODES.O) {
            map.put("verticalAccuracyMeters", location.getVerticalAccuracyMeters());
            map.put("speedAccuracyMetersPerSecond", location.getSpeedAccuracyMetersPerSecond());
            map.put("bearingAccuracyDegrees", location.getBearingAccuracyDegrees());
        } else {
            map.put("verticalAccuracyMeters", 0.0);
            map.put("speedAccuracyMetersPerSecond", 0.0);
            map.put("bearingAccuracyDegrees", 0.0);
        }

        return map;
    }

    public static Map<String, Object> fromHWLocationToMap(final HWLocation hwLocation) {
        final Map<String, Object> map = new HashMap<>();

        if (hwLocation == null) {
            return map;
        }

        map.put("provider", hwLocation.getProvider());
        map.put("latitude", hwLocation.getLatitude());
        map.put("longitude", hwLocation.getLongitude());
        map.put("altitude", hwLocation.getAltitude());
        map.put("speed", hwLocation.getSpeed());
        map.put("bearing", hwLocation.getBearing());
        map.put("horizontalAccuracyMeters", hwLocation.getAccuracy());
        map.put("verticalAccuracyMeters", hwLocation.getVerticalAccuracyMeters());
        map.put("speedAccuracyMetersPerSecond", hwLocation.getSpeedAccuracyMetersPerSecond());
        map.put("bearingAccuracyDegrees", hwLocation.getBearingAccuracyDegrees());
        map.put("time", hwLocation.getTime());
        map.put("elapsedRealtimeNanos", hwLocation.getElapsedRealtimeNanos());
        map.put("countryCode", hwLocation.getCountryCode());
        map.put("countryName", hwLocation.getCountryName());
        map.put("state", hwLocation.getState());
        map.put("city", hwLocation.getCity());
        map.put("county", hwLocation.getCounty());
        map.put("street", hwLocation.getStreet());
        map.put("featureName", hwLocation.getFeatureName());
        map.put("postalCode", hwLocation.getPostalCode());
        map.put("phone", hwLocation.getPhone());
        map.put("url", hwLocation.getUrl());
        map.put("extraInfo", hwLocation.getExtraInfo());

        return map;
    }

    public static Map<String, Object> fromLocationAvailabilityToMap(final LocationAvailability locationAvailability) {
        final Map<String, Object> map = new HashMap<>();

        if (locationAvailability == null) {
            return map;
        }

        map.put("cellStatus", locationAvailability.getCellStatus());
        map.put("wifiStatus", locationAvailability.getWifiStatus());
        map.put("elapsedRealtimeNs", locationAvailability.getElapsedRealtimeNs());
        map.put("locationStatus", locationAvailability.getLocationStatus());

        return map;
    }

    public static Map<String, Object> fromLocationResultToMap(final LocationResult locationResult) {
        final Map<String, Object> map = new HashMap<>();

        if (locationResult == null) {
            return map;
        }

        final List<Map<String, Object>> locationMaps = new ArrayList<>();
        final List<Map<String, Object>> hwLocationMaps = new ArrayList<>();

        for (final Location location : locationResult.getLocations()) {
            locationMaps.add(fromLocationToMap(location));
        }

        for (final HWLocation hwLocation : locationResult.getHWLocationList()) {
            hwLocationMaps.add(fromHWLocationToMap(hwLocation));
        }

        map.put("locations", locationMaps);
        map.put("hwLocations", hwLocationMaps);
        map.put("lastLocation", fromLocationToMap(locationResult.getLastLocation()));
        map.put("lastHWLocation", fromHWLocationToMap(locationResult.getLastHWLocation()));

        return map;
    }

    public static Map<String, Object> fromLocationSettingsStatesToMap(final LocationSettingsStates states) {
        final Map<String, Object> map = new HashMap<>();

        if (states == null) {
            return map;
        }

        map.put("blePresent", states.isBlePresent());
        map.put("bleUsable", states.isBleUsable());
        map.put("gpsPresent", states.isGpsPresent());
        map.put("gpsUsable", states.isGpsUsable());
        map.put("locationPresent", states.isLocationPresent());
        map.put("locationUsable", states.isLocationUsable());
        map.put("networkLocationPresent", states.isNetworkLocationPresent());
        map.put("networkLocationUsable", states.isNetworkLocationUsable());

        return map;
    }

    public static LocationRequest fromMapToLocationRequest(final Map map) {
        final boolean isFastestIntervalExplicitlySet = ValueGetter.getBoolean("isFastestIntervalExplicitlySet", map);

        final LocationRequest result = LocationRequest.create();

        if (isFastestIntervalExplicitlySet) {
            result.setFastestInterval(ValueGetter.getLong("fastestInterval", map));
        }

        result.setPriority(ValueGetter.getInt("priority", map));
        result.setInterval(ValueGetter.getLong("interval", map));
        result.setExpirationTime(ValueGetter.getLong("expirationTime", map));
        result.setNumUpdates(ValueGetter.getInt("numUpdates", map));
        result.setSmallestDisplacement(ValueGetter.getFloat("smallestDisplacement", map));
        result.setMaxWaitTime(ValueGetter.getLong("maxWaitTime", map));
        result.setNeedAddress(ValueGetter.getBoolean("needAddress", map));
        result.setLanguage(ValueGetter.getString("language", map));
        result.setCountryCode(ValueGetter.getString("countryCode", map));

        final Map extras = ObjectUtils.cast(map.get("extras"), Map.class);

        if (extras != null) {
            final Set entries = extras.entrySet();
            for (final Object entry : entries) {
                final Map.Entry mapEntry = ObjectUtils.cast(entry, Map.Entry.class);
                final String key = ObjectUtils.cast(mapEntry.getKey(), String.class);
                final String value = ObjectUtils.cast(mapEntry.getValue(), String.class);
                result.putExtras(key, value);
            }
        }

        return result;
    }

    public static Location fromMapToLocation(final Map map) {
        final String provider = ValueGetter.getString("provider", map);
        final Location location = new Location(provider);

        location.setLatitude(ValueGetter.getDouble("latitude", map));
        location.setLongitude(ValueGetter.getDouble("longitude", map));
        location.setAltitude(ValueGetter.getDouble("altitude", map));
        location.setSpeed(ValueGetter.getFloat("speed", map));
        location.setBearing(ValueGetter.getFloat("bearing", map));
        location.setAccuracy(ValueGetter.getFloat("horizontalAccuracyMeters", map));
        location.setTime(ValueGetter.getLong("time", map));
        location.setElapsedRealtimeNanos(ValueGetter.getLong("elapsedRealtimeNanos", map));

        if (VERSION.SDK_INT >= VERSION_CODES.O) {
            location.setVerticalAccuracyMeters(ValueGetter.getFloat("verticalAccuracyMeters", map));
            location.setSpeedAccuracyMetersPerSecond(ValueGetter.getFloat("speedAccuracyMetersPerSecond", map));
            location.setBearingAccuracyDegrees(ValueGetter.getFloat("bearingAccuracyDegrees", map));
        }

        return location;
    }

    public static LocationSettingsRequest fromMapToLocationSettingsRequest(final Map map) {
        final LocationSettingsRequest.Builder builder = new LocationSettingsRequest.Builder();
        final List requests = ObjectUtils.cast(map.get("requests"), List.class);

        if (requests != null) {
            for (final Object request : requests) {
                final Map requestMap = ObjectUtils.cast(request, Map.class);
                builder.addLocationRequest(fromMapToLocationRequest(requestMap));
            }
        }

        builder.setAlwaysShow(ValueGetter.getBoolean("alwaysShow", map));
        builder.setNeedBle(ValueGetter.getBoolean("needBle", map));

        return builder.build();
    }
}

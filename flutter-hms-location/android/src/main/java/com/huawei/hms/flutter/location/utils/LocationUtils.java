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

package com.huawei.hms.flutter.location.utils;

import android.app.Notification;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.location.Location;
import android.net.Uri;
import android.os.Build;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.util.Log;

import com.huawei.hms.location.HWLocation;
import com.huawei.hms.location.LocationAvailability;
import com.huawei.hms.location.LocationRequest;
import com.huawei.hms.location.LocationResult;
import com.huawei.hms.location.LocationSettingsRequest;
import com.huawei.hms.location.LocationSettingsStates;
import com.huawei.hms.location.LogConfig;
import com.huawei.hms.location.NavigationRequest;
import com.huawei.hms.location.NavigationResult;
import com.huawei.hms.support.api.entity.location.coordinate.LonLat;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

public interface LocationUtils {
    /**
     * Utility method
     *
     * @param location ActivityIdentificationData object
     * @return HashMap representation of Location object
     */
    static Map<String, Object> fromLocationToMap(final Location location) {
        if (location == null) {
            return Collections.emptyMap();
        }

        final Map<String, Object> map = new HashMap<>();

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

    /**
     * Utility method
     *
     * @param hwLocation HWLocation object
     * @return HashMap representation of HWLocation object
     */
    static Map<String, Object> fromHWLocationToMap(final HWLocation hwLocation) {
        if (hwLocation == null) {
            return Collections.emptyMap();
        }

        final Map<String, Object> map = new HashMap<>();

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
        map.put("coordinateType", hwLocation.getCoordinateType());

        return map;
    }

    /**
     * Utility method
     *
     * @param locationAvailability LocationAvailability object
     * @return HashMap representation of LocationAvailability object
     */
    static Map<String, Object> fromLocationAvailabilityToMap(final LocationAvailability locationAvailability) {
        if (locationAvailability == null) {
            return Collections.emptyMap();
        }

        final Map<String, Object> map = new HashMap<>();

        map.put("cellStatus", locationAvailability.getCellStatus());
        map.put("wifiStatus", locationAvailability.getWifiStatus());
        map.put("elapsedRealtimeNs", locationAvailability.getElapsedRealtimeNs());
        map.put("locationStatus", locationAvailability.getLocationStatus());

        return map;
    }

    /**
     * Utility method
     *
     * @param locationResult LocationResult object
     * @return HashMap representation of LocationResult object
     */
    static Map<String, Object> fromLocationResultToMap(final LocationResult locationResult) {
        if (locationResult == null) {
            return Collections.emptyMap();
        }

        final Map<String, Object> map = new HashMap<>();
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

    /**
     * Utility method
     *
     * @param states LocationSettingsStates object
     * @return HashMap representation of LocationSettingsStates object
     */
    static Map<String, Object> fromLocationSettingsStatesToMap(final LocationSettingsStates states) {
        if (states == null) {
            return Collections.emptyMap();
        }

        final Map<String, Object> map = new HashMap<>();

        map.put("blePresent", states.isBlePresent());
        map.put("bleUsable", states.isBleUsable());
        map.put("gpsPresent", states.isGpsPresent());
        map.put("gpsUsable", states.isGpsUsable());
        map.put("locationPresent", states.isLocationPresent());
        map.put("locationUsable", states.isLocationUsable());
        map.put("networkLocationPresent", states.isNetworkLocationPresent());
        map.put("networkLocationUsable", states.isNetworkLocationUsable());
        map.put("hmsLocationPresent", states.isHMSLocationPresent());
        map.put("hmsLocationUsable", states.isHMSLocationUsable());
        map.put("gnssPresent", states.isGnssPresent());
        map.put("gnssUsable", states.isGnssUsable());

        return map;
    }

    /**
     * Utility method
     *
     * @param result NavigationResult object
     * @return HashMap representation of NavigationResult object
     */
    static Map<String, Object> fromNavigationResultToMap(final NavigationResult result) {
        if (result == null) {
            return Collections.emptyMap();
        }

        final Map<String, Object> map = new HashMap<>();

        map.put("state", result.getState());
        map.put("possibility", result.getPossibility());

        return map;
    }

    /**
     * Utility method
     *
     * @param map HashMap representation of the LocationRequest object
     * @return LocationRequest object
     */
    static LocationRequest fromMapToLocationRequest(final Map map) {
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
        result.setCoordinateType(ValueGetter.getInt("coordinateType", map));

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

    /**
     * Utility method
     *
     * @param map HashMap representation of the NavigationRequest object
     * @return NavigationRequest object
     */
    static NavigationRequest fromMapToNavigationRequest(final Map<String, Object> map) {
        final int type = ValueGetter.getInt("type", map);
        return new NavigationRequest(type);
    }

    /**
     * Utility method
     *
     * @param map HashMap representation of the Location object
     * @return Location object
     */
    static Location fromMapToLocation(final Map<String, Object> map) {
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

    /**
     * Utility method
     *
     * @param map HashMap representation of the LocationSettingsRequest object
     * @return LocationSettingsRequest object
     */
    static LocationSettingsRequest fromMapToLocationSettingsRequest(final Map<String, Object> map) {
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

    /**
     * Utility method
     *
     * @param map HashMap representation of the LogConfig object
     * @return LogConfig object
     */
    static LogConfig fromMapToLogConfig(final Map<String, Object> map) {
        LogConfig logConfig = new LogConfig();
        logConfig.setFileExpiredTime(ValueGetter.getInt("fileExpiredTime", map));
        logConfig.setFileNum(ValueGetter.getInt("fileNum", map));
        logConfig.setFileSize(ValueGetter.getInt("fileSize", map));
        logConfig.setLogPath(ValueGetter.getString("logPath", map));

        return logConfig;

    }

    /**
     * Utility method
     *
     * @param logConfig LogConfig object
     * @return HashMap representation of LogConfig object
     */
    static Map<String, Object> fromLogConfigToMap(LogConfig logConfig) {
        if (logConfig == null) {
            return Collections.emptyMap();
        }

        final Map<String, Object> map = new HashMap<>();

        map.put("fileExpiredTime", logConfig.getFileExpiredTime());
        map.put("fileNum", logConfig.getFileNum());
        map.put("fileSize", logConfig.getFileSize());
        map.put("logPath", logConfig.getLogPath());

        return map;
    }

    /**
     * Utility method
     *
     * @param hwLocations HWLocation object
     * @return HashMap representation of HWLocation object
     */
    static List<Map<String, Object>> fromHWLocationListToMap(final List<HWLocation> hwLocations) {
        if (hwLocations == null) {
            return Collections.emptyList();
        }

        final List<Map<String, Object>> hwLocationList = new ArrayList<>();

        for (final HWLocation hwLocation : hwLocations) {
            hwLocationList.add(fromHWLocationToMap(hwLocation));
        }

        return hwLocationList;

    }

    /**
     * Utility method
     *
     * @param context Context
     * @param builder NotificationCompat.Builder
     * @param map HashMap representation of the Notification object
     * @return Notification object
     */
    static void fillNotificationBuilder(Context context, Notification.Builder builder, Map map) {
        if (map.get("contentTitle") != null) {
            builder = builder.setContentTitle(ValueGetter.getString("contentTitle", map));
            Log.i(LocationUtils.class.getSimpleName(), String.valueOf(map.get("contentTitle")));
        }
        if (map.get("color") != null) {
            if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
                builder = builder.setColor(ValueGetter.getInt("color", map));
            }
        }
        if (map.get("colorized") != null) {
            if (VERSION.SDK_INT >= VERSION_CODES.O) {
                builder = builder.setColorized(ValueGetter.getBoolean("colorized", map));
            }
        }
        if (map.get("contentInfo") != null) {
            builder = builder.setContentInfo(ValueGetter.getString("contentInfo", map));
        }
        if (map.get("contentText") != null) {
            builder = builder.setContentText(ValueGetter.getString("contentText", map));
        }
        if (map.get("smallIcon") != null) {
            int resourceId = context.getResources()
                    .getIdentifier(ValueGetter.getString("smallIcon", map), "drawable", context.getPackageName());
            builder = builder.setSmallIcon(resourceId);
        } else {
            builder.setSmallIcon(
                    context.getResources().getIdentifier("ic_launcher", "mipmap", context.getPackageName()));
        }
        if (map.get("largeIcon") != null) {
            Bitmap bitmap = null;
            try {
                bitmap = BitmapFactory.decodeStream(context.getAssets().open(ValueGetter.getString("largeIcon", map)));
            } catch (IOException | OutOfMemoryError e) {
                Log.i("Bitmap", "An error occured, please try again.");
            }
            builder = builder.setLargeIcon(bitmap);
        }
        if (map.get("sound") != null) {
            String sourceName = ValueGetter.getString("sound", map);
            int resourceId = context.getResources().getIdentifier(sourceName, "raw", context.getPackageName());
            Uri soundUri = Uri.parse(
                    String.format(Locale.ENGLISH, "android.resource://%s/%s", context.getPackageName(), resourceId));
            builder = builder.setSound(soundUri);
        }
        if (map.get("onGoing") != null) {
            builder = builder.setOngoing(ValueGetter.getBoolean("onGoing", map));
        }
        if (map.get("subText") != null) {
            builder = builder.setSubText(ValueGetter.getString("subText", map));
        }
        if (map.get("vibrate") != null) {
            List<Integer> patternRA = (List<Integer>) map.get("vibrate");
            int length = patternRA.size();
            long[] pattern = new long[length];
            for (int i = 0; i < length; i++) {
                pattern[i] = (long) patternRA.get(i);
            }
            builder = builder.setVibrate(pattern);
        }
        if (map.get("visibility") != null) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                builder = builder.setVisibility(ValueGetter.getInt("visibility", map));
            }
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            builder.setOngoing(true)
                    .setPriority(ValueGetter.getInt("priority", map))
                    .setCategory(ValueGetter.getString("category", map))
                    .build();
        }

    }

    /**
     * Utility method
     *
     * @param lonLat LonLat object
     * @return HashMap representation of LonLat object0
     */
    static Map<String, Object> fromLonLatToMap(LonLat lonLat) {
        if (lonLat == null) {
            return Collections.emptyMap();
        }

        final Map<String, Object> map = new HashMap<>();

        map.put("latitude", lonLat.getLatitude());
        map.put("longitude", lonLat.getLongitude());

        return map;
    }

}

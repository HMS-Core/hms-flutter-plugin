/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.awareness.barriers;

import android.annotation.SuppressLint;

import com.huawei.hms.flutter.awareness.constants.Param;
import com.huawei.hms.flutter.awareness.utils.Convert;
import com.huawei.hms.flutter.awareness.utils.ValueGetter;
import com.huawei.hms.kit.awareness.barrier.AmbientLightBarrier;
import com.huawei.hms.kit.awareness.barrier.AwarenessBarrier;
import com.huawei.hms.kit.awareness.barrier.BeaconBarrier;
import com.huawei.hms.kit.awareness.barrier.BehaviorBarrier;
import com.huawei.hms.kit.awareness.barrier.BluetoothBarrier;
import com.huawei.hms.kit.awareness.barrier.HeadsetBarrier;
import com.huawei.hms.kit.awareness.barrier.LocationBarrier;
import com.huawei.hms.kit.awareness.barrier.ScreenBarrier;
import com.huawei.hms.kit.awareness.barrier.TimeBarrier;
import com.huawei.hms.kit.awareness.barrier.WifiBarrier;
import com.huawei.hms.kit.awareness.status.BeaconStatus.Filter;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

public class CreateBarriers {

    @SuppressLint("MissingPermission")
    public static AwarenessBarrier beaconBarrier(final Map<String, Object> args) {
        final AwarenessBarrier awarenessBarrier;
        final Collection<Filter> beaconFilters = Convert.createBeaconFilters(args);
        final String barrierType = ValueGetter.getString(Param.BARRIER_TYPE, args);
        switch (barrierType) {
            case Param.BEACON_DISCOVER_BARRIER:
                awarenessBarrier = BeaconBarrier.discover(beaconFilters);
                break;
            case Param.BEACON_MISSED_BARRIER:
                awarenessBarrier = BeaconBarrier.missed(beaconFilters);
                break;
            case Param.BEACON_KEEP_BARRIER:
                awarenessBarrier = BeaconBarrier.keep(beaconFilters);
                break;
            default:
                awarenessBarrier = null;
        }
        return awarenessBarrier;
    }

    public static AwarenessBarrier headsetBarrier(final Map<String, Object> args) {
        final AwarenessBarrier awarenessBarrier;
        final String barrierType = ValueGetter.getString(Param.BARRIER_TYPE, args);
        switch (barrierType) {
            case Param.HEADSET_KEEPING_BARRIER:
                final int headsetStatus = ValueGetter.getInt(Param.HEADSET_STATUS, args);
                awarenessBarrier = HeadsetBarrier.keeping(headsetStatus);
                break;
            case Param.HEADSET_CONNECTING_BARRIER:
                awarenessBarrier = HeadsetBarrier.connecting();
                break;
            case Param.HEADSET_DISCONNECTING_BARRIER:
                awarenessBarrier = HeadsetBarrier.disconnecting();
                break;
            default:
                awarenessBarrier = null;
        }
        return awarenessBarrier;
    }

    public static AwarenessBarrier ambientLightBarrier(final Map<String, Object> args) {
        final AwarenessBarrier awarenessBarrier;
        final String barrierType = ValueGetter.getString(Param.BARRIER_TYPE, args);
        switch (barrierType) {
            case Param.AMBIENT_LIGHT_ABOVE_BARRIER:
                final float minLightIntensity = ValueGetter.getFloat(Param.MIN_LIGHT_INTENSITY, args);
                awarenessBarrier = AmbientLightBarrier.above(minLightIntensity);
                break;
            case Param.AMBIENT_LIGHT_BELOW_BARRIER:
                final float maxLightIntensity = ValueGetter.getFloat(Param.MAX_LIGHT_INTENSITY, args);
                awarenessBarrier = AmbientLightBarrier.below(maxLightIntensity);
                break;
            case Param.AMBIENT_LIGHT_RANGE_BARRIER:
                final float minLightIntensityRange = ValueGetter.getFloat(Param.MIN_LIGHT_INTENSITY, args);
                final float maxLightIntensityRange = ValueGetter.getFloat(Param.MAX_LIGHT_INTENSITY, args);
                awarenessBarrier = AmbientLightBarrier.range(minLightIntensityRange, maxLightIntensityRange);
                break;
            default:
                awarenessBarrier = null;
        }
        return awarenessBarrier;
    }

    public static AwarenessBarrier wifiBarrier(final Map<String, Object> args) {
        final AwarenessBarrier awarenessBarrier;
        final String barrierType = ValueGetter.getString(Param.BARRIER_TYPE, args);
        switch (barrierType) {
            case Param.WIFI_KEEPING_BARRIER:
                final int wifiStatus = ValueGetter.getInt(Param.WIFI_STATUS, args);
                if (args.get(Param.BSSID) != null && args.get(Param.SSID) != null) {
                    final String bssid = ValueGetter.getString(Param.BSSID, args);
                    final String ssid = ValueGetter.getString(Param.SSID, args);
                    awarenessBarrier = WifiBarrier.keeping(wifiStatus, bssid, ssid);
                } else {
                    awarenessBarrier = WifiBarrier.keeping(wifiStatus);
                }
                break;
            case Param.WIFI_CONNECTING_BARRIER:
                if (args.get(Param.BSSID) != null && args.get(Param.SSID) != null) {
                    final String bssid = ValueGetter.getString(Param.BSSID, args);
                    final String ssid = ValueGetter.getString(Param.SSID, args);
                    awarenessBarrier = WifiBarrier.connecting(bssid, ssid);
                } else {
                    awarenessBarrier = WifiBarrier.connecting();
                }
                break;
            case Param.WIFI_DISCONNECTING_BARRIER:
                if (args.get(Param.BSSID) != null && args.get(Param.SSID) != null) {
                    final String bssid = ValueGetter.getString(Param.BSSID, args);
                    final String ssid = ValueGetter.getString(Param.SSID, args);
                    awarenessBarrier = WifiBarrier.disconnecting(bssid, ssid);
                } else {
                    awarenessBarrier = WifiBarrier.disconnecting();
                }
                break;
            case Param.WIFI_ENABLING_BARRIER:
                awarenessBarrier = WifiBarrier.enabling();
                break;
            case Param.WIFI_DISABLING_BARRIER:
                awarenessBarrier = WifiBarrier.disabling();
                break;
            default:
                awarenessBarrier = null;
        }
        return awarenessBarrier;
    }

    public static AwarenessBarrier screenBarrier(final Map<String, Object> args) {
        final AwarenessBarrier awarenessBarrier;
        final String barrierType = ValueGetter.getString(Param.BARRIER_TYPE, args);
        switch (barrierType) {
            case Param.SCREEN_KEEPING_BARRIER:
                final int screenStatus = ValueGetter.getInt(Param.SCREEN_STATUS, args);
                awarenessBarrier = ScreenBarrier.keeping(screenStatus);
                break;
            case Param.SCREEN_ON_BARRIER:
                awarenessBarrier = ScreenBarrier.screenOn();
                break;
            case Param.SCREEN_OFF_BARRIER:
                awarenessBarrier = ScreenBarrier.screenOff();
                break;
            case Param.SCREEN_UNLOCK_BARRIER:
                awarenessBarrier = ScreenBarrier.screenUnlock();
                break;
            default:
                awarenessBarrier = null;
        }
        return awarenessBarrier;
    }

    @SuppressLint("MissingPermission")
    public static AwarenessBarrier bluetoothBarrier(final Map<String, Object> args) {
        final AwarenessBarrier awarenessBarrier;
        final int deviceType = ValueGetter.getInt(Param.DEVICE_TYPE, args);
        final String barrierType = ValueGetter.getString(Param.BARRIER_TYPE, args);
        switch (barrierType) {
            case Param.BLUETOOTH_KEEP_BARRIER:
                final int bluetoothStatus = ValueGetter.getInt(Param.BLUETOOTH_STATUS, args);
                awarenessBarrier = BluetoothBarrier.keep(deviceType, bluetoothStatus);
                break;
            case Param.BLUETOOTH_CONNECTING_BARRIER:
                awarenessBarrier = BluetoothBarrier.connecting(deviceType);
                break;
            case Param.BLUETOOTH_DISCONNECTING_BARRIER:
                awarenessBarrier = BluetoothBarrier.disconnecting(deviceType);
                break;
            default:
                awarenessBarrier = null;
        }
        return awarenessBarrier;
    }

    @SuppressLint("MissingPermission")
    public static AwarenessBarrier behaviorBarrier(final Map<String, Object> args) {
        final AwarenessBarrier awarenessBarrier;
        int[] behaviorTypes = null;
        final String barrierType = ValueGetter.getString(Param.BARRIER_TYPE, args);
        final List<Integer> typesFromFlutter = (List<Integer>) args.get(Param.BEHAVIOR_TYPES);
        if (typesFromFlutter != null) {
            behaviorTypes = ValueGetter.behaviorTypesListToArray(typesFromFlutter);
        }
        switch (barrierType) {
            case Param.BEHAVIOR_KEEPING_BARRIER:
                awarenessBarrier = BehaviorBarrier.keeping(behaviorTypes);
                break;
            case Param.BEHAVIOR_BEGINNING_BARRIER:
                awarenessBarrier = BehaviorBarrier.beginning(behaviorTypes);
                break;
            case Param.BEHAVIOR_ENDING_BARRIER:
                awarenessBarrier = BehaviorBarrier.ending(behaviorTypes);
                break;
            default:
                awarenessBarrier = null;
        }
        return awarenessBarrier;
    }

    @SuppressLint("MissingPermission")
    public static AwarenessBarrier locationBarrier(final Map<String, Object> args) {
        final AwarenessBarrier awarenessBarrier;
        final String barrierType = ValueGetter.getString(Param.BARRIER_TYPE, args);
        final double latitude = ValueGetter.getDouble(Param.LATITUDE, args);
        final double longitude = ValueGetter.getDouble(Param.LONGITUDE, args);
        final double radius = ValueGetter.getDouble(Param.RADIUS, args);
        switch (barrierType) {
            case Param.LOCATION_ENTER_BARRIER:
                awarenessBarrier = LocationBarrier.enter(latitude, longitude, radius);
                break;
            case Param.LOCATION_STAY_BARRIER:
                final long timeOfDuration = ValueGetter.getLong(Param.TIME_OF_DURATION, args);
                awarenessBarrier = LocationBarrier.stay(latitude, longitude, radius, timeOfDuration);
                break;
            case Param.LOCATION_EXIT_BARRIER:
                awarenessBarrier = LocationBarrier.exit(latitude, longitude, radius);
                break;
            default:
                awarenessBarrier = null;
        }
        return awarenessBarrier;
    }

    @SuppressLint("MissingPermission")
    public static AwarenessBarrier timeBarrier(final Map<String, Object> args) {
        final AwarenessBarrier awarenessBarrier;
        final String barrierType = ValueGetter.getString(Param.BARRIER_TYPE, args);
        final TimeZone timeZone = ValueGetter.getTimeZone(Param.TIME_ZONE, args);
        switch (barrierType) {
            case Param.TIME_IN_SUNRISE_OR_SUNSET_PERIOD_BARRIER:
                final long startTimeOffset = ValueGetter.getLong(Param.START_TIME_OFFSET, args);
                final long stopTimeOffset = ValueGetter.getLong(Param.STOP_TIME_OFFSET, args);
                final int timeInstant = ValueGetter.getInt(Param.TIME_INSTANT, args);
                awarenessBarrier = TimeBarrier.inSunriseOrSunsetPeriod(timeInstant, startTimeOffset, stopTimeOffset);
                break;
            case Param.TIME_DURING_PERIOD_OF_DAY_BARRIER:
                final long startTimeOfDay = ValueGetter.getLong(Param.START_TIME_OF_DAY, args);
                final long stopTimeOfDay = ValueGetter.getLong(Param.STOP_TIME_OF_DAY, args);
                awarenessBarrier = TimeBarrier.duringPeriodOfDay(timeZone, startTimeOfDay, stopTimeOfDay);
                break;
            case Param.TIME_DURING_TIME_PERIOD_BARRIER:
                final long startTimeStamp = ValueGetter.getLong(Param.START_TIME_STAMP, args);
                final long stopTimeStamp = ValueGetter.getLong(Param.STOP_TIME_STAMP, args);
                awarenessBarrier = TimeBarrier.duringTimePeriod(startTimeStamp, stopTimeStamp);
                break;
            case Param.TIME_DURING_PERIOD_OF_WEEK_BARRIER:
                final int dayOfWeek = ValueGetter.getInt(Param.DAY_OF_WEEK, args);
                final long startTimeOfSpecifiedDay = ValueGetter.getLong(Param.START_TIME_OF_SPECIFIED_DAY, args);
                final long stopTimeOfSpecifiedDay = ValueGetter.getLong(Param.STOP_TIME_OF_SPECIFIED_DAY, args);
                awarenessBarrier = TimeBarrier.duringPeriodOfWeek(dayOfWeek, timeZone, startTimeOfSpecifiedDay,
                    stopTimeOfSpecifiedDay);
                break;
            case Param.TIME_IN_TIME_CATEGORY_BARRIER:
                final int inTimeCategory = ValueGetter.getInt(Param.IN_TIME_CATEGORY, args);
                awarenessBarrier = TimeBarrier.inTimeCategory(inTimeCategory);
                break;
            default:
                awarenessBarrier = null;
        }
        return awarenessBarrier;
    }

}

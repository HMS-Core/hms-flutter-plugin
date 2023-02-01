/*
 * Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.wallet.logger;

import static android.os.Build.DEVICE;

import android.content.Context;
import android.content.pm.PackageManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.util.Log;

import com.huawei.agconnect.config.AGConnectServicesConfig;
import com.huawei.hms.support.hianalytics.HiAnalyticsUtils;
import com.huawei.hms.utils.HMSBIInitializer;

import java.lang.ref.WeakReference;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public final class HMSLogger {
    private static final String TAG = "HMSLogger";

    private static final String KIT = "Wallet";

    private static final String PLATFORM = "Flutter";

    private static final String VERSION = "4.0.5.300";

    private static final String SERVICE = "Cross-Platform";

    private static final String SUCCESS = "0";

    private static final String UNKNOWN = "UNKNOWN";

    private static final String NOT_AVAILABLE = "NOT_AVAILABLE";

    private static final String SINGLE_EVENT_ID = "60000";

    private static final String PERIODIC_EVENT_ID = "60001";

    private static final String NETWORK_TYPE_WIFI = "WIFI";

    private static volatile HMSLogger instance;

    private final WeakReference<Context> weakContext;

    private final HiAnalyticsUtils hiAnalyticsUtils;

    private final ConnectivityManager connectivityManager;

    private final Map<String, Object> singleEventMap = new HashMap<>();

    private final Map<String, Object> periodicEventMap = new HashMap<>();

    private final Map<String, Long> allCountMap = new HashMap<>();

    private final Map<String, Long> failCountMap = new HashMap<>();

    private final Map<String, Long> startTimeMap = new HashMap<>();

    private final Map<String, Long> firstReceiveTimeMap = new HashMap<>();

    private final Map<String, Long> lastReceiveTimeMap = new HashMap<>();

    private final Map<String, Map<String, Long>> resultCodeCountMap = new HashMap<>();

    private final Map<Integer, String> networkTypeMap = createNetworkTypeMap();

    private boolean isEnabled = false;

    /**
     * Private constructor of this class.
     *
     * @param context Application's context
     */
    private HMSLogger(final Context context) {
        weakContext = new WeakReference<>(context);
        hiAnalyticsUtils = HiAnalyticsUtils.getInstance();
        connectivityManager = objectCast(context.getSystemService(Context.CONNECTIVITY_SERVICE), ConnectivityManager.class);

        hiAnalyticsUtils.enableLog();
        HMSBIInitializer.getInstance(context).initBI();
        setupEventMap(singleEventMap);
        setupEventMap(periodicEventMap);
        enableLogger();
    }

    /**
     * Returns the instance of this class.
     *
     * @param context Context object
     * @return HMSLogger instance
     */
    public static synchronized HMSLogger getInstance(final Context context) {
        if (instance == null) {
            synchronized (HMSLogger.class) {
                if (instance == null) {
                    instance = new HMSLogger(context.getApplicationContext());
                }
            }
        }
        return instance;
    }

    /**
     * Returns actual context reference.
     *
     * @return Actual context reference
     */
    private synchronized Context getContext() {
        return weakContext.get();
    }

    /**
     * Enables HMSLogger.
     */
    public synchronized void enableLogger() {
        isEnabled = true;
        Log.d(TAG, "HMS Plugin Dotting is Enabled!");
    }

    /**
     * Disables HMSLogger.
     */
    public synchronized void disableLogger() {
        isEnabled = false;
        Log.d(TAG, "HMS Plugin Dotting is Disabled!");
    }

    /**
     * Sets method start time for given method name.
     *
     * @param methodName Name of the method that will be logged
     */
    public synchronized void startMethodExecutionTimer(final String methodName) {
        startTimeMap.put(methodName, System.currentTimeMillis());
    }

    /**
     * Sends successful single event.
     *
     * @param methodName The name of the method called
     */
    public synchronized void sendSingleEvent(final String methodName) {
        sendEvent(SINGLE_EVENT_ID, methodName, SUCCESS);
    }

    /**
     * Sends unsuccessful single event
     *
     * @param methodName The name of the method called.
     * @param errorCode  API error code
     */
    public synchronized void sendSingleEvent(final String methodName, final String errorCode) {
        sendEvent(SINGLE_EVENT_ID, methodName, errorCode);
    }

    /**
     * Sends successful periodic event.
     *
     * @param methodName The name of the method called
     */
    public synchronized void sendPeriodicEvent(final String methodName) {
        sendEvent(PERIODIC_EVENT_ID, methodName, SUCCESS);
    }

    /**
     * Sends unsuccessful periodic event.
     *
     * @param methodName The name of the method called
     * @param errorCode  API error code
     */
    public synchronized void sendPeriodicEvent(final String methodName, final String errorCode) {
        sendEvent(PERIODIC_EVENT_ID, methodName, errorCode);
    }

    /**
     * Sends the event based on eventId, methodName, and resultCode.
     *
     * @param eventId    Constant id of the event
     * @param methodName The name of the method called
     * @param resultCode Code of the method's result. "0" for success, others for error
     */
    private synchronized void sendEvent(final String eventId, final String methodName, final String resultCode) {
        if (isEnabled) {
            final long currentTime = System.currentTimeMillis();

            if (eventId.equals(SINGLE_EVENT_ID)) {
                putToSingleEventMap(methodName, resultCode, currentTime);
                hiAnalyticsUtils.onNewEvent(getContext(), SINGLE_EVENT_ID, singleEventMap);

                Log.d(TAG, "singleEventMap -> " + singleEventMap);
            } else {
                putToPeriodicEventMap(methodName, resultCode, currentTime);
                hiAnalyticsUtils.onNewEvent(getContext(), PERIODIC_EVENT_ID, periodicEventMap);

                Log.d(TAG, "periodicEventMap -> " + periodicEventMap);
            }
        }
    }

    /**
     * Gets "client/app_id" value from agconnect-services.json file.
     *
     * @return app_id value or NOT_AVAILABLE if not found
     */
    private synchronized String getAppId() {
        try {
            return AGConnectServicesConfig.fromContext(getContext()).getString("client/app_id");
        } catch (final NullPointerException e) {
            Log.d(TAG, "AgConnect is not found. Setting appId value to " + NOT_AVAILABLE);
        }
        return NOT_AVAILABLE;
    }

    /**
     * Gets app version name.
     *
     * @param packageName Package name of the app
     * @return App version name in String type
     */
    private synchronized String getAppVersionName(final String packageName) {
        try {
            return getContext().getPackageManager().getPackageInfo(packageName, 0).versionName;
        } catch (final PackageManager.NameNotFoundException e) {
            Log.e(TAG, "getAppVersionName ->  Could not get appVersionName!");
            return NOT_AVAILABLE;
        }
    }

    /**
     * Detects current network type.
     *
     * @return Human readable network type; such as WIFI, 4G
     */
    private synchronized String getNetworkType() {
        if (connectivityManager != null) {
            final NetworkInfo networkInfo = connectivityManager.getActiveNetworkInfo();
            if (networkInfo != null && networkInfo.isConnected()) {
                final int networkType = networkInfo.getType();
                if (ConnectivityManager.TYPE_WIFI == networkType) {
                    return NETWORK_TYPE_WIFI;
                } else if (ConnectivityManager.TYPE_MOBILE == networkType) {
                    final int networkSubType = networkInfo.getSubtype();
                    return getOrDefault(networkTypeMap, networkSubType, UNKNOWN);
                } else {
                    return UNKNOWN;
                }
            } else {
                return NOT_AVAILABLE;
            }
        } else {
            return NOT_AVAILABLE;
        }
    }

    /**
     * Sets default values to given map.
     *
     * @param map HashMap to put default values
     */
    private synchronized void setupEventMap(final Map<String, Object> map) {
        map.put("kit", KIT);
        map.put("platform", PLATFORM);
        map.put("version", VERSION);
        map.put("service", SERVICE);
        map.put("appid", getAppId());
        map.put("package", getContext().getPackageName());
        map.put("cpAppVersion", getAppVersionName(getContext().getPackageName()));
        map.put("model", DEVICE);
    }

    /**
     * Prepares sing-event map according to input parameters.
     *
     * @param methodName  The name of the method called
     * @param resultCode  Code of the method's result. "0" for success, others for error
     * @param currentTime Current timestamp in millisecond
     */
    private synchronized void putToSingleEventMap(final String methodName, final String resultCode,
                                                  final long currentTime) {
        final long startTime = getOrDefault(startTimeMap, methodName, currentTime);
        final int costTime = (int) (currentTime - startTime);
        singleEventMap.put("apiName", methodName);
        singleEventMap.put("result", resultCode);
        singleEventMap.put("callTime", currentTime);
        singleEventMap.put("costTime", costTime);
        singleEventMap.put("networkType", getNetworkType());
    }

    /**
     * Prepares periodic-event map according to input parameters.
     *
     * @param methodName  The name of the method called
     * @param resultCode  Code of the method's result. "0" for success, others for error
     * @param currentTime Current timestamp in millisecond
     */
    private synchronized void putToPeriodicEventMap(final String methodName, final String resultCode,
                                                    final long currentTime) {
        increaseResultCodeCount(methodName, resultCode);
        increaseMapValue(methodName, allCountMap);

        if (!resultCode.equals(SUCCESS)) {
            increaseMapValue(methodName, failCountMap);
        }

        final long firstReceiveTime = getOrDefault(firstReceiveTimeMap, methodName, currentTime);
        periodicEventMap.put("callTime", firstReceiveTime);

        final long lastReceiveTime = getOrDefault(lastReceiveTimeMap, methodName, currentTime);
        final int costTime = (int) (currentTime - lastReceiveTime);
        periodicEventMap.put("costTime", costTime);

        periodicEventMap.put("apiName", methodName);
        periodicEventMap.put("result", resultCodeCountMap.get(methodName));

        final long allCount = getOrDefault(allCountMap, methodName, 0L);
        periodicEventMap.put("allCnt", allCount);

        final long failCount = getOrDefault(failCountMap, methodName, 0L);
        periodicEventMap.put("failCnt", failCount);

        periodicEventMap.put("lastCallTime", currentTime);
        periodicEventMap.put("networkType", getNetworkType());

        putIfAbsent(firstReceiveTimeMap, methodName, currentTime);
        lastReceiveTimeMap.put(methodName, currentTime);
    }

    /**
     * Prepares HashMap of network type id and its human-readable string pairs.
     *
     * @return HashMap of human readable network type names
     */
    private synchronized Map<Integer, String> createNetworkTypeMap() {
        final Map<Integer, String> map = new HashMap<>();
        map.put(0, UNKNOWN);
        map.put(1, "2G");
        map.put(2, "2G");
        map.put(3, "3G");
        map.put(4, "3G");
        map.put(5, "3G");
        map.put(6, "3G");
        map.put(7, "2G");
        map.put(8, "3G");
        map.put(9, "3G");
        map.put(10, "3G");
        map.put(11, "2G");
        map.put(12, "3G");
        map.put(13, "4G");
        map.put(14, "3G");
        map.put(15, "3G");
        map.put(16, "2G");
        map.put(17, "3G");
        map.put(18, "4G");
        map.put(19, "4G");
        map.put(20, "5G");

        return Collections.unmodifiableMap(map);
    }

    /**
     * Increases count of the given result code.
     *
     * @param methodName Name of the calling method
     * @param resultCode Code of the method's result. "0" for success, others for error
     */
    private synchronized void increaseResultCodeCount(final String methodName, final String resultCode) {
        final Map<String, Long> map = getOrDefault(resultCodeCountMap, methodName, new HashMap<>());

        increaseMapValue(resultCode, map);
        resultCodeCountMap.put(methodName, map);
    }

    /**
     * Increases the value of the corresponding key which in the map.
     *
     * @param key Key for map lookup
     * @param map The Map that contains the key and its corresponding value
     */
    private synchronized void increaseMapValue(final String key, final Map<String, Long> map) {
        map.put(key, getOrDefault(map, key, 0L) + 1);
    }

    /**
     * Get the corresponding value of the key. If the key does not exist in the map then the default value is returned.
     *
     * @param map          The Map
     * @param key          Lookup key
     * @param defaultValue The default value will be returned if the key is absent
     * @param <K>          Generic type of the key
     * @param <V>          Generic type of the value
     * @return Corresponding value or default value
     */
    private synchronized <K, V> V getOrDefault(final Map<K, V> map, final K key, final V defaultValue) {
        return map.containsKey(key) ? map.get(key) : defaultValue;
    }

    /**
     * Put key-value pair to map if the key is absent.
     *
     * @param map   The Map
     * @param key   Lookup key
     * @param value The value will be put to the map if the key is absent
     * @param <K>   Generic type of the key
     * @param <V>   Generic type of the value
     */
    private synchronized <K, V> void putIfAbsent(final Map<K, V> map, final K key, final V value) {
        if (!map.containsKey(key)) {
            map.put(key, value);
        }
    }

    /**
     * Utility method that castes given object to given class type.
     *
     * @param source Source object to be casted
     * @param clazz  Class that object will be casted to its type
     * @param <S>    Source object's type
     * @param <D>    Destination type
     * @return Object that casted to D type
     */
    private synchronized <S, D> D objectCast(final S source, final Class<D> clazz) {
        return clazz.cast(source);
    }
}

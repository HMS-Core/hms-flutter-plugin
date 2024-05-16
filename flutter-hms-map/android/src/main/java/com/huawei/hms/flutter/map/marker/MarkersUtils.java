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

package com.huawei.hms.flutter.map.marker;

import android.app.Application;

import com.huawei.hms.flutter.map.constants.Method;
import com.huawei.hms.flutter.map.constants.Param;
import com.huawei.hms.flutter.map.logger.HMSLogger;
import com.huawei.hms.flutter.map.utils.Convert;
import com.huawei.hms.flutter.map.utils.ToJson;
import com.huawei.hms.maps.HuaweiMap;
import com.huawei.hms.maps.model.LatLng;
import com.huawei.hms.maps.model.Marker;
import com.huawei.hms.maps.model.MarkerOptions;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MarkersUtils {
    private HuaweiMap huaweiMap;

    private final MethodChannel mChannel;

    private BinaryMessenger messenger;

    private final Map<String, MarkerController> idsOnMap;

    private final Map<String, String> ids;

    private final HMSLogger logger;

    public MarkersUtils(final MethodChannel mChannel, final Application application) {
        idsOnMap = new HashMap<>();
        ids = new HashMap<>();
        this.mChannel = mChannel;
        logger = HMSLogger.getInstance(application);
    }

    public void setMap(final HuaweiMap huaweiMap) {
        this.huaweiMap = huaweiMap;
    }

    public void insertMulti(final List<HashMap<String, Object>> markerList, final BinaryMessenger messenger) {
        this.messenger = messenger;
        if (markerList == null) {
            return;
        }

        for (final HashMap<String, Object> markerToAdd : markerList) {
            insert(markerToAdd, messenger);
        }
    }

    private void insert(final HashMap<String, Object> marker, final BinaryMessenger messenger) {
        if (huaweiMap == null) {
            return;
        }
        if (marker == null) {
            return;
        }

        final MarkerBuilder markerBuilder = new MarkerBuilder();
        final String id = Convert.processMarkerOptions(marker, markerBuilder, messenger);
        final MarkerOptions options = markerBuilder.build();

        logger.startMethodExecutionTimer("addMarker");
        final Marker newMarker = huaweiMap.addMarker(options);
        logger.sendSingleEvent("addMarker");

        final MarkerController controller = new MarkerController(newMarker, markerBuilder.isClusterable());
        controller.setAnimationSet(markerBuilder.getAnimationSet());

        idsOnMap.put(id, controller);
        ids.put(newMarker.getId(), id);
    }

    private void update(final HashMap<String, Object> marker) {
        if (marker == null) {
            return;
        }
        final String markerId = getId(marker);
        final MarkerController markerController = idsOnMap.get(markerId);
        if (markerController != null) {
            Convert.processMarkerOptions(marker, markerController, messenger);
        }
    }

    public void updateMulti(final List<HashMap<String, Object>> marker) {
        if (marker == null) {
            return;
        }

        for (final HashMap<String, Object> markerToChange : marker) {
            update(markerToChange);
        }
    }

    public void deleteMulti(final List<String> markerList) {
        if (markerList == null) {
            return;
        }

        for (final String id : markerList) {
            if (id == null) {
                continue;
            }

            final MarkerController markerController = idsOnMap.remove(id);
            if (markerController != null) {

                logger.startMethodExecutionTimer("removeMarker");
                markerController.delete();
                logger.sendSingleEvent("removeMarker");

                ids.remove(markerController.getMapMarkerId());
            }
        }
    }

    public void isMarkerClusterable(final String id, final MethodChannel.Result result) {
        final MarkerController markerController = idsOnMap.get(id);
        if (markerController == null) {
            return;
        }
        result.success(markerController.isClusterable());
    }

    public void showInfoWindow(final String id, final MethodChannel.Result result) {
        final MarkerController markerController = idsOnMap.get(id);
        if (markerController == null) {
            return;
        }

        markerController.showInfoWindow();
        result.success(null);
    }

    public void hideInfoWindow(final String id, final MethodChannel.Result result) {
        final MarkerController markerController = idsOnMap.get(id);
        if (markerController == null) {
            return;
        }

        markerController.hideInfoWindow();
        result.success(null);
    }

    public void isInfoWindowShown(final String id, final MethodChannel.Result result) {
        final MarkerController markerController = idsOnMap.get(id);
        if (markerController == null) {
            return;
        }
        result.success(markerController.isInfoWindowShown());
    }

    public boolean onMarkerClick(final String idOnMap) {
        logger.startMethodExecutionTimer("onMarkerClick");
        final String id = ids.get(idOnMap);
        if (id == null) {
            return false;
        }
        mChannel.invokeMethod(Method.MARKER_CLICK, markerIdToJson(id));
        logger.sendSingleEvent("onMarkerClick");

        final MarkerController markerController = idsOnMap.get(id);

        if (markerController != null) {
            markerController.showInfoWindow();
            return markerController.isClickable();
        }
        return false;

    }

    public void onMarkerDragEnd(final String idOnMap, final LatLng latLng) {
        final String id = ids.get(idOnMap);
        if (id == null) {
            return;
        }

        final Map<String, Object> args = new HashMap<>();
        args.put(Param.MARKER_ID, id);
        args.put(Param.POSITION, ToJson.latLng(latLng));
        mChannel.invokeMethod(Method.MARKER_ON_DRAG_END, args);
    }

    public void onMarkerDragStart(final String idOnMap, final LatLng latLng) {
        final String id = ids.get(idOnMap);
        if (id == null) {
            return;
        }

        final Map<String, Object> args = new HashMap<>();
        args.put(Param.MARKER_ID, id);
        args.put(Param.POSITION, ToJson.latLng(latLng));
        mChannel.invokeMethod(Method.MARKER_ON_DRAG_START, args);
    }

    public void onMarkerDrag(final String idOnMap, final LatLng latLng) {
        final String id = ids.get(idOnMap);
        if (id == null) {
            return;
        }

        final Map<String, Object> args = new HashMap<>();
        args.put(Param.MARKER_ID, id);
        args.put(Param.POSITION, ToJson.latLng(latLng));
        mChannel.invokeMethod(Method.MARKER_ON_DRAG, args);
    }

    public void onInfoWindowClick(final String idOnMap) {
        final String markerId = ids.get(idOnMap);
        if (markerId == null) {
            return;
        }

        mChannel.invokeMethod(Method.INFO_WINDOW_CLICK, markerIdToJson(markerId));
    }

    public void onInfoWindowLongClick(final String idOnMap) {
        final String markerId = ids.get(idOnMap);
        if (markerId == null) {
            return;
        }

        mChannel.invokeMethod(Method.INFO_WINDOW_LONG_CLICK, markerIdToJson(markerId));
    }

    public void onInfoWindowClose(final String idOnMap) {
        final String markerId = ids.get(idOnMap);
        if (markerId == null) {
            return;
        }

        mChannel.invokeMethod(Method.INFO_WINDOW_CLOSE, markerIdToJson(markerId));
    }

    private static String getId(final HashMap<String, Object> marker) {
        return (String) marker.get(Param.MARKER_ID);
    }

    private static HashMap<String, Object> markerIdToJson(final String markerId) {
        if (markerId == null) {
            return null;
        }

        final HashMap<String, Object> data = new HashMap<>();
        data.put(Param.MARKER_ID, markerId);
        return data;
    }

    public void startAnimation(final String id) {
        final MarkerController markerController = idsOnMap.get(id);
        if (markerController != null) {
            markerController.startAnimation();
        }
    }

}

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

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Point;
import android.util.Log;
import android.view.animation.AccelerateDecelerateInterpolator;
import android.view.animation.AccelerateInterpolator;
import android.view.animation.AnticipateInterpolator;
import android.view.animation.BounceInterpolator;
import android.view.animation.DecelerateInterpolator;
import android.view.animation.Interpolator;
import android.view.animation.LinearInterpolator;
import android.view.animation.OvershootInterpolator;

import androidx.interpolator.view.animation.FastOutLinearInInterpolator;
import androidx.interpolator.view.animation.FastOutSlowInInterpolator;
import androidx.interpolator.view.animation.LinearOutSlowInInterpolator;

import com.huawei.hms.flutter.map.circle.CircleMethods;
import com.huawei.hms.flutter.map.constants.Channel;
import com.huawei.hms.flutter.map.constants.Param;
import com.huawei.hms.flutter.map.groundoverlay.GroundOverlayMethods;
import com.huawei.hms.flutter.map.heatmap.HeatMapMethods;
import com.huawei.hms.flutter.map.map.MapMethods;
import com.huawei.hms.flutter.map.marker.MarkerMethods;
import com.huawei.hms.flutter.map.polygon.PolygonMethods;
import com.huawei.hms.flutter.map.polyline.PolylineMethods;
import com.huawei.hms.flutter.map.tileoverlay.TileOverlayMethods;
import com.huawei.hms.maps.CameraUpdate;
import com.huawei.hms.maps.CameraUpdateFactory;
import com.huawei.hms.maps.model.BitmapDescriptor;
import com.huawei.hms.maps.model.BitmapDescriptorFactory;
import com.huawei.hms.maps.model.ButtCap;
import com.huawei.hms.maps.model.CameraPosition;
import com.huawei.hms.maps.model.Cap;
import com.huawei.hms.maps.model.CustomCap;
import com.huawei.hms.maps.model.Dash;
import com.huawei.hms.maps.model.Dot;
import com.huawei.hms.maps.model.Gap;
import com.huawei.hms.maps.model.HeatMapOptions;
import com.huawei.hms.maps.model.LatLng;
import com.huawei.hms.maps.model.LatLngBounds;
import com.huawei.hms.maps.model.MyLocationStyle;
import com.huawei.hms.maps.model.PatternItem;
import com.huawei.hms.maps.model.RoundCap;
import com.huawei.hms.maps.model.SquareCap;
import com.huawei.hms.maps.model.Tile;
import com.huawei.hms.maps.model.TileProvider;
import com.huawei.hms.maps.model.UrlTileProvider;
import com.huawei.hms.maps.model.animation.AlphaAnimation;
import com.huawei.hms.maps.model.animation.Animation;
import com.huawei.hms.maps.model.animation.Animation.AnimationListener;
import com.huawei.hms.maps.model.animation.AnimationSet;
import com.huawei.hms.maps.model.animation.RotateAnimation;
import com.huawei.hms.maps.model.animation.ScaleAnimation;
import com.huawei.hms.maps.model.animation.TranslateAnimation;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterMain;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Convert {
    private static List<?> toList(final Object o) {
        return (List<?>) o;
    }

    private static Map<?, ?> toMap(final Object o) {
        return (Map<?, ?>) o;
    }

    private static Map<Float, Integer> toColorMap(final Object o) {
        final Map<?, ?> args = Convert.toMap(o);
        final Map<Float, Integer> result = new HashMap<>();

        for (Map.Entry<?, ?> entry : args.entrySet()) {
            result.put(Convert.toFloatWrapper(entry.getKey()),
                toIntegerWrapper(Long.parseLong((String) entry.getValue())));
        }
        return result;
    }

    private static Map<Float, Float> toFloatMap(final Object o) {
        final Map<?, ?> args = Convert.toMap(o);
        final Map<Float, Float> result = new HashMap<>();

        for (Map.Entry<?, ?> entry : args.entrySet()) {
            result.put(Convert.toFloatWrapper(entry.getKey()), Convert.toFloatWrapper(entry.getValue()));
        }
        return result;

    }

    private static List<Integer> toIntegerList(final Object o) {
        final List<?> data = Convert.toList(o);
        final List<Integer> integerList = new ArrayList<Integer>();

        for (Object element : data) {
            integerList.add(Convert.toInt(element));
        }
        return integerList;
    }

    public static String toString(final Object o) {
        return (String) o;
    }

    private static double toDouble(final Object o) {
        return ((Number) o).doubleValue();
    }

    private static float toFloat(final Object o) {
        return ((Number) o).floatValue();
    }

    private static Float toFloatWrapper(final Object o) {
        return (o == null) ? null : toFloat(o);
    }

    private static int toInt(final Object o) {
        return ((Number) o).intValue();
    }

    private static Integer toIntegerWrapper(final Object o) {
        return (o == null) ? null : toInt(o);
    }

    private static boolean toBoolean(final Object o) {
        return (Boolean) o;
    }

    public static LatLng toLatLng(final Object o) {
        final List<?> data = Convert.toList(o);
        return new LatLng(Convert.toDouble(data.get(0)), Convert.toDouble(data.get(1)));
    }

    public static LatLng[] toLatLngList(final Object o) {
        final List<?> data = Convert.toList(o);
        LatLng[] result = new LatLng[data.size()];
        for (int i = 0; i < data.size(); i++) {
            result[i] = Convert.toLatLng(data.get(i));
        }
        return result;
    }

    public static Point toPoint(final Object o) {
        final Map<String, Integer> screenCoordinate = (Map<String, Integer>) o;
        return new Point(screenCoordinate.get("x"), screenCoordinate.get("y"));
    }

    public static List<LatLng> toLatLngStartEnd(final Object o) {
        final List<?> data = Convert.toList(o);
        final List<?> dataStart = Convert.toList(data.get(0));
        final List<?> dataEnd = Convert.toList(data.get(1));
        final LatLng start = new LatLng(Convert.toDouble(dataStart.get(0)), Convert.toDouble(dataStart.get(1)));
        final LatLng end = new LatLng(Convert.toDouble(dataEnd.get(0)), Convert.toDouble(dataEnd.get(1)));
        return new ArrayList<>(Arrays.asList(start, end));
    }

    private static BitmapDescriptor toBitmapDescriptor(final Object o) {
        final List<?> data = Convert.toList(o);
        switch (Convert.toString(data.get(0))) {
            case Param.DEFAULT_MARKER:
                if (data.size() == 1) {
                    return BitmapDescriptorFactory.defaultMarker();
                } else {
                    return BitmapDescriptorFactory.defaultMarker(Convert.toFloat(data.get(1)));
                }
            case Param.FROM_ASSET:
                if (data.size() == 2) {
                    return BitmapDescriptorFactory.fromAsset(
                        FlutterMain.getLookupKeyForAsset(Convert.toString(data.get(1))));
                } else {
                    return BitmapDescriptorFactory.fromAsset(
                        FlutterMain.getLookupKeyForAsset(Convert.toString(data.get(1)), Convert.toString(data.get(2))));
                }
            case Param.FROM_ASSET_IMAGE:
                if (data.size() == 3) {
                    return BitmapDescriptorFactory.fromAsset(
                        FlutterMain.getLookupKeyForAsset(Convert.toString(data.get(1))));
                } else {
                    throw new IllegalArgumentException(Param.ERROR);
                }
            case Param.FROM_BYTES:
                return getBitmapFromBytes(data);
            default:
                throw new IllegalArgumentException(Param.ERROR);
        }
    }

    private static BitmapDescriptor getBitmapFromBytes(final List<?> data) {
        if (data.size() == 2) {
            try {
                final Bitmap bitmap = toBitmap(data.get(1));
                return BitmapDescriptorFactory.fromBitmap(bitmap);
            } catch (final Exception e) {
                throw new IllegalArgumentException(Param.ERROR);
            }
        } else {
            throw new IllegalArgumentException(Param.ERROR);
        }
    }

    private static MyLocationStyle toMyLocationStyle(final Object o) {
        final Map<?, ?> data = Convert.toMap(o);
        MyLocationStyle myLocationStyle = new MyLocationStyle();

        final Object anchor = data.get(Param.ANCHOR);
        if (anchor != null) {
            final List<?> anchorData = Convert.toList(anchor);
            myLocationStyle.anchor(Convert.toFloat(anchorData.get(0)), Convert.toFloat(anchorData.get(1)));
        }

        final Object radiusFillColor = data.get(Param.RADIUS_FILL_COLOR);
        if (radiusFillColor != null) {
            myLocationStyle.radiusFillColor(Convert.toInt(radiusFillColor));
        }

        final Object icon = data.get(Param.ICON);
        if (icon != null) {
            myLocationStyle.myLocationIcon(Convert.toBitmapDescriptor(icon));
        }

        return myLocationStyle;
    }

    public static CameraPosition toCameraPosition(final Object o) {
        final Map<?, ?> args = Convert.toMap(o);
        final CameraPosition.Builder builder = CameraPosition.builder();
        builder.bearing(Convert.toFloat(args.get(Param.BEARING)));
        builder.target(toLatLng(args.get(Param.TARGET)));
        builder.tilt(Convert.toFloat(args.get(Param.TILT)));
        builder.zoom(Convert.toFloat(args.get(Param.ZOOM)));
        return builder.build();
    }

    public static CameraUpdate toCameraUpdate(final Object o, final float compactness) {
        final List<?> data = Convert.toList(o);
        switch (Convert.toString(data.get(0))) {
            case Param.NEW_CAMERA_POSITION:
                return CameraUpdateFactory.newCameraPosition(toCameraPosition(data.get(1)));
            case Param.NEW_LAT_LNG:
                return CameraUpdateFactory.newLatLng(toLatLng(data.get(1)));
            case Param.NEW_LAT_LNG_BOUNDS:
                return CameraUpdateFactory.newLatLngBounds(toLatLngBounds(data.get(1)),
                    toPixels(data.get(2), compactness));
            case Param.NEW_LAT_LNG_ZOOM:
                return CameraUpdateFactory.newLatLngZoom(toLatLng(data.get(1)), Convert.toFloat(data.get(2)));
            case Param.SCROLL_BY:
                return CameraUpdateFactory.scrollBy(toFinePixels(data.get(1), compactness),
                    toFinePixels(data.get(2), compactness));
            case Param.ZOOM_BY:
                if (data.size() == 2) {
                    return CameraUpdateFactory.zoomBy(Convert.toFloat(data.get(1)));
                } else {
                    return CameraUpdateFactory.zoomBy(Convert.toFloat(data.get(1)), toPoint(data.get(2), compactness));
                }
            case Param.ZOOM_IN:
                return CameraUpdateFactory.zoomIn();
            case Param.ZOOM_OUT:
                return CameraUpdateFactory.zoomOut();
            case Param.ZOOM_TO:
                return CameraUpdateFactory.zoomTo(Convert.toFloat(data.get(1)));
            default:
                throw new IllegalArgumentException(Param.ERROR);
        }
    }

    private static LatLngBounds toLatLngBounds(final Object o) {
        if (o == null) {
            return null;
        }

        final List<?> data = Convert.toList(o);
        return new LatLngBounds(toLatLng(data.get(0)), toLatLng(data.get(1)));
    }

    private static float toFinePixels(final Object o, final float compactness) {
        return Convert.toFloat(o) * compactness;
    }

    private static int toPixels(final Object o, final float compactness) {
        return (int) toFinePixels(o, compactness);
    }

    private static Bitmap toBitmap(final Object o) {
        final byte[] bmpData = (byte[]) o;
        final Bitmap bitmap = BitmapFactory.decodeByteArray(bmpData, 0, bmpData.length);
        if (bitmap == null) {
            throw new IllegalArgumentException(Param.ERROR);
        } else {
            return bitmap;
        }
    }

    private static Point toPoint(final Object o, final float compactness) {
        final List<?> data = Convert.toList(o);
        return new Point(toPixels(data.get(0), compactness), toPixels(data.get(1), compactness));
    }

    private static TileProvider toTileProvider(final Object o) throws JSONException {
        final TileProvider tileProvider;

        if (o instanceof List) {
            final ArrayList<?> data = (ArrayList<?>) o;
            final JSONArray tileProvidersData = new JSONArray(data);
            final HashMap<List<Integer>, String> mapTypeTwo = new HashMap<>();
            for (int i = 0; i < tileProvidersData.length(); i++) {
                final JSONObject obj = tileProvidersData.getJSONObject(i);
                final List<Integer> set = Arrays.asList(obj.optInt(Param.X), obj.optInt(Param.Y),
                    obj.optInt(Param.ZOOM));
                mapTypeTwo.put(set, obj.optString(Param.IMAGE_DATA));
            }
            tileProvider = (x, y, zoom) -> {
                final List<Integer> key = Arrays.asList(x, y, zoom);
                if (mapTypeTwo.containsKey(key)) {
                    final String byteValues = mapTypeTwo.get(key);
                    final String[] values;
                    if (byteValues != null && byteValues.length() > 0) {
                        values = byteValues.substring(1, byteValues.length() - 1).split(",");
                        final byte[] bytes = new byte[values.length];
                        try {
                            for (int i = 0, len = bytes.length; i < len; i++) {
                                bytes[i] = Byte.parseByte(values[i].trim());
                            }
                            return new Tile(256, 256, bytes);
                        } catch (final Exception e) {
                            Log.e("TileProvider Error", "Please provide a valid image", null);
                        }
                    }
                }
                return null;
            };
        } else {
            final Map<?, ?> obj = Convert.toMap(o);
            if (obj.containsKey(Param.URI)) {
                return new UrlTileProvider(256, 256) {
                    @Override
                    public URL getTileUrl(final int x, final int y, final int zoom) {
                        final String uri = (String) obj.get(Param.URI);
                        if (uri != null) {
                            try {
                                return new URL(uri.replace("{x}", String.valueOf(x))
                                    .replace("{y}", String.valueOf(y))
                                    .replace("{z}", String.valueOf(zoom)));
                            } catch (final MalformedURLException e) {
                                Log.w("UrlTileProvider", e.getMessage());
                                return null;
                            }
                        } else {
                            return null;
                        }
                    }
                };
            } else {
                final byte[] imageData = (byte[]) obj.get(Param.IMAGE_DATA);
                final List<Integer> zoomLevels = (List<Integer>) obj.get(Param.ZOOM);

                tileProvider = (x, y, zoom) -> {
                    for (final int z : zoomLevels) {
                        if (z == zoom) {
                            return new Tile(256, 256, imageData);
                        }
                    }
                    return null;
                };
            }
        }
        return tileProvider;
    }

    private static void processInfoWindowOptions(final Map<String, Object> infoWindow, final MarkerMethods call) {
        final String title = (String) infoWindow.get(Param.TITLE);
        final String snippet = (String) infoWindow.get(Param.SNIPPET);

        if (title != null) {
            call.setInfoWindowText(title, snippet);
        }
        final Object infoWindowAnchor = infoWindow.get(Param.ANCHOR);
        if (infoWindowAnchor != null) {
            final List<?> anchorData = Convert.toList(infoWindowAnchor);
            call.setInfoWindowAnchor(Convert.toFloat(anchorData.get(0)), Convert.toFloat(anchorData.get(1)));
        }
    }

    public static String processMarkerOptions(final Object o, final MarkerMethods call,
        final BinaryMessenger messenger) {
        final Map<?, ?> data = Convert.toMap(o);
        final Object infoWindow = data.get(Param.INFO_WINDOW);
        if (infoWindow != null) {
            processInfoWindowOptions((Map<String, Object>) infoWindow, call);
        }

        final Object alpha = data.get(Param.ALPHA);
        if (alpha != null) {
            call.setAlpha(Convert.toFloat(alpha));
        }

        final Object anchor = data.get(Param.ANCHOR);
        if (anchor != null) {
            final List<?> anchorData = Convert.toList(anchor);
            call.setAnchor(Convert.toFloat(anchorData.get(0)), Convert.toFloat(anchorData.get(1)));
        }

        final Object clickable = data.get(Param.CLICKABLE);
        if (clickable != null) {
            call.setClickable(Convert.toBoolean(clickable));
        }

        final Object clusterable = data.get(Param.CLUSTERABLE);
        if (clusterable != null) {
            call.setClusterable(Convert.toBoolean(clusterable));
        }

        final Object draggable = data.get(Param.DRAGGABLE);
        if (draggable != null) {
            call.setDraggable(Convert.toBoolean(draggable));
        }

        final Object flat = data.get(Param.FLAT);
        if (flat != null) {
            call.setFlat(Convert.toBoolean(flat));
        }

        final Object icon = data.get(Param.ICON);
        if (icon != null) {
            call.setIcon(Convert.toBitmapDescriptor(icon));
        }

        final Object position = data.get(Param.POSITION);
        if (position != null) {
            call.setPosition(Convert.toLatLng(position));
        }

        final Object rotation = data.get(Param.ROTATION);
        if (rotation != null) {
            call.setRotation(Convert.toFloat(rotation));
        }

        final Object visible = data.get(Param.VISIBLE);
        if (visible != null) {
            call.setVisible(Convert.toBoolean(visible));
        }

        final Object zIndex = data.get(Param.Z_INDEX);
        if (zIndex != null) {
            call.setZIndex(Convert.toFloat(zIndex));
        }

        final Object animations = data.get(Param.ANIMATION);
        if (animations != null) {
            call.setAnimationSet(processAnimationSet(animations, messenger));
        }

        final String markerId = (String) data.get(Param.MARKER_ID);
        if (markerId == null) {
            throw new IllegalArgumentException(Param.ERROR);
        } else {
            return markerId;
        }
    }

    public static AnimationSet processAnimationSet(final Object o, final BinaryMessenger messenger) {
        final AnimationSet animationSet = new AnimationSet(false);

        try {
            final JSONArray animations = new JSONArray((String) o);
            for (int i = 0; i <= animations.length() - 1; i++) {
                final JSONObject element = animations.getJSONObject(i);
                animationSet.addAnimation(processAnimationOptions(element, messenger));
            }
        } catch (final JSONException e) {
            Log.e("Convert", e.getMessage());
        }

        return animationSet;
    }

    public static Animation processAnimationOptions(final Object o, final BinaryMessenger messenger)
        throws JSONException {
        final JSONObject data = (JSONObject) o;

        Animation animation = null;

        final Object animationId = data.get(Param.ANIMATION_ID);
        final MethodChannel animationChannel = new MethodChannel(messenger, Channel.ANIMATION + "_" + animationId);

        switch ((String) data.get(Param.ANIMATION_TYPE)) {
            case "HmsAlphaAnimation":
                final Object fromAlpha = data.get(Param.FROM_ALPHA);
                final Object toAlpha = data.get(Param.TO_ALPHA);
                animation = new AlphaAnimation(Convert.toFloat(fromAlpha), Convert.toFloat(toAlpha));
                break;
            case "HmsRotateAnimation":
                final Object fromDegree = data.get(Param.FROM_DEGREE);
                final Object toDegree = data.get(Param.TO_DEGREE);
                animation = new RotateAnimation(Convert.toFloat(fromDegree), Convert.toFloat(toDegree));
                break;
            case "HmsScaleAnimation":
                final Object fromX = data.get(Param.FROM_X);
                final Object toX = data.get(Param.TO_X);
                final Object fromY = data.get(Param.FROM_Y);
                final Object toY = data.get(Param.TO_Y);
                animation = new ScaleAnimation(Convert.toFloat(fromX), Convert.toFloat(toX), Convert.toFloat(fromY),
                    Convert.toFloat(toY));
                break;
            case "HmsTranslateAnimation":
                final JSONArray latLng = (JSONArray) data.get(Param.LAT_LNG);
                final LatLng target = new LatLng(Convert.toDouble(latLng.get(0)), Convert.toDouble(latLng.get(1)));
                animation = new TranslateAnimation(target);
                break;
            default:
                break;
        }

        final Object duration = data.get(Param.DURATION);
        if (animation != null) {
            animation.setDuration(Convert.toInt(duration));
        }

        final Object fillMode = data.get(Param.FILL_MODE);
        if (animation != null) {
            animation.setFillMode(Convert.toInt(fillMode));
        }

        final Object repeatCount = data.get(Param.REPEAT_COUNT);
        if (animation != null) {
            animation.setRepeatCount(Convert.toInt(repeatCount));
        }

        final Object repeatMode = data.get(Param.REPEAT_MODE);
        if (animation != null) {
            animation.setRepeatMode(Convert.toInt(repeatMode));
        }

        final Object interpolator = data.get(Param.INTERPOLATOR);
        if (animation != null) {
            animation.setInterpolator(Convert.toInterpolator(Convert.toInt(interpolator)));
        }

        if (animation != null) {
            animation.setAnimationListener(new AnimationListener() {
                @Override
                public void onAnimationStart() {
                    animationChannel.invokeMethod("onAnimationStart", null);
                }

                @Override
                public void onAnimationEnd() {
                    animationChannel.invokeMethod("onAnimationEnd", null);
                }
            });
        }

        return animation;
    }

    public static Interpolator toInterpolator(final int interpolator) {
        switch (interpolator) {
            default:
            case 0:
                return new LinearInterpolator();
            case 1:
                return new AccelerateInterpolator();
            case 2:
                return new AnticipateInterpolator();
            case 3:
                return new BounceInterpolator();
            case 4:
                return new DecelerateInterpolator();
            case 5:
                return new OvershootInterpolator();
            case 6:
                return new AccelerateDecelerateInterpolator();
            case 7:
                return new FastOutLinearInInterpolator();
            case 8:
                return new FastOutSlowInInterpolator();
            case 9:
                return new LinearOutSlowInInterpolator();
        }
    }

    public static void processHuaweiMapOptions(final Object o, final MapMethods call) {
        final Map<?, ?> args = Convert.toMap(o);
        final Object cameraTargetBounds = args.get(Param.CAMERA_TARGET_BOUNDS);
        if (cameraTargetBounds != null) {
            final List<?> targetData = Convert.toList(cameraTargetBounds);
            call.setCameraTargetBounds(toLatLngBounds(targetData.get(0)));
        }

        final Object compassEnabled = args.get(Param.COMPASS_ENABLED);
        if (compassEnabled != null) {
            call.setCompassEnabled(Convert.toBoolean(compassEnabled));
        }

        final Object isDark = args.get(Param.IS_DARK);
        if (isDark != null) {
            call.setDark(Convert.toBoolean(isDark));
        }

        final Object mapToolbarEnabled = args.get(Param.MAP_TOOLBAR_ENABLED);
        if (mapToolbarEnabled != null) {
            call.setMapToolbarEnabled(Convert.toBoolean(mapToolbarEnabled));
        }

        final Object mapType = args.get(Param.MAP_TYPE);
        if (mapType != null) {
            call.setMapType(Convert.toInt(mapType));
        }

        final Object minMaxZoomPreference = args.get(Param.MIN_MAX_ZOOM_PREFERENCE);
        if (minMaxZoomPreference != null) {
            final List<?> zoomPreferenceData = Convert.toList(minMaxZoomPreference);
            call.setMinMaxZoomPreference(Convert.toFloatWrapper(zoomPreferenceData.get(0)),
                Convert.toFloatWrapper(zoomPreferenceData.get(1)));
        }

        final Object padding = args.get(Param.PADDING);
        if (padding != null) {
            final List<?> paddingData = Convert.toList(padding);
            call.setPadding(Convert.toFloat(paddingData.get(0)), Convert.toFloat(paddingData.get(1)),
                Convert.toFloat(paddingData.get(2)), Convert.toFloat(paddingData.get(3)));
        }

        final Object trackCameraPosition = args.get(Param.TRACK_CAMERA_POSITION);
        if (trackCameraPosition != null) {
            call.setTrackCameraPosition(Convert.toBoolean(trackCameraPosition));
        }

        final Object myLocationEnabled = args.get(Param.MY_LOCATION_ENABLED);
        if (myLocationEnabled != null) {
            call.setMyLocationEnabled(Convert.toBoolean(myLocationEnabled));
        }

        final Object zoomControlsEnabled = args.get(Param.ZOOM_CONTROLS_ENABLED);
        if (zoomControlsEnabled != null) {
            call.setZoomControlsEnabled(Convert.toBoolean(zoomControlsEnabled));
        }

        final Object myLocationButtonEnabled = args.get(Param.MY_LOCATION_BUTTON_ENABLED);
        if (myLocationButtonEnabled != null) {
            call.setMyLocationButtonEnabled(Convert.toBoolean(myLocationButtonEnabled));
        }

        final Object trafficEnabled = args.get(Param.TRAFFIC_ENABLED);
        if (trafficEnabled != null) {
            call.setTrafficEnabled(Convert.toBoolean(trafficEnabled));
        }

        final Object markersClusteringEnabled = args.get(Param.MARKERS_CLUSTERING_ENABLED);
        if (markersClusteringEnabled != null) {
            call.setMarkersClustering(Convert.toBoolean(markersClusteringEnabled));
        }

        final Object buildingsEnabled = args.get(Param.BUILDINGS_ENABLED);
        if (buildingsEnabled != null) {
            call.setBuildingsEnabled(Convert.toBoolean(buildingsEnabled));
        }

        final Object allGesturesEnabled = args.get(Param.ALL_GESTURES_ENABLED);
        if (allGesturesEnabled != null) {
            call.setAllGesturesEnabled(Convert.toBoolean(allGesturesEnabled));
        }

        final Object isScrollGesturesEnabledDuringRotateOrZoom = args.get(
            Param.IS_SCROLL_GESTURES_ENABLED_DURING_ROTATE_OR_ZOOM);
        if (isScrollGesturesEnabledDuringRotateOrZoom != null) {
            call.setScrollGesturesEnabledDuringRotateOrZoom(
                Convert.toBoolean(isScrollGesturesEnabledDuringRotateOrZoom));
        }

        final Object gestureScaleByMapCenter = args.get(Param.GESTURE_SCALE_BY_MAP_CENTER);
        if (gestureScaleByMapCenter != null) {
            call.setGestureScaleByMapCenter(Convert.toBoolean(gestureScaleByMapCenter));
        }

        final Object pointToCenter = args.get(Param.POINT_TO_CENTER);
        if (pointToCenter != null) {
            call.setPointToCenter(Convert.toPoint(pointToCenter));
        }

        final Object clusterMarkerColor = args.get(Param.CLUSTER_MARKER_COLOR);
        if (clusterMarkerColor != null) {
            call.setClusterMarkerColor(Convert.toIntegerWrapper(clusterMarkerColor));
        }

        final Object clusterMarkerTextColor = args.get(Param.CLUSTER_MARKER_TEXT_COLOR);
        if (clusterMarkerTextColor != null) {
            call.setClusterMarkerTextColor(Convert.toIntegerWrapper(clusterMarkerTextColor));
        }

        final Object clusterMarkerIcon = args.get(Param.CLUSTER_MARKER_ICON);
        if (clusterMarkerIcon != null) {
            call.setClusterMarkerIcon(Convert.toBitmapDescriptor(clusterMarkerIcon));
        }

        final Object logoPosition = args.get(Param.LOGO_POSITION);
        if (logoPosition != null) {
            call.setLogoPosition(Convert.toInt(logoPosition));
        }

        final Object logoPadding = args.get(Param.LOGO_PADDING);
        if (logoPadding != null) {
            final List<?> paddingData = Convert.toList(logoPadding);
            call.setLogoPadding(Convert.toInt(paddingData.get(1)), Convert.toInt(paddingData.get(0)),
                Convert.toInt(paddingData.get(3)), Convert.toInt(paddingData.get(2)));
        }

        final Object previewId = args.get(Param.PREVIEW_ID);
        if (previewId != null) {
            call.setPreviewId(Convert.toString(previewId));
        }

        final Object styleId = args.get(Param.STYLE_ID);
        if (styleId != null) {
            call.setStyleId(Convert.toString(styleId));
        }

        final Object liteMode = args.get(Param.LITE_MODE);
        if (liteMode != null) {
            call.setLiteMode(Convert.toBoolean(liteMode));
        }

        final Object myLocationStyle = args.get(Param.MYLOCATION_STYLE);
        if (myLocationStyle != null) {
            call.setMyLocationStyle(Convert.toMyLocationStyle(myLocationStyle));
        }

        processHuaweiMapOptionsGestures(args, call);
    }

    private static void processHuaweiMapOptionsGestures(final Map<?, ?> args, final MapMethods call) {
        final Object rotateGesturesEnabled = args.get(Param.ROTATE_GESTURES_ENABLED);
        if (rotateGesturesEnabled != null) {
            call.setRotateGesturesEnabled(Convert.toBoolean(rotateGesturesEnabled));
        }

        final Object scrollGesturesEnabled = args.get(Param.SCROLL_GESTURES_ENABLED);
        if (scrollGesturesEnabled != null) {
            call.setScrollGesturesEnabled(Convert.toBoolean(scrollGesturesEnabled));
        }

        final Object tiltGesturesEnabled = args.get(Param.TILT_GESTURES_ENABLED);
        if (tiltGesturesEnabled != null) {
            call.setTiltGesturesEnabled(Convert.toBoolean(tiltGesturesEnabled));
        }

        final Object zoomGesturesEnabled = args.get(Param.ZOOM_GESTURES_ENABLED);
        if (zoomGesturesEnabled != null) {
            call.setZoomGesturesEnabled(Convert.toBoolean(zoomGesturesEnabled));
        }

    }

    public static String processPolygonOptions(final Object o, final PolygonMethods call) {
        final Map<?, ?> args = Convert.toMap(o);
        final Object clickable = args.get(Param.CLICKABLE);
        if (clickable != null) {
            call.setClickable(Convert.toBoolean(clickable));
        }

        final Object geodesic = args.get(Param.GEODESIC);
        if (geodesic != null) {
            call.setGeodesic(Convert.toBoolean(geodesic));
        }

        final Object visible = args.get(Param.VISIBLE);
        if (visible != null) {
            call.setVisible(Convert.toBoolean(visible));
        }

        final Object fillColor = args.get(Param.FILL_COLOR);
        if (fillColor != null) {
            call.setFillColor(Convert.toInt(fillColor));
        }

        final Object strokeColor = args.get(Param.STROKE_COLOR);
        if (strokeColor != null) {
            call.setStrokeColor(Convert.toInt(strokeColor));
        }

        final Object strokeWidth = args.get(Param.STROKE_WIDTH);
        if (strokeWidth != null) {
            call.setStrokeWidth(Convert.toInt(strokeWidth));
        }

        final Object zIndex = args.get(Param.Z_INDEX);
        if (zIndex != null) {
            call.setZIndex(Convert.toFloat(zIndex));
        }

        final Object points = args.get(Param.POINTS);
        if (points != null) {
            call.setPoints(toPoints(points));
        }

        final Object holes = args.get(Param.HOLES);
        if (holes != null) {
            call.setHoles(toHoles(holes));
        }

        final Object strokeJointType = args.get(Param.STROKE_JOINT_TYPE);
        if (strokeJointType != null) {
            call.setStrokeJointType(Convert.toInt(strokeJointType));
        }

        final Object strokePattern = args.get(Param.STROKE_PATTERN);
        if (strokePattern != null) {
            call.setStrokePattern(toPattern(strokePattern));
        }

        final String polygonId = (String) args.get(Param.POLYGON_ID);
        if (polygonId == null) {
            throw new IllegalArgumentException(Param.ERROR);
        } else {
            return polygonId;
        }
    }

    public static String processPolylineOptions(final Object o, final PolylineMethods call) {
        final Map<?, ?> args = Convert.toMap(o);
        final Object clickable = args.get(Param.CLICKABLE);
        if (clickable != null) {
            call.setClickable(Convert.toBoolean(clickable));
        }

        final Object color = args.get(Param.COLOR);
        if (color != null) {
            call.setColor(Convert.toInt(color));
        }

        final Object endCap = args.get(Param.END_CAP);
        if (endCap != null) {
            call.setEndCap(toCap(endCap));
        }

        final Object geodesic = args.get(Param.GEODESIC);
        if (geodesic != null) {
            call.setGeodesic(Convert.toBoolean(geodesic));
        }

        final Object jointType = args.get(Param.JOINT_TYPE);
        if (jointType != null) {
            call.setJointType(Convert.toInt(jointType));
        }

        final Object startCap = args.get(Param.START_CAP);
        if (startCap != null) {
            call.setStartCap(toCap(startCap));
        }

        final Object visible = args.get(Param.VISIBLE);
        if (visible != null) {
            call.setVisible(Convert.toBoolean(visible));
        }

        final Object width = args.get(Param.WIDTH);
        if (width != null) {
            call.setWidth(Convert.toInt(width));
        }

        final Object zIndex = args.get(Param.Z_INDEX);
        if (zIndex != null) {
            call.setZIndex(Convert.toFloat(zIndex));
        }

        final Object points = args.get(Param.POINTS);
        if (points != null) {
            call.setPoints(toPoints(points));
        }

        final Object pattern = args.get(Param.PATTERN);
        if (pattern != null) {
            call.setPattern(toPattern(pattern));
        }

        final Object gradient = args.get(Param.GRADIENT);
        if (gradient != null) {
            call.setGradient(toBoolean(gradient));
        }

        final Object colorValues = args.get(Param.COLOR_VALUES);
        if (colorValues != null) {
            call.setColorValues(Convert.toIntegerList(colorValues));
        }

        final String polylineId = (String) args.get(Param.POLYLINE_ID);
        if (polylineId == null) {
            throw new IllegalArgumentException(Param.ERROR);
        } else {
            return polylineId;
        }
    }

    public static String processCircleOptions(final Object o, final CircleMethods call,
        final BinaryMessenger messenger) {
        final Map<?, ?> args = Convert.toMap(o);
        final Object clickable = args.get(Param.CLICKABLE);
        if (clickable != null) {
            call.setClickable(Convert.toBoolean(clickable));
        }

        final Object fillColor = args.get(Param.FILL_COLOR);
        if (fillColor != null) {
            call.setFillColor(Convert.toInt(fillColor));
        }

        final Object strokeColor = args.get(Param.STROKE_COLOR);
        if (strokeColor != null) {
            call.setStrokeColor(Convert.toInt(strokeColor));
        }

        final Object visible = args.get(Param.VISIBLE);
        if (visible != null) {
            call.setVisible(Convert.toBoolean(visible));
        }

        final Object strokeWidth = args.get(Param.STROKE_WIDTH);
        if (strokeWidth != null) {
            call.setStrokeWidth(Convert.toInt(strokeWidth));
        }

        final Object zIndex = args.get(Param.Z_INDEX);
        if (zIndex != null) {
            call.setZIndex(Convert.toFloat(zIndex));
        }

        final Object center = args.get(Param.CENTER);
        if (center != null) {
            call.setCenter(toLatLng(center));
        }

        final Object radius = args.get(Param.RADIUS);
        if (radius != null) {
            call.setRadius(Convert.toDouble(radius));
        }

        final Object strokePattern = args.get(Param.STROKE_PATTERN);
        if (strokePattern != null) {
            call.setStrokePattern(Convert.toPattern(strokePattern));
        }

        final Object animation = args.get(Param.ANIMATION);
        if (animation != null) {
            try {
                call.setAnimation(processAnimationOptions(new JSONObject((String) animation), messenger));
            } catch (final JSONException e) {
                Log.e("processCircleOptions", e.getMessage());
            }
        }

        final String circleId = (String) args.get(Param.CIRCLE_ID);
        if (circleId == null) {
            throw new IllegalArgumentException(Param.ERROR);
        } else {
            return circleId;
        }
    }

    public static String processGroundOverlayOptions(final Object o, final GroundOverlayMethods call) {
        final Map<?, ?> data = Convert.toMap(o);

        final Object bearing = data.get(Param.BEARING);
        if (bearing != null) {
            call.setBearing(Convert.toFloat(bearing));
        }

        final Object clickable = data.get(Param.CLICKABLE);
        if (clickable != null) {
            call.setClickable(Convert.toBoolean(clickable));
        }

        final Object image = data.get(Param.IMAGE_DESCRIPTOR);
        if (image != null) {
            call.setImage(Convert.toBitmapDescriptor(image));
        }

        final Object position = data.get(Param.POSITION);
        final Object width = data.get(Param.WIDTH);
        final Object height = data.get(Param.HEIGHT);
        if (position != null) {
            call.setPosition(Convert.toLatLng(position), Convert.toFloat(width), Convert.toFloat(height));
        }

        final Object anchor = data.get(Param.ANCHOR);
        if (anchor != null) {
            final List<?> anchorData = Convert.toList(anchor);
            call.setAnchor(Convert.toFloat(anchorData.get(0)), Convert.toFloat(anchorData.get(1)));
        }

        final Object bounds = data.get(Param.BOUNDS);
        if (bounds != null) {
            call.setPositionFromBounds(Convert.toLatLngBounds(bounds));
        }

        final Object visible = data.get(Param.VISIBLE);
        if (visible != null) {
            call.setVisible(Convert.toBoolean(visible));
        }

        final Object transparency = data.get(Param.TRANSPARENCY);
        if (transparency != null) {
            call.setTransparency(Convert.toFloat(transparency));
        }

        final Object zIndex = data.get(Param.Z_INDEX);
        if (zIndex != null) {
            call.setZIndex(Convert.toFloat(zIndex));
        }

        final String groundOverlayId = (String) data.get(Param.GROUND_OVERLAY_ID);
        if (groundOverlayId == null) {
            throw new IllegalArgumentException(Param.ERROR);
        } else {
            return groundOverlayId;
        }
    }

    public static String processTileOverlayOptions(final Object o, final TileOverlayMethods call) {
        final Map<?, ?> data = Convert.toMap(o);

        final Object tileProvider = data.get(Param.TILE_PROVIDER);
        if (tileProvider != null) {
            try {
                call.setTileProvider(Convert.toTileProvider(tileProvider));
            } catch (final JSONException e) {
                Log.e("Convert", e.getMessage());
            }
        }

        final Object fadeIn = data.get(Param.FADE_IN);
        if (fadeIn != null) {
            call.setFadeIn(Convert.toBoolean(fadeIn));
        }

        final Object transparency = data.get(Param.TRANSPARENCY);
        if (transparency != null) {
            call.setTransparency(Convert.toFloat(transparency));
        }

        final Object visible = data.get(Param.VISIBLE);
        if (visible != null) {
            call.setVisible(Convert.toBoolean(visible));
        }

        final Object zIndex = data.get(Param.Z_INDEX);
        if (zIndex != null) {
            call.setZIndex(Convert.toFloat(zIndex));
        }

        final String tileOverlayId = (String) data.get(Param.TILE_OVERLAY_ID);
        if (tileOverlayId == null) {
            throw new IllegalArgumentException(Param.ERROR);
        } else {
            return tileOverlayId;
        }
    }

    public static String processHeatMapOptions(final Object o, final HeatMapMethods call) {
        final Map<?, ?> data = Convert.toMap(o);

        final Object color = data.get(Param.COLOR);
        if (color != null) {
            call.setColor(Convert.toColorMap(color));
        }

        final Object resourceId = data.get(Param.RESOURCE_ID);
        if (resourceId != null) {
            call.setDataSet(Convert.toInt(resourceId));
            call.setResourceId(Convert.toInt(resourceId));
        }

        final Object jsonData = data.get(Param.JSON_DATA);
        if (jsonData != null) {
            call.setDataSet(Convert.toString(jsonData));
        }

        final Object intensity = data.get(Param.INTENSITY);
        if (intensity != null) {
            call.setIntensity(Convert.toFloat(intensity));
        }

        final Object intensityMap = data.get(Param.INTENSITY_MAP);
        if (intensityMap != null) {
            call.setIntensity(Convert.toFloatMap(intensityMap));
        }

        final Object opacity = data.get(Param.OPACITY);
        if (opacity != null) {
            call.setOpacity(Convert.toFloat(opacity));
        }

        final Object opacityMap = data.get(Param.OPACITY_MAP);
        if (opacityMap != null) {
            call.setOpacity(Convert.toFloatMap(opacityMap));
        }

        final Object radius = data.get(Param.RADIUS);
        if (radius != null) {
            call.setRadius(Convert.toFloat(radius));
        }

        final Object radiusMap = data.get(Param.RADIUS_MAP);
        if (radiusMap != null) {
            call.setRadius(Convert.toFloatMap(radiusMap));
        }

        final Object radiusUnitInt = data.get(Param.RADIUS_UNIT);
        if (radiusUnitInt != null) {
            switch (Convert.toInt(radiusUnitInt)) {
                case 0:
                    call.setRadiusUnit(HeatMapOptions.RadiusUnit.PIXEL);
                    break;
                case 1:
                    call.setRadiusUnit(HeatMapOptions.RadiusUnit.METER);
                    break;
                default:
                    Log.e("processHeatMapOptions", "Invalid RadiusUnit", null);
            }
        }

        final String heatMapId = (String) data.get(Param.HEAT_MAP_ID);
        if (heatMapId == null) {
            throw new IllegalArgumentException(Param.ERROR);
        } else {
            return heatMapId;
        }
    }

    private static List<LatLng> toPoints(final Object o) {
        final List<?> data = Convert.toList(o);
        final List<LatLng> points = new ArrayList<>(data.size());

        for (final Object ob : data) {
            final List<?> point = Convert.toList(ob);
            points.add(new LatLng(Convert.toFloat(point.get(0)), Convert.toFloat(point.get(1))));
        }
        return points;
    }

    private static List<List<LatLng>> toHoles(final Object o) {
        final List<?> data = Convert.toList(o);
        final List<List<LatLng>> holes = new ArrayList<>(data.size());

        for (final Object ob : data) {
            holes.add(toPoints(ob));
        }
        return holes;
    }

    private static List<PatternItem> toPattern(final Object o) {
        final List<?> data = Convert.toList(o);

        if (data.isEmpty()) {
            return null;
        }

        final List<PatternItem> pattern = new ArrayList<>(data.size());

        for (final Object ob : data) {
            final List<?> patternItem = Convert.toList(ob);
            switch (Convert.toString(patternItem.get(0))) {
                case Param.DOT:
                    pattern.add(new Dot());
                    break;
                case Param.DASH:
                    pattern.add(new Dash(Convert.toFloat(patternItem.get(1))));
                    break;
                case Param.GAP:
                    pattern.add(new Gap(Convert.toFloat(patternItem.get(1))));
                    break;
                default:
                    throw new IllegalArgumentException(Param.ERROR);
            }
        }

        return pattern;
    }

    private static Cap toCap(final Object o) {
        final List<?> data = Convert.toList(o);
        switch (Convert.toString(data.get(0))) {
            case Param.BUTT_CAP:
                return new ButtCap();
            case Param.ROUND_CAP:
                return new RoundCap();
            case Param.SQUARE_CAP:
                return new SquareCap();
            case Param.CUSTOM_CAP:
                if (data.size() == 2) {
                    return new CustomCap(toBitmapDescriptor(data.get(1)));
                } else {
                    return new CustomCap(toBitmapDescriptor(data.get(1)), Convert.toFloat(data.get(2)));
                }
            default:
                throw new IllegalArgumentException(Param.ERROR);
        }
    }
}

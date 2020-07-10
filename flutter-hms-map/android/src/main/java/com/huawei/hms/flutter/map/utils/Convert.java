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

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Point;

import com.huawei.hms.flutter.map.circle.CircleMethods;
import com.huawei.hms.flutter.map.constants.Param;
import com.huawei.hms.flutter.map.map.MapMethods;
import com.huawei.hms.flutter.map.marker.MarkerMethods;
import com.huawei.hms.flutter.map.polygon.PolygonMethods;
import com.huawei.hms.flutter.map.polyline.PolylineMethods;
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
import com.huawei.hms.maps.model.LatLng;
import com.huawei.hms.maps.model.LatLngBounds;
import com.huawei.hms.maps.model.PatternItem;
import com.huawei.hms.maps.model.RoundCap;
import com.huawei.hms.maps.model.SquareCap;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import io.flutter.view.FlutterMain;

public class Convert {
    private static List<?> toList(Object o) {
        return (List<?>) o;
    }

    private static Map<?, ?> toMap(Object o) {
        return (Map<?, ?>) o;
    }

    private static String toString(Object o) {
        return (String) o;
    }

    private static double toDouble(Object o) {
        return ((Number) o).doubleValue();
    }

    private static float toFloat(Object o) {
        return ((Number) o).floatValue();
    }

    private static Float toFloatWrapper(Object o) {
        return (o == null) ? null : toFloat(o);
    }

    private static int toInt(Object o) {
        return ((Number) o).intValue();
    }

    private static boolean toBoolean(Object o) {
        return (Boolean) o;
    }


    public static LatLng toLatLng(Object o) {
        final List<?> data = Convert.toList(o);
        return new LatLng(Convert.toDouble(data.get(0)), Convert.toDouble(data.get(1)));
    }

    public static Point toPoint(Object o) {
        Map<String, Integer> screenCoordinate = (Map<String, Integer>) o;
        return new Point(screenCoordinate.get("x"), screenCoordinate.get("y"));
    }


    private static BitmapDescriptor toBitmapDescriptor(Object o) {
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

    private static BitmapDescriptor getBitmapFromBytes(List<?> data) {
        if (data.size() == 2) {
            try {
                Bitmap bitmap = toBitmap(data.get(1));
                return BitmapDescriptorFactory.fromBitmap(bitmap);
            } catch (Exception e) {
                throw new IllegalArgumentException(Param.ERROR);
            }
        } else {
            throw new IllegalArgumentException(Param.ERROR);
        }
    }

    public static CameraPosition toCameraPosition(Object o) {
        final Map<?, ?> args = Convert.toMap(o);
        final CameraPosition.Builder builder = CameraPosition.builder();
        builder.bearing(Convert.toFloat(args.get(Param.BEARING)));
        builder.target(toLatLng(args.get(Param.TARGET)));
        builder.tilt(Convert.toFloat(args.get(Param.TILT)));
        builder.zoom(Convert.toFloat(args.get(Param.ZOOM)));
        return builder.build();
    }

    public static CameraUpdate toCameraUpdate(Object o, float compactness) {
        final List<?> data = Convert.toList(o);
        switch (Convert.toString(data.get(0))) {
            case Param
                    .NEW_CAMERA_POSITION:
                return CameraUpdateFactory.newCameraPosition(toCameraPosition(data.get(1)));
            case Param.NEW_LAT_LNG:
                return CameraUpdateFactory.newLatLng(toLatLng(data.get(1)));
            case Param.NEW_LAT_LNG_BOUNDS:
                return CameraUpdateFactory.newLatLngBounds(
                        toLatLngBounds(data.get(1)), toPixels(data.get(2), compactness));
            case Param.NEW_LAT_LNG_ZOOM:
                return CameraUpdateFactory.newLatLngZoom(toLatLng(data.get(1)), Convert.toFloat(data.get(2)));
            case Param.SCROLL_BY:
                return CameraUpdateFactory.scrollBy(
                        toFinePixels(data.get(1), compactness),
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


    private static LatLngBounds toLatLngBounds(Object o) {
        if (o == null) return null;

        final List<?> data = Convert.toList(o);
        return new LatLngBounds(toLatLng(data.get(0)), toLatLng(data.get(1)));
    }

    private static float toFinePixels(Object o, float compactness) {
        return Convert.toFloat(o) * compactness;
    }

    private static int toPixels(Object o, float compactness) {
        return (int) toFinePixels(o, compactness);
    }

    private static Bitmap toBitmap(Object o) {
        byte[] bmpData = (byte[]) o;
        Bitmap bitmap = BitmapFactory.decodeByteArray(bmpData, 0, bmpData.length);
        if (bitmap == null) {
            throw new IllegalArgumentException(Param.ERROR);
        } else {
            return bitmap;
        }
    }

    private static Point toPoint(Object o, float compactness) {
        final List<?> data = Convert.toList(o);
        return new Point(toPixels(data.get(0), compactness), toPixels(data.get(1), compactness));
    }

    private static void processInfoWindowOptions(
            Map<String, Object> infoWindow, MarkerMethods call) {
        String title = (String) infoWindow.get(Param.TITLE);
        String snippet = (String) infoWindow.get(Param.SNIPPET);

        if (title != null) {
            call.setInfoWindowText(title, snippet);
        }
        Object infoWindowAnchor = infoWindow.get(Param.ANCHOR);
        if (infoWindowAnchor != null) {
            final List<?> anchorData = Convert.toList(infoWindowAnchor);
            call.setInfoWindowAnchor(Convert.toFloat(anchorData.get(0)), Convert.toFloat(anchorData.get(1)));
        }
    }

    @SuppressWarnings("unchecked")
    public static String processMarkerOptions(Object o, MarkerMethods call) {
        final Map<?, ?> data = Convert.toMap(o);
        final Object infoWindow = data.get(Param.INFO_WINDOW);
        if (infoWindow != null) processInfoWindowOptions((Map<String, Object>) infoWindow, call);

        final Object alpha = data.get(Param.ALPHA);
        if (alpha != null) call.setAlpha(Convert.toFloat(alpha));

        final Object anchor = data.get(Param.ANCHOR);
        if (anchor != null) {
            final List<?> anchorData = Convert.toList(anchor);
            call.setAnchor(Convert.toFloat(anchorData.get(0)), Convert.toFloat(anchorData.get(1)));
        }

        final Object clickable = data.get(Param.CLICKABLE);
        if (clickable != null) call.setClickable(Convert.toBoolean(clickable));

        final Object draggable = data.get(Param.DRAGGABLE);
        if (draggable != null) call.setDraggable(Convert.toBoolean(draggable));

        final Object flat = data.get(Param.FLAT);
        if (flat != null) call.setFlat(Convert.toBoolean(flat));

        final Object icon = data.get(Param.ICON);
        if (icon != null) call.setIcon(Convert.toBitmapDescriptor(icon));

        final Object position = data.get(Param.POSITION);
        if (position != null) call.setPosition(Convert.toLatLng(position));

        final Object rotation = data.get(Param.ROTATION);
        if (rotation != null) call.setRotation(Convert.toFloat(rotation));

        final Object visible = data.get(Param.VISIBLE);
        if (visible != null) call.setVisible(Convert.toBoolean(visible));

        final Object zIndex = data.get(Param.Z_INDEX);
        if (zIndex != null) call.setZIndex(Convert.toFloat(zIndex));

        final String markerId = (String) data.get(Param.MARKER_ID);
        if (markerId == null) {
            throw new IllegalArgumentException(Param.ERROR);
        } else {
            return markerId;
        }
    }

    public static void processHuaweiMapOptions(Object o, MapMethods call) {
        final Map<?, ?> args = Convert.toMap(o);
        final Object cameraTargetBounds = args.get(Param.CAMERA_TARGET_BOUNDS);
        if (cameraTargetBounds != null) {
            final List<?> targetData = Convert.toList(cameraTargetBounds);
            call.setCameraTargetBounds(toLatLngBounds(targetData.get(0)));
        }

        final Object compassEnabled = args.get(Param.COMPASS_ENABLED);
        if (compassEnabled != null) call.setCompassEnabled(Convert.toBoolean(compassEnabled));

        final Object mapToolbarEnabled = args.get(Param.MAP_TOOLBAR_ENABLED);
        if (mapToolbarEnabled != null)
            call.setMapToolbarEnabled(Convert.toBoolean(mapToolbarEnabled));

        final Object mapType = args.get(Param.MAP_TYPE);
        if (mapType != null) call.setMapType(Convert.toInt(mapType));

        final Object minMaxZoomPreference = args.get(Param.MIN_MAX_ZOOM_PREFERENCE);
        if (minMaxZoomPreference != null) {
            final List<?> zoomPreferenceData = Convert.toList(minMaxZoomPreference);
            call.setMinMaxZoomPreference(
                    Convert.toFloatWrapper(zoomPreferenceData.get(0)),
                    Convert.toFloatWrapper(zoomPreferenceData.get(1)));
        }

        final Object padding = args.get(Param.PADDING);
        if (padding != null) {
            final List<?> paddingData = Convert.toList(padding);
            call.setPadding(
                    Convert.toFloat(paddingData.get(0)),
                    Convert.toFloat(paddingData.get(1)),
                    Convert.toFloat(paddingData.get(2)),
                    Convert.toFloat(paddingData.get(3)));
        }

        final Object trackCameraPosition = args.get(Param.TRACK_CAMERA_POSITION);
        if (trackCameraPosition != null)
            call.setTrackCameraPosition(Convert.toBoolean(trackCameraPosition));

        final Object myLocationEnabled = args.get(Param.MY_LOCATION_ENABLED);
        if (myLocationEnabled != null)
            call.setMyLocationEnabled(Convert.toBoolean(myLocationEnabled));

        final Object zoomControlsEnabled = args.get(Param.ZOOM_CONTROLS_ENABLED);
        if (zoomControlsEnabled != null)
            call.setZoomControlsEnabled(Convert.toBoolean(zoomControlsEnabled));

        final Object myLocationButtonEnabled = args.get(Param.MY_LOCATION_BUTTON_ENABLED);
        if (myLocationButtonEnabled != null)
            call.setMyLocationButtonEnabled(Convert.toBoolean(myLocationButtonEnabled));

        final Object trafficEnabled = args.get(Param.TRAFFIC_ENABLED);
        if (trafficEnabled != null) call.setTrafficEnabled(Convert.toBoolean(trafficEnabled));

        final Object buildingsEnabled = args.get(Param.BUILDINGS_ENABLED);
        if (buildingsEnabled != null) call.setBuildingsEnabled(Convert.toBoolean(buildingsEnabled));

        processHuaweiMapOptionsGestures(args, call);
    }

    private static void processHuaweiMapOptionsGestures(Map args, MapMethods call) {
        final Object rotateGesturesEnabled = args.get(Param.ROTATE_GESTURES_ENABLED);
        if (rotateGesturesEnabled != null)
            call.setRotateGesturesEnabled(Convert.toBoolean(rotateGesturesEnabled));

        final Object scrollGesturesEnabled = args.get(Param.SCROLL_GESTURES_ENABLED);
        if (scrollGesturesEnabled != null)
            call.setScrollGesturesEnabled(Convert.toBoolean(scrollGesturesEnabled));

        final Object tiltGesturesEnabled = args.get(Param.TILT_GESTURES_ENABLED);
        if (tiltGesturesEnabled != null)
            call.setTiltGesturesEnabled(Convert.toBoolean(tiltGesturesEnabled));

        final Object zoomGesturesEnabled = args.get(Param.ZOOM_GESTURES_ENABLED);
        if (zoomGesturesEnabled != null)
            call.setZoomGesturesEnabled(Convert.toBoolean(zoomGesturesEnabled));

    }

    public static String processPolygonOptions(Object o, PolygonMethods call) {
        final Map<?, ?> args = Convert.toMap(o);
        final Object clickable = args.get(Param.CLICKABLE);
        if (clickable != null) call.setClickable(Convert.toBoolean(clickable));

        final Object geodesic = args.get(Param.GEODESIC);
        if (geodesic != null) call.setGeodesic(Convert.toBoolean(geodesic));

        final Object visible = args.get(Param.VISIBLE);
        if (visible != null) call.setVisible(Convert.toBoolean(visible));

        final Object fillColor = args.get(Param.FILL_COLOR);
        if (fillColor != null) call.setFillColor(Convert.toInt(fillColor));

        final Object strokeColor = args.get(Param.STROKE_COLOR);
        if (strokeColor != null) call.setStrokeColor(Convert.toInt(strokeColor));

        final Object strokeWidth = args.get(Param.STROKE_WIDTH);
        if (strokeWidth != null) call.setStrokeWidth(Convert.toInt(strokeWidth));

        final Object zIndex = args.get(Param.Z_INDEX);
        if (zIndex != null) call.setZIndex(Convert.toFloat(zIndex));

        final Object points = args.get(Param.POINTS);
        if (points != null) call.setPoints(toPoints(points));

        final String polygonId = (String) args.get(Param.POLYGON_ID);
        if (polygonId == null) {
            throw new IllegalArgumentException(Param.ERROR);
        } else {
            return polygonId;
        }
    }

    public static String processPolylineOptions(Object o, PolylineMethods call) {
        final Map<?, ?> args = Convert.toMap(o);
        final Object clickable = args.get(Param.CLICKABLE);
        if (clickable != null) call.setClickable(Convert.toBoolean(clickable));

        final Object color = args.get(Param.COLOR);
        if (color != null) call.setColor(Convert.toInt(color));

        final Object endCap = args.get(Param.END_CAP);
        if (endCap != null) call.setEndCap(toCap(endCap));

        final Object geodesic = args.get(Param.GEODESIC);
        if (geodesic != null) call.setGeodesic(Convert.toBoolean(geodesic));

        final Object jointType = args.get(Param.JOINT_TYPE);
        if (jointType != null) call.setJointType(Convert.toInt(jointType));

        final Object startCap = args.get(Param.START_CAP);
        if (startCap != null) call.setStartCap(toCap(startCap));

        final Object visible = args.get(Param.VISIBLE);
        if (visible != null) call.setVisible(Convert.toBoolean(visible));

        final Object width = args.get(Param.WIDTH);
        if (width != null) call.setWidth(Convert.toInt(width));

        final Object zIndex = args.get(Param.Z_INDEX);
        if (zIndex != null) call.setZIndex(Convert.toFloat(zIndex));

        final Object points = args.get(Param.POINTS);
        if (points != null) call.setPoints(toPoints(points));

        final Object pattern = args.get(Param.PATTERN);
        if (pattern != null) call.setPattern(toPattern(pattern));

        final String polylineId = (String) args.get(Param.POLYLINE_ID);
        if (polylineId == null) {
            throw new IllegalArgumentException(Param.ERROR);
        } else {
            return polylineId;
        }
    }

    public static String processCircleOptions(Object o, CircleMethods call) {
        final Map<?, ?> args = Convert.toMap(o);
        final Object clickable = args.get(Param.CLICKABLE);
        if (clickable != null) call.setClickable(Convert.toBoolean(clickable));

        final Object fillColor = args.get(Param.FILL_COLOR);
        if (fillColor != null) call.setFillColor(Convert.toInt(fillColor));

        final Object strokeColor = args.get(Param.STROKE_COLOR);
        if (strokeColor != null) call.setStrokeColor(Convert.toInt(strokeColor));

        final Object visible = args.get(Param.VISIBLE);
        if (visible != null) call.setVisible(Convert.toBoolean(visible));

        final Object strokeWidth = args.get(Param.STROKE_WIDTH);
        if (strokeWidth != null) call.setStrokeWidth(Convert.toInt(strokeWidth));

        final Object zIndex = args.get(Param.Z_INDEX);
        if (zIndex != null) call.setZIndex(Convert.toFloat(zIndex));

        final Object center = args.get(Param.CENTER);
        if (center != null) call.setCenter(toLatLng(center));

        final Object radius = args.get(Param.RADIUS);
        if (radius != null) call.setRadius(Convert.toDouble(radius));

        final String circleId = (String) args.get(Param.CIRCLE_ID);
        if (circleId == null) {
            throw new IllegalArgumentException(Param.ERROR);
        } else {
            return circleId;
        }
    }

    private static List<LatLng> toPoints(Object o) {
        final List<?> data = Convert.toList(o);
        final List<LatLng> points = new ArrayList<>(data.size());

        for (Object ob : data) {
            final List<?> point = Convert.toList(ob);
            points.add(new LatLng(Convert.toFloat(point.get(0)), Convert.toFloat(point.get(1))));
        }
        return points;
    }

    private static List<PatternItem> toPattern(Object o) {
        final List<?> data = Convert.toList(o);

        if (data.isEmpty()) return null;

        final List<PatternItem> pattern = new ArrayList<>(data.size());

        for (Object ob : data) {
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

    private static Cap toCap(Object o) {
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

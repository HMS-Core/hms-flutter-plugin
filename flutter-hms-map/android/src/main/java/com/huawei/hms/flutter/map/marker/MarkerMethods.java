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

package com.huawei.hms.flutter.map.marker;

import com.huawei.hms.maps.model.BitmapDescriptor;
import com.huawei.hms.maps.model.LatLng;

/**
 * The interface Marker methods.
 *
 * @since v.4.0.4
 */
public interface MarkerMethods {
    /**
     * Sets alpha.
     *
     * @param alpha the alpha
     */
    void setAlpha(float alpha);

    /**
     * Sets anchor.
     *
     * @param u the u
     * @param v the v
     */
    void setAnchor(float u, float v);

    /**
     * Sets clickable.
     *
     * @param isClickable the is clickable
     */
    void setClickable(boolean isClickable);

    /**
     * Sets draggable.
     *
     * @param draggable the draggable
     */
    void setDraggable(boolean draggable);

    /**
     * Sets flat.
     *
     * @param flat the flat
     */
    void setFlat(boolean flat);

    /**
     * Sets icon.
     *
     * @param bitmapDescriptor the bitmap descriptor
     */
    void setIcon(BitmapDescriptor bitmapDescriptor);

    /**
     * Sets info window anchor.
     *
     * @param u the u
     * @param v the v
     */
    void setInfoWindowAnchor(float u, float v);

    /**
     * Sets info window text.
     *
     * @param title   the title
     * @param snippet the snippet
     */
    void setInfoWindowText(String title, String snippet);

    /**
     * Sets position.
     *
     * @param position the position
     */
    void setPosition(LatLng position);

    /**
     * Sets rotation.
     *
     * @param rotation the rotation
     */
    void setRotation(float rotation);

    /**
     * Sets visible.
     *
     * @param visible the visible
     */
    void setVisible(boolean visible);

    /**
     * Sets z index.
     *
     * @param zIndex the z index
     */
    void setZIndex(float zIndex);

    /**
     * Delete.
     */
    void delete();
}

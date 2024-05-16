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

package com.huawei.hms.flutter.map.groundoverlay;

import com.huawei.hms.maps.model.BitmapDescriptor;
import com.huawei.hms.maps.model.LatLng;
import com.huawei.hms.maps.model.LatLngBounds;

/**
 * The interface Ground Overlay methods.
 *
 * @since v.5.3.0
 */
public interface GroundOverlayMethods {

    /**
     * Is clickable boolean.
     *
     * @return the boolean
     */
    boolean isClickable();

    /**
     * Sets bearing.
     *
     * @param bearing the bearing.
     */
    void setBearing(float bearing);

    /**
     * Sets anchor.
     *
     * @param u the u coordinate of the anchor.
     * @param v the v coordinate of the anchor.
     */
    void setAnchor(float u, float v);

    /**
     * Sets clickable.
     *
     * @param isClickable the isClickable.
     */
    void setClickable(boolean isClickable);

    /**
     * Sets image.
     *
     * @param imageDescriptor the image.
     */
    void setImage(BitmapDescriptor imageDescriptor);

    /**
     * Sets position.
     *
     * @param position the position.
     * @param width the width.
     * @param height the height.
     */
    void setPosition(LatLng position, float width, float height);

    /**
     * Sets position from bounds.
     *
     * @param bounds the bounds.
     */
    void setPositionFromBounds(LatLngBounds bounds);

    /**
     * Sets transparency.
     *
     * @param transparency the transparency.
     */
    void setTransparency(float transparency);

    /**
     * Sets visible.
     *
     * @param visible the visible.
     */
    void setVisible(boolean visible);

    /**
     * Sets zIndex.
     *
     * @param zIndex the zIndex.
     */
    void setZIndex(float zIndex);

    /**
     * Delete.
     */
    void delete();
}

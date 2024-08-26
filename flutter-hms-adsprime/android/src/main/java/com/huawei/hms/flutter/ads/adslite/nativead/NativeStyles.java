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

package com.huawei.hms.flutter.ads.adslite.nativead;

import android.graphics.Color;
import android.graphics.Typeface;
import android.view.View;
import android.widget.ImageView;

import com.huawei.hms.flutter.ads.utils.FromMap;
import com.huawei.hms.flutter.ads.utils.ToMap;

import java.util.HashMap;
import java.util.Map;

public class NativeStyles {
    boolean showMediaContent = true;
    ImageView.ScaleType mediaImageScaleType = ImageView.ScaleType.FIT_CENTER;
    Map<String, Object> source = createNativeStyle(14f, Color.BLACK);
    Map<String, Object> flag = createNativeStyle(11f, Color.WHITE, Color.parseColor("#ECC159"));
    Map<String, Object> title = createNativeStyle(15f, Color.BLACK);
    Map<String, Object> description = createNativeStyle(12f, Color.GRAY);
    Map<String, Object> callToAction = createNativeStyle(14f, Color.WHITE, Color.parseColor("#1D9CE7"));
    Map<String, Object> appDownloadButtonNormal = createNativeStyle(12f, Color.WHITE);
    Map<String, Object> appDownloadButtonProcessing = createNativeStyle(12f, Color.WHITE);
    Map<String, Object> appDownloadButtonInstalling = createNativeStyle(12f, Color.WHITE);

    public NativeStyles build(Map<String, Object> args) {
        NativeStyles styles = new NativeStyles();

        Boolean showMedia = FromMap.toBoolean("showMedia", args.get("showMedia"));
        if (args.get("showMedia") != null) {
            this.showMediaContent = showMedia;
        }

        String scaleType = FromMap.toString("mediaImageScaleType", args.get("mediaImageScaleType"));
        if (scaleType != null) {
            mediaImageScaleType = ImageView.ScaleType.valueOf(scaleType);
        }

        Map<String, Object> flagMap = ToMap.fromObject(args.get("flag"));
        if (!flagMap.isEmpty()) {
            buildNativeStyle(styles.flag, flagMap);
        }

        Map<String, Object> sourceMap = ToMap.fromObject(args.get("source"));
        if (!sourceMap.isEmpty()) {
            buildNativeStyle(styles.source, sourceMap);
        }

        Map<String, Object> titleMap = ToMap.fromObject(args.get("title"));
        if (!titleMap.isEmpty()) {
            buildNativeStyle(styles.title, titleMap);
        }

        Map<String, Object> descriptionMap = ToMap.fromObject(args.get("description"));
        if (!descriptionMap.isEmpty()) {
            buildNativeStyle(styles.description, descriptionMap);
        }

        Map<String, Object> callToActionMap = ToMap.fromObject(args.get("callToAction"));
        if (!callToActionMap.isEmpty()) {
            buildNativeStyle(styles.callToAction, callToActionMap);
        }

        Map<String, Object> appDownloadButtonNormalMap = ToMap.fromObject(args.get("appDownloadButtonNormal"));
        if (!appDownloadButtonNormalMap.isEmpty()) {
            buildNativeStyle(styles.appDownloadButtonNormal, appDownloadButtonNormalMap);
        }

        Map<String, Object> appDownloadButtonProcessingMap = ToMap.fromObject(args.get("appDownloadButtonProcessing"));
        if (!appDownloadButtonProcessingMap.isEmpty()) {
            buildNativeStyle(styles.appDownloadButtonProcessing, appDownloadButtonProcessingMap);
        }

        Map<String, Object> appDownloadButtonInstallingMap = ToMap.fromObject(args.get("appDownloadButtonInstalling"));
        if (!appDownloadButtonInstallingMap.isEmpty()) {
            buildNativeStyle(styles.appDownloadButtonInstalling, appDownloadButtonInstallingMap);
        }

        return styles;
    }

    private Map<String, Object> createNativeStyle(float fontSize, int color) {
        Map<String, Object> nativeStyle = new HashMap<>();
        nativeStyle.put(Keys.VISIBILITY, View.VISIBLE);
        nativeStyle.put(Keys.FONT_SIZE, fontSize);
        nativeStyle.put(Keys.FONT_WEIGHT, Typeface.NORMAL);
        nativeStyle.put(Keys.COLOR, color);
        nativeStyle.put(Keys.BACKGROUND_COLOR, 0);

        return nativeStyle;
    }

    private Map<String, Object> createNativeStyle(float fontSize, int color, int backgroundColor) {
        Map<String, Object> nativeStyle = new HashMap<>();
        nativeStyle.put(Keys.VISIBILITY, View.VISIBLE);
        nativeStyle.put(Keys.FONT_SIZE, fontSize);
        nativeStyle.put(Keys.FONT_WEIGHT, Typeface.NORMAL);
        nativeStyle.put(Keys.COLOR, color);
        nativeStyle.put(Keys.BACKGROUND_COLOR, backgroundColor);

        return nativeStyle;
    }

    private void buildNativeStyle(Map<String, Object> nativeStyle, Map<String, Object> args) {
        Double size = FromMap.toDouble("fontSize", args.get("fontSize"));
        if (size != null) {
            nativeStyle.put(Keys.FONT_SIZE, (float) size.doubleValue());
        }

        Integer weight = FromMap.toInteger("fontWeight", args.get("fontWeight"));
        if (weight != null) {
            nativeStyle.put(Keys.FONT_WEIGHT, weight);
        }

        String txtColor = FromMap.toString("color", args.get("color"));
        if (txtColor != null) {
            nativeStyle.put(Keys.COLOR, Color.parseColor(txtColor));
        }

        String bgColor = FromMap.toString("backgroundColor", args.get("backgroundColor"));
        if (bgColor != null) {
            nativeStyle.put(Keys.BACKGROUND_COLOR, Color.parseColor(bgColor));
        }

        if (args.get("isVisible") != null) {
            Boolean isVisible = FromMap.toBoolean("isVisible", args.get("isVisible"));
            nativeStyle.put(Keys.VISIBILITY, isVisible ? View.VISIBLE : View.GONE);
        }
    }

    interface Keys {
        String VISIBILITY = "visibility";
        String FONT_SIZE = "fontSize";
        String FONT_WEIGHT = "fontWeight";
        String COLOR = "color";
        String BACKGROUND_COLOR = "backgroundColor";
    }
}


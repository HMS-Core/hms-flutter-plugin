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

import android.content.Context;

import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.huawei.hms.ads.AppDownloadButton;
import com.huawei.hms.ads.AppDownloadButtonStyle;
import com.huawei.hms.ads.nativead.MediaView;
import com.huawei.hms.ads.nativead.NativeAd;
import com.huawei.hms.ads.nativead.NativeView;
import com.huawei.hms.flutter.ads.R;

import java.util.Map;

public class HmsNativeView extends LinearLayout {

    private NativeView nativeView;
    private MediaView media;
    private TextView flag;
    private TextView title;
    private TextView source;
    private TextView description;
    private Button callToAction;
    private AppDownloadButton appDownloadButton;
    ImageView.ScaleType mediaImageScaleType = ImageView.ScaleType.FIT_CENTER;

    public HmsNativeView(Context context, int layout) {
        super(context);
        inflate(context, layout);
    }

    public NativeView getNativeView() {
        return nativeView;
    }

    private void inflate(Context context, int layout) {
        LayoutInflater inflater = LayoutInflater.from(context);

        inflater.inflate(layout, this, true);
        setBackgroundColor(Color.TRANSPARENT);

        nativeView = findViewById(R.id.view);

        media = nativeView.findViewById(R.id.media);
        nativeView.setMediaView(media);

        flag = nativeView.findViewById(R.id.flag);
        flag.setBackground(new ColorDrawable(Color.parseColor("#ECC159")));

        source = nativeView.findViewById(R.id.source);
        nativeView.setAdSourceView(source);

        title = nativeView.findViewById(R.id.title);
        nativeView.setTitleView(title);

        description = nativeView.findViewById(R.id.description);
        nativeView.setDescriptionView(description);

        callToAction = nativeView.findViewById(R.id.call_to_action);
        nativeView.setCallToActionView(callToAction);

        appDownloadButton = nativeView.findViewById(R.id.app_download_btn);

        nativeView.setIconView(nativeView.findViewById(R.id.icon));
    }

    void setNativeAd(NativeAd nativeAd) {
        if (nativeAd == null) {
            return;
        }

        if (nativeAd.getMediaContent() != null) {
            media.setMediaContent(nativeAd.getMediaContent());
            media.setImageScaleType(mediaImageScaleType);
        }

        if (nativeAd.getAdSource() != null) {
            source.setText(nativeAd.getAdSource());
        }

        if (nativeAd.getTitle() != null) {
            title.setText(nativeAd.getTitle());
        }

        if (nativeView.getIconView() != null) {
            if (nativeAd.getIcon() == null) {
                nativeView.getIconView().setVisibility(View.GONE);
            } else {
                ((ImageView) nativeView.getIconView()).setImageDrawable(nativeAd.getIcon().getDrawable());
                nativeView.getIconView().setVisibility(View.VISIBLE);
            }
        }

        if (nativeAd.getDescription() != null) {
            description.setText(nativeAd.getDescription());
        }

        if (null != nativeAd.getCallToAction()) {
            ((Button) nativeView.getCallToActionView()).setText(nativeAd.getCallToAction());
        }

        nativeView.setNativeAd(nativeAd);
    }

    public void setNativeStyles(Context context, NativeStyles nativeStyles) {
        if (media != null) {
            media.setVisibility(nativeStyles.showMediaContent ? View.VISIBLE : View.GONE);
        }

        if (flag != null) {
            setStyle(flag, nativeStyles.flag);
        }

        if (title != null) {
            setStyle(title, nativeStyles.title);
        }

        if (source != null) {
            setStyle(source, nativeStyles.source);
        }

        if (description != null) {
            setStyle(description, nativeStyles.description);
        }

        if (callToAction != null) {
            setStyle(callToAction, nativeStyles.callToAction);
        }

        if(appDownloadButton != null){
            appDownloadButton.setAppDownloadButtonStyle(new AppDownloadStyle(context,
                    nativeStyles.appDownloadButtonNormal,
                    nativeStyles.appDownloadButtonProcessing,
                    nativeStyles.appDownloadButtonInstalling));
            if (nativeView.register(appDownloadButton)) {
                appDownloadButton.setVisibility(View.VISIBLE);
                appDownloadButton.refreshAppStatus();
                nativeView.getCallToActionView().setVisibility(View.GONE);
            } else {
                appDownloadButton.setVisibility(View.GONE);
                nativeView.getCallToActionView().setVisibility(View.VISIBLE);
            }
        }

        mediaImageScaleType = nativeStyles.mediaImageScaleType;
    }

    private void setStyle(TextView textView, Map<String, Object> nativeStyle) {
        textView.setTextColor((int) nativeStyle.get(NativeStyles.Keys.COLOR));
        textView.setTextSize((float) nativeStyle.get(NativeStyles.Keys.FONT_SIZE));
        textView.setTypeface(null, (int) nativeStyle.get(NativeStyles.Keys.FONT_WEIGHT));
        textView.setVisibility((int) nativeStyle.get(NativeStyles.Keys.VISIBILITY));
        int bgColor = (int) nativeStyle.get(NativeStyles.Keys.BACKGROUND_COLOR);
        if (bgColor != 0) {
            textView.setBackground(new ColorDrawable(bgColor));
        }
    }

    public void showAdvertiserInfoDialog(){
        nativeView.showAdvertiserInfoDialog(nativeView, true);
    }

    public void hideAdvertiserInfoDialog(){
        nativeView.hideAdvertiserInfoDialog();
    }

    private static class AppDownloadStyle extends AppDownloadButtonStyle {
        final Map<String, Object> normalStyleMap;
        final Map<String, Object> processingStyleMap;
        final Map<String, Object> installingStyleMap;

        public AppDownloadStyle(Context context, Map<String, Object> normalStyleMap, Map<String, Object> processingStyleMap, Map<String, Object> installingStyleMap) {
            super(context);
            this.normalStyleMap = normalStyleMap;
            this.processingStyleMap = processingStyleMap;
            this.installingStyleMap = installingStyleMap;

            normalStyle.setTextColor((int) this.normalStyleMap.get(NativeStyles.Keys.COLOR));
            normalStyle.setTextSize(Math.round((float) this.normalStyleMap.get(NativeStyles.Keys.FONT_SIZE)));
            int bgColor = (int) this.normalStyleMap.get(NativeStyles.Keys.BACKGROUND_COLOR);
            if (bgColor != 0) {
                normalStyle.setBackground(new ColorDrawable(bgColor));
            }

            processingStyle.setTextColor((int) this.processingStyleMap.get(NativeStyles.Keys.COLOR));
            processingStyle.setTextSize(Math.round((float) this.processingStyleMap.get(NativeStyles.Keys.FONT_SIZE)));
            int bgColorP = (int) this.processingStyleMap.get(NativeStyles.Keys.BACKGROUND_COLOR);
            if (bgColorP != 0) {
                processingStyle.setBackground(new ColorDrawable(bgColorP));
            }

            installingStyle.setTextColor((int) this.installingStyleMap.get(NativeStyles.Keys.COLOR));
            installingStyle.setTextSize(Math.round((float) this.installingStyleMap.get(NativeStyles.Keys.FONT_SIZE)));
            int bgColorI = (int) this.installingStyleMap.get(NativeStyles.Keys.BACKGROUND_COLOR);
            if (bgColorI != 0) {
                installingStyle.setBackground(new ColorDrawable(bgColorI));
            }
        }
    }
}

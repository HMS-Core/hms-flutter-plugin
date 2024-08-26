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
import android.view.View;

import com.huawei.hms.flutter.ads.R;
import com.huawei.hms.flutter.ads.utils.FromMap;
import com.huawei.hms.flutter.ads.utils.ToMap;

import java.util.Map;

import io.flutter.plugin.platform.PlatformView;

public class NativeAdPlatformView implements PlatformView {
    enum AdType {
        banner, small, full, video, app_download
    }

    private NativeAdController nativeAdController;
    private HmsNativeView hmsNativeView;

    NativeAdPlatformView(Context context, Object args) {
        Map<String, Object> params = ToMap.fromObject(args);
        if (params.isEmpty()) {
            return;
        }
        String type = FromMap.toString("type", params.get("type"));
        Integer layout = null;
        if (type != null) {
            switch (AdType.valueOf(type)) {
                case banner:
                    layout = R.layout.native_ad_banner_template;
                    break;
                case small:
                    layout = R.layout.native_ad_small_template;
                    break;
                case full:
                    layout = R.layout.native_ad_full_template;
                    break;
                case video:
                    layout = R.layout.native_ad_video_template;
                    break;
                case app_download:
                    layout = R.layout.native_ad_app_download_template;
            }
        }

        hmsNativeView = new HmsNativeView(context, layout != null ? layout : R.layout.native_ad_banner_template);
        Integer id = FromMap.toInteger("id", params.get("id"));
        if (id != null) {
            NativeAdController controller = NativeAdControllerFactory.get(id);
            if (controller == null) {
                return;
            }
            controller.setNativeView(hmsNativeView);
            this.nativeAdController = controller;
        }
        if (nativeAdController != null && nativeAdController.getNativeAd() != null) {
            hmsNativeView.setNativeAd(nativeAdController.getNativeAd());
        }
        Map<String, Object> stylesMap = ToMap.fromObject(params.get("nativeStyles"));
        if (!stylesMap.isEmpty()) {
            hmsNativeView.setNativeStyles(context, new NativeStyles().build(stylesMap));
        }
    }

    @Override
    public View getView() {
        return hmsNativeView;
    }

    @Override
    public void dispose() {
        if (hmsNativeView != null) {
            if (hmsNativeView.getNativeView() != null) {
                hmsNativeView.getNativeView().destroy();
            }
        }
    }
}
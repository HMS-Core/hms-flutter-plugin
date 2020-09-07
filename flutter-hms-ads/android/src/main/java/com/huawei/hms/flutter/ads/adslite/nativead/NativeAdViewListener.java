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
package com.huawei.hms.flutter.ads.adslite.nativead;

interface NativeAdViewListener {
    /**
     * Callback method that receives the nativeAdView as an argument when a controller is set for that native ad.
     *
     * @param hmsNativeView : The NativeAdView that which has its controller set
     */
    void onNativeControllerSet(HmsNativeView hmsNativeView);

    /**
     * Callback method that is called when a Native Platform View is disposed
     */
    void onNativeViewDestroyed();
}

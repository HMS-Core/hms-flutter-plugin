/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.scan.multiprocessor;

class ScanTextOptions {
    private long textColor;

    private float textSize;

    private boolean showText;

    private boolean showTextOutBounds;

    private long textBackgroundColor;

    private boolean autoSizeText;

    private int minTextSize;

    private int granularity;

    ScanTextOptions() {
        textColor = 4278190080L;
        textSize = 35.0F;
        showText = true;
        showTextOutBounds = false;
        textBackgroundColor = 0;
        autoSizeText = false;
        minTextSize = 24;
        granularity = 2;
    }

    float getTextSize() {
        return textSize;
    }

    int getMinTextSize() {
        return minTextSize;
    }

    int getGranularity() {
        return granularity;
    }

    int getTextBackgroundColor() {
        return (int) textBackgroundColor;
    }

    int getTextColor() {
        return (int) textColor;
    }

    boolean getShowText() {
        return showText;
    }

    boolean getShowTextOutBounds() {
        return showTextOutBounds;
    }

    boolean getAutoSizeText() {
        return autoSizeText;
    }

}

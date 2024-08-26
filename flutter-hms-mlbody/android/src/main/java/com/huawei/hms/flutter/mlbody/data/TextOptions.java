/*
 * Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.mlbody.data;

public class TextOptions {
    private long textColor;

    private float textSize;

    private boolean autoSizeText;

    private int minTextSize;

    private int maxTextSize;

    private int granularity;

    public TextOptions() {
        textColor = 4278190080L;
        textSize = 35.0F;
        autoSizeText = false;
        minTextSize = 18;
        granularity = 2;
        maxTextSize = 34;
    }

    public float getTextSize() {
        return textSize;
    }

    public int getMinTextSize() {
        return minTextSize;
    }

    public int getMaxTextSize() {
        return maxTextSize;
    }

    public int getGranularity() {
        return granularity;
    }

    public int getTextColor() {
        return (int) textColor;
    }

    public boolean getAutoSizeText() {
        return autoSizeText;
    }

}

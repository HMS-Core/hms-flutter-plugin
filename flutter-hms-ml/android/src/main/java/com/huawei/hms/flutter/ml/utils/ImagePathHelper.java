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

package com.huawei.hms.flutter.ml.utils;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;

import java.io.ByteArrayOutputStream;

public class ImagePathHelper {
    public static String pathToBase64(String path) {
        Bitmap bt = BitmapFactory.decodeFile(path);
        ByteArrayOutputStream bs = new ByteArrayOutputStream();
        bt.compress(Bitmap.CompressFormat.JPEG, 100, bs);
        byte[] by = bs.toByteArray();
        return Base64.encodeToString(by, Base64.DEFAULT);
    }
}

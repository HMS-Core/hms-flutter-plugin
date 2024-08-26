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

package com.huawei.hms.flutter.mltext.customview;

import android.content.Context;
import android.content.res.Configuration;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;

import com.huawei.hms.mlplugin.card.bcr.R;

public class ViewfinderView extends View {
    private static final String TAG = ViewfinderView.class.getSimpleName();
    private final Paint paint;
    private Rect frameRect;
    private Context context;
    private boolean isLandscape;

    /**
     * Constructor
     *
     * @param context Activity
     */
    public ViewfinderView(Context context, Rect frameRect) {
        super(context);
        this.context = context;
        this.frameRect = frameRect;
        this.isLandscape = isLandscape(context);
        this.paint = new Paint(Paint.ANTI_ALIAS_FLAG);
    }

    /**
     * According to the context to determine whether the current horizontal screen
     *
     * @param context context
     * @return true：Landscape；false：Portrait
     */
    public static boolean isLandscape(Context context) {
        int orientation = context.getResources().getConfiguration().orientation;
        return orientation == Configuration.ORIENTATION_LANDSCAPE;
    }

    @Override
    public void onDraw(Canvas canvas) {
        Log.i(TAG, "onDraw frameRect = " + frameRect);
        // Scanning border drawing
        // You can also draw other such as scan lines, masks, and draw prompts and other buttons according to your needs
        drawBoarderFrame(canvas, frameRect);
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        return false;
    }

    private void drawBoarderFrame(Canvas canvas, Rect frame) {
        final int lindDrawWidth = context.getResources().getDimensionPixelSize(R.dimen.mlkit_bcr_line_draw_width);
        int lineWidth = isLandscape ? lindDrawWidth : lindDrawWidth >> 1;
        int roundWidth = (frame.right - frame.left) / 12;

        canvas.save();
        canvas.drawRect((float) frame.left, (float) frame.top, (float) (frame.left + roundWidth + 1),
                (float) (frame.top + lineWidth + 1), this.paint);
        canvas.drawRect((float) frame.left, (float) frame.top, (float) (frame.left + lineWidth + 1),
                (float) (frame.top + roundWidth + 1), this.paint);
        canvas.drawRect((float) (frame.right - roundWidth), (float) frame.top, (float) (frame.right + 1),
                (float) (frame.top + lineWidth + 1), this.paint);
        canvas.drawRect((float) (frame.right - lineWidth), (float) frame.top, (float) (frame.right + 1),
                (float) (frame.top + roundWidth + 1), this.paint);

        canvas.drawRect((float) frame.left, (float) (frame.bottom - lineWidth), (float) (frame.left + roundWidth + 1),
                (float) (frame.bottom + 1), this.paint);
        canvas.drawRect((float) frame.left, (float) (frame.bottom - roundWidth), (float) (frame.left + lineWidth + 1),
                (float) (frame.bottom + 1), this.paint);
        canvas.drawRect((float) (frame.right - roundWidth), (float) (frame.bottom - lineWidth),
                (float) (frame.right + 1), (float) (frame.bottom + 1), this.paint);
        canvas.drawRect((float) (frame.right - lineWidth), (float) (frame.bottom - roundWidth),
                (float) (frame.right + 1), (float) (frame.bottom + 1), this.paint);
        canvas.restore();
    }
}

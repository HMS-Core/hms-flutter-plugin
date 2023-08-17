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

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.RectF;
import android.text.Layout;
import android.text.StaticLayout;
import android.text.TextPaint;
import android.util.AttributeSet;
import android.view.View;

import androidx.annotation.Nullable;

import com.huawei.hms.ml.scan.HmsScan;

import java.util.ArrayList;
import java.util.List;

public class ScanResultView extends View {

    private final Object lock = new Object();

    private final List<HmsScanGraphic> hmsScanGraphics = new ArrayList<>();

    public boolean showText;

    protected float widthScaleFactor = 1.0f;

    protected float heightScaleFactor = 1.0f;

    protected float previewWidth;

    protected float previewHeight;

    public ScanResultView(Context context) {
        super(context);
    }

    public ScanResultView(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
    }

    public void clear() {
        synchronized (lock) {
            hmsScanGraphics.clear();
        }
        postInvalidate();
    }

    public void add(HmsScanGraphic graphic) {
        synchronized (lock) {
            hmsScanGraphics.add(graphic);
        }
    }

    public void setCameraInfo(int previewWidth, int previewHeight) {
        synchronized (lock) {
            this.previewWidth = previewWidth;
            this.previewHeight = previewHeight;
        }
        postInvalidate();
    }

    /**
     * Draw MultiCodes on screen.
     *
     * @param canvas canvas
     */
    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        synchronized (lock) {
            if ((previewWidth != 0) && (previewHeight != 0)) {
                widthScaleFactor = (float) getWidth() / previewWidth;
                heightScaleFactor = (float) getHeight() / previewHeight;
            }
            for (HmsScanGraphic graphic : hmsScanGraphics) {
                graphic.drawGraphic(canvas);
                if (showText) {
                    graphic.drawText(canvas);
                }
            }
        }
    }

    static class HmsScanGraphic {

        private final Paint rectPaint;

        private final HmsScan hmsScan;

        // Options from Flutter.
        private final int textColor;

        private final float textSize;

        private final int textBackgroundColor;

        private final boolean showTextOutBounds;

        private final boolean autoSizeText;

        private final int minTextSize;

        private final int granularity;

        private ScanResultView scanResultView;

        HmsScanGraphic(ScanResultView scanResultView, HmsScan hmsScan, int color, int textColor, float textSize,
            float strokeWidth, int textBackgroundColor, boolean mShowText, boolean showTextOutBounds,
            boolean autoSizeText, int minTextSize, int granularity) {
            this.scanResultView = scanResultView;
            this.hmsScan = hmsScan;
            this.textColor = textColor;
            this.textSize = textSize;
            this.textBackgroundColor = textBackgroundColor;
            this.showTextOutBounds = showTextOutBounds;
            this.autoSizeText = autoSizeText;
            this.minTextSize = minTextSize;
            this.granularity = granularity;

            scanResultView.showText = mShowText;

            rectPaint = new Paint();
            rectPaint.setColor(color);
            rectPaint.setStyle(Paint.Style.STROKE);
            rectPaint.setStrokeWidth(strokeWidth);

            Paint hmsScanResult = new Paint();
            hmsScanResult.setColor(this.textColor);
            hmsScanResult.setTextSize(this.textSize);
        }

        void drawGraphic(Canvas canvas) {
            if (hmsScan == null) {
                return;
            }

            // rect - for hms results
            // other - for colorful rectangle on canvas
            RectF rect = new RectF(hmsScan.getBorderRect());
            RectF other = new RectF();
            other.left = canvas.getWidth() - scaleX(rect.top);
            other.top = scaleY(rect.left);
            other.right = canvas.getWidth() - scaleX(rect.bottom);
            other.bottom = scaleY(rect.right);
            canvas.drawRect(other, rectPaint);
        }

        /**
         * getTextHeight
         *
         * @param text text
         * @param paint paint
         * @return text height
         */
        private float getTextHeight(String text, Paint paint) {
            Rect rect = new Rect();
            paint.getTextBounds(text, 0, text.length(), rect);
            return rect.height();
        }

        /**
         * getTextHeightInRect
         *
         * @param text text
         * @param width width
         * @param fontSize fontSize
         * @return text height in static layout a.k.a rectangle
         * it is used to get height of the text in borders.
         */
        private int getTextHeightInRect(String text, int width, float fontSize) {
            TextPaint tp = new TextPaint();
            tp.setTextSize(fontSize);
            int textHeight = (int) getTextHeight(text, tp);
            StaticLayout innerStaticLayout = new StaticLayout(text, tp, width, Layout.Alignment.ALIGN_CENTER, 1, 0,
                false);
            int numberOfTextLines = innerStaticLayout.getLineCount();
            return (textHeight * (numberOfTextLines + 2));
        }

        /**
         * getOptimalTextSize
         *
         * @param text text
         * @param width width
         * @param height height
         * @return optimal text size a.k.a Auto Size Text
         */
        private int getOptimalTextSize(String text, int width, int height) {
            int targetTextSize = (int) textSize;
            while (getTextHeightInRect(text, width, targetTextSize) >= height && targetTextSize > minTextSize) {
                targetTextSize = Math.max(targetTextSize - granularity, minTextSize);
            }
            return targetTextSize;
        }

        // Draw text on rectangle
        void drawText(Canvas canvas) {
            // rect for hms scan object.
            // other for rectangle drawing.
            RectF rect = new RectF(hmsScan.getBorderRect());
            RectF other = new RectF();
            other.left = canvas.getWidth() - scaleX(rect.top);
            other.top = scaleY(rect.left);
            other.right = canvas.getWidth() - scaleX(rect.bottom);
            other.bottom = scaleY(rect.right);

            int width = (int) other.width() * -1;
            int height = (int) other.height();

            // bitmap for text background.
            Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
            Canvas canvas2 = new Canvas(bitmap);
            Paint p2 = new Paint();
            p2.setStyle(Paint.Style.FILL);
            p2.setColor(textBackgroundColor);
            canvas2.drawRect(0, 0, width, height, p2);

            canvas.drawBitmap(bitmap, other.right, other.top, null);

            // hms scan text value.
            String text = hmsScan.getOriginalValue();

            // Text options from Flutter.
            TextPaint tp = new TextPaint();
            tp.setColor(textColor);
            tp.setTextSize(autoSizeText && !showTextOutBounds ? getOptimalTextSize(text, width, height) : textSize);
            tp.setAntiAlias(true);

            float textHeight = getTextHeight(text, tp);

            // static layout for drawing text.
            StaticLayout staticLayout = new StaticLayout(text, tp, width, Layout.Alignment.ALIGN_CENTER, 1, 0, false);
            canvas2.save();
            canvas.save();

            int numberOfTextLines = staticLayout.getLineCount();

            float textYCoordinate = (showTextOutBounds ? other.centerY() : (bitmap.getHeight() / 2.0f))
                - (numberOfTextLines * textHeight) / 2;

            float textXCoordinate = other.right;

            // For positioning text according to rectangles.
            canvas.translate(textXCoordinate, textYCoordinate);
            canvas2.translate(0, (numberOfTextLines * textHeight) >= bitmap.getHeight() ? 0 : textYCoordinate);

            // drawing text.
            staticLayout.draw(showTextOutBounds ? canvas : canvas2);
            canvas.restore();
            canvas2.restore();
        }

        float scaleX(float horizontal) {
            return horizontal * scanResultView.widthScaleFactor;
        }

        float scaleY(float vertical) {
            return vertical * scanResultView.heightScaleFactor;
        }

    }
}

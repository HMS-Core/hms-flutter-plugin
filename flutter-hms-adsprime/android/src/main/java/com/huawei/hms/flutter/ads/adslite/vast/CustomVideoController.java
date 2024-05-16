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

package com.huawei.hms.flutter.ads.adslite.vast;

import android.app.Activity;
import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.CheckBox;

import com.huawei.hms.ads.vast.player.api.VastPlayerListener;
import com.huawei.hms.ads.vast.player.base.BaseVideoController;
import com.huawei.hms.ads.vast.player.misc.utils.AudioUtil;

public class CustomVideoController extends BaseVideoController {
    private ViewGroup clContent;
    private CheckBox btnMute;
    private Button btnDetailView;
    private Button btnScreen;
    private Button btnPlay;
    private Context context;

    public CustomVideoController(Context context, VastPlayerListener vastPlayerListener) {
        super(context);
        this.context = context;
        initViews();
        btnMute.setChecked(isMute());
        btnMute.setOnCheckedChangeListener((button, checked) -> toggleMuteState(checked));

        setPlayerListener(vastPlayerListener);
    }

    private void initViews() {
        clContent = (ViewGroup) handleResources("cl_content");
        btnDetailView = (Button) handleResources("demo_bt_detail");
        btnScreen = (Button) handleResources("demo_bt_full_screen");
        btnPlay = (Button) handleResources("demo_bt_play");
        btnMute = (CheckBox) handleResources("demo_bt_voice");

        btnScreen.setOnClickListener(v -> toggleScreen((Activity) context));
        btnDetailView.setOnClickListener(v -> launchAdDetailView((Activity) context));
        btnPlay.setOnClickListener(v -> startOrPause());
        clContent.setOnClickListener(v -> launchAdDetailView((Activity) context));
    }

    private View handleResources(String resourceName) {
        return findViewById(context.getResources().getIdentifier(resourceName, "id", context.getPackageName()));
    }

    @Override
    public int getLayoutId() {
        return getContext().getResources().getIdentifier("vast_video_player_template", "layout", getContext().getPackageName());
    }

    @Override
    public boolean isMute() {
        if (mIsForceMute) {
            return btnMute.isChecked();
        } else {
            return AudioUtil.isSystemVolumeZero(mActivity);
        }
    }
}

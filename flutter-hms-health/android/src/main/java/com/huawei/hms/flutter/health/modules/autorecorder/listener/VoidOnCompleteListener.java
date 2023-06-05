/*
 * Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.health.modules.autorecorder.listener;

import com.huawei.hmf.tasks.OnCompleteListener;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.health.foundation.listener.VoidResultListener;

public interface VoidOnCompleteListener extends VoidResultListener {
    /**
     * the {@link OnCompleteListener} interface won't always success, if u use the onComplete interface, u should add
     * the judgement of result is successful or not.
     * <p>
     * Handling of callback exceptions needs to be added for the case that the calling fails due to the app not being
     * authorized or type not being supported. the fail reason includes: 1. The app hasn't been granted the scopes. 2.
     * This type is not supported so far.
     *
     * @param taskResult Task<Void> result.
     */
    void onComplete(Task<Void> taskResult);
}

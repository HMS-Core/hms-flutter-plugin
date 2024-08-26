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

import com.huawei.hms.mlsdk.face.MLFaceAnalyzerSetting;
import com.huawei.hms.mlsdk.face.face3d.ML3DFaceAnalyzerSetting;
import com.huawei.hms.mlsdk.handkeypoint.MLHandKeypointAnalyzerSetting;

import io.flutter.plugin.common.MethodCall;

public class RequestBuilder {
    public static MLFaceAnalyzerSetting createFaceAnalyzerSetting(MethodCall call) {
        Integer keyPointType = call.argument("keyPointType");
        Integer featureType = call.argument("featureType");
        Integer shapeType = call.argument("shapeType");
        Integer performanceType = call.argument("performanceType");
        Integer tracingMode = call.argument("tracingMode");
        Boolean tracingAllowed = call.argument("tracingAllowed");
        Boolean poseDisabled = call.argument("poseDisabled");
        Boolean maxSizeFaceOnly = call.argument("maxSizeFaceOnly");
        Double minFaceProportion = call.argument("minFaceProportion");

        return new MLFaceAnalyzerSetting.Factory()
                .setKeyPointType(keyPointType == null ? 1 : keyPointType)
                .setFeatureType(featureType == null ? 1 : featureType)
                .setShapeType(shapeType == null ? 2 : shapeType)
                .setTracingAllowed(tracingAllowed == null ? false : tracingAllowed, tracingMode == null ? 2 : 1)
                .setPoseDisabled(poseDisabled == null ? false : poseDisabled)
                .setPerformanceType(performanceType == null ? 1 : performanceType)
                .setMaxSizeFaceOnly(maxSizeFaceOnly == null ? true : maxSizeFaceOnly)
                .setMinFaceProportion(minFaceProportion == null ? 0.5f : minFaceProportion.floatValue())
                .create();
    }

    public static ML3DFaceAnalyzerSetting create3DAnalyzeSetting(MethodCall call) {
        Integer performanceType = call.argument("performanceType");
        Boolean tracingAllowed = call.argument("tracingAllowed");

        return new ML3DFaceAnalyzerSetting.Factory()
                .setPerformanceType(performanceType != null ? performanceType : 1)
                .setTracingAllowed(tracingAllowed != null ? tracingAllowed : false)
                .create();
    }

    public static MLHandKeypointAnalyzerSetting createHandAnalyzerSetting(MethodCall call) {
        Integer sceneType = call.argument("sceneType");
        Integer maxHandResults = call.argument("maxHandResults");

        return new MLHandKeypointAnalyzerSetting.Factory()
                .setMaxHandResults(maxHandResults != null ? maxHandResults : 10)
                .setSceneType(sceneType != null ? sceneType : 0)
                .create();
    }
}

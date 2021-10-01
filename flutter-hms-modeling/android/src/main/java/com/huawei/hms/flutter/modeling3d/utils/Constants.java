/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.modeling3d.utils;

public final class Constants {
    public static final String ERROR_CODE = "-1";

    public static final String TASK_ID = "taskId";

    private static final String NOT_IMPLEMENTED_ERROR = "No Implementation found for method: ";

    private Constants() {
    }

    public static final class Channels {

        private Channels() {
        }

        public static final String MODELING3D_RECONSTRUCT_ENGINE_CHANNEL
            = "com.huawei.modelling3d.reconstructengine/method";

        public static final String MODELING3D_TASK_UTILS_CHANNEL = "com.huawei.modelling3d.taskutils/method";

        public static final String RECONSTRUCT_APP_CHANNEL = "com.huawei.modelling3d.reconstructapplication/method";

        public static final String PERMISSION_CHANNEL = "com.huawei.modelling3d.permission/method";
    }

    public enum Modeling3DEngineMethods {
        GET_INSTANCE("getInstance"),
        INIT_TASK("initTask"),
        CLOSE("close"),
        UPLOAD_FILE("uploadFile"),
        CANCEL_UPLOAD("cancelUpload"),
        DOWNLOAD_MODEL("downloadModel"),
        CANCEL_DOWNLOAD("cancelDownload"),
        PREVIEW_MODEL("previewModel"),
        SET_RECONSTRUCT_UPLOAD_LISTENER("setReconstructUploadListener"),
        SET_RECONSTRUCT_DOWNLOAD_LISTENER("setReconstructDownloadListener");

        private final String methodName;

        Modeling3DEngineMethods(String methodName) {
            this.methodName = methodName;
        }

        public String getMethodName() {
            return methodName;
        }

        public static Modeling3DEngineMethods getEnum(String methodName) {
            for (Modeling3DEngineMethods taskUtilsMethod : Modeling3DEngineMethods.values()) {
                if (taskUtilsMethod.methodName.equals(methodName)) {
                    return taskUtilsMethod;
                }
            }
            throw new IllegalArgumentException(NOT_IMPLEMENTED_ERROR + methodName);
        }
    }

    public enum TaskUtilsMethods {
        GET_INSTANCE("getInstance"),
        QUERY_TASK("queryTask"),
        DELETE_TASK("deleteTask"),
        SET_TASK_RESTRICT_STATUS("setTaskRestrictStatus"),
        QUERY_TASK_RESTRICT_STATUS("queryTaskRestrictStatus");

        private final String methodName;

        TaskUtilsMethods(String methodName) {
            this.methodName = methodName;
        }

        public String getMethodName() {
            return methodName;
        }

        public static TaskUtilsMethods getEnum(String methodName) {
            for (TaskUtilsMethods taskUtilsMethod : TaskUtilsMethods.values()) {
                if (taskUtilsMethod.methodName.equals(methodName)) {
                    return taskUtilsMethod;
                }
            }
            throw new IllegalArgumentException(NOT_IMPLEMENTED_ERROR + methodName);
        }
    }

    public enum ReconstructAppMethods {
        GET_INSTANCE("getInstance"),
        SET_API_KEY("setApiKey"),
        SET_ACCESS_TOKEN("setAccessToken");

        private final String methodName;

        ReconstructAppMethods(String methodName) {
            this.methodName = methodName;
        }

        public String getMethodName() {
            return methodName;
        }

        public static ReconstructAppMethods getEnum(String methodName) {
            for (ReconstructAppMethods taskUtilsMethod : ReconstructAppMethods.values()) {
                if (taskUtilsMethod.methodName.equals(methodName)) {
                    return taskUtilsMethod;
                }
            }
            throw new IllegalArgumentException(NOT_IMPLEMENTED_ERROR + methodName);
        }
    }
}

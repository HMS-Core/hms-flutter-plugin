/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.drive.common;

import com.huawei.hms.flutter.drive.common.methodenum.EnumGetter;
import com.huawei.hms.flutter.drive.common.methodenum.MethodEnum;

public final class Constants {
    private Constants() {
    }

    public static final String UNKNOWN_ERROR = "-1";
    public static final String TAG = "HMSDriveKit";

    public static final class Channel {
        private Channel() {
        }

        public static final String DRIVE_METHOD_CHANNEL = "com.huawei.hms.flutter.drive";
        public static final String PERMISSION_METHOD_CHANNEL = "com.huawei.hms.flutter.drive.permissions";
        public static final String PROGRESS_CHANNEL = "com.huawei.hms.flutter.drive.progress";
        public static final String BATCH_CHANNEL = "com.huawei.hms.flutter.drive.batch";
    }

    public enum ModuleNames implements MethodEnum {
        ABOUT("About"),
        CHANGES("Changes"),
        DRIVE("Drive"),
        FILES("Files"),
        CHANNELS("Channels"),
        REPLIES("Replies"),
        COMMENTS("Comments"),
        HISTORY_VERSIONS("HistoryVersions"),
        BATCH("Batch"),
        LOGGER("Logger");

        private final String value;
        private static EnumGetter<ModuleNames> enumGetter = new EnumGetter<>(ModuleNames.values());

        ModuleNames(final String value) {
            this.value = value;
        }

        @Override
        public String getValue() {
            return value;
        }

        public static ModuleNames getEnum(final String value) {
            return enumGetter.getEnum(value);
        }
    }

    public enum BatchMethods implements MethodEnum {
        BATCH_EXECUTE("Execute");

        private String value;
        private static EnumGetter<BatchMethods> enumGetter = new EnumGetter<>(BatchMethods.values());

        BatchMethods(final String value) {
            this.value = value;
        }

        @Override
        public String getValue() {
            return value;
        }

        public static BatchMethods getEnum(final String value) {
            return enumGetter.getEnum(value);
        }
    }

    public enum FilesMethods implements MethodEnum {
        FILES_GET("Get"),
        FILES_COPY("Copy"),
        FILES_CREATE("Create"),
        FILES_DELETE("Delete"),
        FILES_EMPTY_RECYCLE("EmptyRecycle"),
        FILES_LIST("List"),
        FILES_UPDATE("Update"),
        FILES_SUBSCRIBE("Subscribe"),
        FILES_EXECUTE_CONTENT("ExecuteContent"),
        FILES_EXECUTE_AS_INPUT_STREAM("ExecuteContentAsInputStream"),
        FILES_EXECUTE_AND_DOWNLOAD_TO("ExecuteContentAndDownloadTo");

        private String value;
        private static EnumGetter<FilesMethods> enumGetter = new EnumGetter<>(FilesMethods.values());

        FilesMethods(final String value) {
            this.value = value;
        }

        @Override
        public String getValue() {
            return value;
        }

        public static FilesMethods getEnum(final String value) {
            return enumGetter.getEnum(value);
        }

    }

    public enum FilesBatchMethods implements MethodEnum {
        FILES_GET("Get"),
        FILES_COPY("Copy"),
        FILES_CREATE("Create"),
        FILES_DELETE("Delete"),
        FILES_EMPTY_RECYCLE("EmptyRecycle"),
        FILES_LIST("List"),
        FILES_UPDATE("Update"),
        FILES_SUBSCRIBE("Subscribe");

        private String value;
        private static EnumGetter<FilesBatchMethods> enumGetter = new EnumGetter<>(FilesBatchMethods.values());

        FilesBatchMethods(final String value) {
            this.value = value;
        }

        @Override
        public String getValue() {
            return value;
        }

        public static FilesBatchMethods getEnum(final String value) {
            return enumGetter.getEnum(value);
        }

    }

    public enum CommentsMethods implements MethodEnum {
        COMMENT_CREATE("Create"),
        COMMENT_DELETE("Delete"),
        COMMENT_GET("Get"),
        COMMENT_LIST("List"),
        COMMENTS_UPDATE("Update");

        private String value;
        private static EnumGetter<CommentsMethods> enumGetter = new EnumGetter<>(CommentsMethods.values());

        CommentsMethods(final String value) {
            this.value = value;
        }

        @Override
        public String getValue() {
            return value;
        }

        public static CommentsMethods getEnum(final String value) {
            return enumGetter.getEnum(value);
        }
    }

    public enum RepliesMethods implements MethodEnum {
        REPLIES_CREATE("Create"),
        REPLIES_DELETE("Delete"),
        REPLIES_GET("Get"),
        REPLIES_LIST("List"),
        REPLIES_UPDATE("Update");

        private String value;
        private static EnumGetter<RepliesMethods> enumGetter = new EnumGetter<>(RepliesMethods.values());

        RepliesMethods(final String value) {
            this.value = value;
        }

        @Override
        public String getValue() {
            return value;
        }

        public static RepliesMethods getEnum(final String value) {
            return enumGetter.getEnum(value);
        }
    }

    public enum ChangesMethods implements MethodEnum {
        CHANGES_GET_START_CURSOR("GetStartCursor"),
        CHANGES_LIST("List"),
        CHANGES_SUBSCRIBE("Subscribe");

        private String value;
        private static EnumGetter<ChangesMethods> enumGetter = new EnumGetter<>(ChangesMethods.values());

        ChangesMethods(final String value) {
            this.value = value;
        }

        @Override
        public String getValue() {
            return value;
        }

        public static ChangesMethods getEnum(final String value) {
            return enumGetter.getEnum(value);
        }
    }

    public enum HistoryVersionsMethods implements MethodEnum {
        HISTORY_VERSIONS_DELETE("Delete"),
        HISTORY_VERSIONS_GET("Get"),
        HISTORY_VERSIONS_EXECUTE_CONTENT("ExecuteContent"),
        HISTORY_VERSIONS_EXECUTE_CONTENT_AND_DOWNLOAD_TO("ExecuteContentAndDownloadTo"),
        HISTORY_VERSIONS_EXECUTE_CONTENT_AS_INPUT_STREAM("ExecuteContentAsInputStream"),
        HISTORY_VERSIONS_LIST("List"),
        HISTORY_VERSIONS_UPDATE("Update");

        private String value;
        private static EnumGetter<HistoryVersionsMethods> enumGetter = new EnumGetter<>(
            HistoryVersionsMethods.values());

        HistoryVersionsMethods(final String value) {
            this.value = value;
        }

        @Override
        public String getValue() {
            return value;
        }

        public static HistoryVersionsMethods getEnum(final String value) {
            return enumGetter.getEnum(value);
        }
    }

    public enum DriveRequestType {
        CREATE,
        GET,
        DELETE,
        LIST,
        UPDATE,
    }

    public enum FilesRequestType {
        CREATE,
        GET,
        DELETE,
        LIST,
        UPDATE,
        COPY,
        EMPTY_RECYCLE,
        SUBSCRIBE,
    }

    public enum ChangesRequestType {
        GET_START_CURSOR,
        LIST,
        SUBSCRIBE
    }
}

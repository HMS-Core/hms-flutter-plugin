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

package com.huawei.hms.flutter.location.utils;

public interface ObjectUtils {
    /**
     * Utility method that castes given object to given class type
     *
     * @param source Source object to be casted
     * @param clazz Class that object will be casted to its type
     * @param <S> Source object's type
     * @param <D> Destination type
     * @return Object that casted to D type
     */
    static <S, D> D cast(final S source, final Class<D> clazz) {
        return clazz.cast(source);
    }
}

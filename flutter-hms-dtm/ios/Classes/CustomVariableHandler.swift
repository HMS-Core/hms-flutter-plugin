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

import DTMSDK

final class CustomVariableHandler: CustomVariable {
    override func getValue(_ params: [String : NSObject]) -> String? {
        guard let name = params["varName"] as? String, !name.isEmpty else {
            Logger.shared.debug("Non-empty String expected for varName", type: .fail)
            return ""
        }
        guard let value = DTMPlugin.allReturnValues[name] else { return "" }
        return value
    }
}

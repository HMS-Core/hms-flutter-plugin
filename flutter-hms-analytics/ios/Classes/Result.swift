/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

import Foundation
import HiAnalytics

/// Handling blueprint and declerations.
protocol Handling {
  func handle(resolve: @escaping FlutterResult, _ isSuccess: Bool?, _ message: String?)
  func handle<T>(resolve: FlutterResult, _ instance: T)
  func fail(with message: String, resolve: @escaping FlutterResult)
}

extension Handling {
  func handle(resolve: @escaping FlutterResult, _ isSuccess: Bool?=true, _ message: String?=nil) {
    Result.shared.resolve(resolve: resolve, isSuccess, message)
  }

  func handle<T>(resolve: FlutterResult, _ instance: T) {
    Result.shared.resolve(resolve: resolve, instance: instance)
  }

  func fail(with message: String, resolve: @escaping FlutterResult) {
    Result.shared.resolve(resolve: resolve, false, message)
  }
}

class Result {
  static let shared = Result()

  private init() { }

  func resolve<T>(resolve: FlutterResult, instance: T?) {
    resolve(instance)
  }

  func resolve(resolve: @escaping FlutterResult, _ isSuccess: Bool?, _ message: String?) {
    guard let success = isSuccess else { return }
    if success {
        resolve(success)
    } else {
        resolve(FlutterError(code: "", message: message, details: ""))
    }
  }
}

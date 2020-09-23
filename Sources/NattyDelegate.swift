//
//  NattyDelegate.swift
//  NattyLog-iOS
//
//  Created by yonghoonKwon on 2020/08/24.
//  Copyright (c) 2020 SK Telecom Co., Ltd. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation

public protocol NattyDelegate: class {
    /// It is delegated the log message that `NattyLog` will print.
    /// - Parameter logMessage: The `logMessage` that `NattyLog` will print
    /// - Parameter logLevel: The `logLevel` is the level for printing log.
    /// - Returns: Return `true` when the delegated `logMessage` is directly output.
    func nattyShouldDelegate(logMessage: String?, logLevel: LogLevel) -> Bool
}

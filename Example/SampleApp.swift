//
//  SampleApp.swift
//  NattyLog_Example
//
//  Created by yonghoonKwon on 20/06/2019.
//  Copyright (c) 2019 SK Telecom Co., Ltd. All rights reserved.
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
import NattyLog

// MARK: - Const for app

let log = SampleApp.natty

struct SampleApp {
    /**
     # Note
     If you want to customize, set initializer's parameters
     
     # Example (For customization)
     ```
     static var customClosure: (String?) -> Void = { (message) in
         print(message ?? "")
         NSLog(message ?? "")
     }
     
     static var configuration: NattyConfiguration {
        return NattyConfiguration(
            minLogLevel: .debug,
            maxDescriptionLevel: .nothing,
            showPersona: true,
            prefix: "Natty-Example",
            outputMethod: .custom(closure: customClosure)
        )
     }
     
     static let natty = Natty(by: configuration)
     ```
     */
    
    static let natty = Natty()
}

// MARK: - NattyLog.LogLevel

extension NattyLog.LogLevel {
    var name: String {
        switch self {
        case .debug: return "Debug"
        case .info: return "Info"
        case .warning: return "Warning"
        case .error: return "Error"
        case .nothing: return "Nothing"
        }
    }
}

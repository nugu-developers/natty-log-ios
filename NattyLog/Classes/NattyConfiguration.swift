//
//  NattyConfiguration.swift
//  NattyLog
//
//  Created by yonghoonKwon on 11/01/2019.
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

public struct NattyConfiguration {
    public var minLogLevel: LogLevel
    public var maxDescriptionLevel: LogLevel
    public var showPersona: Bool
    public var prefix: String?
    public var outputMethod: OutputMethod
    
    public static var `default`: NattyConfiguration {
        return NattyConfiguration()
    }
    
    public init(
        minLogLevel: LogLevel = .debug,
        maxDescriptionLevel: LogLevel = .nothing,
        showPersona isShowPersona: Bool = true,
        prefix: String? = nil,
        outputMethod: OutputMethod = .nslog
        ) {
        self.minLogLevel = minLogLevel
        self.maxDescriptionLevel = maxDescriptionLevel
        self.showPersona = isShowPersona
        self.prefix = prefix
        self.outputMethod = outputMethod
    }
}

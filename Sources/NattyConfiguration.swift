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

/// A configuration struct that defines behavior for printing log.
public struct NattyConfiguration {
    /// A minimum level for printing log.
    public var minLogLevel: LogLevel
    /// A maximum level for log's description.
    public var maxDescriptionLevel: LogLevel
    /// A persona shown according to the requested level for printing log.
    public var showPersona: Bool
    /// A prefix in log.
    public var prefix: String?
    /// The method for printing log.
    public var outputMethod: OutputMethod
    /// Make output using delegate.
    public var usingDelegate: Bool
  
    /// A configuration value for default.
    public static var `default`: NattyConfiguration {
        return NattyConfiguration()
    }
    
    /// Creates custom `NattyConfiguration` each environment.
    /// - Parameter minLogLevel: A minimum level for printing log.
    ///                          Default value is `.debug`.
    /// - Parameter maxDescriptionLevel: A maximum level for log's description.
    ///                                  Default value is `.nothing`.
    /// - Parameter isShowPersona: A persona shown according to the requested level for printing log.
    ///                            Default value is `true`.
    /// - Parameter prefix: A prefix in log.
    ///                     Default value is `nil`.
    /// - Parameter outputMethod: The method for printing log.
    ///                           Default value is `.nslog`.
    /// - Parameter usingDelegate: Make output using delegate.
    ///                            Default value is `true`.
    public init(
        minLogLevel: LogLevel = .debug,
        maxDescriptionLevel: LogLevel = .nothing,
        showPersona isShowPersona: Bool = true,
        prefix: String? = nil,
        outputMethod: OutputMethod = .nslog,
        usingDelegate: Bool = true
        ) {
        self.minLogLevel = minLogLevel
        self.maxDescriptionLevel = maxDescriptionLevel
        self.showPersona = isShowPersona
        self.prefix = prefix
        self.outputMethod = outputMethod
        self.usingDelegate = usingDelegate
    }
}

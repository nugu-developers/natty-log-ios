//
//  NattyLog.swift
//  NattyLog
//
//  Created by yonghoon.kwon on 01/11/2019.
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

// MARK: - LogLevel

/// `LogLevel` is the level for printing log.
public enum LogLevel {
    /// A `debug` is to print log for debugging.
    case debug
    /// A `info` is to print log for information.
    case info
    /// A `warning` is to print log for warning.
    case warning
    /// A `error` is to print log for error.
    case error
    /// A `nothing` is to print log for nothing.
    case nothing
    
    enum Persona: String {
        case debug = "✨"
        case info = "❔"
        case warning = "⚠️"
        case error = "‼️"
    }
    
    var persona: Persona? {
        switch self {
        case .debug: return .debug
        case .info: return .info
        case .warning: return .warning
        case .error: return .error
        case .nothing: return nil
        }
    }
}

// MARK: - LogLevelBound

/// A `LogLevelBound` is the bound of `LogLevel`.
///
/// - Note: `LogLevel` is the relative level.
/// It can calculated the relative levels with upper and lower bound using `LogLevelBound`.
public enum LogLevelBound {
    /// An `upper` bound is lowest `nothing` and highest `error`.
    case upper(level: LogLevel)
    /// A `lower` bound is lowest `debug` and highest `nothing`.
    case lower(level: LogLevel)
    
    /// A `value` is level of each `LogLevelBound`.
    public var value: Int {
        switch self {
        case .lower(let level):
            switch level {
            case .debug: return 0
            case .info: return 1
            case .warning: return 2
            case .error: return 3
            case .nothing: return 4
            }
        case .upper(let level):
            switch level {
            case .nothing: return -1
            case .debug: return 0
            case .info: return 1
            case .warning: return 2
            case .error: return 3
            }
        }
    }
    
    /// A `lowerLevel` function is getter for log-level on the `lower`
    /// - Parameter value: The `value` of `lower` log-level.
    public static func lowerLevel(value: Int) -> LogLevel? {
        switch value {
        case 0: return .debug
        case 1: return .info
        case 2: return .warning
        case 3: return .error
        case 4: return .nothing
        default: return nil
        }
    }
    
    /// A `upperLevel` function is getter for log-level on the `upper`
    /// - Parameter value: The `value` of `upper` log-level.
    public static func upperLevel(value: Int) -> LogLevel? {
        switch value {
        case -1: return .nothing
        case 0: return .debug
        case 1: return .info
        case 2: return .warning
        case 3: return .error
        default: return nil
        }
    }
}

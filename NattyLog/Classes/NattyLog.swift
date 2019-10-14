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

public enum LogLevel {
    case debug
    case info
    case warning
    case error
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

public enum LogLevelBound {
    case upper(level: LogLevel)
    case lower(level: LogLevel)
    
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

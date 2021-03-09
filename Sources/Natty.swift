//
//  Natty.swift
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

import Foundation

public class Natty {
    /// Configuration for `Natty` instance.
    public var configuration: NattyConfiguration
    
    // Use `delegate` when printing directly. It must be used only in the endpoint (application).
    public static weak var delegate: NattyDelegate?
    
    /// Creates a `Natty` from a `NattyConfiguration`.
    ///
    /// - Note: Recommend using that change the `configuration` according to your build environment.
    /// - Parameter configuration: A `configuration` value that specifies contain behaviors,
    ///                            such as minimum level for logging, setting prefix.
    ///                            Default value is `NattyConfiguration.default`
    public init(by configuration: NattyConfiguration = NattyConfiguration.default) {
        self.configuration = configuration
    }
    
    /// Print log when `minloglevel` in `configuration` is lower than or equal to `debug`.
    /// - Parameter message: A message to print. called immediately because it is an autoclosure type.
    /// - Parameter file: A filename that called print. Default value is `#file`.
    /// - Parameter function: A function that called print. Default value is `#function`.
    /// - Parameter line: A code line that called print. Default value is `#line`.
    /// - Parameter then: Call this closure after success or fail to print log.
    ///                   It is called synchronous.
    ///                   If success to print log, receive `String?` type of `message` converted from `Any?` type.
    ///                   If failure to print log, receive `NTError`.
    public func debug(
        _ message: @autoclosure () -> Any?,
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        then: ((Result<String?, NTError>) -> Void)? = nil
        ) {
        log(message: message,
            by: .debug,
            file: file,
            function: function,
            line: line,
            then: then)
    }
    
    /// Print log when `minloglevel` in `configuration` is lower than or equal to `info`.
    /// - Parameter message: A message to print. called immediately because it is an autoclosure type.
    /// - Parameter file: A filename that called print. Default value is `#file`.
    /// - Parameter function: A function that called print. Default value is `#function`.
    /// - Parameter line: A code line that called print. Default value is `#line`.
    /// - Parameter then: Call this closure after success or fail to print log.
    ///                   It is called synchronous.
    ///                   If success to print log, receive `String?` type of `message` converted from `Any?` type.
    ///                   If failure to print log, receive `NTError`.
    public func info(
        _ message: @autoclosure () -> Any?,
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        then: ((Result<String?, NTError>) -> Void)? = nil
        ) {
        log(message: message,
            by: .info,
            file: file,
            function: function,
            line: line,
            then: then)
    }
    
    /// Print log when `minloglevel` in `configuration` is lower than or equal to `warning`.
    /// - Parameter message: A message to print. called immediately because it is an autoclosure type.
    /// - Parameter file: A filename that called print. Default value is `#file`.
    /// - Parameter function: A function that called print. Default value is `#function`.
    /// - Parameter line: A code line that called print. Default value is `#line`.
    /// - Parameter then: Call this closure after success or fail to print log.
    ///                   It is called synchronous.
    ///                   If success to print log, receive `String?` type of `message` converted from `Any?` type.
    ///                   If failure to print log, receive `NTError`.
    public func warning(
        _ message: @autoclosure () -> Any?,
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        then: ((Result<String?, NTError>) -> Void)? = nil
        ) {
        log(message: message,
            by: .warning,
            file: file,
            function: function,
            line: line,
            then: then)
    }
    
    /// Print log when `minloglevel` in `configuration` is lower than or equal to `error`.
    /// - Parameter message: A message to print. called immediately because it is an autoclosure type.
    /// - Parameter file: A filename that called print. Default value is `#file`.
    /// - Parameter function: A function that called print. Default value is `#function`.
    /// - Parameter line: A code line that called print. Default value is `#line`.
    /// - Parameter then: Call this closure after success or fail to print log.
    ///                   It is called synchronous.
    ///                   If success to print log, receive `String?` type of `message` converted from `Any?` type.
    ///                   If failure to print log, receive `NTError`.
    public func error(
        _ message: @autoclosure () -> Any?,
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        then: ((Result<String?, NTError>) -> Void)? = nil
        ) {
        log(message: message,
            by: .error,
            file: file,
            function: function,
            line: line,
            then: then)
    }
}

// MARK: - Private

private extension Natty {
    func log(
        message: () -> Any?,
        by level: LogLevel,
        file: String,
        function: String,
        line: Int,
        then: ((Result<String?, NTError>) -> Void)? = nil
        ) {
        guard LogLevelBound.lower(level: configuration.minLogLevel).value <= LogLevelBound.lower(level: level).value else {
            then?(.failure(.logLevelTooLow))
            return
        }
        
        var logMessage = String()
        
        if let prefix = configuration.prefix {
            logMessage.append("[\(prefix)]")
        }
        
        if LogLevelBound.upper(level: configuration.maxDescriptionLevel).value >= LogLevelBound.upper(level: level).value {
            logMessage.append("[")
            if let fileName = file.lastPathComponent {
                logMessage.append("\(fileName), ")
            } else {
                logMessage.append("Unknown File, ")
            }
            
            logMessage.append("\(function), \(line)")
            logMessage.append("]")
        }
        
        logMessage.append(" ")
        
        if configuration.showPersona, let persona = level.persona {
            logMessage.append("\(persona.rawValue) ")
        }
        
        let messageValue = message()
        
        if let errorMessage = (messageValue as? LocalizedError)?.errorDescription, errorMessage.isEmpty == false {
            logMessage.append(errorMessage)
        } else if let descriptionMessage = (messageValue as? CustomStringConvertible)?.description, descriptionMessage.isEmpty == false {
            logMessage.append(descriptionMessage)
        } else {
            logMessage.append(messageValue.debugDescription)
        }
        
        if configuration.usingDelegate == true {
            let isDelegated = Natty.delegate?.nattyShouldDelegate(logMessage: logMessage, logLevel: level)
        
            guard isDelegated == false || isDelegated == nil else {
                then?(.success(logMessage))
                return
            }
        }
        
        switch configuration.outputMethod {
        case .nslog:
            printByNSLog(logMessage: logMessage)
        case .print:
            print(logMessage)
        case .custom(let closure):
            closure(logMessage)
        }
        
        then?(.success(logMessage))
    }
    
    func printByNSLog(logMessage: String) {
        var startIndex = logMessage.startIndex
        var results = [Substring]()
        
        // Used `mainQueue` because memory leak issued by `stdlib:createTLS`
        DispatchQueue.main.async {
            while startIndex < logMessage.endIndex {
                let endIndex = logMessage.index(startIndex, offsetBy: 500, limitedBy: logMessage.endIndex) ?? logMessage.endIndex
                results.append(logMessage[startIndex..<endIndex])
                startIndex = endIndex
            }

            results
                .map { String($0) }
                .forEach { NSLog("%@", $0) }
        }
    }
}

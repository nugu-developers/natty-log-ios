//
//  OutputMethod.swift
//  NattyLog
//
//  Created by yonghoonKwon on 21/06/2019.
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

public enum OutputMethod {
    
    /// If you use nslog method in Foundation, logMessage is seperated each 500 characters.
    /// Because using nslog is available maximum 1024 bytes
    case nslog
    
    /// If you use print method in Swift, Can't see logMessage by device console
    ///
    /// Recommend using by debug mode with Xcode
    case print
    
    /// If you want to use custom method, implement using closure. (like to save log file without print)
    /// Also, you can use custom format by closure's `String` type argument (Not recommended)
    case custom(closure: (String?) -> Void)
}

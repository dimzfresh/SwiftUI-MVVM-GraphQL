//
//  Logger.swift
//  SwiftUI-MVVM
//
//  Created by Dmitrii Ziablikov on 08.01.2020.
//  Copyright © 2020 Dmitrii Ziablikov. All rights reserved.
//

import Foundation

public enum LoggingType {
    case error, debug
}

public final class Logger {
    static func log(_ type: LoggingType, _ info: String) {
        NSLog(info)
    }
}

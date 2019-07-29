//
//  Logger.swift
//  RxExamples
//
//  Created by 晋先森 on 2019/5/24.
//  Copyright © 2019 legenddigital. All rights reserved.
//

import Foundation

// MARK: Public
func logInfo<T>(
    _ message : T,
    file : StaticString = #file,
    function : StaticString = #function,
    line : UInt = #line
    ) {
    LXFLog(message, type: .info, file : file, function: function, line: line)
}

func logWarn<T>(
    _ message : T,
    file : StaticString = #file,
    function : StaticString = #function,
    line : UInt = #line
    ) {
    LXFLog(message, type: .warning, file : file, function: function, line: line)
}

func logDebug<T>(
    _ message : T,
    file : StaticString = #file,
    function : StaticString = #function,
    line : UInt = #line
    ) {
    LXFLog(message, type: .debug, file : file, function: function, line: line)
}

func logError<T>(
    _ message : T,
    file : StaticString = #file,
    function : StaticString = #function,
    line : UInt = #line
    ) {
    LXFLog(message, type: .error, file : file, function: function, line: line)
}


// MARK: Log
private let shared = Logger.shared

private class Logger {
    static let shared = Logger()
    private init() { }

    let logDateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return f
    }()
}

enum LogType: String {
    case error = "❤️ ERROR"
    case warning = "💛 WARNING"
    case info = "💙 INFO"
    case debug = "💚 DEBUG"
}

private func LXFLog<T>(
    _ message : T,
    type: LogType,
    file : StaticString = #file,
    function : StaticString = #function,
    line : UInt = #line
    ) {
    #if DEBUG
    let time = shared.logDateFormatter.string(from: Date())
    let fileName = (file.description as NSString).lastPathComponent
    print("\(time) \(type.rawValue) \(fileName):\(line)\n\(message)")
    #endif
}

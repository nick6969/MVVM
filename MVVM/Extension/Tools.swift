//
//  Tools.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/3.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

public func print<T>(msg: T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
        Swift.print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(msg)")
    #endif
}

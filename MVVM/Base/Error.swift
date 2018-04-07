//
//  Error.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/3.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

enum JSONConvertError: Error, LocalizedError, CustomNSError {
    case noDataError

    var localizedDescription: String {
        return "JSON Convert Error"
    }

    public var errorDescription: String? {
        switch self {
        case .noDataError: return "無輸入資料"
        }
    }

    public static var errorDomain: String {
        return "JSON Convert Error"
    }

    public var errorCode: Int {
        switch self {
        case .noDataError: return 8000
        }
    }

    public var errorUserInfo: [String: Any] {
        switch self {
        case .noDataError: return [:]
        }
    }
}

enum WebError: Error, LocalizedError, CustomNSError {
    static let url = "url"
    static let heads = "httpHeads"
    static let body = "httpBody"

    case convertFail(userInfo: [String: Any])
    case unKnowError(userInfo: [String: Any])

    var localizedDescription: String {
        switch self {
        case .convertFail: return "網路請求錯誤 - 伺服器回傳資料型別錯誤"
        case .unKnowError: return "網路請求錯誤 - 未知錯誤"
        }
    }

    public var errorDescription: String? {
        switch self {
        case .convertFail: return "網路請求錯誤 - 伺服器回傳資料型別錯誤"
        case .unKnowError: return "網路請求錯誤 - 未知錯誤"
        }
    }

    public static var errorDomain: String {
        return "網路請求錯誤"
    }

    public var errorCode: Int {
        switch self {
        case .convertFail: return 9000
        case .unKnowError: return 9001
        }
    }

    public var errorUserInfo: [String: Any] {
        switch self {
        case .convertFail(let dic): return dic
        case .unKnowError(let dic): return dic
        }
    }

}

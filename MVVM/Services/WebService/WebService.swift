//
//  WebService.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/3.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation
import Alamofire

typealias DataCompleClosure = (Data) -> Void
typealias LoadDataFailClosure = (Error?) -> Void

final class WebService: SessionManager {

    static let shared = WebService()
    private convenience init() {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [ChlURLProtocol.self]
        config.timeoutIntervalForRequest = 10
        self.init(configuration: config, delegate: SessionDelegate(), serverTrustPolicyManager: nil)
    }

    fileprivate func request(method: HTTPMethod, url: String = String(), parameters: [String: Any]? = nil, handle: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        request(url, method: method, parameters: parameters).validate().response { response in
            handle(response.data, response.response, response.error)
        }
    }

    fileprivate func baseRequest(method: HTTPMethod, url: String = String(), parameters: [String: Any]?, success: DataCompleClosure?, fail: LoadDataFailClosure?) {
        request(method: .get, url: url, parameters: parameters) { (data, res, error) in

            guard error == nil else {
                fail?(error ?? WebError.unKnowError(userInfo: [WebError.url: url, WebError.heads: res?.allHeaderFields ?? [AnyHashable: Any](), WebError.body: data?.string ?? Data()]))
                return
            }
            guard let datas = data else {
                fail?(WebError.convertFail(userInfo: [WebError.url: url, WebError.heads: res?.allHeaderFields ?? [AnyHashable: Any](), WebError.body: data ?? Data()]))
                return
            }
            success?(datas)
            return
        }
    }

}

extension WebService {

    func getZipData(success: DataCompleClosure?, fail: LoadDataFailClosure?) {
        let url = "http://data.ntpc.gov.tw/od/data/api/AC110AF8-C847-43E5-B62C-7985E9E049F9"
        var para: [String: Any] = [:]
        para["$format"] = "json"
        baseRequest(method: .get, url: url, parameters: para, success: success, fail: fail)
    }

    func getGarbageStationInfo(with area: String, skip: Int, success: DataCompleClosure?, fail: LoadDataFailClosure?) {
        let path = "http://data.ntpc.gov.tw/od/data/api/EDC3AD26-8AE7-4916-A00B-BC6048D19BF8"
        var para: [String: Any] = [:]
        para["$format"] = "json"
        para["$filter"] = "city eq \(area)"
        para["$skip"] = skip
        para["$top"] = 40
        baseRequest(method: .get, url: path, parameters: para, success: success, fail: fail)
    }

    func getLocaleServiceSchoolData(success: DataCompleClosure?, fail: LoadDataFailClosure?) {
        let url = "https://github.com/nick6969/MVVM/blob/master/MVVM/data.json?raw=true"
        baseRequest(method: .get, url: url, parameters: nil, success: success, fail: fail)
    }
}

//
//  ChlURLProtocol.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/3.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

class ChlURLProtocol: URLProtocol, URLSessionDataDelegate {

    fileprivate var session: URLSession?
    fileprivate var sessionTask: URLSessionTask?

    fileprivate var clientThread: Thread?

    override class func canInit(with request: URLRequest) -> Bool {
        if URLProtocol.property(forKey: "process", in: request) != nil {
            return false
        }
        return true
    }

    override class func canInit(with task: URLSessionTask) -> Bool {
        guard let request = task.originalRequest else {
            return false
        }

        if URLProtocol.property(forKey: "process", in: request) != nil {
            return false
        }
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {

        let newRequest = request as! NSMutableURLRequest
        URLProtocol.setProperty("process", forKey: "process", in: newRequest)
        return newRequest as URLRequest
    }

    override func startLoading() {

        clientThread = Thread.current

        session = URLSession(configuration: .default, delegate: self, delegateQueue: URLSession.shared.delegateQueue)
        sessionTask = self.session?.dataTask(with: self.request) { [weak self] (data, res, err) in
            guard let strongSelf = self else { return }

            strongSelf.threadSafety {

                if let err = err {
                    strongSelf.client?.urlProtocol(strongSelf, didFailWithError: err)
                } else {
                    strongSelf.client?.urlProtocol(strongSelf, didReceive: res!, cacheStoragePolicy: .allowed)
                    strongSelf.client?.urlProtocol(strongSelf, didLoad: data!)
                    strongSelf.client?.urlProtocolDidFinishLoading(strongSelf)
                }
            }
        }
        sessionTask?.resume()
    }

    override func stopLoading() {
        self.sessionTask?.cancel()
        self.sessionTask = nil
        self.session = nil
    }

    func threadSafety(_ clourse: (() -> Void)) {
        guard let thread = clientThread else { return }
        perform(#selector(performClourseOnThread(_:)), on: thread, with: clourse, waitUntilDone: false)
    }

    @objc func performClourseOnThread(_ clourse: Any) {
        guard let clourse = clourse as? () -> Void else { return }
        clourse()
    }

}

//
//  BaseDataProtocol.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/10.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

protocol BaseDataProtocol: class {
    associatedtype Model: JsonModel
    var models: [Model] { get set }
}

extension ViewModelLoadingProtocol where Self: BaseDataProtocol, Self: ViewModelLoadingFuncProtocol {

    func refreshData() {
        if status != .loadStart {
            status = .refreshLoading
            nextStatus()
        }
    }

    func nextStatus() {
        switch status {
        case .initialize, .loadFail:
            status = .loadStart
            if models.isEmpty {
                DispatchQueue.main.async {
                    self.loadingStatusDelegate?.showLoading(true)
                }
            }
            loadData()

        case .loadDone, .loadMoreDone, .loadMoreFail:
            status = .loadMoreStart
            loadDataMore()

        case .refreshLoading:
            status = .loadStart
            models = []
            DispatchQueue.main.async {
                self.loadingStatusDelegate?.showLoading(true)
            }
            loadData()

        case .loadStart, .loadMoreStart, .noMoreCanLoad:
            break
        }
    }

}

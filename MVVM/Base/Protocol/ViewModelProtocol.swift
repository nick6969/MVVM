//
//  ViewModelProtocol.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/3.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

protocol ViewModelDataProtocol: class {
    associatedtype Model
    var models: [Model] { get set }
    var datasCount: Int { get }
    func model(at index: Int) -> Model?
    func isLastData(index: Int) -> Bool
    func isLoadMore(index: Int) -> Bool
}

extension ViewModelDataProtocol {
    
    var datasCount: Int { return models.count }

    func model(at index: Int) -> Model? {
        return models[safe: index]
    }

    func isLastData(index: Int) -> Bool {
        return index + 1 == datasCount
    }

    func isLoadMore(index: Int) -> Bool {
        if models.isEmpty { return false }
        return index == datasCount
    }

}

protocol ViewModelLoadingProtocol: class {
    var loadingDelegate: ViewModelLoadingDelegate? {get set}
    var loadingStatusDelegate: ViewModelLoadingStatusDelegate? {get set}
    var status: ViewModelStatus { get set }
    func refreshData()
    func nextStatus()
}

extension ViewModelLoadingProtocol where Self: ViewModelDataProtocol, Self: ViewModelLoadingFuncProtocol {

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

protocol ViewModelLoadingFuncProtocol: class {
    func loadData()
    func loadDataMore()
}

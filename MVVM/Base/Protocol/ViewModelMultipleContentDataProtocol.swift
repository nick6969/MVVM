//
//  ViewModelMultipleContentDataProtocol.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/7.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

protocol ViewModelMultipleContentDataProtocol: class {
    associatedtype Model: MultipleContentProtocol
    var models: [Model] { get set }
    func numberOfSection() -> Int
    func numberOfItem(in section: Int) -> Int
    func modelAt(section: Int) -> Model?
    func modelAt(indexPath: IndexPath) -> Model.SubModel?
    func isLastData(index: IndexPath) -> Bool
}

extension ViewModelMultipleContentDataProtocol {

    func numberOfSection() -> Int {
        return models.count
    }

    func numberOfItem(in section: Int) -> Int {
        return modelAt(section: section)?.subModels.count ?? 0
    }

    func modelAt(section: Int) -> Model? {
        return models[safe: section]
    }

    func modelAt(indexPath: IndexPath) -> Model.SubModel? {
        return models[safe: indexPath.section]?.subModels[safe: indexPath.item]
    }

    func isLastData(index: IndexPath) -> Bool {
        return index.section + 1 == models.count && index.item + 1 == numberOfItem(in: index.section)
    }

}

extension ViewModelLoadingProtocol where Self: ViewModelMultipleContentDataProtocol, Self: ViewModelLoadingFuncProtocol {

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
                loadingStatusDelegate?.showLoading(true)
            }
            loadData()

        case .loadDone, .loadMoreDone, .loadMoreFail:
            status = .loadMoreStart
            loadDataMore()

        case .refreshLoading:
            status = .loadStart
            models = []
            loadingStatusDelegate?.showLoading(true)
            loadData()

        case .loadStart, .loadMoreStart, .noMoreCanLoad:
            break
        }
    }

}

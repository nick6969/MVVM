//
//  BaseViewModel.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/3.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

class BaseViewModel<T> where T: JsonModel {
    weak var loadingDelegate: ViewModelLoadingDelegate?
    weak var loadingStatusDelegate: ViewModelLoadingStatusDelegate?
    var status: ViewModelStatus = .initialize

    var models: [T] = [] {
        didSet {
            if models.isEmpty && status != .loadStart {
                DispatchQueue.main.async {
                    self.loadingStatusDelegate?.showEmptyView(with: nil)
                }
            }
        }
    }

    var modelsSuccessClosure: (([T]) -> Void)?
    var modelSuccessClosure: ((T) -> Void)?
    var loadingFailClosure: ( (Error?) -> Void )?

    var dataConvertToModelsClosure: ((Data) -> Void)?
    var dataConvertToModelClosure: ((Data) -> Void)?

    init() {
        setupClosure()
    }

    fileprivate func setupClosure() {

        dataConvertToModelsClosure = { [weak self] data in
            guard let `self` = self else { return }
            do {
                let models = try data.decodeToModelArray(type: T.self)
                self.modelsSuccessClosure?(models)
            } catch {
                self.loadingFailClosure?(error)
            }
        }

        dataConvertToModelClosure = { [weak self] data in
            guard let `self` = self else { return }
            do {
                let model = try data.decodeToModel(type: T.self)
                self.modelSuccessClosure?(model)
            } catch {
                self.loadingFailClosure?(error)
            }
        }

        modelsSuccessClosure = { [weak self] models in
            guard let `self` = self else { return }
            if self.status == .loadStart {
                self.models = models
            } else if self.status == .loadMoreStart {
                if models.isEmpty {
                    self.status = .noMoreCanLoad
                } else {
                    self.models.append(contentsOf: models)
                }
            }
            self.loadDoneChangeStatus()
            DispatchQueue.main.async {
                self.loadingStatusDelegate?.showLoading(false)
                if self.models.isEmpty {
                    self.loadingStatusDelegate?.showEmptyView(with: nil)
                } else {
                    self.loadingStatusDelegate?.removeEmptyView()
                }
                self.loadingDelegate?.loadingDone()
            }
        }

        modelSuccessClosure = { [weak self] model in
            guard let `self` = self else { return }
            self.models = [model]
            self.loadDoneChangeStatus()
            DispatchQueue.main.async {
                self.loadingStatusDelegate?.showLoading(false)
                self.loadingStatusDelegate?.removeEmptyView()
                self.loadingDelegate?.loadingDone()
            }
        }

        loadingFailClosure = { [weak self] error in
            guard let `self` = self else { return }
            self.loadFailChangeStatus()
            DispatchQueue.main.async {
                self.loadingStatusDelegate?.showLoading(false)
                if self.models.isEmpty {
                    self.loadingStatusDelegate?.showEmptyView(with: error)
                }
                self.loadingDelegate?.loadingFail(error)
            }
        }
    }

    fileprivate func loadDoneChangeStatus() {
        switch status {
        case .loadStart:
            status = .loadDone
        case .loadMoreStart:
            status = .loadMoreDone
        default:
            break
        }
    }

    fileprivate func loadFailChangeStatus() {
        switch status {
        case .loadStart:
            status = .loadFail
        case .loadMoreStart:
            status = .loadMoreFail
        default:
            break
        }
    }
}

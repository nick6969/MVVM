//
//  ViewModelMultipleContentDataProtocol.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/7.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

typealias StandardMultipleContentViewModel = ViewModelMultipleContentDataProtocol & ViewModelLoadingProtocol & ViewModelLoadingFuncProtocol

protocol ViewModelMultipleContentDataProtocol: BaseDataProtocol where Model: MultipleContentProtocol {
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

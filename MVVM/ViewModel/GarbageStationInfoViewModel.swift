//
//  GarbageStationInfoViewModel.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/3.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

class GarbageStationInfoViewModel: BaseCodableViewModel<GarbageStationInfoModel>, ViewModelLoadingProtocol, ViewModelLoadingFuncProtocol {

    fileprivate var area: String = String()

    convenience init(with area: String) {
        self.init()
        self.area = area
    }

    func loadData() {
        useLoadData()
    }

    func loadDataMore() {
        useLoadData()
    }

    private func useLoadData() {
        WebService.shared.getGarbageStationInfo(with: self.area, skip: self.datasCount, success: dataConvertToModelsClosure, fail: loadingFailClosure)
    }
}

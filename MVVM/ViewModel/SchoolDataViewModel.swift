//
//  SchoolDataViewModel.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/7.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

class SchoolDataViewModel: BaseCodableMultipleContentViewModel<ClassModel>, ViewModelLoadingProtocol, ViewModelLoadingFuncProtocol {

    func loadData() {
        WebService.shared.getLocaleServiceSchoolData(success: dataConvertToModelsClosure, fail: loadingFailClosure)
    }

    func loadDataMore() {
        status = .noMoreCanLoad
    }

}

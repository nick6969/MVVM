//
//  ZipViewModel.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/3.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

class ZipViewModel: BaseViewModel<ZipModel>, StandardViewModel {

    func loadData() {
        WebService.shared.getZipData(success: dataConvertToModelsClosure, fail: loadingFailClosure)
    }

    func loadDataMore() {
        status = .noMoreCanLoad
    }

}

//
//  ViewModelDelegate.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/3.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

protocol ViewModelLoadingDelegate: class {
    func loadingDone()
    func loadingFail(_ error: Error?)
}

protocol ViewModelLoadingStatusDelegate: class {
    func showEmptyView(with: Error?)
    func removeEmptyView()
    func showLoading(_ bool: Bool)
}

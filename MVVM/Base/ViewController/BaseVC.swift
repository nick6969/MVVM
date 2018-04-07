//
//  BaseVC.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/3.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import UIKit
import SVProgressHUD

class BaseVC: UIViewController {
    fileprivate var emptyView: EmptyView?
    fileprivate var noDataView: NoDataView?
}

extension BaseVC: ViewModelLoadingStatusDelegate {
    func showLoading(_ bool: Bool) {

        if bool {
            DispatchQueue.main.async {
                SVProgressHUD.show()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                SVProgressHUD.dismiss()
            }
        }
    }

    func showEmptyView(with error: Error?) {
        if error != nil {
            if emptyView == nil {
                let emptyView = EmptyView()
                emptyView.alpha = 0
                emptyView.reloadButton.addTarget(self, action: #selector(didTapReloadButton), for: .touchUpInside)
                self.emptyView = emptyView
                self.view.addSubview(emptyView)
                emptyView.mLay(pin: .zero)
                self.view.bringSubview(toFront: emptyView)
            }
            UIView.animate(withDuration: 0.2) {
                self.emptyView?.alpha = 1
            }
        } else {
            if noDataView == nil {
                let noDataView = NoDataView()
                noDataView.alpha = 0
                self.noDataView = noDataView
                self.view.addSubview(noDataView)
                noDataView.mLay(pin: .zero)
                self.view.bringSubview(toFront: noDataView)
            }
            UIView.animate(withDuration: 0.2, animations: {
                self.noDataView?.alpha = 1
            })
        }
    }

    func removeEmptyView() {
        if emptyView != nil {
            UIView.animate(withDuration: 0.2, animations: {
                self.emptyView?.alpha = 0
                self.emptyView?.removeFromSuperview()
            })
        }
        if noDataView != nil {
            UIView.animate(withDuration: 0.2, animations: {
                self.noDataView?.alpha = 0
                self.noDataView?.removeFromSuperview()
            })
        }
    }

    @objc func didTapReloadButton() {
        assert(false, "if sub class need using emptyView, remeber override this method :\(#function)")
    }

}

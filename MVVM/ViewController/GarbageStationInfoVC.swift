//
//  GarbageStationInfoVC.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/3.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import UIKit

class GarbageStationInfoVC: BaseVC {

    fileprivate lazy var viewModel: GarbageStationInfoViewModel = GarbageStationInfoViewModel()

    fileprivate let tableView: UITableView = UITableView()

    convenience init(with area: String) {
        self.init()
        self.viewModel = GarbageStationInfoViewModel(with: area)
        self.title = area
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.loadingDelegate = self
        viewModel.loadingStatusDelegate = self
        viewModel.nextStatus()
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.mLay(pin: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GarbageStationInfoCell.self, forCellReuseIdentifier: "cell")
    }

    override func didTapReloadButton() {
        viewModel.refreshData()
    }
}

extension GarbageStationInfoVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datasCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! GarbageStationInfoCell
        if let model = viewModel.model(at: indexPath.row) {
            cell.setup(with: model)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.isLastData(index: indexPath.row) {
            viewModel.nextStatus()
        }
    }
}

extension GarbageStationInfoVC: ViewModelLoadingDelegate {

    func loadingDone() {
        tableView.reloadData()
    }

    func loadingFail(_ error: Error?) {

    }

}

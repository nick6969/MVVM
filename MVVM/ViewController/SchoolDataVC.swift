//
//  SchoolDataVC.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/7.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import UIKit

class SchoolDataVC: BaseVC {

    fileprivate lazy var viewModel: SchoolDataViewModel = SchoolDataViewModel()

    fileprivate let tableView: UITableView = UITableView()

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
        tableView.register(SchoolDataCell.self, forCellReuseIdentifier: "cell")
    }

    override func didTapReloadButton() {
        viewModel.refreshData()
    }
    
}

extension SchoolDataVC: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItem(in: section)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let model = viewModel.modelAt(section: section) {
            let headerLabel = UILabel()
            headerLabel.text = "    🔷班級: \(model.className), 導師: \(model.tutorName)"
            headerLabel.backgroundColor = .red
            return headerLabel
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.modelAt(section: section) != nil ? 50 : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SchoolDataCell
        if let model = viewModel.modelAt(indexPath: indexPath) {
            cell.setup(with: model)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.isLastData(index: indexPath) {
            viewModel.nextStatus()
        }
    }
}

extension SchoolDataVC: ViewModelLoadingDelegate {

    func loadingDone() {
        tableView.reloadData()
    }

    func loadingFail(_ error: Error?) {

    }

}

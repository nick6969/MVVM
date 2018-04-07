//
//  ZipVC.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/3.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import UIKit

class ZipVC: BaseVC {

    fileprivate lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
    fileprivate let flowLayout = UICollectionViewFlowLayout()
    fileprivate lazy var viewModel: ZipViewModel = ZipViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupFlowLayout()
        viewModel.loadingDelegate = self
        viewModel.loadingStatusDelegate = self
        viewModel.nextStatus()
    }

    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.mLay(pin: .zero)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ZipCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }

    private func setupFlowLayout() {
        flowLayout.sectionInset = .init(top: 10, left: 10, bottom: 20, right: 10)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        let width = CGFloat(Int((UIScreen.main.bounds.width - 40) / 3))
        flowLayout.itemSize = CGSize(width: width, height: 50)
    }

    override func didTapReloadButton() {
        viewModel.refreshData()
    }
}

extension ZipVC: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.datasCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ZipCollectionViewCell
        if let model = viewModel.model(at: indexPath.item) {
            cell.setup(with: model)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = viewModel.model(at: indexPath.item) else { return }
        let vc = GarbageStationInfoVC(with: model.district)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ZipVC: ViewModelLoadingDelegate {

    func loadingDone() {
        collectionView.reloadData()
    }

    func loadingFail(_ error: Error?) {

    }

}

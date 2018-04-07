//
//  ZipCollectionViewCell.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/3.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import UIKit

class ZipCollectionViewCell: UICollectionViewCell {

    fileprivate let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        contentView.addSubview(label)
        label.mLay(pin: .zero)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.init(netHex: 0x747474).cgColor
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .white
    }

    func setup(with model: ZipModel) {
        self.label.text = model.district
    }

}

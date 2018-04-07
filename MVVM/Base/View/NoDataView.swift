//
//  NoDataView.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/3.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import UIKit

class NoDataView: UIView {
    let imageView = UIImageView()
    let messageLabel = UILabel()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    private func setupUI() {
        backgroundColor = UIColor.init(netHex: 0xf6f6f6)
        addSubview(imageView)
        addSubview(messageLabel)
        messageLabel.font = UIFont.systemFont(ofSize: 18)
        messageLabel.textAlignment = .center
        messageLabel.text = "目前沒有任何內容"
        messageLabel.numberOfLines = 1
        imageView.image = UIImage(named: "NoData")
        imageView.contentMode = .scaleAspectFit

        imageView.mLay(size: CGSize(width: 180, height: 100))
        imageView.mLay(.centerX, .equal, self)
        imageView.mLay(.centerY, .equal, self, multiplier: 0.8, constant: 0)

        messageLabel.mLay(.top, .equal, self, .centerY, multiplier: 1.2, constant: 0)
        messageLabel.mLay(.centerX, .equal, self)
    }
}

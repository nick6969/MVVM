//
//  EmptyView.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/3.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import UIKit

class EmptyView: UIView {

    let messageLabel = UILabel()
    let reloadButton = UIButton()

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
        addSubview(messageLabel)
        addSubview(reloadButton)

        messageLabel.font = UIFont.systemFont(ofSize: 18)
        messageLabel.textAlignment = .center
        messageLabel.text = "連線異常，請重新嘗試"
        messageLabel.numberOfLines = 2

        reloadButton.backgroundColor = UIColor.red
        reloadButton.setTitle("重新整理", for: .normal)
        reloadButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)

        messageLabel.mLay(.centerX, .equal, self)
        messageLabel.mLay(.width, 300)
        messageLabel.mLay(.bottom, .equal, self, .centerY, multiplier: 1, constant: -10)

        reloadButton.mLay(.centerX, .equal, self)
        reloadButton.mLay(.width, 300)
        reloadButton.mLay(.top, .equal, self, .centerY, multiplier: 1, constant: 10)
        reloadButton.mLay(.height, 50)

    }

}

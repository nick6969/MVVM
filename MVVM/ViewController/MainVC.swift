//
//  MainVC.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/3.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    fileprivate lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("新北市垃圾車路線", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    fileprivate lazy var schoolButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("學校資料", for: .normal)
        button.addTarget(self, action: #selector(didTapSchoolButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        button.mLayCenterXY()
        button.mLay(size: CGSize(width: 180, height: 50))

        view.addSubview(schoolButton)
        schoolButton.mLay(.centerX, .equal, view)
        schoolButton.mLay(size: CGSize(width: 180, height: 50))
        schoolButton.mLay(.centerY, .equal, view, multiplier: 1.5, constant: 0)
    }

    @objc func didTapButton() {
        self.navigationController?.pushViewController(ZipVC(), animated: true)
    }

    @objc func didTapSchoolButton() {
        self.navigationController?.pushViewController(SchoolDataVC(), animated: true)
    }
}

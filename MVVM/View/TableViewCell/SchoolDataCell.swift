//
//  SchoolDataCell.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/7.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import UIKit

class SchoolDataCell: UITableViewCell {

    func setup(with model: StudentModel) {
        textLabel?.text = "座號: \(model.seatNumber), 姓名: \(model.name)"
    }
}

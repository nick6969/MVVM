//
//  GarbageStationInfoCell.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/3.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import UIKit

class GarbageStationInfoCell: UITableViewCell {

    func setup(with model: GarbageStationInfoModel) {
        textLabel?.text = model.linename + ", " + model.time + ", " + model.name
    }

}

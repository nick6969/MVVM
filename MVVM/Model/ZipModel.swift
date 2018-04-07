//
//  ZipModel.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/3.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

struct ZipModel: JsonModel {
    let district, zipcode: String

    enum CodingKeys: String, CodingKey {
        case district = "District"
        case zipcode
    }
}

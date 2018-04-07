//
//  GarbageStationInfoModel.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/3.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

struct GarbageStationInfoModel: JsonModel {
    let city, lineid, linename, rank, name, village, longitude, latitude, time, memo: String

    enum CodingKeys: String, CodingKey {
        case city, lineid, linename, rank, name, village, longitude, latitude, time, memo
    }
}

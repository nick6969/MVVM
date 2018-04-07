//
//  ClassModel.swift
//  MVVM
//
//  Created by Nick Lin on 2018/4/7.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

struct ClassModel: MultipleContentProtocol {
    let className, tutorName: String
    var subModels: [StudentModel]
    enum CodingKeys: String, CodingKey {
        case subModels = "students"
        case className
        case tutorName
    }
}

struct StudentModel: JsonModel {
    let name: String
    let seatNumber: Int
}

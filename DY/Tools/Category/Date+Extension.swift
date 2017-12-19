
//
//  Date+Extension.swift
//  DY
//
//  Created by 满艺网 on 2017/12/18.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentTime() -> String {
        let date = Date()
        let time = Int(date.timeIntervalSince1970)
        return "\(time)"
    }
}

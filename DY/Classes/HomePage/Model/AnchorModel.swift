//
//  AnchorModel.swift
//  DY
//
//  Created by 满艺网 on 2017/12/18.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    @objc var room_id : Int = 0
    @objc var vertical_src : String = ""
    @objc var online : Int = 0
    @objc var nickname : String = ""
    @objc var room_name : String = ""
    @objc var isVertical : Bool = false

    init(_ dict:[String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

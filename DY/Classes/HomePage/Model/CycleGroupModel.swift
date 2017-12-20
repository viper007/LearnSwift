//
//  CycleGroupModel.swift
//  DY
//
//  Created by 满艺网 on 2017/12/20.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit

class CycleGroupModel: NSObject {
    @objc var id : Int = 0
    @objc var title : String = ""
    @objc var pic_url : String = ""
    @objc var tv_pic_url : String = ""
    @objc var room : AnchorModel? {
        didSet {

        }
    }

    init(_ dict:[String : NSObject]){
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

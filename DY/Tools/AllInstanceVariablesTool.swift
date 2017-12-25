//
//  AllInstanceVariablesTool.swift
//  DY
//
//  Created by 满艺网 on 2017/12/21.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit
import Foundation
class AllInstanceVariablesTool: NSObject {
    class func getAllVariables(cls : Any?) {
        guard let cls = cls as? AnyClass else { return }
        var outPut : UInt32 = 0
        let Ivars = class_copyIvarList(cls , &outPut)!
        for i in 0..<outPut {
            let ivar : Ivar = Ivars[Int(i)]
            let cName = ivar_getName(ivar)
            print(String(cString:cName!))
        }
    }
}

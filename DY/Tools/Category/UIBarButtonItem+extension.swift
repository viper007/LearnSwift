//
//  UIBarButtonItem+extension.swift
//  DY
//
//  Created by 满艺网 on 2017/12/14.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(image:String,highImage:String = "", size:CGSize ,target : Any? = nil,action : Selector? = nil) {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: image), for: .normal)
        if highImage != "" {
            btn.setImage(UIImage.init(named: highImage), for: .highlighted)
        }

        btn.frame = CGRect(origin:.zero, size: size)
        self.init(customView: btn)  //需要调用init方法
        guard let target = target else { return }
        guard let action = action else { return }
        btn.addTarget(target, action: action, for: .touchUpInside)
    }
}

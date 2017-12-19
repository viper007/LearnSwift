//
//  CustomNavgationController.swift
//  DY
//
//  Created by 满艺网 on 2017/12/14.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit

class CustomNavgationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //添加全屏的pop手势
        //获取到系统的popGes->view->target/action指定对应的方法
        guard let sysGes = interactivePopGestureRecognizer else {return}
        guard let popView = sysGes.view else {return}

        //
//        var outCount : UInt32 = 0
//        let ivars = class_copyIvarList(UIGestureRecognizer.self, &outCount)!
//        for i in 0..<outCount {
//            let ivar : Ivar = ivars[Int(i)]
//            let name = ivar_getName(ivar)
//            print(String(cString: name!))
//        }
        let targets = sysGes.value(forKey: "_targets") as? [NSObject]
        guard let targetDic = targets?.first else {return}

        //取出target
        guard let target = targetDic.value(forKey: "target") else {return}
        let action = Selector(("handleNavigationTransition:"))
        //创建自己的pop
        let panGes = UIPanGestureRecognizer()
        panGes.addTarget(target, action: action)
        popView.addGestureRecognizer(panGes)
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //storyBoard第一次进来不会push，代码加载的会push进来
        if viewControllers.count > 0 {
           viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//
//  MainViewController.swift
//  DY
//
//  Created by 满艺网 on 2017/12/14.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainViewController {

    fileprivate func setupTabControllers() {
        tabBar.backgroundColor = UIColor.white
        let homeNav =  CustomNavgationController.init(rootViewController: HomeViewController())
        addChildVC(VC: homeNav,normal: "btn_home_normal",selected: "btn_home_selected",title: "首页")
        addChildVC(VC: HomeViewController(), normal: "btn_home_normal",selected: "btn_home_selected",title: "我的")
    }
    private func addChildVC(VC:UIViewController,normal:String,selected:String,title:String) {
        VC.tabBarItem.image = UIImage.init(named: normal)
        VC.tabBarItem.selectedImage = UIImage.init(named: selected)
        VC.tabBarItem.title = title
    VC.tabBarItem.setTitleTextAttributes([.foregroundColor:UIColor.orange], for: .selected)
        self.addChildViewController(VC)
    }
}

//
//  BaseViewController.swift
//  DY
//
//  Created by 满艺网 on 2017/12/18.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    /// 在对一个的闭包中必须用self,防止循环引用
    fileprivate lazy var aniImageView : UIImageView = {[unowned self] in
        let imageView = UIImageView(image: UIImage(named:"img_loading_1"))
        imageView.animationImages = [UIImage(named:"img_loading_1")!,UIImage(named:"img_loading_2")!]
        imageView.center = self.view.center
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return imageView
    }()

    fileprivate lazy var errorPlaceholderImageView : UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: ""))

        return imageView
    }()

    var contentView : UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension BaseViewController {

    /// 重写父类的方法需要在父类前添加@objc
    @objc func setupUI() {
        contentView?.isHidden = true
        view.addSubview(aniImageView)
        aniImageView.startAnimating()
        view.backgroundColor = UIColor(r:250,g:250,b:250)
    }

    func finishLoadData() {
        aniImageView.stopAnimating()
        aniImageView.isHidden = true
        contentView?.isHidden = false
    }

    func finishLoadErrorData(_ reloadCallBack :() -> ()) {
        aniImageView.stopAnimating()
        aniImageView.isHidden = true
        contentView?.isHidden = true
        
    }
}

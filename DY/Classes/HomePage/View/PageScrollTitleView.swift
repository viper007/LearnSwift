//
//  PageScrollTitleView.swift
//  DY
//
//  Created by 满艺网 on 2017/12/18.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit

let kPageTitileH : CGFloat = 44.0
private let kIndiactorH : CGFloat = 2.0

/// 类协议需要在前面添加对应的@objc
@objc protocol PageScrollTitleViewDelegate {
     func pageTitleView(_ titleView : PageScrollTitleView, selectedIndex index : Int)
}

class PageScrollTitleView: UIView {

    var titles : [String] = [String]()
    let indicator : UIView = UIView()
    var preLabel = UILabel()
    weak open var delegate: PageScrollTitleViewDelegate?
    private var labels = [UILabel]()
    //MARK: - 初始化方法
    init(frame: CGRect,titles: [String]) {
        super.init(frame: frame)
        self.titles = titles
        setupUI()
    }

    func setupUI() {
        let labelW : CGFloat = frame.size.width/CGFloat(titles.count)
        for (index,item) in titles.enumerated() {
            let label = UILabel()
            label.text = item
            label.textColor = UIColor.gray
            label.textAlignment = .center
            addSubview(label)
            label.frame = CGRect(x: CGFloat(index) * labelW, y: 0, width: labelW, height: kPageTitileH)
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapTitlelabel(_:)))
            label.addGestureRecognizer(tapGes)
            labels.append(label)
            if index == 0 {
                tapTitlelabel(tapGes)
            }
        }
        //添加对应的indicator
        indicator.frame = CGRect(x: 0, y: kPageTitileH - kIndiactorH, width: labelW, height: kIndiactorH)
        indicator.backgroundColor = UIColor.orange
        addSubview(indicator)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func tapTitlelabel(_ tapGes : UITapGestureRecognizer) {
        preLabel.textColor = UIColor.gray
        let label = tapGes.view as! UILabel
        let index = labels.index(of: label)!
        label.textColor = UIColor.orange
        preLabel = label
        UIView.animate(withDuration: 0.25) {
            self.indicator.center.x = label.center.x
        }
        guard (self.delegate) != nil else {return}
        delegate?.pageTitleView(self, selectedIndex: index)
//        if delegate != nil {
//            delegate?.pageTitleView(self, selectedIndex: index)
//        }
    }
}

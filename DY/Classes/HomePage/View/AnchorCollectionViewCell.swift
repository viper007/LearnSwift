//
//  AnchorCollectionViewCell.swift
//  DY
//
//  Created by 满艺网 on 2017/12/18.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit
import Kingfisher

class AnchorCollectionViewCell: UICollectionViewCell {
    //赋值模型
    var anchor : AnchorModel? {
        didSet {
            guard let anchorModel = anchor else { return }
            if anchorModel.online >= 10000 {
                let online = anchorModel.online/10000
                onlneLabel.text = "\(online)万在线"
            } else {
                onlneLabel.text = "\(anchorModel.online)在线"
            }
            desLabel.text = anchorModel.room_name
            roomNameLabel.text = anchorModel.nickname
            guard let iconURL = URL(string: anchorModel.vertical_src) else {return}
            imageView.kf.setImage(with: iconURL)
        }
    }
    //MARK: - 控件
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var onlneLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}

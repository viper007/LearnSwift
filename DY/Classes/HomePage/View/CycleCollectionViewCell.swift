//
//  CycleCollectionViewCell.swift
//  DY
//
//  Created by 满艺网 on 2017/12/20.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit

class CycleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    var cycleModel : CycleGroupModel? {
        didSet {
            guard let cycleMode = cycleModel else { return }
            imageView.kf.setImage(with: URL(string: cycleMode.pic_url))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

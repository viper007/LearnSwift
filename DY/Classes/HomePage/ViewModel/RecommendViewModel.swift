//
//  RecommendViewModel.swift
//  DY
//
//  Created by 满艺网 on 2017/12/18.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit

class RecommendViewModel {

    var anchorArray = [AnchorModel]()

    func requestAnchorData(_ finishCallBack : @escaping ()->()) {
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
            guard let resultDict = result as? [String : NSObject] else {return}
            guard let anchors = resultDict["data"] as? [[String : NSObject]] else {return}
            for dict in anchors {
                let anchorModel = AnchorModel(dict)
                self.anchorArray.append(anchorModel)
                print(dict)
            }
            finishCallBack()
        }
    }
}

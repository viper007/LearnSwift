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
    var cyclesArray = [CycleGroupModel]()
    var prettyArray = [AnchorModel]()
    func requestAnchorData(_ finishCallBack : @escaping ()->(),errorCallBack: @escaping (_ erro : Error)->() ) {
        let DisGroup = DispatchGroup()
        //请求大数据
        DisGroup.enter()
        //1.推荐数据
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom",parameters: ["time" : Date.getCurrentTime()], resultCallBack: { (result) in
            guard let resultDict = result as? [String : NSObject] else {return}
            guard let anchors = resultDict["data"] as? [[String : NSObject]] else {return}
            for dict in anchors {
                let anchorModel = AnchorModel(dict)
                self.anchorArray.append(anchorModel)
            }
            DisGroup.leave()
        }) { (error) in

        }
        //2.请求轮播图数据
        DisGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6",parameters: ["version" : "3.540"],resultCallBack: {(result) in
            guard let result = result as? [String : NSObject] else {return}
            guard let dataArray = result["data"] as? [NSObject] else {return}
            for dict in dataArray {
                self.cyclesArray.append(CycleGroupModel(dict as! [String : NSObject]))
            }
           DisGroup.leave()
        }) { (error) in

        }
        //3.颜值数据
        let parameters : [String : String] = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        DisGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters, resultCallBack: { (result) in

            guard let result = result as? [String : NSObject] else { return }
            guard let dataArray = result["data"] as? [[String : NSObject]] else { return }
            for dict in dataArray {
                self.prettyArray.append(AnchorModel(dict))
            }
            DisGroup.leave()
        }, errorCallBack: nil)
        //排序 解决
        DisGroup.notify(queue: DispatchQueue.main) {
            finishCallBack()
        }
    }
}

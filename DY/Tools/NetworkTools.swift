//
//  NetworkTools.swift
//  DY
//
//  Created by 满艺网 on 2017/12/14.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {

    /// 请求逻辑
    ///
    /// - Parameters:
    ///   - type: 请求类型比如:get/post等
    ///   - URLString: 请求路径
    ///   - parameters: 请求参数
    ///   - resultCallBack: 回调闭包
    ///   这里注意：在闭包里面 加上逃逸功能，并且闭包的第一个参数要加上下划线
    class func requestData(_ type:MethodType,URLString: String, parameters: [String:Any]? = nil, resultCallBack:@escaping ((_ result : Any)->()) , errorCallBack: @escaping ((_ error : Error)->())) {
        let method = type == MethodType.get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            // 3.获取结果
            guard let result = response.result.value else {
                print(response.result.error!)
                errorCallBack(response.result.error!)
                return
            }
            // 4.将结果回调出去
            resultCallBack(result)
        }
    }
}

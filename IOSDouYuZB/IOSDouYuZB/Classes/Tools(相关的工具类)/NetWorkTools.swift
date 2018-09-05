//
//  NetWorkTools.swift
//  NetWorkAlamfireProject
//
//  Created by nbcei on 2018/8/21.
//  Copyright © 2018年 Liux. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetWorkTools {
    //class方法 --> OC +开头
    class func requsetData(URLString : String, type : MethodType, parameters : [String : Any]? = nil, finishCallback : @escaping (_ result : Any) -> ()) {
        
        //1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        //2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            //3、校验是否有结果
//            if let result = response.result.value {
//                finishCallback(result)
//            } else {
//                print(response.result.error as Any)
//            }
            //3.校验是否有结果
            guard let result = response.result.value else {
                print(response.result.error as Any)
                return
            }
            
            //4.将结果回调出去
            finishCallback(result)
        }
        
        
    }
    
}

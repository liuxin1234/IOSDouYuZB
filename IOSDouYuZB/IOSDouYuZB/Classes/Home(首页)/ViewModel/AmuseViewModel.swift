//
//  AmuseViewModel.swift
//  IOSDouYuZB
//
//  Created by nbcei on 2018/10/11.
//  Copyright © 2018年 Liux. All rights reserved.
//

import UIKit

class AmuseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension AmuseViewModel {
    func loadAmuseData(finishCallBack : @escaping () -> ()) {
        NetWorkTools.requsetData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", type: .get) { (result) in
            //1.对界面进行处理
            guard let resultDict = result as? [String : Any] else {
                return
            }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {
                return
            }
            
            //2.遍历数组中的字典
            for dict in dataArray {
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            
            //3.完成回调
            finishCallBack()
        }
    }
}

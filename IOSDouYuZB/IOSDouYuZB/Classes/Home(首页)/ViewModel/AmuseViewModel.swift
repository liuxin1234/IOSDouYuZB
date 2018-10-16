//
//  AmuseViewModel.swift
//  IOSDouYuZB
//
//  Created by nbcei on 2018/10/11.
//  Copyright © 2018年 Liux. All rights reserved.
//  http://capi.douyucdn.cn/api/v1/getHotRoom/2

import UIKit

class AmuseViewModel : BaseViewModel {
}

extension AmuseViewModel {
    func loadAmuseData(finishCallBack : @escaping () -> ()) {
        // 注意这里的isGroupData：判断接口传递过来的是数据是否是分组数据  true：分组数据  false：不分组数据
       loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishCallBack)
    }
}

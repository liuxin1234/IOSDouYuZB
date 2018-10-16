//
//  FunnyViewModel.swift
//  IOSDouYuZB
//
//  Created by nbcei on 2018/10/16.
//  Copyright © 2018年 Liux. All rights reserved.
//

import UIKit

class FunnyViewModel : BaseViewModel{
    
}

extension FunnyViewModel {
    func loadFunnyData(finishedCallBack : @escaping () -> ()) {
        // 注意这里的isGroupData：判断接口传递过来的是数据是否是分组数据  true：分组数据  false：不分组数据
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallBack)
    }
}

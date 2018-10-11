//
//  AnchorGroup.swift
//  IOSDouYuZB
//
//  Created by nbcei on 2018/8/30.
//  Copyright © 2018年 Liux. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    //给基本数据类型初始化
    //使用KVC会提示无法找到age的KEY，因为Int是一个基本数据类型的结构体，OC中只有基本数据类型。因此对于基本数据类型要设置初始值。
    //var age: Int = 0
    
    //该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        //监听属性变化的控制器
        didSet {
            //这里使用guard进行校验 判断room_list是否有值
            guard let room_list = room_list else {return}
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
   
    // 主显示的图标
    var icon_name: String = "home_header_normal"
    // 定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
  
}


//
//  AnchorGroup.swift
//  IOSDouYuZB
//
//  Created by nbcei on 2018/8/30.
//  Copyright © 2018年 Liux. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
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
    // 组显示的标题
    var tag_name: String = ""
    // 游戏对应的图标
    var icon_url : String = ""
    // 主显示的图标
    var icon_name: String = "home_header_normal"
    // 定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    override init() {
        
    }
    
    //这里涉及计算，所以就不要设置为可选了  对外提供的参数之间为不可选的
    init(dict: [String: NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    /*
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String : NSObject]] {
                for dict in dataArray {
                    anchors.append(AnchorModel(dict: dict))
                }
            }
        }
    }
     */
}


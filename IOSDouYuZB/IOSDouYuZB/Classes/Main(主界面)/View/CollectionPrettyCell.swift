//
//  CollectionPrettyCell.swift
//  IOSDouYuZB
//
//  Created by nbcei on 2018/8/27.
//  Copyright © 2018年 Liux. All rights reserved.
//  颜值布局控件设置

import UIKit
import Kingfisher

// 这里继承CollectionBaseCell中的共用控件
class CollectionPrettyCell: CollectionBaseCell {
    // MARK: 控件的属性
    @IBOutlet weak var cityBtn: UIButton!
    
    // MARK: 定义模型属性
    override var anchor : AnchorModel? {
        didSet {
            //1.将属性传递给父类
            super.anchor = anchor
            
            //2.所在的城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }

    
}

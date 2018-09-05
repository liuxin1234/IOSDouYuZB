//
//  CollectionNormaCell.swift
//  IOSDouYuZB
//
//  Created by nbcei on 2018/8/27.
//  Copyright © 2018年 Liux. All rights reserved.
//  常用主播首页的布局显示

import UIKit

// 这里继承CollectionBaseCell中的共用控件
class CollectionNormaCell: CollectionBaseCell {

    // MARK: 控件的属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    // MARK: 定义模型属性 因为上面继承了CollectionBaseCell,所以这里需要用到override 来对父类的这个方法属性进行重写
    override var anchor : AnchorModel? {
        didSet {
            //1.将属性传递给父类
            super.anchor = anchor
            
            //2.房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }
}

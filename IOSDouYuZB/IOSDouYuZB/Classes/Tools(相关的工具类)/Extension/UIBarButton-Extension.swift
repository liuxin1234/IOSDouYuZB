//
//  UIBarButton-Extension.swift
//  IOSDouYuZB
//
//  Created by nbcei on 2018/7/31.
//  Copyright © 2018年 Liux. All rights reserved.
//  对系统类进行一个扩展

import UIKit

extension UIBarButtonItem {
    //首先创建一个扩展类，参数：1.设置图片的名字（路径）；2.设置图片高亮的名字（路径）；3.设置图片的大小
//    class func createItem(imageName : String, highImageName : String,
//                          size : CGSize) -> UIBarButtonItem {
//        let btn = UIButton()
//        btn.setImage(UIImage(named: imageName), for: .normal)
//        btn.setImage(UIImage(named: highImageName), for: .highlighted)
//        btn.frame = CGRect(origin: CGPoint.zero, size: size)
//        return UIBarButtonItem(customView: btn)
//    }
    
    //遍历构造函数：1.convenience开头 2.在构造函数中必须明确请用一个设计的构造函数（self）
    convenience init(imageName : String, highImageName : String = "",
                     size : CGSize = CGSize.zero){
        //1.创建UIButton
        let btn = UIButton()
        //2.设置btn的图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        if (highImageName != "") {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        //3.设置btn的尺寸
        if(size == CGSize.zero) {
            //根据图标的大小自适应
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        //4.创建UIBarButtonItem
        self.init(customView : btn)
    }
}

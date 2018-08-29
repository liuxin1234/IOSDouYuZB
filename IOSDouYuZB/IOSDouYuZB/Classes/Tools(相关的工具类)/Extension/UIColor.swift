//
//  UIColor.swift
//  IOSDouYuZB
//
//  Created by nbcei on 2018/8/24.
//  Copyright © 2018年 Liux. All rights reserved.
//

import UIKit

extension UIColor {
   convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
    self.init(red: r / 255.0, green: g / 255.0, blue: b/255.0, alpha: 1.0    )
    }
}

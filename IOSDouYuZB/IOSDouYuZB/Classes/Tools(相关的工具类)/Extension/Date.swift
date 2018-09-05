//
//  NSDate.swift
//  IOSDouYuZB
//
//  Created by nbcei on 2018/8/30.
//  Copyright © 2018年 Liux. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentTime() -> String {
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}

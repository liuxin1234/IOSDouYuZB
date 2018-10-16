//
//  RoomNormalViewController.swift
//  IOSDouYuZB
//
//  Created by nbcei on 2018/10/16.
//  Copyright © 2018年 Liux. All rights reserved.
//

import UIKit

class RoomNormalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.orange
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
        // 依然保持手势
//        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

////
////  MainTableViewController.swift
////  IOSDouYuZB
////
////  Created by nbcei on 2018/7/31.
////  Copyright © 2018年 Liux. All rights reserved.
////  这里设置是为了适配ios系统8.0， 8.0系统无法使用StoryBoard的布局只能设置代码进行适配
////
//
//import UIKit
//
//class MainTableViewController: UITableViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        addChildVc(storyName: "Home");
//        addChildVc(storyName: "Live");
//        addChildVc(storyName: "Follow");
//        addChildVc(storyName: "Mine");
//    }
//
//    private func addChildVc(storyName : String) {
//        //1.通过storyboard获取控制器
//        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
//
//        //2.将childVc作为控制器
//        addChildViewController(childVc);
//    }
//}

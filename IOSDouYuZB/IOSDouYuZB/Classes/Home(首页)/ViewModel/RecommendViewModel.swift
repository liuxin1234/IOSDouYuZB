//
//  RecommendViewModel.swift
//  IOSDouYuZB
//
//  Created by nbcei on 2018/8/30.
//  Copyright © 2018年 Liux. All rights reserved.
//

import UIKit

class RecommendViewModel : BaseViewModel{
    // MARK: 懒加载属性
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

// MARK: 发送网络请求
extension RecommendViewModel {
    // 请求推荐数据
    func requestData(finishCallBack : @escaping () -> ())  {
        //1.定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        //2.创建Group
        let dGroup = DispatchGroup()
        
        
        //3.请求第一部分推荐数据
        dGroup.enter()
        NetWorkTools.requsetData(URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", type: .get, parameters: ["time" : Date.getCurrentTime()]) { (result) in
            //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {return}
            //2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            //3.遍历data改key,获取数组

            //3.1设置组的属性 因为在闭包里 所有需要写self
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            //3.2获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            //3.3离开组
            dGroup.leave()
        }
        
        //4.请求第二部分颜值数据
        dGroup.enter()
        NetWorkTools.requsetData(URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", type: .get, parameters: parameters) { (result) in
            //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {return}
            //2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            //3.遍历data改key,获取数组
            //3.1设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            //3.2获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            //3.3离开组
            dGroup.leave()
        }
        //5.请求2-12部分游戏数据
        dGroup.enter()
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate") {
            //4.离开组
            dGroup.leave()
        }
        
        //6.所有的数据都请求到，之后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallBack()
        }
    }
    
    // MARK: 请求无线轮播的数据
    func requestCycleData(finishCallBack : @escaping() -> ())  {
        NetWorkTools.requsetData(URLString: "http://www.douyutv.com/api/v1/slide/6", type: .get, parameters: ["version" : "2.300"]) { (result) in
            //1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            
            //2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                return
            }
            
            //3.字典转模型对象
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            finishCallBack()
        }
    }
}




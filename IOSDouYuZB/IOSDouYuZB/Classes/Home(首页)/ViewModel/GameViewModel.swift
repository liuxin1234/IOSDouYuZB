//
//  GameViewModel.swift
//  IOSDouYuZB
//
//  Created by nbcei on 2018/10/10.
//  Copyright © 2018年 Liux. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var games : [GameModel] = [GameModel]()

}

extension GameViewModel {
    func loadAllGameData(finishedCallback : @escaping () -> ()) {
        print("4到这一步了 loadAllGameData。。。。")
        NetWorkTools.requsetData(URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", type: .get) { (result) in
             print("http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game")
            //1.获取到数据
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            
            //2.字典转模型
            for dict in dataArray {
                self.games.append(GameModel(dict: dict))
            }
            
            //3.完成回调
            finishedCallback()
        }
    }
}

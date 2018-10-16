//
//  RecommendViewController.swift
//  IOSDouYuZB
//
//  Created by nbcei on 2018/8/27.
//  Copyright © 2018年 Liux. All rights reserved.
//  推荐界面

import UIKit


private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90



class RecommendViewController: BaseAnchorViewController {

    // MARK: 增加载属性
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    //头部图片轮播
    fileprivate lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    //游戏列表滚动
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()

}

 // MARK: 设置UI界面内容
extension RecommendViewController {
    override func setupUI() { //重写父类
        //1.先调用super.setupUI()
        super.setupUI()
        
        //2.将CycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        
        //3.将gameView添加collectView中
        collectionView.addSubview(gameView)
        
        //3.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK: 请求数据
extension RecommendViewController {
    override func loadData() {
        //0.给父类中的viewModel进行赋值
        baseVM = recommendVM
        //1.请求推荐数据
        recommendVM.requestData {
            //1.1展示推荐数据
            self.collectionView.reloadData()
            
            //1.2将数据传递给GameView
            var groups = self.recommendVM.anchorGroups
            //1.3移除前两组
            groups.removeFirst()
            groups.removeFirst()
            
            //1.4添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.groups = groups
            
            //1.5.数据请求完成
            self.loadDataFinished()
        }
        
        //2.请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}


// MARK: 遵守UICollectionView的数据源协议
extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            // 1.取出PrettyCell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
            // 2.设置数据
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return prettyCell
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}



//
//  GameViewController.swift
//  IOSDouYuZB
//
//  Created by nbcei on 2018/10/10.
//  Copyright © 2018年 Liux. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kHeaderViewH : CGFloat = 50
private let kGameViewH : CGFloat = 90
//cell的标识符
private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"

class GameViewController: UIViewController {

    // MARK: 懒加载属性
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        //设置item之间的间距
        layout.minimumInteritemSpacing = 0
        //设置item的内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.white
        //设置cell 随着宽度和高度拉升而拉升 使其底部有一部分内容不被底部导航按钮所遮盖
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        //注册cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.dataSource = self
        return collectionView
    }()
    //添加内容顶部头部布局
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
       let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameViewH), width: kScreenW, height: kHeaderViewH)
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.titleLabel.text = "常见"
        headerView.moreBtn.isHidden = true
        return headerView
    }()
    
    //添加顶部内容游戏左滑的滚动布局
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        
    }
    
}

// MARK: 设置UI界面
extension GameViewController {
    fileprivate func setupUI(){
        //1.添加UICollectionView
        view.addSubview(collectionView)
        
        //2.添加顶部的HeaderView
        collectionView.addSubview(topHeaderView)
        
        // 3.将常用游戏的View,添加到collectionView中
        collectionView.addSubview(gameView)
        
        //4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
   
    }
}

// MARK:- 请求数据
extension GameViewController {
    fileprivate func loadData() {
        gameVM.loadAllGameData {
            // 1.展示全部游戏
            self.collectionView.reloadData()
            
            // 2.展示常用游戏
            self.gameView.groups = Array(self.gameVM.games[0..<10])
//
//            // 3.数据请求完成
//            self.loadDataFinished()
        }
    }
}

// MARK: -遵守UICollectionView的数据源&代理
extension GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1. 获取cell将 cell强制转成CollectionGameCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.baseGame = gameVM.games[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        // 2.给HeaderView设置属性
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        
        return headerView
    }
    
}

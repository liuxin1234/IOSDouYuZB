//
//  RecommendViewController.swift
//  IOSDouYuZB
//
//  Created by nbcei on 2018/8/27.
//  Copyright © 2018年 Liux. All rights reserved.
//  推荐界面

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kPrettyCellID = "kPrettyCellID"

class RecommendViewController: UIViewController {

    // MARK: 增加载属性
    private lazy var collectionView : UICollectionView = {[unowned self] in
        // 1.先创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        // item 之间的行间距
        layout.minimumLineSpacing = 1
        // 2个item 之间的间距
        layout.minimumInteritemSpacing = kItemMargin
        // 设置每个item的头部
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        // 设置item组的内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.white
        //让控制器成为数据源
        collectionView.dataSource = self
        //设置代理
        collectionView.delegate = self
        //设置随着父控件缩小而缩小 从而使布局不会被tabBar挡住
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        // 注册self item
        collectionView.register(UINib(nibName: "CollectionNormaCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        //注册item 的头布局 这里用自定义的xib来注册
            collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()
    
    // MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setupUI()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

 // MARK: 设置UI界面内容
extension RecommendViewController {
    private func setupUI() {
        //1.将UICollectionView添加到控制器的view中
        view.addSubview(collectionView)
    }
}

// MARK: 遵守UICollectionView的数据源协议
extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    // 列表总共有多少组
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    // 每组里面有多少条数据
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { // 如果是第一个的话返回8个
            return 8
        }
        return 4
    }
    
    // item的view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.定义Cell
        var cell : UICollectionViewCell!
        
        // 2.取出Cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        }
        
        return cell
    }
    
    // head的view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出setion的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        
        return headerView
    }
    
    //决定item的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}

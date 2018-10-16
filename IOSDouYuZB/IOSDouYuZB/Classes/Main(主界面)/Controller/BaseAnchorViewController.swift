//
//  BaseAnchorViewController.swift
//  IOSDouYuZB
//
//  Created by nbcei on 2018/10/11.
//  Copyright © 2018年 Liux. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10

private let kHeaderViewH : CGFloat = 50
private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

let kPrettyCellID = "kPrettyCellID"
let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3

class BaseAnchorViewController: BaseViewControler {

    // MARK: 定义属性
    var baseVM : BaseViewModel!
    lazy var collectionView : UICollectionView = {[unowned self] in
        // 1.先创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
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
    
    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}

// MARK: 设置UI界面
extension BaseAnchorViewController {
   override func setupUI() {
        //1.给父类中内容view的引用进行赋值
        contentView = collectionView
    
        //2.添加collection
        super.setupUI()
        view.addSubview(collectionView)
    }
}

// MARK: 请求数据
extension BaseAnchorViewController {
     func loadData() {
      
    }
}

// MARK: 遵守UICollectionView的数据源&代理协议
extension BaseAnchorViewController : UICollectionViewDataSource {
    //总共八组数据
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    //每组数据有4个item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormaCell

        //2.给cell设置数据源
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView

        //2.给HeaderView设置数据
        headerView.group = baseVM.anchorGroups[indexPath.section]
        return headerView
    }
}

// MARK: 遵守UICollectionView的代理协议
extension BaseAnchorViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //1.取出对应的主播信息
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        //2.判断是秀场房间&普通房间
        anchor.isVertical == 0 ? pushNormalRoomVc() : presentShowRoomVc()
        
    }
    // 秀场房间
    private func presentShowRoomVc() {
        //1.创建showRoomVc
        let showRoomVc = RoomShowViewController()
        //2.以Modal方式弹出
        present(showRoomVc, animated: true, completion: nil)
    }
    // 普通房间
    private func pushNormalRoomVc() {
        //1.创建NormalRoomVc
        let normalRoomVc = RoomNormalViewController()
        //2.以push方式弹出
        navigationController?.pushViewController(normalRoomVc, animated: true)
    }
}


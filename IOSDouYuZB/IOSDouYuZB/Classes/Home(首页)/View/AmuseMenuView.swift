//
//  AmuseMenuView.swift
//  IOSDouYuZB
//
//  Created by nbcei on 2018/10/12.
//  Copyright © 2018年 Liux. All rights reserved.
//

import UIKit

private let kMenuCellID = "kMenuCellID"

class AmuseMenuView: UIView {
    // MARK: 定义属性
    var groups : [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: 从xib中加载出来
    override func awakeFromNib() {
        super.awakeFromNib()
        //注册cell
        collectionView.register(UINib(nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }
    
    // MARK: 设置布局的方法  能够获取到布局的大小尺寸
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        layout.itemSize = collectionView.bounds.size
    }
}

extension AmuseMenuView {
    class func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

// MARK: 设置数据源
extension AmuseMenuView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil {
            return 0
        }
        let pageMenu = (groups!.count - 1) / 8 + 1
        //这里是设置指示器轮播图小点的个数
        pageControl.numberOfPages = pageMenu
        return pageMenu
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! AmuseMenuViewCell
        //2.给cell设置数据
        setupDateCellWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    private func setupDateCellWithCell(cell: AmuseMenuViewCell,indexPath: IndexPath) {
        //0页：0~7    1页：8~15  2页：16~23
        //1.取出起始位置&终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        //2.判断越界问题
        if endIndex >= groups!.count - 1 {
            //意思是 如果你要越界了 就等于最后一个
            endIndex = groups!.count - 1
        }
        
        //3.取出数据，并且赋值给cell
        cell.groups = Array(groups![startIndex...endIndex])
        
    }
}
//设置代理
extension AmuseMenuView : UICollectionViewDelegate {
    //监听滚动事件
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //当前页为 x轴方向的偏移量 / scrollView的宽度
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}

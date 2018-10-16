//
//  BaseViewControler.swift
//  IOSDouYuZB
//
//  Created by nbcei on 2018/10/16.
//  Copyright © 2018年 Liux. All rights reserved.
//

import UIKit

class BaseViewControler: UIViewController {
    
    // MARK:定义属性
    var contentView : UIView?
    
    // MARK: 懒加载属性
    fileprivate lazy var animImageView : UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        //动画执行的时间
        imageView.animationDuration = 0.5
        //动画重复次数 LONG_MAX：非常大的值
        imageView.animationRepeatCount = LONG_MAX
        //设拉伸属性 随父控件进行拉伸
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return imageView
    }()
    
    // MARK：系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension BaseViewControler {
    func setupUI() {
        //1.隐藏内容的View
        contentView?.isHidden = true
        
        //2.添加执行动画的UIImageView
        view.addSubview(animImageView)
        
        //3.给animImageView执行动画
        animImageView.startAnimating()
        
        //4.设置view的背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished() {
        //1.停止动画
        animImageView.stopAnimating()
        
        //2.隐藏animImageView
        animImageView.isHidden = true
        
        //3.显示内容的view
        contentView?.isHidden = false
    }
}

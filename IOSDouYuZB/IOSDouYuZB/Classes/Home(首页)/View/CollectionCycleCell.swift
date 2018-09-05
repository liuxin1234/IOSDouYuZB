//
//  CollectionCycleCell.swift
//  IOSDouYuZB
//
//  Created by nbcei on 2018/9/5.
//  Copyright © 2018年 Liux. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {
    // MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: 定义模型属性  将传递进来的模型数据进行展示
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")!
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named:"Img_default"))
            
        }
    }

}

//
//  WalkThroughCollectionCell.swift
//  CustomPageControl
//
//  Created by Devanshu Saini on 11/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import UIKit

class WalkThroughCollectionCell: UICollectionViewCell {
    @IBOutlet weak var walkThroughImageView:UIImageView!
    @IBOutlet weak var walkThroughTitleLabel:UILabel!
    @IBOutlet weak var walkThroughSubTitleLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.walkThroughTitleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.walkThroughTitleLabel.textColor = .black
        
        self.walkThroughSubTitleLabel.font = UIFont.systemFont(ofSize: 16.0)
        self.walkThroughSubTitleLabel.textColor = .gray
    }
}


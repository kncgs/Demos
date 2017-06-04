//
//  TableViewCell.swift
//  MasonryCell
//
//  Created by PaoHaiLe on 3/21/16.
//  Copyright © 2016 CoderDB. All rights reserved.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    var nameLabel: UILabel!
    var commentLabel: UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        nameLabel = UILabel()
        nameLabel.backgroundColor = UIColor.redColor()
        nameLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width-20
        nameLabel.sizeToFit()
        self.contentView.addSubview(nameLabel)
        
        
        
        commentLabel = UILabel()
        commentLabel.numberOfLines = 0
        commentLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width-60
//        commentLabel.sizeToFit()
        self.contentView.addSubview(commentLabel)
        commentLabel.backgroundColor = UIColor.cyanColor()
        
        
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.height.equalTo(20)
        }
        
        commentLabel.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(nameLabel).offset(30)
            make.left.equalTo(contentView).offset(50)
            make.right.equalTo(contentView).offset(-10)
//            make.bottom.equalTo(contentView).offset(10)
//            make.bottom.greaterThanOrEqualTo(contentView.snp_bottom).inset(10)
//
//            make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 10, left: 10, bottom: -10, right: 10))
        }
        
        contentView.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(commentLabel.snp_bottom).offset(30)
        }

    }
    
    
//    override func updateConstraints() {
//        nameLabel.snp_makeConstraints { (make) -> Void in
//            make.top.equalTo(contentView).offset(10)
//            make.left.equalTo(contentView).offset(10)
//            make.right.equalTo(contentView).offset(-10)
//            make.height.equalTo(20)
//        }
//        
//        commentLabel.snp_makeConstraints { (make) -> Void in
//            
//            make.top.equalTo(nameLabel).offset(30)
//            make.left.equalTo(contentView).offset(50)
//            make.right.equalTo(contentView).offset(-10)
//            make.bottom.greaterThanOrEqualTo(-10)
//        }
//        
//        contentView.snp_makeConstraints { (make) -> Void in
//            make.bottom.equalTo(commentLabel.snp_bottom)
//        }
//        super.updateConstraints()
//    }
    

}

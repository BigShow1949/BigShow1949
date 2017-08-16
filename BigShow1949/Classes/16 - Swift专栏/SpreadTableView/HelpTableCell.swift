//
//  HelpTableCell.swift
//  TableViewSpread-swift
//
//  Created by pxh on 2016/11/18.
//  Copyright © 2016年 pxh. All rights reserved.
//

import UIKit

class HelpTableCell: UITableViewCell {
    
    @IBOutlet weak var cellTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        print("layoutSubviews")

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

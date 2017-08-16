//
//  HelpSectionHeader.swift
//  SpreadTableView
//
//  Created by apple on 17/2/14.
//  Copyright © 2017年 BigShow1949. All rights reserved.
//

import UIKit

class HelpSectionHeader: UIView {

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var spreadBtn: UIButton!
    
    typealias callBackBlock = (_ index : NSInteger,_ isSelected : Bool) -> ()
    
    var spreadBlock : callBackBlock!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.red
        let subView : UIView = Bundle.main.loadNibNamed("HelpSectionHeader", owner: self, options: nil)?.first as! UIView
        subView.frame = self.frame
        self.addSubview(subView)
        spreadBtn.tintColor = UIColor.clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @IBAction func spreadBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if let _ = spreadBlock {
            spreadBlock(self.tag, sender.isSelected)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}

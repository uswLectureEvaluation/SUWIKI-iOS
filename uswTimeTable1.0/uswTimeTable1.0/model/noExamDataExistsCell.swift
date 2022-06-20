//
//  noExamDataExistsCell.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/04/14.
//

import UIKit

class noExamDataExistsCell:
    UITableViewCell {
    
    @IBOutlet weak var noExamData: UILabel!
    

    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.cornerRadius = 8.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  MajorCategoryNoDataCell.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/07/05.
//

import UIKit

class MajorCategoryNoDataCell: UITableViewCell {

    @IBOutlet weak var noMajorLabel: UILabel!
    
    @IBOutlet weak var hiddenLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

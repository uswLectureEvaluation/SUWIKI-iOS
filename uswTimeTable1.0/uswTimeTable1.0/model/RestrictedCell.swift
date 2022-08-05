//
//  RestrictedCell.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/08/03.
//

import UIKit

class RestrictedCell: UITableViewCell {

    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var expiredAtLabel: UILabel!
    @IBOutlet weak var judgementLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

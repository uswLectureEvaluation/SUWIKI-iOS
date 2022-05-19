//
//  examInfoTakeCell.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/04/12.
//

import UIKit
import Alamofire
import SwiftyJSON
import KeychainSwift

class examInfoTakeCell: UITableViewCell {
    
    let keychain = KeychainSwift()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.cornerRadius = 8.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

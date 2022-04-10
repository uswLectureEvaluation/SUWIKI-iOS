//
//  detailEvaluationCell.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/04/09.
//

import UIKit

class detailEvaluationCell: UITableViewCell {

    
    
    @IBOutlet weak var totalAvg: UILabel!

    
    @IBOutlet weak var hiddenView: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    /*
    func hiddenStackView1(){
        if hiddenView.isHidden == true {
            hiddenConstraint.constant = 0
        } else {
            hiddenConstraint.constant = 65
        }
    }
     */
}

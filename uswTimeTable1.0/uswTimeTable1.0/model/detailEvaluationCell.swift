//
//  detailEvaluationCell.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/04/09.
//

import UIKit

class detailEvaluationCell: UITableViewCell {

    
    
    @IBOutlet weak var totalAvg: UILabel!
    
    @IBOutlet weak var semester: UILabel!
    @IBOutlet weak var satisfactionPoint: UILabel!
    @IBOutlet weak var honeyPoint: UILabel!
    @IBOutlet weak var learningPoint: UILabel!
    
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var team: UILabel!
    @IBOutlet weak var homework: UILabel!
    @IBOutlet weak var difficulty: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 8.0    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 6, right: 0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
}
